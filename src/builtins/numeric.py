#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 数值处理内置函数 / Numeric Processing Built-in Functions
# Author: Evil0ctal
# Date: 2025-05-04

from . import register_builtin


def _to_number(args):
    """Convert value to number 将值转换为数字"""
    if len(args) != 1:
        raise Exception("toNumber函数需要一个参数")

    value = args[0]

    # 如果已经是数字类型直接返回
    if isinstance(value, (int, float)):
        return value

    # 如果是字符串尝试转换
    if isinstance(value, str):
        try:
            # 先尝试转换为整数
            if '.' in value:
                return float(value)
            else:
                return int(value)
        except ValueError:
            raise Exception(f"无法将字符串 '{value}' 转换为数字")

    raise Exception(f"无法将类型 {type(value)} 转换为数字")


def _number_add(args):
    """Add two values as numbers / 将两个值作为数字相加"""
    try:
        if len(args) != 2:
            raise ValueError("numberAdd function requires two arguments")

        a, b = args

        # Try to convert arguments to numbers / 尝试将参数转换为数字
        if isinstance(a, str):
            try:
                a = float(a) if '.' in a else int(a)
            except ValueError:
                raise ValueError(f"Cannot convert string '{a}' to a number")

        if isinstance(b, str):
            try:
                b = float(b) if '.' in b else int(b)
            except ValueError:
                raise ValueError(f"Cannot convert string '{b}' to a number")

        return a + b
    except Exception as e:
        # Convert any regular Python exceptions to our custom error types
        if isinstance(e, ValueError):
            # Already our custom error type, just re-raise
            raise
        else:
            # Wrap in our custom error type
            raise RuntimeError(str(e))


def _number_sub(args):
    """Subtract two values as numbers 将两个值作为数字相减"""
    if len(args) != 2:
        raise Exception("numberSub函数需要两个参数")

    a, b = args

    # 尝试将两个参数转换为数字
    if isinstance(a, str):
        try:
            a = float(a) if '.' in a else int(a)
        except ValueError:
            raise Exception(f"无法将字符串 '{a}' 转换为数字")

    if isinstance(b, str):
        try:
            b = float(b) if '.' in b else int(b)
        except ValueError:
            raise Exception(f"无法将字符串 '{b}' 转换为数字")

    return a - b


def _number_mul(args):
    """Multiply two values as numbers 将两个值作为数字相乘"""
    if len(args) != 2:
        raise Exception("numberMul函数需要两个参数")

    a, b = args

    # 尝试将两个参数转换为数字
    if isinstance(a, str):
        try:
            a = float(a) if '.' in a else int(a)
        except ValueError:
            raise Exception(f"无法将字符串 '{a}' 转换为数字")

    if isinstance(b, str):
        try:
            b = float(b) if '.' in b else int(b)
        except ValueError:
            raise Exception(f"无法将字符串 '{b}' 转换为数字")

    return a * b


def _number_div(args):
    """Divide two values as numbers 将两个值作为数字相除"""
    if len(args) != 2:
        raise Exception("numberDiv函数需要两个参数")

    a, b = args

    # 尝试将两个参数转换为数字
    if isinstance(a, str):
        try:
            a = float(a) if '.' in a else int(a)
        except ValueError:
            raise Exception(f"无法将字符串 '{a}' 转换为数字")

    if isinstance(b, str):
        try:
            b = float(b) if '.' in b else int(b)
        except ValueError:
            raise Exception(f"无法将字符串 '{b}' 转换为数字")

    if b == 0:
        raise Exception("除数不能为零")

    return a / b


def _typeof(args):
    """Get the type of a value"""
    if len(args) != 1:
        raise ValueError("typeof function requires exactly one argument")

    value = args[0]

    if value is None:
        return "null"
    elif isinstance(value, bool):
        return "boolean"
    elif isinstance(value, (int, float)):
        return "number"
    elif isinstance(value, str):
        return "string"
    elif isinstance(value, list):
        return "array"
    elif isinstance(value, dict):
        return "object"
    elif callable(value) or hasattr(value, 'func_node'):
        return "function"
    else:
        return "unknown"


# 注册内置函数 / Register built-in functions
register_builtin('toNumber', _to_number)
register_builtin('numberAdd', _number_add)
register_builtin('numberSub', _number_sub)
register_builtin('numberMul', _number_mul)
register_builtin('numberDiv', _number_div)
register_builtin('typeof', _typeof)
