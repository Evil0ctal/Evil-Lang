# Installation Guide

This guide will help you install Evil Lang on your system.

## Prerequisites

Before installing Evil Lang, make sure you have:

- **Python 3.6 or higher** installed on your system
- **Git** (optional, for cloning the repository)
- A text editor or IDE for writing Evil Lang programs

## Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/Evil0ctal/Evil-Lang.git
cd Evil-Lang
```

Alternatively, you can download the ZIP file from GitHub and extract it.

### 2. Verify Python Installation

Make sure Python is properly installed:

```bash
python --version
# or
python3 --version
```

You should see Python 3.6 or higher.

### 3. Test the Installation

Run a simple test to ensure everything is working:

```bash
python evil_lang.py examples/hello_world.el
```

You should see:
```
Hello, Evil World!
```

## Running Evil Lang Programs

### Command Line Usage

Basic syntax:
```bash
python evil_lang.py <filename>
```

### Available Options

- **Debug Mode**: See the parsing and execution process
  ```bash
  python evil_lang.py program.el --debug
  ```

- **No Color Mode**: Disable colored output
  ```bash
  python evil_lang.py program.el --no-color
  ```

### Interactive REPL

To start the interactive interpreter:
```bash
python evil_lang.py
```

You'll see:
```
Evil Lang REPL v1.0.2
Type 'help' for help, 'exit' to quit

evil>
```

## Setting Up Your Development Environment

### Recommended Text Editors

1. **Visual Studio Code**
   - Install the "JavaScript" extension for syntax highlighting
   - Evil Lang syntax is similar to JavaScript

2. **Sublime Text**
   - Use JavaScript syntax highlighting

3. **Vim/Neovim**
   - Set filetype to javascript: `:set filetype=javascript`

### File Extension

Evil Lang files use the `.el` extension by convention.

## Troubleshooting

### Common Issues

1. **"python: command not found"**
   - Make sure Python is in your PATH
   - Try using `python3` instead of `python`

2. **"No such file or directory"**
   - Ensure you're in the Evil-Lang directory
   - Check that the file path is correct

3. **Unicode/Encoding Errors**
   - Evil Lang expects UTF-8 encoded files
   - Save your source files with UTF-8 encoding

### Getting Help

If you encounter issues:

1. Check the [examples](../../examples) directory for working code
2. Read the error messages carefully - they provide context
3. Open an issue on [GitHub](https://github.com/Evil0ctal/Evil-Lang/issues)

## Next Steps

Now that you have Evil Lang installed, you can:

- Follow the [Quick Start Guide](quick-start.md)
- Explore the [examples](../../examples) directory
- Read about [Basic Syntax](basic-syntax.md)