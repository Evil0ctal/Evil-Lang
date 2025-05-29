#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 字符串处理内置函数 / String Processing Built-in Functions
# Author: Evil0ctal
# Date: 2025-05-04

from . import register_builtin


def _to_string(args):
    """Convert value to string 将值转换为字符串"""
    if len(args) != 1:
        raise Exception("toString函数需要一个参数")

    value = args[0]

    # 将任意值转换为字符串
    if value is None:
        return "null"
    elif isinstance(value, bool):
        return "true" if value else "false"
    else:
        return str(value)


def _string_length(args):
    """Get string length 获取字符串长度"""
    if len(args) != 1:
        raise Exception("stringLength函数需要一个参数")

    value = args[0]

    # 确保参数是字符串
    if not isinstance(value, str):
        raise Exception(f"stringLength函数需要字符串参数，得到了 {type(value)}")

    return len(value)


def _string_concat(args):
    """Concatenate strings 连接字符串"""
    result = ""
    for arg in args:
        # 将所有参数转换为字符串
        if arg is None:
            result += "null"
        elif isinstance(arg, bool):
            result += "true" if arg else "false"
        else:
            result += str(arg)

    return result


def _string_substring(args):
    """Get substring 获取子字符串"""
    if len(args) < 2 or len(args) > 3:
        raise Exception("substring函数需要2-3个参数: (字符串, 开始索引, [结束索引])")

    string = args[0]
    start = args[1]

    # 确保参数类型正确
    if not isinstance(string, str):
        raise Exception("substring函数的第一个参数必须是字符串")

    if not isinstance(start, int):
        raise Exception("substring函数的第二个参数必须是整数")

    # 有结束索引
    if len(args) == 3:
        end = args[2]
        if not isinstance(end, int):
            raise Exception("substring函数的第三个参数必须是整数")

        # 边界检查
        if start < 0 or start > len(string):
            raise Exception(f"substring函数的开始索引越界: {start}")
        if end < 0 or end > len(string):
            raise Exception(f"substring函数的结束索引越界: {end}")
        if start > end:
            raise Exception(f"substring函数的开始索引不能大于结束索引: {start} > {end}")

        return string[start:end]
    else:
        # 只有开始索引
        if start < 0 or start > len(string):
            raise Exception(f"substring函数的开始索引越界: {start}")

        return string[start:]


def _string_index_of(args):
    """Find substring in string 查找子字符串位置"""
    if len(args) != 2:
        raise Exception("indexOf函数需要两个参数: (字符串, 要查找的子串)")

    string = args[0]
    substr = args[1]

    # 确保参数类型正确
    if not isinstance(string, str):
        raise Exception("indexOf函数的第一个参数必须是字符串")

    if not isinstance(substr, str):
        raise Exception("indexOf函数的第二个参数必须是字符串")

    return string.find(substr)


def _string_replace(args):
    """Replace substring in string 替换字符串"""
    if len(args) != 3:
        raise Exception("replace函数需要三个参数: (字符串, 要替换的子串, 替换成的子串)")

    string = args[0]
    old = args[1]
    new = args[2]

    # 确保参数类型正确
    if not isinstance(string, str):
        raise Exception("replace函数的第一个参数必须是字符串")

    if not isinstance(old, str):
        raise Exception("replace函数的第二个参数必须是字符串")

    if not isinstance(new, str):
        raise Exception("replace函数的第三个参数必须是字符串")

    return string.replace(old, new)


def _string_to_upper(args):
    """Convert string to uppercase 转换为大写"""
    if len(args) != 1:
        raise Exception("toUpper函数需要一个参数")
    
    string = args[0]
    if not isinstance(string, str):
        raise Exception("toUpper函数的参数必须是字符串")
    
    return string.upper()


def _string_to_lower(args):
    """Convert string to lowercase 转换为小写"""
    if len(args) != 1:
        raise Exception("toLower函数需要一个参数")
    
    string = args[0]
    if not isinstance(string, str):
        raise Exception("toLower函数的参数必须是字符串")
    
    return string.lower()


def _string_trim(args):
    """Trim whitespace from string 去除字符串两端空白"""
    if len(args) != 1:
        raise Exception("trim函数需要一个参数")
    
    string = args[0]
    if not isinstance(string, str):
        raise Exception("trim函数的参数必须是字符串")
    
    return string.strip()


def _string_split(args):
    """Split string by delimiter 按分隔符分割字符串"""
    if len(args) < 1 or len(args) > 2:
        raise Exception("split函数需要1-2个参数: (字符串, [分隔符])")
    
    string = args[0]
    if not isinstance(string, str):
        raise Exception("split函数的第一个参数必须是字符串")
    
    if len(args) == 2:
        delimiter = args[1]
        if not isinstance(delimiter, str):
            raise Exception("split函数的第二个参数必须是字符串")
        return string.split(delimiter)
    else:
        # 默认按空白字符分割
        return string.split()


def _string_join(args):
    """Join array elements into string 将数组元素连接成字符串"""
    if len(args) != 2:
        raise Exception("join函数需要两个参数: (分隔符, 数组)")
    
    delimiter = args[0]
    array = args[1]
    
    if not isinstance(delimiter, str):
        raise Exception("join函数的第一个参数必须是字符串")
    
    if not isinstance(array, list):
        raise Exception("join函数的第二个参数必须是数组")
    
    # 将数组元素转换为字符串
    str_array = []
    for item in array:
        if item is None:
            str_array.append("null")
        elif isinstance(item, bool):
            str_array.append("true" if item else "false")
        else:
            str_array.append(str(item))
    
    return delimiter.join(str_array)


def _char_at(args):
    """Get character at index 获取指定位置的字符"""
    if len(args) != 2:
        raise Exception("charAt函数需要两个参数: (字符串, 索引)")
    
    string = args[0]
    index = args[1]
    
    if not isinstance(string, str):
        raise Exception("charAt函数的第一个参数必须是字符串")
    
    if not isinstance(index, int):
        raise Exception("charAt函数的第二个参数必须是整数")
    
    if index < 0 or index >= len(string):
        raise Exception(f"charAt函数的索引越界: {index}")
    
    return string[index]


# 注册内置函数
register_builtin('toString', _to_string)
register_builtin('stringLength', _string_length)
register_builtin('stringConcat', _string_concat)
register_builtin('substring', _string_substring)
register_builtin('indexOf', _string_index_of)
register_builtin('replace', _string_replace)
register_builtin('toUpper', _string_to_upper)
register_builtin('toLower', _string_to_lower)
register_builtin('trim', _string_trim)
register_builtin('split', _string_split)
register_builtin('join', _string_join)
register_builtin('charAt', _char_at)
