#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 数组处理内置函数 / Array Processing Built-in Functions
# Author: Evil0ctal
# Date: 2025-05-28

from . import register_builtin


def _array_push(args):
    """Push element to array 向数组添加元素"""
    if len(args) != 2:
        raise Exception("push函数需要两个参数: (数组, 元素)")
    
    array = args[0]
    element = args[1]
    
    if not isinstance(array, list):
        raise Exception("push函数的第一个参数必须是数组")
    
    array.append(element)
    return len(array)  # 返回新长度


def _array_pop(args):
    """Pop element from array 从数组弹出元素"""
    if len(args) != 1:
        raise Exception("pop函数需要一个参数: 数组")
    
    array = args[0]
    
    if not isinstance(array, list):
        raise Exception("pop函数的参数必须是数组")
    
    if len(array) == 0:
        raise Exception("不能从空数组中弹出元素")
    
    return array.pop()


def _array_shift(args):
    """Remove first element from array 移除数组第一个元素"""
    if len(args) != 1:
        raise Exception("shift函数需要一个参数: 数组")
    
    array = args[0]
    
    if not isinstance(array, list):
        raise Exception("shift函数的参数必须是数组")
    
    if len(array) == 0:
        raise Exception("不能从空数组中移除元素")
    
    return array.pop(0)


def _array_unshift(args):
    """Add element to beginning of array 向数组开头添加元素"""
    if len(args) != 2:
        raise Exception("unshift函数需要两个参数: (数组, 元素)")
    
    array = args[0]
    element = args[1]
    
    if not isinstance(array, list):
        raise Exception("unshift函数的第一个参数必须是数组")
    
    array.insert(0, element)
    return len(array)  # 返回新长度


def _array_slice(args):
    """Get slice of array 获取数组切片"""
    if len(args) < 2 or len(args) > 3:
        raise Exception("slice函数需要2-3个参数: (数组, 开始索引, [结束索引])")
    
    array = args[0]
    start = args[1]
    
    if not isinstance(array, list):
        raise Exception("slice函数的第一个参数必须是数组")
    
    if not isinstance(start, int):
        raise Exception("slice函数的第二个参数必须是整数")
    
    if len(args) == 3:
        end = args[2]
        if not isinstance(end, int):
            raise Exception("slice函数的第三个参数必须是整数")
        return array[start:end]
    else:
        return array[start:]


def _array_reverse(args):
    """Reverse array 反转数组"""
    if len(args) != 1:
        raise Exception("reverse函数需要一个参数: 数组")
    
    array = args[0]
    
    if not isinstance(array, list):
        raise Exception("reverse函数的参数必须是数组")
    
    # 创建新数组，不修改原数组
    return array[::-1]


def _array_sort(args):
    """Sort array 排序数组"""
    if len(args) != 1:
        raise Exception("sort函数需要一个参数: 数组")
    
    array = args[0]
    
    if not isinstance(array, list):
        raise Exception("sort函数的参数必须是数组")
    
    # 创建新数组，不修改原数组
    return sorted(array)


def _array_includes(args):
    """Check if array includes element 检查数组是否包含元素"""
    if len(args) != 2:
        raise Exception("includes函数需要两个参数: (数组, 元素)")
    
    array = args[0]
    element = args[1]
    
    if not isinstance(array, list):
        raise Exception("includes函数的第一个参数必须是数组")
    
    return element in array


def _array_index_of(args):
    """Find index of element in array 查找元素在数组中的索引"""
    if len(args) != 2:
        raise Exception("arrayIndexOf函数需要两个参数: (数组, 元素)")
    
    array = args[0]
    element = args[1]
    
    if not isinstance(array, list):
        raise Exception("arrayIndexOf函数的第一个参数必须是数组")
    
    try:
        return array.index(element)
    except ValueError:
        return -1


def _array_concat(args):
    """Concatenate arrays 连接数组"""
    if len(args) < 1:
        raise Exception("concat函数至少需要一个参数")
    
    result = []
    for arg in args:
        if isinstance(arg, list):
            result.extend(arg)
        else:
            # 如果不是数组，作为单个元素添加
            result.append(arg)
    
    return result


def _array_filter(args):
    """Filter array by condition 按条件过滤数组"""
    if len(args) != 2:
        raise Exception("filter函数需要两个参数: (数组, 条件函数)")
    
    array = args[0]
    predicate = args[1]
    
    if not isinstance(array, list):
        raise Exception("filter函数的第一个参数必须是数组")
    
    # 暂时返回原数组，因为需要函数作为参数的支持
    # TODO: 实现函数作为参数传递后再完善
    return array


def _array_map(args):
    """Map array elements 映射数组元素"""
    if len(args) != 2:
        raise Exception("map函数需要两个参数: (数组, 映射函数)")
    
    array = args[0]
    mapper = args[1]
    
    if not isinstance(array, list):
        raise Exception("map函数的第一个参数必须是数组")
    
    # 暂时返回原数组，因为需要函数作为参数的支持
    # TODO: 实现函数作为参数传递后再完善
    return array


# 注册内置函数
register_builtin('push', _array_push)
register_builtin('pop', _array_pop)
register_builtin('shift', _array_shift)
register_builtin('unshift', _array_unshift)
register_builtin('slice', _array_slice)
register_builtin('arrayReverse', _array_reverse)
register_builtin('arraySort', _array_sort)
register_builtin('includes', _array_includes)
register_builtin('arrayIndexOf', _array_index_of)
register_builtin('concat', _array_concat)
register_builtin('filter', _array_filter)
register_builtin('map', _array_map)