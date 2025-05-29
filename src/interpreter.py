#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - Interpreter Core / 解释器核心
# Author: Evil0ctal
# Date: 2025-05-04

from .ast import *
from .errors import EvilLangError, RuntimeError, NameError, TypeError, ValueError, IndexError, ReturnException, \
    BreakException, ContinueException, EvilLangException
from .builtins import get_builtins
from .class_system import EvilClass, EvilInstance, BoundMethod


class Interpreter:
    """Tree-walking interpreter with closure support / 支持闭包的语法树遍历解释器"""

    def __init__(self, source_code=None, filename=None):
        self.global_scope = {}  # Global scope / 全局变量作用域
        self.functions = {}  # Function storage / 函数字典
        self.classes = {}  # Class storage / 类字典
        self.source_code = source_code  # Store the source code for error reporting
        self.filename = filename  # Store the filename for error reporting
        self.builtins = {}  # Built-in functions / 内置函数
        self.module_manager = None  # Module manager / 模块管理器（延迟初始化以避免循环导入）
        self.current_instance = None  # Current instance for this reference / 当前实例（用于this引用）

        # Add built-in functions / 添加内置函数
        self._add_builtins()

    def _add_builtins(self):
        """Add built-in functions to global scope / 添加内置函数到全局作用域"""
        self.builtins = get_builtins()
        for name, func in self.builtins.items():
            self.global_scope[name] = func

    def visit(self, node):
        """Visit node using the appropriate method / 使用适当的方法访问节点"""
        method_name = 'visit_' + type(node).__name__
        visitor = getattr(self, method_name, self.generic_visit)
        return visitor(node)

    def generic_visit(self, node):
        """Generic visit method for unknown node types / 未知节点类型的通用访问方法"""
        raise RuntimeError(f"No visit_{type(node).__name__} method implemented")

    def _to_string(self, value):
        """Type conversion to string / 类型转换为字符串"""
        if value is None:
            return "null"
        elif isinstance(value, bool):
            return "true" if value else "false"
        else:
            return str(value)

    def visit_BinOp(self, node):
        """Evaluate binary operations / 执行二元运算"""
        left = self.visit(node.left)
        right = self.visit(node.right)

        line = node.token.line if hasattr(node, 'token') else None
        column = node.token.column if hasattr(node, 'token') else None

        # Handle string concatenation - automatically convert non-string values to strings
        # 处理字符串连接 - 自动将非字符串值转换为字符串
        if node.op.value == '+' and (isinstance(left, str) or isinstance(right, str)):
            return self._to_string(left) + self._to_string(right)

        # Other binary operators / 其他二元操作符
        try:
            if node.op.value == '+':
                return left + right
            elif node.op.value == '-':
                return left - right
            elif node.op.value == '*':
                return left * right
            elif node.op.value == '/':
                if right == 0:
                    raise ValueError("Division by zero", line, column)
                return left / right
            elif node.op.value == '%':
                if right == 0:
                    raise ValueError("Modulo by zero", line, column)
                return left % right
            elif node.op.value == '==':
                return left == right
            elif node.op.value == '!=':
                return left != right
            elif node.op.value == '<':
                return left < right
            elif node.op.value == '>':
                return left > right
            elif node.op.value == '<=':
                return left <= right
            elif node.op.value == '>=':
                return left >= right
            elif node.op.value == '&&':
                return left and right
            elif node.op.value == '||':
                return left or right
        except TypeError:
            # Convert Python TypeError to EvilLang TypeError
            raise TypeError(
                f"Operator '{node.op.value}' cannot be applied to types '{type(left).__name__}' and '{type(right).__name__}'",
                line, column
            )

    def visit_UnaryOp(self, node):
        """Evaluate unary operations / 执行一元运算"""
        line = node.token.line if hasattr(node, 'token') else None
        column = node.token.column if hasattr(node, 'token') else None

        op = node.op.value
        try:
            if op == '+':
                return +self.visit(node.expr)
            elif op == '-':
                return -self.visit(node.expr)
            elif op == '!':
                return not self.visit(node.expr)
        except TypeError:
            raise TypeError(
                f"Operator '{op}' cannot be applied to this type",
                line, column
            )

    def visit_TernaryOp(self, node):
        """Evaluate ternary operations / 执行三元运算"""
        condition = self.visit(node.condition)
        if condition:
            return self.visit(node.true_expr)
        else:
            return self.visit(node.false_expr)

    def visit_Number(self, node):
        """Evaluate number node / 计算数字节点"""
        return node.value

    def visit_String(self, node):
        """Evaluate string node / 计算字符串节点"""
        return node.value

    def visit_Boolean(self, node):
        """Evaluate boolean node / 计算布尔节点"""
        return node.value

    def visit_Null(self, node):
        """Evaluate null node / 计算空值节点"""
        return None

    def visit_ObjectLiteral(self, node):
        """Evaluate object literal / 计算对象字面量"""
        result = {}
        for key, value_node in node.pairs.items():
            result[key] = self.visit(value_node)
        return result

    def visit_PropertyAccess(self, node):
        """Evaluate property access / 计算属性访问"""
        obj = self.visit(node.obj)

        line = node.obj.token.line if hasattr(node.obj, 'token') else None
        column = node.obj.token.column if hasattr(node.obj, 'token') else None

        # Handle Evil Lang object instances / 处理 Evil Lang 对象实例
        if isinstance(obj, EvilInstance):
            value = obj.get(node.prop)
            if value is None:
                raise NameError(f"Instance has no property '{node.prop}'", line, column)
            return value
        # Handle built-in properties and methods / 处理内置属性和方法
        elif isinstance(obj, list) and node.prop == 'length':
            return len(obj)
        # Handle string properties / 处理字符串属性
        elif isinstance(obj, str) and node.prop == 'length':
            return len(obj)
        # Handle object property access / 处理对象属性访问
        elif isinstance(obj, dict) and node.prop in obj:
            return obj[node.prop]
        # If object is a dictionary, try to access its keys / 如果对象是字典，尝试访问它的键
        elif isinstance(obj, dict):
            if node.prop in obj:
                return obj[node.prop]
            else:
                # If property doesn't exist, throw error / 如果属性不存在，抛出异常
                raise NameError(f"Object has no property '{node.prop}'", line, column)
        else:
            raise TypeError(f"Cannot access property '{node.prop}' on this type", line, column)

    def visit_Compound(self, node):
        """Execute compound statement / 执行复合语句"""
        result = None
        for child in node.children:
            result = self.visit(child)
        return result

    def visit_VarDecl(self, node):
        """Execute variable declaration / 执行变量声明"""
        var_name = node.var_node.value
        var_value = None

        if node.value_node is not None:
            var_value = self.visit(node.value_node)

        self.global_scope[var_name] = var_value
        return var_value

    def visit_Assign(self, node):
        """Execute assignment / 执行赋值"""
        line = node.left.token.line if hasattr(node.left, 'token') else None
        column = node.left.token.column if hasattr(node.left, 'token') else None

        if isinstance(node.left, Var):
            var_name = node.left.value

            # Check if variable is declared / 检查变量是否声明
            if var_name not in self.global_scope:
                raise NameError(f"Variable '{var_name}' is not declared", line, column)

            # Calculate assignment expression value / 计算赋值表达式的值
            value = self.visit(node.right)

            # Update variable value / 更新变量的值
            self.global_scope[var_name] = value
            return value

        elif isinstance(node.left, ArrayAccess):
            # Handle array element assignment / 处理数组元素赋值
            array = self.visit(node.left.array)
            index = self.visit(node.left.index)

            if not isinstance(array, list):
                raise TypeError(f"Not an array: {array}", line, column)

            if not isinstance(index, int):
                raise TypeError(f"Array index must be an integer: {index}", line, column)

            # Modified boundary check, allows adding elements at the end
            # 修改后的边界检查，允许在数组末尾添加元素
            if index < 0 or index > len(array):
                raise IndexError(f"Array index out of bounds: {index}", line, column)

            value = self.visit(node.right)

            # If index equals array length, append to end
            # 如果索引等于数组长度，附加到数组末尾
            if index == len(array):
                array.append(value)
            else:
                array[index] = value

            return value

        elif isinstance(node.left, PropertyAccess):
            # Handle object property assignment / 处理对象属性赋值
            obj = self.visit(node.left.obj)
            prop = node.left.prop

            if isinstance(obj, dict):
                value = self.visit(node.right)
                obj[prop] = value
                return value
            elif isinstance(obj, EvilInstance):
                # Handle Evil Lang instance property assignment
                value = self.visit(node.right)
                obj.set(prop, value)
                return value
            else:
                raise TypeError(f"Cannot set property on non-object type", line, column)

        else:
            raise TypeError(f"Unsupported assignment target type: {type(node.left)}", line, column)

    def visit_Var(self, node):
        """Evaluate variable / 计算变量值"""
        var_name = node.value
        line = node.token.line if hasattr(node.token, 'line') else None
        column = node.token.column if hasattr(node.token, 'column') else None

        # Check if it's a function name / 检查是否是函数名
        if var_name in self.functions:
            # Return function name for later use in function calls
            # 返回函数名，之后可以用于函数调用
            return var_name

        # Variable lookup / 变量查找
        if var_name not in self.global_scope:
            raise NameError(f"Variable '{var_name}' is not declared", line, column)

        return self.global_scope[var_name]

    def visit_If(self, node):
        """Execute if statement / 执行if语句"""
        condition = self.visit(node.condition)

        if condition:
            return self.visit(node.if_body)
        elif node.else_body is not None:
            return self.visit(node.else_body)

    def visit_While(self, node):
        """Execute while loop / 执行while循环"""
        while self.visit(node.condition):
            try:
                self.visit(node.body)
            except BreakException:
                break
            except ContinueException:
                continue

    def visit_For(self, node):
        """Execute for loop / 执行for循环"""
        # Execute initialization statement / 执行初始化语句
        self.visit(node.init_stmt)

        # Execute loop / 循环执行
        while self.visit(node.condition):
            try:
                # Execute loop body / 执行循环体
                self.visit(node.body)
            except BreakException:
                break
            except ContinueException:
                pass

            # Execute update statement / 执行更新语句
            self.visit(node.update_stmt)

    def visit_Print(self, node):
        """Execute print statement / 执行print语句"""
        value = self.visit(node.expr)
        print(value)

    def visit_Input(self, node):
        """Execute input statement / 执行input语句"""
        prompt = ""
        if node.prompt:
            prompt = self.visit(node.prompt)
        return input(prompt)

    def visit_Array(self, node):
        """Evaluate array literal / 计算数组字面量"""
        return [self.visit(element) for element in node.elements]

    def visit_ArrayAccess(self, node):
        """Evaluate array access / 计算数组访问"""
        array = self.visit(node.array)
        index = self.visit(node.index)

        line = node.array.token.line if hasattr(node.array, 'token') else None
        column = node.array.token.column if hasattr(node.array, 'token') else None

        if not isinstance(array, list):
            raise TypeError(f"Not an array: {array}", line, column)

        if not isinstance(index, int):
            raise TypeError(f"Array index must be an integer: {index}", line, column)

        if index < 0 or index >= len(array):
            raise IndexError(f"Array index out of bounds: {index}", line, column)

        return array[index]

    def visit_FuncDecl(self, node):
        """Execute function declaration / 执行函数声明"""
        # Store function definition in function dictionary
        # 将函数定义保存到函数字典中
        self.functions[node.name] = node

        # Save current environment as captured environment for closures
        # 保存当前环境作为闭包捕获的环境
        closure_env = self.global_scope.copy()

        # Create a FuncRef object for the function, supporting later use as a value
        # 把函数本身创建为一个FuncRef对象，支持后续作为值使用
        func_ref = FuncRef(node, closure_env)
        
        # Also store function reference in global scope for easier access
        # 同时将函数引用存储在全局作用域中，方便访问
        self.global_scope[node.name] = func_ref

        # Return function reference, allowing functions to be assigned to variables
        # 返回函数引用，使得函数可以被赋值给变量
        return func_ref

    def visit_FuncCall(self, node):
        """Execute function call / 执行函数调用"""
        func_name = node.name
        func_line = node.token.line if hasattr(node, 'token') else None
        func_column = node.token.column if hasattr(node, 'token') else None

        try:
            # Prepare arguments / 准备参数
            arg_values = []
            for arg in node.arguments:
                arg_value = self.visit(arg)

                # Check if argument is a function name, if so, convert to function reference
                # 检查参数是否为函数名，如果是，转换为函数引用
                if isinstance(arg_value, str) and arg_value in self.functions:
                    arg_value = FuncRef(self.functions[arg_value], self.global_scope.copy())

                arg_values.append(arg_value)

            # Check if built-in function / 检查是否是内置函数
            if func_name in self.global_scope and callable(self.global_scope[func_name]):
                try:
                    # Call built-in function / 调用内置函数
                    return self.global_scope[func_name](arg_values)
                except EvilLangError as e:
                    # Already our custom error type, add stack frame and re-raise
                    # 已经是我们的自定义错误类型，添加堆栈帧并重新抛出
                    e.add_stack_frame(func_name, func_line, func_column)
                    raise
                except Exception as e:
                    # Convert standard exceptions to EvilLang errors
                    # 将标准异常转换为EvilLang错误
                    error = RuntimeError(str(e), func_line, func_column)
                    error.add_stack_frame(func_name, func_line, func_column)
                    raise error

            # Check if it's a stored function reference (closure case)
            # 检查是不是一个存储为变量的函数引用 (闭包情况)
            if func_name in self.global_scope and isinstance(self.global_scope[func_name], FuncRef):
                # Get function reference from variable / 从变量中获取函数引用
                func_ref = self.global_scope[func_name]

                # Get function definition / 获取函数定义
                func_node = func_ref.func_node

                # Check parameter count / 检查参数数量
                if len(arg_values) != len(func_node.params):
                    raise ValueError(
                        f"Function '{func_name}' requires {len(func_node.params)} arguments, but {len(arg_values)} were given",
                        func_line, func_column
                    )

                # Save current scope / 保存当前作用域
                saved_scope = self.global_scope.copy()

                # Use closure's lexical scope, note we don't copy here because we need to modify it directly
                # 使用闭包的词法作用域，注意这里不要复制，因为我们需要直接修改它
                if func_ref.lexical_scope:
                    self.global_scope = func_ref.lexical_scope  # Use reference directly / 直接使用引用

                # Bind parameters / 绑定参数
                for i, param in enumerate(func_node.params):
                    param_name = param.value
                    self.global_scope[param_name] = arg_values[i]

                # Execute function body / 执行函数体
                return_value = None
                try:
                    self.visit(func_node.body)
                except ReturnException as e:
                    return_value = e.value
                except EvilLangError as e:
                    # Add stack frame information / 添加堆栈帧信息
                    e.add_stack_frame(func_name, func_line, func_column)
                    raise
                finally:
                    # Restore original scope / 恢复原来的作用域
                    self.global_scope = saved_scope

                return return_value

            # Regular function call / 常规函数调用
            elif func_name in self.functions:
                func_node = self.functions[func_name]

                # Check parameter count / 检查参数数量
                if len(arg_values) != len(func_node.params):
                    raise ValueError(
                        f"Function '{func_name}' requires {len(func_node.params)} arguments, but {len(arg_values)} were given",
                        func_line, func_column
                    )

                # Save current scope / 保存当前作用域
                saved_scope = self.global_scope.copy()

                # Create new scope for function execution
                # 创建新的作用域用于函数执行
                new_scope = saved_scope.copy()  # Copy current scope as base / 复制当前作用域作为基础
                for i, param in enumerate(func_node.params):
                    param_name = param.value
                    new_scope[param_name] = arg_values[i]

                # Set new scope / 设置新作用域
                self.global_scope = new_scope

                # Execute function body / 执行函数体
                return_value = None
                try:
                    self.visit(func_node.body)
                except ReturnException as e:
                    return_value = e.value

                    # If return value is a function name, convert to function reference
                    # 如果返回值是一个函数名，将其转换为函数引用
                    if isinstance(return_value, str) and return_value in self.functions:
                        return_value = FuncRef(self.functions[return_value], self.global_scope.copy())
                    # If return value is a function array, convert each function name to reference
                    # 如果返回值是函数数组，将每个函数名转换为函数引用
                    elif isinstance(return_value, list):
                        for i, item in enumerate(return_value):
                            if isinstance(item, str) and item in self.functions:
                                return_value[i] = FuncRef(self.functions[item], self.global_scope.copy())
                except EvilLangError as e:
                    # Add current function call to the stack trace
                    # 将当前函数调用添加到堆栈跟踪
                    e.add_stack_frame(func_name, func_line, func_column)
                    raise  # Re-raise to continue building the stack trace / 重新抛出以继续构建堆栈跟踪
                finally:
                    # Restore original scope / 恢复原来的作用域
                    self.global_scope = saved_scope

                return return_value
            else:
                raise NameError(f"Undefined function: {func_name}", func_line, func_column)

        except EvilLangError as e:
            # Add current function to call stack if not already added
            # 将当前函数添加到调用堆栈（如果尚未添加）
            e.add_stack_frame(func_name, func_line, func_column)
            raise

    def visit_Return(self, node):
        """Execute return statement / 执行return语句"""
        line = node.token.line if hasattr(node, 'token') else None
        column = node.token.column if hasattr(node, 'token') else None

        if node.expr:
            value = self.visit(node.expr)

            # If return value is a function name, convert to function reference
            # 如果返回值是函数名，将其转换为函数引用
            if isinstance(value, str) and value in self.functions:
                value = FuncRef(self.functions[value], self.global_scope.copy())

            raise ReturnException(value)
        else:
            raise ReturnException(None)

    def visit_Break(self, node):
        """Execute break statement / 执行break语句"""
        raise BreakException()

    def visit_Continue(self, node):
        """Execute continue statement / 执行continue语句"""
        raise ContinueException()

    def visit_NoOp(self, node):
        """Execute no-op statement / 执行空操作语句"""
        pass
    
    def visit_MethodCall(self, node):
        """Execute method call / 执行方法调用"""
        # 获取对象
        obj = self.visit(node.obj)
        
        # 获取方法名
        method_name = node.method
        
        # 准备参数
        arg_values = []
        for arg in node.arguments:
            arg_values.append(self.visit(arg))
        
        # 如果对象是 Evil Lang 实例
        if isinstance(obj, EvilInstance):
            method = obj.get(method_name)
            if method is None:
                raise NameError(f"Instance has no method '{method_name}'")
            
            # 如果是绑定方法，调用它
            if isinstance(method, BoundMethod):
                return method.call(self, arg_values)
            else:
                raise TypeError(f"'{method_name}' is not a callable method")
        
        # 如果对象是字典，尝试获取方法
        elif isinstance(obj, dict) and method_name in obj:
            method = obj[method_name]
            
            # 如果是函数引用，调用它
            if isinstance(method, FuncRef):
                func_node = method.func_node
                
                # 检查参数数量
                if len(arg_values) != len(func_node.params):
                    raise ValueError(
                        f"Method '{method_name}' requires {len(func_node.params)} arguments, "
                        f"but {len(arg_values)} were given"
                    )
                
                # 创建新作用域
                saved_scope = self.global_scope.copy()
                saved_functions = self.functions.copy()
                
                # 创建闭包作用域
                new_scope = method.lexical_scope.copy() if method.lexical_scope else {}
                
                # 绑定参数
                for i, param in enumerate(func_node.params):
                    new_scope[param.value] = arg_values[i]
                
                # 设置新作用域
                self.global_scope = new_scope
                self.functions = saved_functions
                
                try:
                    # 执行函数体
                    self.visit(func_node.body)
                    return_value = None
                except ReturnException as e:
                    return_value = e.value
                finally:
                    # 恢复原作用域
                    self.global_scope = saved_scope
                    self.functions = saved_functions
                
                return return_value
            else:
                raise TypeError(f"'{method_name}' is not a callable method")
        else:
            raise NameError(f"Object has no method '{method_name}'")

    def visit_ImportStmt(self, node):
        """Execute import statement / 执行导入语句"""
        # 延迟初始化模块管理器
        if self.module_manager is None:
            from .module import ModuleManager
            self.module_manager = ModuleManager(self)
        
        # 导入模块
        imports = self.module_manager.import_module(
            node.module_path,
            items=node.items,
            alias=node.alias,
            from_path=self.filename
        )
        
        # 将导入的符号添加到当前作用域
        self.global_scope.update(imports)
    
    def visit_ExportStmt(self, node):
        """Execute export statement / 执行导出语句"""
        # 如果我们在模块上下文中，初始化导出字典
        if not hasattr(self, 'module_exports'):
            self.module_exports = {}
        
        # 处理导出项
        for item in node.items:
            if item.value:
                # 这是一个声明导出（export var x = value）
                # 先执行声明
                self.visit(item.value)
                
                # 获取导出的值
                if item.name in self.global_scope:
                    self.module_exports[item.name] = self.global_scope[item.name]
                elif item.name in self.functions:
                    self.module_exports[item.name] = self.functions[item.name]
                else:
                    raise NameError(f"Cannot export undefined variable '{item.name}'")
            else:
                # 这是一个命名导出（export { x, y, z }）
                if item.name in self.global_scope:
                    self.module_exports[item.name] = self.global_scope[item.name]
                elif item.name in self.functions:
                    self.module_exports[item.name] = self.functions[item.name]
                else:
                    raise NameError(f"Cannot export undefined variable '{item.name}'")

    def visit_ClassDecl(self, node):
        """Execute class declaration / 执行类声明"""
        # 获取父类（如果有）
        superclass = None
        if node.superclass:
            if node.superclass in self.classes:
                superclass = self.classes[node.superclass]
            else:
                raise NameError(f"Superclass '{node.superclass}' is not defined")
        
        # 创建类对象
        evil_class = EvilClass(node.name, superclass, {}, node.constructor)
        
        # 添加方法
        for method in node.methods:
            evil_class.methods[method.name] = method
        
        # 将类添加到类字典和全局作用域
        self.classes[node.name] = evil_class
        self.global_scope[node.name] = evil_class
        
        return evil_class
    
    def visit_NewExpr(self, node):
        """Execute new expression / 执行new表达式"""
        # 查找类
        if node.class_name not in self.classes:
            raise NameError(f"Class '{node.class_name}' is not defined")
        
        evil_class = self.classes[node.class_name]
        
        # 准备构造函数参数
        args = []
        for arg in node.arguments:
            args.append(self.visit(arg))
        
        # 创建实例
        return evil_class.instantiate(self, args)
    
    def visit_ThisExpr(self, node):
        """Execute this expression / 执行this表达式"""
        if 'this' in self.global_scope:
            return self.global_scope['this']
        else:
            raise RuntimeError("'this' can only be used inside a class method")
    
    def visit_SuperExpr(self, node):
        """Execute super expression / 执行super表达式"""
        # TODO: 实现 super 支持
        raise RuntimeError("'super' is not yet implemented")
    
    def visit_TryStmt(self, node):
        """Execute try statement / 执行try语句"""
        exception_caught = None
        return_value = None
        
        # 执行try块
        try:
            return_value = self.visit(node.try_block)
        except ReturnException as e:
            # Return语句不应该被捕获为异常
            if node.finally_block:
                self.visit(node.finally_block)
            raise
        except BreakException:
            # Break语句不应该被捕获为异常
            if node.finally_block:
                self.visit(node.finally_block)
            raise
        except ContinueException:
            # Continue语句不应该被捕获为异常
            if node.finally_block:
                self.visit(node.finally_block)
            raise
        except EvilLangException as e:
            # 用户抛出的异常
            exception_caught = e
        except EvilLangError as e:
            # 将Evil Lang错误转换为异常值
            exception_caught = EvilLangException(str(e))
        except Exception as e:
            # 其他Python异常
            exception_caught = EvilLangException(str(e))
        
        # 如果捕获到异常且有catch子句
        if exception_caught and node.catch_clause:
            # 保存当前作用域
            saved_scope = self.global_scope.copy()
            
            # 创建新作用域，包含异常参数
            new_scope = saved_scope.copy()
            new_scope[node.catch_clause.param] = exception_caught.value
            
            # 执行catch块
            self.global_scope = new_scope
            try:
                return_value = self.visit(node.catch_clause.body)
                exception_caught = None  # 异常已处理
            finally:
                # 恢复作用域
                self.global_scope = saved_scope
        
        # 执行finally块（如果有）
        if node.finally_block:
            self.visit(node.finally_block)
        
        # 如果异常未被处理，重新抛出
        if exception_caught:
            raise exception_caught
        
        return return_value
    
    def visit_ThrowStmt(self, node):
        """Execute throw statement / 执行throw语句"""
        # 计算要抛出的值
        value = self.visit(node.expr)
        
        # 抛出用户异常
        raise EvilLangException(value)
    
    def interpret(self, tree):
        """Main interpreter entry point / 解释器主入口点"""
        try:
            return self.visit(tree)
        except EvilLangError as e:
            # Add main program to the call stack
            # 将主程序添加到调用堆栈
            e.add_stack_frame("main", None, None)
            raise
