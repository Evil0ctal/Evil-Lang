#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 内置函数注册 / Built-in Function Registry
# Author: Evil0ctal
# Date: 2025-05-04

# 内置函数注册表
_builtin_functions = {}


def register_builtin(name, func):
    """Register a built-in function 注册内置函数"""
    _builtin_functions[name] = func


def get_builtins():
    """Get all registered built-in functions 获取所有注册的内置函数"""
    return _builtin_functions.copy()


# 导入各模块中的内置函数
from .numeric import *
from .string import *
from .io import *
from .array import *

# 可以在这里添加其他内置函数模块
