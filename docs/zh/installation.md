# 安装指南

本指南将帮助您在系统上安装和设置 Evil Lang。

## 系统要求

- Python 3.8 或更高版本
- pip（Python 包管理器）
- 任何操作系统（Windows、macOS、Linux）

## 安装步骤

### 1. 克隆仓库

```bash
git clone https://github.com/evil0ctal/evil-lang.git
cd evil-lang
```

### 2. 安装依赖

Evil Lang 是一个纯 Python 实现，没有外部依赖：

```bash
# 可选：创建虚拟环境
python -m venv venv
source venv/bin/activate  # Linux/macOS
# 或
venv\Scripts\activate  # Windows

# 当前没有依赖需要安装
```

### 3. 验证安装

运行一个简单的 Evil Lang 程序来验证安装：

```bash
python evil_lang.py examples/hello_world.el
```

您应该看到输出：
```
Hello, Evil World!
```

## 使用方法

### 运行 Evil Lang 文件

```bash
python evil_lang.py <filename.el>
```

### 启动交互式 REPL

```bash
python evil_lang.py
```

在 REPL 中，您可以输入 Evil Lang 表达式并立即看到结果：

```
Evil Lang REPL v1.0.2
输入 'exit' 或 'quit' 退出，'help' 获取帮助
>>> print("Hello, World!")
Hello, World!
>>> let x = 42
>>> x * 2
84
>>> exit
再见！
```

## 配置

### 设置编辑器

为了更好的开发体验，请配置您的编辑器以识别 `.el` 文件：

**VS Code**：
1. 安装语法高亮扩展（如果可用）
2. 将 `.el` 文件关联到 JavaScript 语法以获得基本高亮

**其他编辑器**：
- 将 `.el` 文件视为 JavaScript 或类似语言以获得语法高亮

### 项目结构

典型的 Evil Lang 项目结构：

```
my-project/
├── main.el          # 主程序入口
├── lib/             # 自定义库
│   ├── utils.el
│   └── helpers.el
├── tests/           # 测试文件
│   └── test_main.el
└── README.md        # 项目文档
```

## 故障排除

### Python 版本错误

如果遇到 Python 版本错误：
```bash
python --version  # 检查您的 Python 版本
python3 evil_lang.py examples/hello_world.el  # 尝试使用 python3
```

### 模块未找到错误

确保您在正确的目录中：
```bash
cd path/to/evil-lang
python evil_lang.py examples/hello_world.el
```

### 权限错误

在 Unix 系统上，您可能需要使文件可执行：
```bash
chmod +x evil_lang.py
./evil_lang.py examples/hello_world.el
```

## 下一步

- 阅读[快速入门](quick-start.md)学习基础知识
- 探索[示例](../../examples/)目录
- 查看[语言参考](../reference/)了解所有功能