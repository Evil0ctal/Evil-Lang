"""
Evil Lang Class System
类系统实现
"""

class EvilClass:
    """表示一个Evil Lang类"""
    
    def __init__(self, name, superclass=None, methods=None, constructor=None):
        self.name = name
        self.superclass = superclass
        self.methods = methods or {}
        self.constructor = constructor
        self.static_methods = {}
        self.static_fields = {}
    
    def has_method(self, name):
        """检查类是否有指定方法"""
        if name in self.methods:
            return True
        if self.superclass:
            return self.superclass.has_method(name)
        return False
    
    def get_method(self, name):
        """获取方法（包括继承的方法）"""
        if name in self.methods:
            return self.methods[name]
        if self.superclass:
            return self.superclass.get_method(name)
        return None
    
    def instantiate(self, interpreter, args):
        """创建类的实例"""
        instance = EvilInstance(self)
        
        # 如果有构造函数，调用它
        if self.constructor:
            # 创建一个绑定了实例的环境
            saved_scope = interpreter.global_scope.copy()
            saved_functions = interpreter.functions.copy()
            
            # 创建新作用域，包含 this 引用
            new_scope = saved_scope.copy()
            new_scope['this'] = instance
            
            # 绑定构造函数参数
            params = self.constructor.params
            if len(args) != len(params):
                raise ValueError(
                    f"Constructor of '{self.name}' expects {len(params)} arguments, "
                    f"but {len(args)} were given"
                )
            
            for i, param in enumerate(params):
                new_scope[param.value] = args[i]
            
            # 执行构造函数
            interpreter.global_scope = new_scope
            interpreter.functions = saved_functions
            
            try:
                interpreter.visit(self.constructor.body)
            finally:
                # 恢复原作用域
                interpreter.global_scope = saved_scope
                interpreter.functions = saved_functions
        
        return instance


class EvilInstance:
    """表示一个Evil Lang对象实例"""
    
    def __init__(self, evil_class):
        self.evil_class = evil_class
        self.fields = {}
    
    def get(self, name):
        """获取实例的字段或方法"""
        # 首先检查实例字段
        if name in self.fields:
            return self.fields[name]
        
        # 然后检查类方法
        method = self.evil_class.get_method(name)
        if method:
            # 返回绑定了 this 的方法
            return BoundMethod(self, method)
        
        # 如果都没有，返回 None
        return None
    
    def set(self, name, value):
        """设置实例字段"""
        self.fields[name] = value
    
    def __str__(self):
        return f"<{self.evil_class.name} instance>"
    
    def __repr__(self):
        return self.__str__()


class BoundMethod:
    """表示绑定了实例的方法"""
    
    def __init__(self, instance, method):
        self.instance = instance
        self.method = method
    
    def call(self, interpreter, args):
        """调用绑定的方法"""
        # 保存当前环境
        saved_scope = interpreter.global_scope.copy()
        saved_functions = interpreter.functions.copy()
        
        # 创建新作用域，包含 this 引用
        new_scope = saved_scope.copy()
        new_scope['this'] = self.instance
        
        # 绑定参数
        params = self.method.params
        if len(args) != len(params):
            raise ValueError(
                f"Method '{self.method.name}' expects {len(params)} arguments, "
                f"but {len(args)} were given"
            )
        
        for i, param in enumerate(params):
            new_scope[param.value] = args[i]
        
        # 执行方法
        interpreter.global_scope = new_scope
        interpreter.functions = saved_functions
        
        try:
            interpreter.visit(self.method.body)
            return_value = None
        except Exception as e:
            if hasattr(e, 'value'):  # ReturnException
                return_value = e.value
            else:
                raise
        finally:
            # 恢复原作用域
            interpreter.global_scope = saved_scope
            interpreter.functions = saved_functions
        
        return return_value