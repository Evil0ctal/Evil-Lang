#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Evil Lang - Main Entry Point
主入口文件

A lightweight, expressive interpreted programming language
轻量级、富有表现力的解释型编程语言
"""

import sys
from src.cli import main
from src.repl import start_repl

if __name__ == "__main__":
    # 如果有命令行参数，使用 CLI 模块处理
    # If there are command line arguments, use CLI module
    if len(sys.argv) > 1:
        main()
    else:
        # 否则启动 REPL
        # Otherwise start REPL
        start_repl()
