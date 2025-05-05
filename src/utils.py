#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 工具函数 / Utility Functions
# Author: Evil0ctal
# Date: 2025-05-04

def validate_boolean_operands(op, left, right):
    """Validate boolean operands 验证布尔操作数"""
    if not isinstance(left, bool) or not isinstance(right, bool):
        raise Exception(f"Operator '{op}' cannot be applied to non-boolean types")


def log_debug(info):
    """Output debug information 输出调试信息"""
    print(f"[DEBUG] {info}")
