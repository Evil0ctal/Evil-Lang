"""
Evil Lang Configuration
配置管理模块，集中管理语言配置项
"""

import os
import sys


class Config:
    """Evil Lang 配置类"""
    
    # 调试选项
    DEBUG = False
    SHOW_TOKENS = False
    SHOW_AST = False
    
    # 输出选项
    USE_COLORS = True
    COLOR_OUTPUT = sys.stdout.isatty()  # 检测是否在终端中运行
    
    # 语言限制
    MAX_RECURSION_DEPTH = 1000
    MAX_LOOP_ITERATIONS = 1000000  # 防止无限循环
    MAX_STRING_LENGTH = 1048576    # 1MB
    MAX_ARRAY_SIZE = 100000
    
    # 文件选项
    DEFAULT_ENCODING = 'utf-8'
    FILE_EXTENSION = '.el'
    
    # REPL选项
    REPL_PROMPT = '>>> '
    REPL_CONTINUATION_PROMPT = '... '
    REPL_HISTORY_SIZE = 1000
    REPL_HISTORY_FILE = os.path.expanduser('~/.evil_lang_history')
    
    # 错误处理
    SHOW_STACK_TRACE = True
    ERROR_CONTEXT_LINES = 3  # 错误上下文显示的行数
    
    # 性能选项
    ENABLE_OPTIMIZATIONS = False
    CACHE_PARSED_FILES = False
    
    @classmethod
    def load_from_args(cls, args):
        """从命令行参数加载配置
        
        Args:
            args: 命令行参数对象
        """
        if hasattr(args, 'debug') and args.debug:
            cls.DEBUG = True
            cls.SHOW_TOKENS = True
            cls.SHOW_AST = True
            cls.SHOW_STACK_TRACE = True
            
        if hasattr(args, 'no_color') and args.no_color:
            cls.USE_COLORS = False
            cls.COLOR_OUTPUT = False
            
        if hasattr(args, 'quiet') and args.quiet:
            cls.SHOW_STACK_TRACE = False
            
    @classmethod
    def reset(cls):
        """重置所有配置为默认值"""
        cls.DEBUG = False
        cls.SHOW_TOKENS = False
        cls.SHOW_AST = False
        cls.USE_COLORS = True
        cls.COLOR_OUTPUT = sys.stdout.isatty()
        cls.SHOW_STACK_TRACE = True
        cls.ENABLE_OPTIMIZATIONS = False
        cls.CACHE_PARSED_FILES = False


class Colors:
    """ANSI颜色代码"""
    
    # 基本颜色
    BLACK = '\033[30m'
    RED = '\033[31m'
    GREEN = '\033[32m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    MAGENTA = '\033[35m'
    CYAN = '\033[36m'
    WHITE = '\033[37m'
    
    # 明亮颜色
    BRIGHT_BLACK = '\033[90m'
    BRIGHT_RED = '\033[91m'
    BRIGHT_GREEN = '\033[92m'
    BRIGHT_YELLOW = '\033[93m'
    BRIGHT_BLUE = '\033[94m'
    BRIGHT_MAGENTA = '\033[95m'
    BRIGHT_CYAN = '\033[96m'
    BRIGHT_WHITE = '\033[97m'
    
    # 样式
    BOLD = '\033[1m'
    DIM = '\033[2m'
    ITALIC = '\033[3m'
    UNDERLINE = '\033[4m'
    
    # 重置
    RESET = '\033[0m'
    
    # 语义颜色
    ERROR = BRIGHT_RED
    WARNING = BRIGHT_YELLOW
    SUCCESS = BRIGHT_GREEN
    INFO = BRIGHT_CYAN
    DEBUG = BRIGHT_MAGENTA
    
    @classmethod
    def colorize(cls, text, color):
        """给文本添加颜色
        
        Args:
            text: 要着色的文本
            color: 颜色代码
            
        Returns:
            str: 着色后的文本
        """
        if Config.USE_COLORS and Config.COLOR_OUTPUT:
            return f"{color}{text}{cls.RESET}"
        return text
    
    @classmethod
    def error(cls, text):
        """错误文本（红色）"""
        return cls.colorize(text, cls.ERROR)
    
    @classmethod
    def warning(cls, text):
        """警告文本（黄色）"""
        return cls.colorize(text, cls.WARNING)
    
    @classmethod
    def success(cls, text):
        """成功文本（绿色）"""
        return cls.colorize(text, cls.SUCCESS)
    
    @classmethod
    def info(cls, text):
        """信息文本（青色）"""
        return cls.colorize(text, cls.INFO)
    
    @classmethod
    def debug(cls, text):
        """调试文本（品红色）"""
        return cls.colorize(text, cls.DEBUG)
    
    @classmethod
    def bold(cls, text):
        """粗体文本"""
        return cls.colorize(text, cls.BOLD)
    
    @classmethod
    def dim(cls, text):
        """暗淡文本"""
        return cls.colorize(text, cls.DIM)