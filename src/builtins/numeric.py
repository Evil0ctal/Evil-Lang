#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Evil Lang - Numeric Processing Built-in Functions
数值处理内置函数
"""

from . import register_builtin
from ..types import NumberType, get_type_name
from ..errors import TypeError as EvilTypeError, ValueError as EvilValueError


def _to_number(args):
    """Convert value to number 将值转换为数字"""
    if len(args) != 1:
        raise EvilValueError("toNumber function requires exactly one argument")
    
    try:
        return NumberType.convert(args[0])
    except EvilTypeError as e:
        raise e  # Re-raise with proper error type


def _number_add(args):
    """Add two values as numbers 将两个值作为数字相加"""
    if len(args) != 2:
        raise EvilValueError("numberAdd function requires exactly two arguments")
    
    try:
        a = NumberType.convert(args[0])
        b = NumberType.convert(args[1])
        return a + b
    except EvilTypeError as e:
        raise e


def _number_sub(args):
    """Subtract two values as numbers 将两个值作为数字相减"""
    if len(args) != 2:
        raise EvilValueError("numberSub function requires exactly two arguments")
    
    try:
        a = NumberType.convert(args[0])
        b = NumberType.convert(args[1])
        return a - b
    except EvilTypeError as e:
        raise e


def _number_mul(args):
    """Multiply two values as numbers 将两个值作为数字相乘"""
    if len(args) != 2:
        raise EvilValueError("numberMul function requires exactly two arguments")
    
    try:
        a = NumberType.convert(args[0])
        b = NumberType.convert(args[1])
        return a * b
    except EvilTypeError as e:
        raise e


def _number_div(args):
    """Divide two values as numbers 将两个值作为数字相除"""
    if len(args) != 2:
        raise EvilValueError("numberDiv function requires exactly two arguments")
    
    try:
        a = NumberType.convert(args[0])
        b = NumberType.convert(args[1])
        
        if b == 0:
            raise EvilValueError("Division by zero")
            
        return a / b
    except EvilTypeError as e:
        raise e


def _abs(args):
    """Get absolute value 获取绝对值"""
    if len(args) != 1:
        raise EvilValueError("abs function requires exactly one argument")
    
    try:
        value = NumberType.convert(args[0])
        return abs(value)
    except EvilTypeError as e:
        raise e


def _round(args):
    """Round a number 四舍五入"""
    if len(args) < 1 or len(args) > 2:
        raise EvilValueError("round function requires one or two arguments")
    
    try:
        value = NumberType.convert(args[0])
        
        if len(args) == 2:
            precision = NumberType.convert(args[1])
            if not isinstance(precision, int):
                precision = int(precision)
            return round(value, precision)
        else:
            return round(value)
    except EvilTypeError as e:
        raise e


def _min(args):
    """Find minimum value 查找最小值"""
    if len(args) == 0:
        raise EvilValueError("min function requires at least one argument")
    
    try:
        # Convert all arguments to numbers
        numbers = [NumberType.convert(arg) for arg in args]
        return min(numbers)
    except EvilTypeError as e:
        raise e


def _max(args):
    """Find maximum value 查找最大值"""
    if len(args) == 0:
        raise EvilValueError("max function requires at least one argument")
    
    try:
        # Convert all arguments to numbers
        numbers = [NumberType.convert(arg) for arg in args]
        return max(numbers)
    except EvilTypeError as e:
        raise e


def _typeof(args):
    """Get the type of a value 获取值的类型"""
    if len(args) != 1:
        raise EvilValueError("typeof function requires exactly one argument")
    
    return get_type_name(args[0])


# Register all numeric functions
register_builtin('toNumber', _to_number)
register_builtin('numberAdd', _number_add)
register_builtin('numberSub', _number_sub)
register_builtin('numberMul', _number_mul)
register_builtin('numberDiv', _number_div)
register_builtin('abs', _abs)
register_builtin('round', _round)
register_builtin('min', _min)
register_builtin('max', _max)
register_builtin('typeof', _typeof)