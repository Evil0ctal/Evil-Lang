#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 抽象语法树定义 / Abstract Syntax Tree Definitions
# Author: Evil0ctal
# Date: 2025-05-04

class AST:
    """Base class for all AST nodes 所有AST节点的基类"""
    pass


class BinOp(AST):
    """Binary operation node 二元操作节点"""
    def __init__(self, left, op, right):
        self.left = left      # 左表达式 Left expression
        self.token = self.op = op  # 操作符 Operator token
        self.right = right    # 右表达式 Right expression


class UnaryOp(AST):
    """Unary operation node 一元操作节点"""
    def __init__(self, op, expr):
        self.token = self.op = op  # 操作符 Operator token
        self.expr = expr           # 表达式 Expression


class TernaryOp(AST):
    """Ternary operation node 三元操作节点"""
    def __init__(self, condition, true_expr, false_expr):
        self.condition = condition    # 条件 Condition
        self.true_expr = true_expr    # 真值表达式 True expression
        self.false_expr = false_expr  # 假值表达式 False expression


class Number(AST):
    """Number literal node 数字字面量节点"""
    def __init__(self, token):
        self.token = token
        self.value = token.value


class String(AST):
    """String literal node 字符串字面量节点"""
    def __init__(self, token):
        self.token = token
        self.value = token.value


class Boolean(AST):
    """Boolean literal node 布尔字面量节点"""
    def __init__(self, token):
        self.token = token
        self.value = token.value == 'TRUE'  # 将 'TRUE' 字符串转换为 Python 的 True


class Null(AST):
    """Null literal node 空值字面量节点"""
    def __init__(self, token):
        self.token = token
        self.value = None


class ObjectLiteral(AST):
    """Object literal node 对象字面量节点"""
    def __init__(self, pairs):
        self.pairs = pairs  # 键值对字典 Key-value pairs dictionary


class PropertyAccess(AST):
    """Property access node 属性访问节点"""
    def __init__(self, obj, prop):
        self.obj = obj    # 要访问的对象 Object to access
        self.prop = prop  # 属性名称 Property name


class Compound(AST):
    """Compound statement node 复合语句节点"""
    def __init__(self):
        self.children = []  # 子节点列表 List of child nodes


class Assign(AST):
    """Assignment node 赋值节点"""
    def __init__(self, left, op, right):
        self.left = left      # 左侧变量 Left variable
        self.token = self.op = op  # 操作符 Operator token
        self.right = right    # 右侧表达式 Right expression


class Var(AST):
    """Variable node 变量节点"""
    def __init__(self, token):
        self.token = token
        self.value = token.value


class VarDecl(AST):
    """Variable declaration node 变量声明节点"""
    def __init__(self, var_node, value_node=None):
        self.var_node = var_node      # 变量节点 Variable node
        self.value_node = value_node  # 初始值节点 Initial value node


class If(AST):
    """If statement node If语句节点"""
    def __init__(self, condition, if_body, else_body=None):
        self.condition = condition  # 条件 Condition
        self.if_body = if_body      # If分支 If branch
        self.else_body = else_body  # Else分支 Else branch


class While(AST):
    """While loop node While循环节点"""
    def __init__(self, condition, body):
        self.condition = condition  # 条件 Condition
        self.body = body            # 循环体 Loop body


class Print(AST):
    """Print statement node 打印语句节点"""
    def __init__(self, expr):
        self.expr = expr  # 打印表达式 Print expression


class Array(AST):
    """Array literal node 数组字面量节点"""
    def __init__(self, elements):
        self.elements = elements  # 数组元素列表 Array elements list


class ArrayAccess(AST):
    """Array access node 数组访问节点"""
    def __init__(self, array, index):
        self.array = array  # 访问的数组 Array to access
        self.index = index  # 索引表达式 Index expression


class FuncDecl(AST):
    """Function declaration node 函数声明节点"""
    def __init__(self, name, params, body):
        self.name = name    # 函数名 Function name
        self.params = params  # 参数列表 Parameter list
        self.body = body    # 函数体 Function body


class FuncCall(AST):
    """Function call node 函数调用节点"""
    def __init__(self, name, arguments):
        self.name = name          # 函数名 Function name
        self.arguments = arguments  # 参数列表 Argument list


class Return(AST):
    """Return statement node 返回语句节点"""
    def __init__(self, expr=None):
        self.expr = expr  # 返回表达式 Return expression


class Break(AST):
    """Break statement node Break语句节点"""
    pass


class Continue(AST):
    """Continue statement node Continue语句节点"""
    pass


class Input(AST):
    """Input statement node 输入语句节点"""
    def __init__(self, prompt=None):
        self.prompt = prompt  # 可选的提示信息 Optional prompt message


class For(AST):
    """For loop node For循环节点"""
    def __init__(self, init_stmt, condition, update_stmt, body):
        self.init_stmt = init_stmt      # 初始化语句 Initialization statement
        self.condition = condition      # 条件表达式 Condition expression
        self.update_stmt = update_stmt  # 更新语句 Update statement
        self.body = body                # 循环体 Loop body


class NoOp(AST):
    """No operation node 空操作节点"""
    pass


# 函数引用类，用于支持闭包 Function reference class for closure support
class FuncRef:
    """Function reference with closure support 带闭包支持的函数引用"""
    def __init__(self, func_node, lexical_scope=None):
        self.func_node = func_node        # 函数定义 Function definition
        self.lexical_scope = lexical_scope  # 词法作用域，用于闭包 Lexical scope for closures
