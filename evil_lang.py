#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 主入口文件 / Main Entry File
# Author: Evil0ctal
# Date: 2025-05-04

import sys

from src.errors import EvilLangError, Colors
from src.lexer import Lexer, TokenType
from src.parser import Parser
from src.interpreter import Interpreter


# 辅助函数：检查源代码中的关键字识别
# Utility function to check keyword recognition in source code
def check_keywords(source_code):
    """Check keyword recognition in source code 检查源代码中的关键字识别"""
    print("\n检查源代码中的'input'关键字识别：")
    lines = source_code.split('\n')
    for i, line in enumerate(lines):
        if 'input' in line:
            print(f"行 {i + 1}: {line}")
            # 简单的词法分析
            lexer = Lexer(line)
            tokens = []
            token = lexer.get_next_token()
            while token.type != TokenType.EOF:
                tokens.append(token)
                token = lexer.get_next_token()
            print("词法分析结果:")
            for t in tokens:
                print(f"  {t}")


def main():
    """Main function / 主函数"""
    if len(sys.argv) < 2:
        print(f"{Colors.RED}Usage: python evil_lang.py <filename> [--debug] [--no-color]{Colors.RESET}")
        sys.exit(1)

    debug_mode = '--debug' in sys.argv
    use_colors = '--no-color' not in sys.argv
    filename = sys.argv[1]

    try:
        # Open file with UTF-8 encoding to support Unicode characters
        # 使用UTF-8编码打开文件以支持Unicode字符
        with open(filename, 'r', encoding='utf-8') as f:
            source_code = f.read()
    except FileNotFoundError:
        print(f"{Colors.RED}Error: Cannot open file '{filename}'{Colors.RESET}")
        sys.exit(1)

    # Check keyword recognition if debug mode is enabled
    # 如果启用调试模式，检查关键字识别
    if debug_mode:
        check_keywords(source_code)

    lexer = Lexer(source_code)
    parser = Parser(lexer)
    parser.debug_mode = debug_mode

    try:
        tree = parser.parse()
        interpreter = Interpreter(source_code, filename)
        result = interpreter.interpret(tree)
        return result
    except EvilLangError as e:
        print(e.format_error(use_colors))
        if debug_mode:
            print(f"\n{Colors.CYAN}Debug info:{Colors.RESET}")
            import traceback
            traceback.print_exc()
        sys.exit(1)


def repl():
    """Interactive REPL for Evil Lang"""
    print("Welcome to Evil-Programming-Language REPL (输入exit退出 / type 'exit' to quit)")

    # Create a persistent interpreter for the REPL session
    interpreter = Interpreter(filename="REPL")

    while True:
        try:
            text = input(">>> ")
            if text.lower() == 'exit':
                break

            # Add a semicolon automatically if missing
            if text and not text.strip().endswith(';'):
                text += ';'

            lexer = Lexer(text)
            parser = Parser(lexer)
            parser.filename = "REPL"  # Set filename for error reporting

            try:
                tree = parser.parse()
                result = interpreter.interpret(tree)

                # Only print non-None results
                if result is not None:
                    print(result)

            except EvilLangError as e:
                # Use our enhanced error formatting
                print(e.format_error(use_colors=True))

        except KeyboardInterrupt:
            print("\nExiting Evil-Programming-Language REPL...")
            break
        except Exception as e:
            print(f"{Colors.RED}Unhandled error: {str(e)}{Colors.RESET}")
            if '--debug' in sys.argv:
                import traceback
                traceback.print_exc()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        main()
    else:
        repl()
