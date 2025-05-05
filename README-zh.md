# Evil Lang 🔮

[![Version](https://img.shields.io/badge/version-1.0.1-blue)](https://github.com/Evil0ctal/Evil-Lang)
[![Python](https://img.shields.io/badge/python-3.6+-yellow)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/Evil0ctal/Evil-Lang/blob/main/LICENSE)
[![Stars](https://img.shields.io/github/stars/Evil0ctal/Evil-Lang?style=social)](https://github.com/Evil0ctal/Evil-Lang)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Evil0ctal/Evil-Lang/pulls)
![View Count](https://views.whatilearened.today/views/github/Evil0ctal/Evil-Lang.svg)
[![Made with ❤️](https://img.shields.io/badge/made%20with-%E2%9D%A4%EF%B8%8F-red)](https://github.com/Evil0ctal)

**Evil Lang(Evil Program Language)** 是一款轻量级、富有表现力的解释型编程语言，它融合了命令式和函数式编程的精华，专为教育与学习编程语言实现原理而设计。它不仅是一个编程语言，更是一次穿越编程语言内部奥秘的冒险之旅！

<p align="center">
  <img src="/assets/EPL.jpg" alt="Evil Lang Logo" width="100"/>
</p>

```javascript
// Evil Lang 代码示例：闭包与高阶函数
func createFibGenerator() {
    var a = 0;
    var b = 1;
    
    func next() {
        var temp = a;
        a = b;
        b = temp + b;
        return temp;
    }
    
    return next;
}

var fib = createFibGenerator();
for (var i = 0; i < 10; i = i + 1) {
    print(fib() + " ");  // 打印斐波那契数列的前10项
}
```

## 📢 更新日志 (v1.0.1)

本次更新重点改进了错误处理和内置函数系统，使 Evil Lang 更加易于使用和扩展：

* ✅ **增强的错误报告系统** - 实现了完整的调用堆栈追踪，显示详细的错误位置和错误上下文
* ✅ **彩色错误输出** - 使用 ANSI 颜色代码突出显示错误信息，提高可读性
* ✅ **全英文错误消息** - 标准化错误消息为英文，提高国际化兼容性
* ✅ **模块化内置函数架构** - 重构内置函数系统，使其更加可扩展
* ✅ **新增 `typeof` 函数** - 支持运行时类型检查
* ✅ **改进的 REPL 体验** - 更好的交互式环境，支持彩色输出和更详细的错误信息
* ✅ **代码片段高亮** - 在错误报告中显示出错的代码片段并使用脱字符(^)指示错误位置

## 🚀 目录

* [为什么是 Evil Lang？](#-为什么是-evil-lang)
* [特色功能](#-特色功能)
* [安装与使用](#-安装与使用)
* [语言特性详解](#-语言特性详解)
* [语法参考](#-语法参考)
* [幕后实现原理](#-幕后实现原理)
* [开发者指南](#-开发者指南)
* [我们克服的挑战](#-我们克服的挑战)
* [设计理念](#-设计理念)
* [未来发展方向](#-未来发展方向)
* [贡献指南](#-贡献指南)
* [许可证](#-许可证)

## 🔍 为什么是 Evil Lang？

在众多编程语言的海洋中，为什么我们要创造 Evil Lang？因为深入理解编程语言的设计和实现过程是每位程序员成长道路上的一道重要关卡！

与其他教育目的语言不同，Evil Lang 专注于：

* **平衡复杂度和可理解性** - 我们的代码库只有约1000行Python代码，却实现了完整的编程语言功能
* **可视化内部机制** - 提供 `--debug` 模式，让你一步步看到词法分析、语法分析的过程
* **亲民的语法** - 借鉴JavaScript和C的语法，降低学习曲线
* **闭包的简洁实现** - 我们用不到100行代码就实现了完整的闭包功能，比许多教学实现更简洁
* **中文友好** - 内置对UTF-8的完整支持，可以使用中文变量名、字符串和注释

Evil Lang 不是为了取代任何现有语言，而是为了让你看到语言的骨架，理解语言的灵魂！

## ✨ 特色功能

Evil Lang 虽然简洁，但功能丰富，融合了多种编程范式的精华：

### 命令式编程

```javascript
var total = 0;
for (var i = 1; i <= 100; i = i + 1) {
    total = total + i;
}
print("1到100的和是: " + total);
```

### 函数式编程

```javascript
func map(arr, fn) {
    var result = [];
    for (var i = 0; i < arr.length; i = i + 1) {
        result[i] = fn(arr[i]);
    }
    return result;
}

var numbers = [1, 2, 3, 4, 5];
print(map(numbers, func(x) { return x * x; }));
```

### 闭包与状态管理

```javascript
func createLogger(prefix) {
    func log(message) {
        print(prefix + ": " + message);
    }
    return log;
}

var debugLogger = createLogger("DEBUG");
var errorLogger = createLogger("ERROR");

debugLogger("程序正在运行");
errorLogger("发现未处理的异常");
```

## 📦 安装与使用

### 前提条件

* Python 3.6 或更高版本
* 好奇心和探索精神！✨

### 获取代码

```bash
git clone https://github.com/Evil0ctal/Evil-Lang.git
cd Evil-Lang
```

### 运行 Evil Lang 程序

```bash
python evil_lang.py examples/hello_world.el
```

### 在调试模式下运行，查看解释器内部工作

```bash
python evil_lang.py examples/advanced_example.el --debug
```

### 禁用彩色输出 (对于不支持 ANSI 颜色的终端)

```bash
python evil_lang.py examples/hello_world.el --no-color
```

### 创建你的第一个 Evil Lang 程序

创建文件 `hello.el`：

```javascript
// 我的第一个Evil Lang程序
print("Hello, Evil World!");

var name = input("请输入你的名字: ");
print("欢迎来到Evil Lang的世界，" + name + "！");
```

然后运行：

```bash
python evil_lang.py hello.el
```

## 🔧 语言特性详解

Evil Lang 融合了多种语言的优点，同时保持简洁和一致性：

### 1. 类型系统

Evil Lang 是动态类型语言，支持以下基本类型：

* **数值**：整数和浮点数
* **字符串**：支持 Unicode 和转义字符
* **布尔值**：`true` 和 `false`
* **空值**：`null`
* **数组**：支持嵌套和多维数组
* **对象**：类似于 JavaScript 对象的键值对结构
* **函数**：一等公民，可作为参数和返回值

与 Python 或 JavaScript 不同，Evil Lang 的类型系统简单明了，没有复杂的继承或原型链，让初学者容易理解类型的基本概念。

我们还提供了 `typeof` 内置函数用于运行时类型检查：

```javascript
print(typeof(42));        // "number"
print(typeof("hello"));   // "string"
print(typeof(true));      // "boolean"
print(typeof(null));      // "null"
print(typeof([]));        // "array"
print(typeof({}));        // "object"
print(typeof(print));     // "function"
```

### 2. 控制流

Evil Lang 提供直观的控制流语句：

* **条件**：`if`, `else if`, `else`
* **循环**：`while`, `for`
* **跳转**：`break`, `continue`
* **三元运算符**：`condition ? expr1 : expr2`

这些控制结构的语法接近 C 和 JavaScript，使初学者轻松过渡到主流语言。

### 3. 函数与闭包

Evil Lang 的函数系统设计精巧：

* **函数定义**：使用 `func` 关键字
* **参数传递**：支持值传递
* **返回值**：使用 `return` 语句
* **递归**：完全支持递归调用
* **闭包**：函数可以捕获并保留外部环境

闭包是 Evil Lang 的一大特色——我们不仅实现了它，还使其易于理解和使用。

```javascript
func makeAdder(x) {
    func add(y) {
        return x + y;  // 捕获外部变量x
    }
    return add;
}

var add5 = makeAdder(5);
print(add5(10));  // 输出15
```

### 4. 数据结构

Evil Lang 支持两种主要复合数据结构：

* **数组**：使用方括号 `[]` 定义，索引从0开始
* **对象**：使用花括号 `{}` 定义键值对

这些数据结构虽然简单，但足以构建复杂应用程序的基础。

## 📚 语法参考

### 变量与赋值

```javascript
// 变量声明
var x = 42;
var name = "Evil Lang";
var isEnabled = true;

// 变量赋值
x = x + 8;
name = name + " 编程语言";
```

### 运算符

```javascript
// 算术运算符
var sum = a + b;
var diff = a - b;
var product = a * b;
var quotient = a / b;

// 比较运算符
var isEqual = a == b;
var isNotEqual = a != b;
var isGreater = a > b;
var isLess = a < b;

// 逻辑运算符
var andResult = a && b;
var orResult = a || b;
var notResult = !a;
```

### 条件语句

```javascript
if (score >= 90) {
    print("优秀");
} else if (score >= 80) {
    print("良好");
} else if (score >= 70) {
    print("中等");
} else if (score >= 60) {
    print("及格");
} else {
    print("不及格");
}
```

### 循环

```javascript
// while循环
var i = 0;
while (i < 5) {
    print(i);
    i = i + 1;
}

// for循环
for (var j = 0; j < 5; j = j + 1) {
    print(j);
}
```

### 数组操作

```javascript
// 创建数组
var fruits = ["苹果", "香蕉", "橙子"];

// 访问元素
print(fruits[1]);  // 输出"香蕉"

// 修改元素
fruits[0] = "梨";

// 遍历数组
for (var i = 0; i < fruits.length; i = i + 1) {
    print(fruits[i]);
}
```

### 函数

```javascript
// 基本函数
func greet(name) {
    return "你好, " + name + "!";
}

// 函数调用
print(greet("小明"));

// 递归函数
func factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

// 高阶函数
func operate(a, b, operation) {
    return operation(a, b);
}

func add(x, y) {
    return x + y;
}

print(operate(5, 3, add));  // 输出8
```

## 🔬 幕后实现原理

Evil Lang 的实现遵循经典的三步走架构，但我们注重简洁性和可理解性：

### 1. 词法分析器 (Lexer)

词法分析器是 Evil Lang 的"眼睛"，它扫描源代码文本，识别出程序的基本构建块：

```python
# Evil Lang的词法分析器核心原理
class Lexer:
    def get_next_token(self):
        # 跳过空白字符和注释
        self.skip_whitespace()
        self.skip_comment()
        
        # 处理不同类型的标记
        if self.current_char.isdigit():
            return self.get_number()
        elif self.current_char.isalpha() or self.current_char == '_':
            return self.get_identifier()
        elif self.current_char == '"':
            return self.get_string()
        # ... 其他标记类型
```

与传统实现不同，我们的词法分析器：

* **支持Unicode** - 可以处理中文等非ASCII字符
* **智能处理注释** - 区分代码和注释，提升可读性
* **提供精确错误位置** - 报错时指明具体的行号和列号

### 2. 语法分析器 (Parser)

语法分析器是 Evil Lang 的"大脑"，它将标记流组织成有结构的抽象语法树(AST)：

```python
# Evil Lang的递归下降语法分析
class Parser:
    def expr(self):
        """解析表达式"""
        node = self.logic_expr()
        
        # 检查是否是三元表达式
        if self.current_token.type == TokenType.OPERATOR and self.current_token.value == '?':
            self.eat(TokenType.OPERATOR)  # 吃掉问号
            true_expr = self.expr()
            self.eat(TokenType.COLON)
            false_expr = self.expr()
            node = TernaryOp(node, true_expr, false_expr)
            
        return node
```

我们的语法分析器特点：

* **递归下降解析** - 清晰反映语言语法结构
* **优雅处理运算符优先级** - 使用独立函数处理不同优先级
* **强大的错误恢复** - 在出错时提供有意义的提示

### 3. 解释器 (Interpreter)

解释器是 Evil Lang 的"心脏"，它遍历AST并执行相应操作：

```python
# Evil Lang的解释器核心
class Interpreter:
    def visit_FuncCall(self, node):
        """函数调用处理"""
        # 准备参数
        arg_values = [self.visit(arg) for arg in node.arguments]
        
        # 查找并调用函数
        if node.name in self.functions:
            func_node = self.functions[node.name]
            
            # 创建新作用域
            saved_scope = self.global_scope.copy()
            new_scope = saved_scope.copy()
            
            # 绑定参数
            for i, param in enumerate(func_node.params):
                new_scope[param.value] = arg_values[i]
                
            # 设置新作用域并执行
            self.global_scope = new_scope
            
            try:
                self.visit(func_node.body)
            except ReturnException as e:
                return_value = e.value
            finally:
                # 恢复原作用域
                self.global_scope = saved_scope
                
            return return_value
```

我们的解释器亮点：

* **优雅的闭包实现** - 使用词法作用域捕获
* **访问者模式** - 使代码结构清晰，便于扩展
* **异常处理控制流** - 使用异常来处理return、break和continue

## 💻 开发者指南

### 代码结构

Evil Lang 的代码组织遵循模块化原则，主要模块包括：

```
Evil-Lang/
├── src/
│   ├── lexer.py         # 词法分析器
│   ├── parser.py        # 语法分析器
│   ├── ast.py           # 抽象语法树定义
│   ├── interpreter.py   # 解释器核心
│   ├── errors.py        # 错误处理
│   ├── builtins/        # 内置函数
│   │   ├── __init__.py  # 内置函数注册
│   │   ├── numeric.py   # 数值相关函数
│   │   ├── string.py    # 字符串相关函数
│   │   └── io.py        # 输入输出函数
├── examples/            # 示例程序
└── evil_lang.py         # 主程序入口
```

### 添加新的内置函数

Evil Lang 的内置函数系统设计为易于扩展。以下是添加新函数的步骤：

1. **选择或创建适当的模块**：在 `src/builtins/` 目录下选择合适的模块，或创建新模块。
2. **定义函数**：函数应该接受一个参数列表，并返回结果。
   ```python
   def _my_new_function(args):
       """函数文档字符串 - 说明函数的功能"""
       # 参数验证
       if len(args) != 2:
           raise ValueError("myNewFunction requires exactly two arguments")
   
       # 实现逻辑
       result = args[0] + args[1]  # 示例逻辑
   
       # 返回结果
       return result
   ```
3. **注册函数**：使用 `register_builtin` 函数将你的新函数注册到 Evil Lang 环境中。
   ```python
   # 在文件末尾添加
   register_builtin('myNewFunction', _my_new_function)
   ```
4. **确保模块被导入**：在 `src/builtins/__init__.py` 中导入你的模块。
   ```python
   # 在 __init__.py 中
   from .numeric import *
   from .string import *
   from .io import *
   from .your_new_module import *  # 如果你创建了新模块
   ```
5. **编写测试**：创建测试程序以验证你的新函数。
   ```javascript
   // 在 examples/test_my_function.el 中
   print(myNewFunction(10, 20));  // 应该输出 30
   ```

### 错误处理

Evil Lang 1.0.1 版本引入了增强的错误处理系统。在实现新功能时，使用适当的错误类：

```python
from ..errors import ValueError, TypeError, RuntimeError

# 在你的函数中
if not isinstance(args[0], (int, float)):
    raise TypeError("First argument must be a number", line, column)
```

这将产生一致的、用户友好的错误消息，并自动收集调用堆栈信息。

### 调试技巧

1. **使用 `--debug` 标志**：运行时添加 `--debug` 查看内部执行细节。
2. **在内置函数中添加调试输出**：
   ```python
   if '--debug' in sys.argv:
       print(f"DEBUG: args = {args}")
   ```
3. **使用 `format_error` 方法**：查看格式化的错误信息。
   ```python
   try:
       # 代码
   except EvilLangError as e:
       print(e.format_error())
   ```

## 🏆 我们克服的挑战

开发 Evil Lang 的过程中，我们遇到并解决了许多有趣的挑战：

### 1. 闭包实现的挑战

闭包是 Evil Lang 中最复杂的特性之一。主要挑战是：如何让函数"记住"它被创建时的环境？

**解决方案**：我们创建了 `FuncRef` 类，它不仅存储函数定义，还保存了函数定义时的作用域快照：

```python
class FuncRef:
    def __init__(self, func_node, lexical_scope=None):
        self.func_node = func_node  # 函数定义
        self.lexical_scope = lexical_scope  # 词法作用域
```

当函数返回内部函数时，我们捕获当前环境并与内部函数绑定，使其成为一个真正的闭包。

### 2. 错误处理和调试

在复杂程序中定位错误是一大挑战，尤其对语言初学者。

**解决方案**：我们实现了详细的错误报告系统：

* 记录每个标记的行号和列号
* 提供上下文相关的错误信息
* 添加 `--debug` 模式，显示词法分析和语法分析的中间结果
* 在 1.0.1 版本中增加了调用堆栈跟踪和代码片段高亮

### 3. 递归和栈溢出

递归是编程语言的重要特性，但不受控的递归可能导致栈溢出。

**解决方案**：我们使用Python的异常机制来处理控制流，避免了深度递归的问题，并使实现更加简洁。

### 4. Unicode支持

许多教育用解释器只支持ASCII，限制了国际化应用。

**解决方案**：我们从一开始就设计了完整的Unicode支持：

* 使用UTF-8编码读取源文件
* 正确处理Unicode标识符和字符串
* 支持中文等非ASCII字符的变量名和输出

## 💡 设计理念

Evil Lang 的设计遵循以下核心理念：

### 1. 教育优先

Evil Lang 的首要目标是教育。我们宁可牺牲一些性能和功能，也要保持代码的清晰和可理解性。每个组件都被设计为"自解释"的，让读者可以轻松理解其工作原理。

### 2. 平衡熟悉性和简洁性

我们借鉴了 JavaScript 和 C 的语法，使初学者感到熟悉，但同时剔除了那些复杂或容易混淆的特性，保持语言的简洁和一致性。

### 3. 渐进式复杂度

Evil Lang 的特性按复杂度排列，让学习者可以循序渐进：

* 基本变量和表达式
* 条件和循环
* 函数和递归
* 数组和对象
* 高阶函数和闭包

### 4. 可视化和交互性

我们重视用户体验，提供丰富的输出和交互功能：

* 内置 `print` 和 `input` 函数
* 详细的错误信息
* 调试模式下的可视化跟踪

## 🔮 未来发展方向

Evil Lang 仍在积极发展中，以下是我们计划的迭代方向：

### 1. 语言增强

* **模块系统** - 实现导入和导出机制，支持代码复用（1.1.0版本计划）
* **类和对象系统** - 添加简单但功能完整的面向对象编程支持
* **异常处理** - 添加 try/catch 机制
* **标准库** - 构建强大的标准库，包括数学、字符串处理和文件I/O
* **异步编程** - 实现 Promise 或类似机制

### 2. 工具和生态

* **改进REPL环境** - 增强交互式解释器的功能，如历史记录和自动完成
* **VSCode插件** - 语法高亮和自动完成
* **调试器** - 图形化的步进执行和变量监视
* **包管理器** - 分享和重用 Evil Lang 代码

### 3. 性能优化

* **字节码编译器** - 将AST编译为中间字节码，提升执行速度
* **简单JIT编译** - 实现热点代码的即时编译
* **内存优化** - 减少对象分配和复制

### 4. 教育资源

* **交互式教程** - 循序渐进学习语言特性
* **在线解释器** - 无需安装即可体验
* **编译原理课程** - 使用Evil Lang讲解编程语言实现

## 👥 贡献指南

Evil Lang 是一个社区驱动的项目，我们欢迎各种形式的贡献！

### 参与方式

1. **代码贡献**
   * 修复bug或实现新特性
   * 优化现有实现
   * 添加测试用例
2. **文档改进**
   * 完善教程和示例
   * 翻译文档
   * 创建学习资源
3. **使用反馈**
   * 报告问题
   * 提出改进建议
   * 分享使用经验

### 提交流程

1. Fork 仓库
2. 创建特性分支：`git checkout -b my-new-feature`
3. 提交更改：`git commit -am 'Add some feature'`
4. 推送分支：`git push origin my-new-feature`
5. 提交 Pull Request

我们特别欢迎教育工作者和学生参与，共同打造更好的编程语言学习工具！

## 📄 许可证

Evil Lang 采用 MIT 许可证开源。

```
MIT License

Copyright (c) 2025 Evil0ctal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files...
```

详见 [LICENSE](https://github.com/Evil0ctal/Evil-Lang/blob/main/LICENSE) 文件。

---

<p align="center">
  <sub>用 ❤️ 和 Python 制作 - Evil0ctal</sub>
</p>
