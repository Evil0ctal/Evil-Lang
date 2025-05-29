"""
Evil Lang REPL (Read-Eval-Print Loop)
交互式解释器环境
"""

import sys
import os
import readline
import atexit
from .config import Config, Colors
from .lexer import Lexer
from .parser import Parser
from .interpreter import Interpreter
from .errors import EvilLangError


class REPL:
    """Evil Lang 交互式解释器"""
    
    def __init__(self):
        self.interpreter = Interpreter(filename="<repl>")
        self.history_file = Config.REPL_HISTORY_FILE
        self.setup_readline()
        
    def setup_readline(self):
        """设置 readline 历史记录"""
        try:
            # 设置历史文件
            if os.path.exists(self.history_file):
                readline.read_history_file(self.history_file)
            
            # 设置历史记录大小
            readline.set_history_length(Config.REPL_HISTORY_SIZE)
            
            # 注册退出时保存历史
            atexit.register(self.save_history)
            
            # 设置自动完成
            readline.set_completer(self.completer)
            readline.parse_and_bind('tab: complete')
            
        except Exception:
            # 某些系统可能不支持 readline
            pass
    
    def save_history(self):
        """保存历史记录"""
        try:
            readline.write_history_file(self.history_file)
        except Exception:
            pass
    
    def completer(self, text, state):
        """简单的自动完成功能"""
        # 获取所有可能的完成项
        options = []
        
        # 添加关键字
        keywords = ['var', 'if', 'else', 'while', 'for', 'func', 'return', 
                   'break', 'continue', 'true', 'false', 'null', 'print', 'input']
        
        # 添加内置函数
        builtins = list(self.interpreter.builtins.keys())
        
        # 添加已定义的变量和函数
        variables = list(self.interpreter.global_scope.keys())
        functions = list(self.interpreter.functions.keys())
        
        # 合并所有选项
        options.extend(keywords)
        options.extend(builtins)
        options.extend(variables)
        options.extend(functions)
        
        # 过滤匹配的选项
        matches = [opt for opt in options if opt.startswith(text)]
        
        # 返回第 state 个匹配项
        if state < len(matches):
            return matches[state]
        return None
    
    def print_welcome(self):
        """打印欢迎信息"""
        print(Colors.bold("Evil Lang REPL v1.0.1"))
        print(Colors.dim("Type 'exit' or 'quit' to leave, 'help' for help"))
        print()
    
    def print_help(self):
        """打印帮助信息"""
        help_text = """
Available commands:
  exit, quit    - Exit the REPL
  help          - Show this help message
  clear         - Clear the screen
  reset         - Reset the interpreter state
  debug on/off  - Toggle debug mode

Special variables:
  _             - Result of the last expression

Examples:
  > var x = 10;
  > print(x * 2);
  > func greet(name) { return "Hello, " + name + "!"; }
  > print(greet("World"));
"""
        print(Colors.info(help_text))
    
    def is_complete_statement(self, code):
        """检查代码是否是完整的语句"""
        # 简单的括号匹配检查
        brackets = {'(': ')', '{': '}', '[': ']'}
        stack = []
        in_string = False
        escape_next = False
        
        for char in code:
            if escape_next:
                escape_next = False
                continue
                
            if char == '\\' and in_string:
                escape_next = True
                continue
                
            if char == '"':
                in_string = not in_string
                continue
                
            if in_string:
                continue
                
            if char in brackets:
                stack.append(brackets[char])
            elif char in brackets.values():
                if not stack or stack[-1] != char:
                    return True  # 不匹配，认为是完整的（会报错）
                stack.pop()
        
        # 如果栈不为空，说明还有未匹配的括号
        return len(stack) == 0
    
    def get_multiline_input(self):
        """获取多行输入"""
        lines = []
        prompt = Config.REPL_PROMPT
        
        while True:
            try:
                line = input(prompt)
                lines.append(line)
                
                # 检查是否是完整的语句
                code = '\n'.join(lines)
                if self.is_complete_statement(code):
                    return code
                    
                # 继续输入
                prompt = Config.REPL_CONTINUATION_PROMPT
                
            except KeyboardInterrupt:
                print()  # 新行
                return None
            except EOFError:
                if lines:
                    return '\n'.join(lines)
                raise
    
    def execute(self, code):
        """执行代码并返回结果"""
        try:
            # 词法分析
            lexer = Lexer(code)
            
            if Config.SHOW_TOKENS:
                # 调试模式：显示标记
                print(Colors.debug("=== Tokens ==="))
                temp_lexer = Lexer(code)
                tokens = []
                while True:
                    token = temp_lexer.get_next_token()
                    if token.type.name == 'EOF':
                        break
                    tokens.append(str(token))
                    print(Colors.dim(str(token)))
                print()
            
            # 语法分析
            parser = Parser(lexer)
            ast = parser.parse()
            
            if Config.SHOW_AST:
                # 调试模式：显示 AST
                print(Colors.debug("=== AST ==="))
                print(Colors.dim(str(ast)))
                print()
            
            # 解释执行
            # 更新解释器的源代码引用
            self.interpreter.source_code = code
            result = self.interpreter.interpret(ast)
            
            # 保存最后的结果到特殊变量 _
            if result is not None:
                self.interpreter.global_scope['_'] = result
                
            return result
            
        except EvilLangError as e:
            print(e.format_error())
            return None
        except Exception as e:
            print(Colors.error(f"Error: {str(e)}"))
            return None
    
    def run(self):
        """运行 REPL"""
        self.print_welcome()
        
        while True:
            try:
                # 获取输入
                code = self.get_multiline_input()
                
                if code is None:
                    continue
                
                # 处理特殊命令
                code_stripped = code.strip().lower()
                
                if code_stripped in ['exit', 'quit']:
                    print(Colors.info("Goodbye!"))
                    break
                    
                elif code_stripped == 'help':
                    self.print_help()
                    continue
                    
                elif code_stripped == 'clear':
                    os.system('clear' if os.name != 'nt' else 'cls')
                    continue
                    
                elif code_stripped == 'reset':
                    self.interpreter = Interpreter(filename="<repl>")
                    print(Colors.success("Interpreter state reset."))
                    continue
                    
                elif code_stripped == 'debug on':
                    Config.DEBUG = True
                    Config.SHOW_TOKENS = True
                    Config.SHOW_AST = True
                    print(Colors.success("Debug mode enabled."))
                    continue
                    
                elif code_stripped == 'debug off':
                    Config.DEBUG = False
                    Config.SHOW_TOKENS = False
                    Config.SHOW_AST = False
                    print(Colors.success("Debug mode disabled."))
                    continue
                
                # 执行代码
                if code.strip():
                    result = self.execute(code)
                    
                    # 如果是表达式且有返回值，打印结果
                    if result is not None and not code.strip().endswith(';'):
                        print(Colors.dim(f"=> {result}"))
                        
            except KeyboardInterrupt:
                print("\n" + Colors.warning("Use 'exit' or 'quit' to leave."))
                continue
                
            except EOFError:
                print("\n" + Colors.info("Goodbye!"))
                break
                
            except Exception as e:
                print(Colors.error(f"REPL Error: {str(e)}"))
                if Config.DEBUG:
                    import traceback
                    traceback.print_exc()


def start_repl():
    """启动 REPL 的便捷函数"""
    repl = REPL()
    repl.run()