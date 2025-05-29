"""
Evil Lang CLI (Command Line Interface)
命令行接口模块
"""

import argparse
import sys
import os
from .config import Config, Colors
from .lexer import Lexer
from .parser import Parser
from .interpreter import Interpreter
from .errors import EvilLangError
from .repl import start_repl


def create_parser():
    """创建命令行参数解析器"""
    parser = argparse.ArgumentParser(
        prog='evil_lang',
        description='Evil Lang - A lightweight, expressive interpreted programming language',
        epilog='For more information, visit: https://github.com/Evil0ctal/Evil-Lang'
    )
    
    # 位置参数
    parser.add_argument(
        'file',
        nargs='?',
        help='Evil Lang source file to execute (.el)'
    )
    
    # 可选参数
    parser.add_argument(
        '-d', '--debug',
        action='store_true',
        help='Enable debug mode (show tokens, AST, and detailed errors)'
    )
    
    parser.add_argument(
        '--no-color',
        action='store_true',
        help='Disable colored output'
    )
    
    parser.add_argument(
        '-v', '--version',
        action='version',
        version='Evil Lang v1.0.1'
    )
    
    parser.add_argument(
        '-c', '--command',
        help='Execute a single command and exit'
    )
    
    parser.add_argument(
        '--show-tokens',
        action='store_true',
        help='Show lexical tokens (implies --debug)'
    )
    
    parser.add_argument(
        '--show-ast',
        action='store_true',
        help='Show abstract syntax tree (implies --debug)'
    )
    
    parser.add_argument(
        '-q', '--quiet',
        action='store_true',
        help='Suppress error stack traces'
    )
    
    return parser


def read_source_file(filename):
    """读取源文件"""
    if not os.path.exists(filename):
        print(Colors.error(f"Error: File '{filename}' not found"))
        sys.exit(1)
        
    if not filename.endswith('.el'):
        print(Colors.warning(f"Warning: File '{filename}' does not have .el extension"))
    
    try:
        with open(filename, 'r', encoding=Config.DEFAULT_ENCODING) as f:
            return f.read()
    except Exception as e:
        print(Colors.error(f"Error reading file: {str(e)}"))
        sys.exit(1)


def execute_code(source_code, filename='<string>'):
    """执行 Evil Lang 代码"""
    try:
        # 词法分析
        lexer = Lexer(source_code)
        
        if Config.SHOW_TOKENS:
            print(Colors.debug("=== Lexical Tokens ==="))
            # 创建一个新的词法分析器来显示标记
            temp_lexer = Lexer(source_code)
            while True:
                token = temp_lexer.get_next_token()
                if token.type.name == 'EOF':
                    break
                print(Colors.dim(str(token)))
            print()
        
        # 语法分析
        parser = Parser(lexer)
        ast = parser.parse()
        
        if Config.SHOW_AST:
            print(Colors.debug("=== Abstract Syntax Tree ==="))
            print(Colors.dim(str(ast)))
            print()
        
        # 解释执行
        interpreter = Interpreter(source_code, filename)
        result = interpreter.interpret(ast)
        
        if Config.DEBUG and result is not None:
            print(Colors.debug(f"=== Result: {result} ==="))
            
        return 0  # 成功
        
    except EvilLangError as e:
        print(e.format_error(filename=filename))
        return 1  # 错误
        
    except KeyboardInterrupt:
        print("\n" + Colors.warning("Execution interrupted by user"))
        return 130  # 被信号中断
        
    except Exception as e:
        print(Colors.error(f"Unexpected error: {str(e)}"))
        if Config.DEBUG:
            import traceback
            traceback.print_exc()
        return 1


def main():
    """主函数"""
    # 解析命令行参数
    parser = create_parser()
    args = parser.parse_args()
    
    # 应用配置
    Config.load_from_args(args)
    
    # 处理特殊的调试选项
    if args.show_tokens:
        Config.SHOW_TOKENS = True
        Config.DEBUG = True
    
    if args.show_ast:
        Config.SHOW_AST = True
        Config.DEBUG = True
    
    # 执行单个命令
    if args.command:
        exit_code = execute_code(args.command, '<command>')
        sys.exit(exit_code)
    
    # 执行文件
    if args.file:
        source_code = read_source_file(args.file)
        exit_code = execute_code(source_code, args.file)
        sys.exit(exit_code)
    
    # 没有参数，启动 REPL
    try:
        start_repl()
    except Exception as e:
        print(Colors.error(f"Failed to start REPL: {str(e)}"))
        sys.exit(1)


if __name__ == '__main__':
    main()