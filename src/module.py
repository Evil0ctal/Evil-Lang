"""
Evil Lang Module System
模块系统实现
"""

import os
import sys
from pathlib import Path
from .lexer import Lexer
from .parser import Parser
from .errors import RuntimeError as EvilRuntimeError
from .config import Config


class Module:
    """表示一个Evil Lang模块"""
    
    def __init__(self, path, exports=None):
        self.path = path
        self.exports = exports or {}
        self.loaded = False
        self.source_code = None
        self.ast = None


class ModuleManager:
    """模块管理器，负责加载、缓存和管理模块"""
    
    def __init__(self, interpreter):
        self.interpreter = interpreter
        self.modules = {}  # 模块缓存
        self.module_paths = [
            os.getcwd(),  # 当前工作目录
            os.path.join(os.path.dirname(__file__), 'stdlib'),  # 标准库目录
        ]
        self.current_module_path = None  # 当前正在执行的模块路径
        
    def add_module_path(self, path):
        """添加模块搜索路径"""
        if path not in self.module_paths:
            self.module_paths.append(path)
    
    def resolve_module_path(self, module_name, from_path=None):
        """解析模块路径
        
        Args:
            module_name: 模块名或路径
            from_path: 导入语句所在文件的路径
            
        Returns:
            str: 解析后的完整文件路径
        """
        # 如果是相对路径
        if module_name.startswith('./') or module_name.startswith('../'):
            if from_path:
                base_dir = os.path.dirname(from_path)
                full_path = os.path.normpath(os.path.join(base_dir, module_name))
            else:
                full_path = os.path.normpath(module_name)
        else:
            # 搜索模块路径
            for search_path in self.module_paths:
                full_path = os.path.join(search_path, module_name)
                if os.path.exists(full_path + '.el'):
                    full_path = full_path + '.el'
                    break
                elif os.path.exists(full_path):
                    break
            else:
                raise EvilRuntimeError(f"Module not found: {module_name}")
        
        # 添加 .el 扩展名（如果需要）
        if not full_path.endswith('.el') and os.path.exists(full_path + '.el'):
            full_path = full_path + '.el'
            
        if not os.path.exists(full_path):
            raise EvilRuntimeError(f"Module file not found: {full_path}")
            
        return os.path.abspath(full_path)
    
    def load_module(self, module_path):
        """加载模块
        
        Args:
            module_path: 模块的完整路径
            
        Returns:
            Module: 加载的模块对象
        """
        # 检查缓存
        if module_path in self.modules:
            return self.modules[module_path]
        
        # 创建新模块
        module = Module(module_path)
        
        # 读取源代码
        try:
            with open(module_path, 'r', encoding=Config.DEFAULT_ENCODING) as f:
                module.source_code = f.read()
        except Exception as e:
            raise EvilRuntimeError(f"Failed to read module {module_path}: {str(e)}")
        
        # 解析模块
        lexer = Lexer(module.source_code)
        parser = Parser(lexer)
        parser.filename = module_path
        
        try:
            module.ast = parser.parse()
        except Exception as e:
            raise EvilRuntimeError(f"Failed to parse module {module_path}: {str(e)}")
        
        # 缓存模块
        self.modules[module_path] = module
        
        # 在新的作用域中执行模块
        saved_scope = self.interpreter.global_scope.copy()
        saved_functions = self.interpreter.functions.copy()
        saved_module_path = self.current_module_path
        
        # 创建模块作用域
        module_scope = {}
        module_functions = {}
        
        # 添加内置函数到模块作用域
        for name, func in self.interpreter.builtins.items():
            module_scope[name] = func
        
        # 设置当前模块路径
        self.current_module_path = module_path
        
        # 执行模块
        self.interpreter.global_scope = module_scope
        self.interpreter.functions = module_functions
        self.interpreter.module_exports = {}  # 收集导出
        
        try:
            self.interpreter.visit(module.ast)
            module.exports = self.interpreter.module_exports.copy()
            module.loaded = True
        finally:
            # 恢复原始作用域
            self.interpreter.global_scope = saved_scope
            self.interpreter.functions = saved_functions
            self.current_module_path = saved_module_path
            if hasattr(self.interpreter, 'module_exports'):
                delattr(self.interpreter, 'module_exports')
        
        return module
    
    def import_module(self, module_name, items=None, alias=None, from_path=None):
        """导入模块
        
        Args:
            module_name: 模块名
            items: 要导入的特定项
            alias: 模块别名
            from_path: 导入语句所在文件的路径
            
        Returns:
            dict: 导入的符号字典
        """
        # 解析模块路径
        module_path = self.resolve_module_path(module_name, from_path)
        
        # 加载模块
        module = self.load_module(module_path)
        
        # 处理导入
        imports = {}
        
        if items:
            # 导入特定项
            for item in items:
                if item.name in module.exports:
                    import_name = item.alias or item.name
                    imports[import_name] = module.exports[item.name]
                else:
                    raise EvilRuntimeError(
                        f"Module '{module_name}' has no export '{item.name}'"
                    )
        else:
            # 导入整个模块
            if alias:
                # import module as alias
                imports[alias] = module.exports
            else:
                # import module (将所有导出添加到当前作用域)
                imports.update(module.exports)
        
        return imports