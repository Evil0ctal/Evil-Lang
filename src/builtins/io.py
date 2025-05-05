#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 输入输出增强内置函数 / Enhanced I/O Built-in Functions
# Author: Evil0ctal
# Date: 2025-05-04

from . import register_builtin


def _print_line(args):
    """Print with line break 打印并换行"""
    if len(args) == 0:
        print()
        return None

    # 将所有参数转换为字符串并打印
    result = ""
    for arg in args:
        if arg is None:
            result += "null"
        elif isinstance(arg, bool):
            result += "true" if arg else "false"
        else:
            result += str(arg)

    print(result)
    return None


def _input_number(args):
    """Input with automatic number conversion 输入并自动转换为数字"""
    prompt = ""
    if len(args) > 0:
        prompt = str(args[0])

    value = input(prompt)

    # 尝试自动转换为数字
    try:
        if '.' in value:
            return float(value)
        else:
            return int(value)
    except ValueError:
        # 如果转换失败，返回原始字符串
        return value


def _format(args):
    """Format string with placeholders 使用占位符格式化字符串"""
    if len(args) < 1:
        raise Exception("format函数至少需要一个参数: (格式字符串, 参数1, 参数2, ...)")

    format_string = args[0]

    if not isinstance(format_string, str):
        raise Exception("format函数的第一个参数必须是字符串")

    # 提取其余参数
    format_args = args[1:]

    # 执行格式化
    try:
        # 使用Python的字符串格式化，将{}替换为参数
        result = format_string
        for i, arg in enumerate(format_args):
            result = result.replace(f"{{{i}}}", str(arg))
        return result
    except Exception as e:
        raise Exception(f"格式化字符串失败: {str(e)}")


# 注册内置函数
register_builtin('printLine', _print_line)
register_builtin('inputNumber', _input_number)
register_builtin('format', _format)
