#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - Error definitions / 异常定义
# Author: Evil0ctal
# Date: 2025-05-04

# ANSI color codes for terminal output / 终端输出的ANSI颜色代码
class Colors:
    """ANSI color codes for terminal output / 终端输出的ANSI颜色代码"""
    RED = '\033[91m'  # For errors / 用于错误
    YELLOW = '\033[93m'  # For warnings / 用于警告
    GREEN = '\033[92m'  # For success / 用于成功
    BLUE = '\033[94m'  # For info / 用于信息
    MAGENTA = '\033[95m'  # For special messages / 用于特殊消息
    CYAN = '\033[96m'  # For debugging / 用于调试
    BOLD = '\033[1m'  # Bold text / 粗体文本
    UNDERLINE = '\033[4m'  # Underlined text / 带下划线的文本
    RESET = '\033[0m'  # Reset to default / 重置为默认


class EvilLangError(Exception):
    """Base error class with call stack tracking capability / 带调用堆栈跟踪功能的基础错误类"""

    def __init__(self, message, line=None, column=None, source_code=None, filename=None):
        self.message = message
        self.line = line
        self.column = column
        self.source_code = source_code  # Store the source code reference
        self.filename = filename        # Store the source filename
        self.call_stack = []
        super().__init__(message)

    def add_stack_frame(self, func_name, line, column):
        """Add a frame to the call stack / 向调用堆栈添加一帧"""
        # Avoid duplicate stack frames / 避免重复的堆栈帧
        frame = (func_name, line, column)
        if not self.call_stack or self.call_stack[-1] != frame:
            self.call_stack.append(frame)

    def format_location(self, line, column):
        """Format location information / 格式化位置信息"""
        if line is not None and column is not None:
            return f"line {line}, column {column}"
        elif line is not None:
            return f"line {line}"
        else:
            return "unknown location"

    def format_code_snippet(self, use_colors=True):
        """Format a code snippet showing the error location"""
        if not self.source_code or self.line is None:
            return ""

        # Colors for formatting
        error_color = Colors.RED if use_colors else ""
        reset = Colors.RESET if use_colors else ""
        bold = Colors.BOLD if use_colors else ""

        lines = self.source_code.splitlines()
        if not lines:  # Handle empty source
            return ""

        # For REPL, we're usually dealing with a single line
        if len(lines) == 1 and self.filename == "REPL":
            result = f"\n{bold}Source:{reset}\n"
            result += f"{error_color}{bold}>>> {lines[0]}{reset}\n"

            # Add a caret pointing to the column if available
            if self.column is not None:
                # Account for prompt when calculating padding
                padding = " " * (self.column + 4)  # 4 for ">>> "
                result += f"{error_color}{padding}^--- Error occurs here{reset}\n"
            return result

    def format_error(self, use_colors=True):
        """Format the error message with stack trace / 使用堆栈跟踪格式化错误消息"""
        # Colors for formatting / 格式化的颜色
        error_color = Colors.RED if use_colors else ""
        reset = Colors.RESET if use_colors else ""
        bold = Colors.BOLD if use_colors else ""

        # Basic error message / 基本错误消息
        result = f"{error_color}{bold}Error:{reset} {self.message}"

        # Add location if available / 如果有位置信息则添加
        if self.line is not None or self.column is not None:
            location = self.format_location(self.line, self.column)
            result += f" at {location}"

        # Format call stack / 格式化调用堆栈
        if self.call_stack:
            result += f"\n{bold}Call stack (most recent call last):{reset}"
            for frame in reversed(self.call_stack):
                func_name, line, column = frame
                loc = self.format_location(line, column)

                # Check if this is a built-in function
                if func_name.startswith("number") or func_name.startswith("string") or func_name.startswith("input"):
                    result += f"\n  Function '{bold}{func_name}{reset}' (built-in function)"
                elif func_name == "main":
                    result += f"\n  {bold}Main program{reset}"
                else:
                    result += f"\n  Function '{bold}{func_name}{reset}' at {loc}"

        # Add code snippet if available
        result += self.format_code_snippet(use_colors)

        return result


class BreakException(Exception):
    """Break statement exception / Break语句异常"""
    pass


class ContinueException(Exception):
    """Continue statement exception / Continue语句异常"""
    pass


class ReturnException(Exception):
    """Return statement with value / 带返回值的Return语句"""

    def __init__(self, value=None):
        self.value = value
        super().__init__(str(value))


class SyntaxError(EvilLangError):
    """Syntax error during parsing / 解析时的语法错误"""
    pass


class RuntimeError(EvilLangError):
    """Runtime error during execution / 执行时的运行时错误"""
    pass


class TypeError(EvilLangError):
    """Type error during operations / 操作期间的类型错误"""
    pass


class NameError(EvilLangError):
    """Error when accessing undefined names / 访问未定义名称时的错误"""
    pass


class ValueError(EvilLangError):
    """Error when a value is not appropriate for an operation / 值不适合操作时的错误"""
    pass


class IndexError(EvilLangError):
    """Error when accessing an invalid index / 访问无效索引时的错误"""
    pass
