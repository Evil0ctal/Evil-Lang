"""
Evil Lang Type System
类型系统模块，提供统一的类型定义、转换和验证
"""

from .errors import TypeError as EvilTypeError


class EvilType:
    """Evil Lang 基础类型类"""
    
    @classmethod
    def type_name(cls):
        """返回类型名称"""
        return cls.__name__.replace('Type', '').lower()


class NumberType(EvilType):
    """数字类型"""
    
    @staticmethod
    def convert(value):
        """将值转换为数字
        
        Args:
            value: 要转换的值
            
        Returns:
            int or float: 转换后的数字
            
        Raises:
            EvilTypeError: 当无法转换时
        """
        if isinstance(value, (int, float)):
            return value
        
        if isinstance(value, bool):
            return 1 if value else 0
            
        if isinstance(value, str):
            value = value.strip()
            if not value:
                raise EvilTypeError(f"Cannot convert empty string to number")
            
            try:
                # 尝试转换为整数
                if '.' not in value and 'e' not in value.lower():
                    return int(value)
                # 否则转换为浮点数
                return float(value)
            except ValueError:
                raise EvilTypeError(f"Cannot convert '{value}' to number")
                
        raise EvilTypeError(f"Cannot convert {type(value).__name__} to number")
    
    @staticmethod
    def is_number(value):
        """检查值是否为数字类型"""
        return isinstance(value, (int, float)) and not isinstance(value, bool)


class StringType(EvilType):
    """字符串类型"""
    
    @staticmethod
    def convert(value):
        """将值转换为字符串
        
        Args:
            value: 要转换的值
            
        Returns:
            str: 转换后的字符串
        """
        if value is None:
            return "null"
        if isinstance(value, bool):
            return "true" if value else "false"
        if isinstance(value, (list, dict)):
            # 简单的列表/对象字符串表示
            if isinstance(value, list):
                return f"[{', '.join(StringType.convert(v) for v in value)}]"
            else:
                items = [f'{k}: {StringType.convert(v)}' for k, v in value.items()]
                return f"{{{', '.join(items)}}}"
        return str(value)


class BooleanType(EvilType):
    """布尔类型"""
    
    @staticmethod
    def convert(value):
        """将值转换为布尔值
        
        Args:
            value: 要转换的值
            
        Returns:
            bool: 转换后的布尔值
        """
        if isinstance(value, bool):
            return value
        if value is None:
            return False
        if isinstance(value, (int, float)):
            return value != 0
        if isinstance(value, str):
            return len(value) > 0
        if isinstance(value, (list, dict)):
            return len(value) > 0
        return True


class ArrayType(EvilType):
    """数组类型"""
    
    @staticmethod
    def is_array(value):
        """检查值是否为数组类型"""
        return isinstance(value, list)
    
    @staticmethod
    def length(value):
        """获取数组长度"""
        if not isinstance(value, list):
            raise EvilTypeError(f"Cannot get length of {type(value).__name__}")
        return len(value)


class ObjectType(EvilType):
    """对象类型"""
    
    @staticmethod
    def is_object(value):
        """检查值是否为对象类型"""
        return isinstance(value, dict)
    
    @staticmethod
    def keys(value):
        """获取对象的所有键"""
        if not isinstance(value, dict):
            raise EvilTypeError(f"Cannot get keys of {type(value).__name__}")
        return list(value.keys())
    
    @staticmethod
    def values(value):
        """获取对象的所有值"""
        if not isinstance(value, dict):
            raise EvilTypeError(f"Cannot get values of {type(value).__name__}")
        return list(value.values())


class FunctionType(EvilType):
    """函数类型"""
    
    @staticmethod
    def is_function(value):
        """检查值是否为函数类型"""
        return callable(value) or hasattr(value, 'func_node')


def get_type_name(value):
    """获取值的类型名称
    
    Args:
        value: 要检查的值
        
    Returns:
        str: 类型名称
    """
    if value is None:
        return "null"
    if isinstance(value, bool):
        return "boolean"
    if isinstance(value, (int, float)):
        return "number"
    if isinstance(value, str):
        return "string"
    if isinstance(value, list):
        return "array"
    if isinstance(value, dict):
        return "object"
    if callable(value) or hasattr(value, 'func_node'):
        return "function"
    return "unknown"


def type_check(value, expected_types):
    """检查值是否符合预期类型
    
    Args:
        value: 要检查的值
        expected_types: 预期的类型列表
        
    Returns:
        bool: 是否符合预期类型
    """
    actual_type = get_type_name(value)
    return actual_type in expected_types