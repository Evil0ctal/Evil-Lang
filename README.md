# Evil Lang 🔮

[![Version](https://img.shields.io/badge/version-1.0.1-blue)](https://github.com/Evil0ctal/Evil-Lang)
[![Python](https://img.shields.io/badge/python-3.6+-yellow)](https://www.python.org/)
[![License](https://img.shields.io/badge/license-MIT-green)](https://github.com/Evil0ctal/Evil-Lang/blob/main/LICENSE)
[![Stars](https://img.shields.io/github/stars/Evil0ctal/Evil-Lang?style=social)](https://github.com/Evil0ctal/Evil-Lang)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/Evil0ctal/Evil-Lang/pulls)
![View Count](https://views.whatilearened.today/views/github/Evil0ctal/Evil-Lang.svg)
[![Made with ❤️](https://img.shields.io/badge/made%20with-%E2%9D%A4%EF%B8%8F-red)](https://github.com/Evil0ctal)

**Evil Lang (Evil Program Language)** is a lightweight, expressive interpreted programming language that combines the essence of imperative and functional programming paradigms. It's specifically designed for education and learning programming language implementation principles. It's not just a programming language, but an adventure into the inner workings of programming languages!

<p align="center">
  <img src="/assets/EPL.jpg" alt="Evil Lang Logo" width="100"/>
</p>

```javascript
// Evil Lang code example: Closures and higher-order functions
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
    print(fib() + " ");  // Print the first 10 items of the Fibonacci sequence
}
```

## 📢 Changelog (v1.0.1)

This update focuses on improving error handling and the built-in function system, making Evil Lang more user-friendly and extensible:

* ✅ **Enhanced Error Reporting System** - Implemented complete call stack tracing with detailed error location and context
* ✅ **Colorful Error Output** - Used ANSI color codes to highlight error messages, improving readability
* ✅ **Standardized English Error Messages** - Standardized error messages in English for better internationalization
* ✅ **Modular Built-in Function Architecture** - Restructured the built-in function system to make it more extensible
* ✅ **New `typeof` Function** - Added support for runtime type checking
* ✅ **Improved REPL Experience** - Better interactive environment with colored output and more detailed error information
* ✅ **Code Snippet Highlighting** - Error reports now display the problematic code snippet and indicate the error position with caret (^) symbols

## 🚀 Table of Contents

* [Why Evil Lang?](#-why-evil-lang)
* [Key Features](#-key-features)
* [Installation and Usage](#-installation-and-usage)
* [Language Features](#-language-features)
* [Syntax Reference](#-syntax-reference)
* [Implementation Principles](#-implementation-principles)
* [Developer's Guide](#-developers-guide)
* [Challenges We Overcame](#-challenges-we-overcame)
* [Design Philosophy](#-design-philosophy)
* [Future Development](#-future-development)
* [Contribution Guidelines](#-contribution-guidelines)
* [License](#-license)

## 🔍 Why Evil Lang?

In the vast ocean of programming languages, why did we create Evil Lang? Because deeply understanding the design and implementation of programming languages is a crucial milestone in every programmer's growth journey!

Unlike other educational languages, Evil Lang focuses on:

* **Balancing Complexity and Comprehensibility** - Our codebase has only about 1000 lines of Python code, yet implements a complete programming language
* **Visualizing Internal Mechanisms** - Providing a `--debug` mode that lets you see the lexical and syntax analysis process step by step
* **Approachable Syntax** - Drawing inspiration from JavaScript and C syntax to lower the learning curve
* **Elegant Closure Implementation** - We implemented complete closure functionality in less than 100 lines of code, more concisely than many educational implementations
* **Unicode Friendly** - Built-in support for UTF-8, allowing Chinese and other non-ASCII characters in variable names, strings, and comments

Evil Lang isn't meant to replace any existing language, but to let you see the skeleton of a language and understand its soul!

## ✨ Key Features

Though concise, Evil Lang is feature-rich, combining the essence of multiple programming paradigms:

### Imperative Programming

```javascript
var total = 0;
for (var i = 1; i <= 100; i = i + 1) {
    total = total + i;
}
print("Sum from 1 to 100 is: " + total);
```

### Functional Programming

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

### Closures and State Management

```javascript
func createLogger(prefix) {
    func log(message) {
        print(prefix + ": " + message);
    }
    return log;
}

var debugLogger = createLogger("DEBUG");
var errorLogger = createLogger("ERROR");

debugLogger("Program is running");
errorLogger("Unhandled exception detected");
```

## 📦 Installation and Usage

### Prerequisites

* Python 3.6 or higher
* Curiosity and an exploratory spirit! ✨

### Getting the Code

```bash
git clone https://github.com/Evil0ctal/Evil-Lang.git
cd Evil-Lang
```

### Running Evil Lang Programs

```bash
python evil_lang.py examples/hello_world.el
```

### Running in Debug Mode to See Interpreter Internals

```bash
python evil_lang.py examples/advanced_example.el --debug
```

### Disabling Colored Output (for Terminals without ANSI Color Support)

```bash
python evil_lang.py examples/hello_world.el --no-color
```

### Creating Your First Evil Lang Program

Create a file named `hello.el`:

```javascript
// My first Evil Lang program
print("Hello, Evil World!");

var name = input("Please enter your name: ");
print("Welcome to the world of Evil Lang, " + name + "!");
```

Then run:

```bash
python evil_lang.py hello.el
```

## 🔧 Language Features

Evil Lang combines the advantages of several languages while maintaining simplicity and consistency:

### 1. Type System

Evil Lang is a dynamically typed language supporting these basic types:

* **Numbers**: Integers and floating-point numbers
* **Strings**: Supporting Unicode and escape characters
* **Booleans**: `true` and `false`
* **Null**: `null`
* **Arrays**: Supporting nested and multi-dimensional arrays
* **Objects**: Key-value pair structures similar to JavaScript objects
* **Functions**: First-class citizens, usable as parameters and return values

Unlike Python or JavaScript, Evil Lang's type system is straightforward without complex inheritance or prototype chains, making it easy for beginners to understand basic type concepts.

We also provide the `typeof` built-in function for runtime type checking:

```javascript
print(typeof(42));        // "number"
print(typeof("hello"));   // "string"
print(typeof(true));      // "boolean"
print(typeof(null));      // "null"
print(typeof([]));        // "array"
print(typeof({}));        // "object"
print(typeof(print));     // "function"
```

### 2. Control Flow

Evil Lang provides intuitive control flow statements:

* **Conditionals**: `if`, `else if`, `else`
* **Loops**: `while`, `for`
* **Jump Statements**: `break`, `continue`
* **Ternary Operator**: `condition ? expr1 : expr2`

These control structures have syntax similar to C and JavaScript, enabling beginners to easily transition to mainstream languages.

### 3. Functions and Closures

Evil Lang's function system is elegantly designed:

* **Function Definition**: Using the `func` keyword
* **Parameter Passing**: Supporting pass-by-value
* **Return Values**: Using the `return` statement
* **Recursion**: Fully supporting recursive calls
* **Closures**: Functions can capture and retain their outer environment

Closures are a highlight of Evil Lang—we not only implemented them but made them easy to understand and use.

```javascript
func makeAdder(x) {
    func add(y) {
        return x + y;  // Captures outer variable x
    }
    return add;
}

var add5 = makeAdder(5);
print(add5(10));  // Outputs 15
```

### 4. Data Structures

Evil Lang supports two main composite data structures:

* **Arrays**: Defined using square brackets `[]`, zero-indexed
* **Objects**: Defined using curly braces `{}` for key-value pairs

These data structures are simple yet sufficient as building blocks for complex applications.

## 📚 Syntax Reference

### Variables and Assignment

```javascript
// Variable declaration
var x = 42;
var name = "Evil Lang";
var isEnabled = true;

// Variable assignment
x = x + 8;
name = name + " Programming Language";
```

### Operators

```javascript
// Arithmetic operators
var sum = a + b;
var diff = a - b;
var product = a * b;
var quotient = a / b;

// Comparison operators
var isEqual = a == b;
var isNotEqual = a != b;
var isGreater = a > b;
var isLess = a < b;

// Logical operators
var andResult = a && b;
var orResult = a || b;
var notResult = !a;
```

### Conditional Statements

```javascript
if (score >= 90) {
    print("Excellent");
} else if (score >= 80) {
    print("Good");
} else if (score >= 70) {
    print("Average");
} else if (score >= 60) {
    print("Pass");
} else {
    print("Fail");
}
```

### Loops

```javascript
// While loop
var i = 0;
while (i < 5) {
    print(i);
    i = i + 1;
}

// For loop
for (var j = 0; j < 5; j = j + 1) {
    print(j);
}
```

### Array Operations

```javascript
// Creating arrays
var fruits = ["Apple", "Banana", "Orange"];

// Accessing elements
print(fruits[1]);  // Outputs "Banana"

// Modifying elements
fruits[0] = "Pear";

// Iterating through arrays
for (var i = 0; i < fruits.length; i = i + 1) {
    print(fruits[i]);
}
```

### Functions

```javascript
// Basic function
func greet(name) {
    return "Hello, " + name + "!";
}

// Function call
print(greet("John"));

// Recursive function
func factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

// Higher-order function
func operate(a, b, operation) {
    return operation(a, b);
}

func add(x, y) {
    return x + y;
}

print(operate(5, 3, add));  // Outputs 8
```

## 🔬 Implementation Principles

Evil Lang follows a classic three-step architecture, focusing on simplicity and comprehensibility:

### 1. Lexical Analyzer (Lexer)

The lexer is Evil Lang's "eyes," scanning source code text and identifying the program's basic building blocks:

```python
# Evil Lang's lexer core principle
class Lexer:
    def get_next_token(self):
        # Skip whitespace and comments
        self.skip_whitespace()
        self.skip_comment()
        
        # Process different token types
        if self.current_char.isdigit():
            return self.get_number()
        elif self.current_char.isalpha() or self.current_char == '_':
            return self.get_identifier()
        elif self.current_char == '"':
            return self.get_string()
        # ... other token types
```

Unlike traditional implementations, our lexer:

* **Supports Unicode** - Handles non-ASCII characters like Chinese
* **Intelligently Processes Comments** - Distinguishes code from comments, improving readability
* **Provides Precise Error Locations** - Reports specific line and column numbers when errors occur

### 2. Syntax Analyzer (Parser)

The parser is Evil Lang's "brain," organizing token streams into structured abstract syntax trees (AST):

```python
# Evil Lang's recursive descent parsing
class Parser:
    def expr(self):
        """Parse expressions"""
        node = self.logic_expr()
        
        # Check if it's a ternary expression
        if self.current_token.type == TokenType.OPERATOR and self.current_token.value == '?':
            self.eat(TokenType.OPERATOR)  # Consume the question mark
            true_expr = self.expr()
            self.eat(TokenType.COLON)
            false_expr = self.expr()
            node = TernaryOp(node, true_expr, false_expr)
            
        return node
```

Our parser features:

* **Recursive Descent Parsing** - Clearly reflects the language grammar structure
* **Elegant Operator Precedence Handling** - Uses separate functions for different precedence levels
* **Robust Error Recovery** - Provides meaningful hints when errors occur

### 3. Interpreter

The interpreter is Evil Lang's "heart," traversing the AST and executing corresponding operations:

```python
# Evil Lang's interpreter core
class Interpreter:
    def visit_FuncCall(self, node):
        """Function call handling"""
        # Prepare arguments
        arg_values = [self.visit(arg) for arg in node.arguments]
        
        # Find and call the function
        if node.name in self.functions:
            func_node = self.functions[node.name]
            
            # Create new scope
            saved_scope = self.global_scope.copy()
            new_scope = saved_scope.copy()
            
            # Bind parameters
            for i, param in enumerate(func_node.params):
                new_scope[param.value] = arg_values[i]
                
            # Set new scope and execute
            self.global_scope = new_scope
            
            try:
                self.visit(func_node.body)
            except ReturnException as e:
                return_value = e.value
            finally:
                # Restore original scope
                self.global_scope = saved_scope
                
            return return_value
```

Highlights of our interpreter:

* **Elegant Closure Implementation** - Using lexical scope capturing
* **Visitor Pattern** - Making code structure clear and extensible
* **Exception-based Control Flow** - Using exceptions to handle return, break, and continue

## 💻 Developer's Guide

### Code Structure

Evil Lang's code organization follows modular principles, with main modules including:

```
Evil-Lang/
├── src/
│   ├── lexer.py         # Lexical analyzer
│   ├── parser.py        # Syntax analyzer
│   ├── ast.py           # Abstract syntax tree definitions
│   ├── interpreter.py   # Interpreter core
│   ├── errors.py        # Error handling
│   ├── builtins/        # Built-in functions
│   │   ├── __init__.py  # Built-in function registration
│   │   ├── numeric.py   # Number-related functions
│   │   ├── string.py    # String-related functions
│   │   └── io.py        # Input/output functions
├── examples/            # Example programs
└── evil_lang.py         # Main program entry
```

### Adding New Built-in Functions

Evil Lang's built-in function system is designed to be easily extensible. Here are the steps to add a new function:

1. **Choose or Create an Appropriate Module**: Select a suitable module in the `src/builtins/` directory, or create a new one.
2. **Define the Function**: The function should accept a parameter list and return a result.
   ```python
   def _my_new_function(args):
       """Function docstring - explains the function's purpose"""
       # Parameter validation
       if len(args) != 2:
           raise ValueError("myNewFunction requires exactly two arguments")
   
       # Implementation logic
       result = args[0] + args[1]  # Example logic
   
       # Return result
       return result
   ```
3. **Register the Function**: Use the `register_builtin` function to register your new function in the Evil Lang environment.
   ```python
   # Add at the end of the file
   register_builtin('myNewFunction', _my_new_function)
   ```
4. **Ensure the Module is Imported**: Import your module in `src/builtins/__init__.py`.
   ```python
   # In __init__.py
   from .numeric import *
   from .string import *
   from .io import *
   from .your_new_module import *  # If you created a new module
   ```
5. **Write Tests**: Create test programs to verify your new function.
   ```javascript
   // In examples/test_my_function.el
   print(myNewFunction(10, 20));  // Should output 30
   ```

### Error Handling

Evil Lang version 1.0.1 introduces an enhanced error handling system. When implementing new features, use appropriate error classes:

```python
from ..errors import ValueError, TypeError, RuntimeError

# In your function
if not isinstance(args[0], (int, float)):
    raise TypeError("First argument must be a number", line, column)
```

This will produce consistent, user-friendly error messages and automatically collect call stack information.

### Debugging Tips

1. **Use the `--debug` Flag**: Add `--debug` when running to see internal execution details.
2. **Add Debug Output in Built-in Functions**:
   ```python
   if '--debug' in sys.argv:
       print(f"DEBUG: args = {args}")
   ```
3. **Use the `format_error` Method**: View formatted error information.
   ```python
   try:
       # Code
   except EvilLangError as e:
       print(e.format_error())
   ```

## 🏆 Challenges We Overcame

During Evil Lang development, we encountered and solved many interesting challenges:

### 1. Closure Implementation Challenge

Closures are one of the most complex features in Evil Lang. The main challenge was: how to make functions "remember" the environment they were created in?

**Solution**: We created a `FuncRef` class that not only stores the function definition but also saves a snapshot of the lexical scope at the time of definition:

```python
class FuncRef:
    def __init__(self, func_node, lexical_scope=None):
        self.func_node = func_node  # Function definition
        self.lexical_scope = lexical_scope  # Lexical scope
```

When a function returns an inner function, we capture the current environment and bind it to the inner function, making it a true closure.

### 2. Error Handling and Debugging

Locating errors in complex programs is a major challenge, especially for language beginners.

**Solution**: We implemented a detailed error reporting system:

* Recording line and column numbers for each token
* Providing context-sensitive error messages
* Adding a `--debug` mode to show intermediate results of lexical and syntax analysis
* Adding call stack tracing and code snippet highlighting in version 1.0.1

### 3. Recursion and Stack Overflow

Recursion is an important feature of programming languages, but uncontrolled recursion can lead to stack overflow.

**Solution**: We used Python's exception mechanism to handle control flow, avoiding deep recursion issues and making implementation more concise.

### 4. Unicode Support

Many educational interpreters only support ASCII, limiting internationalization.

**Solution**: We designed complete Unicode support from the beginning:

* Using UTF-8 encoding to read source files
* Correctly handling Unicode identifiers and strings
* Supporting non-ASCII characters like Chinese for variable names and output

## 💡 Design Philosophy

Evil Lang's design adheres to the following core principles:

### 1. Education First

Evil Lang's primary goal is education. We're willing to sacrifice some performance and features to maintain code clarity and comprehensibility. Each component is designed to be "self-explanatory," allowing readers to easily understand how it works.

### 2. Balancing Familiarity and Simplicity

We borrowed syntax from JavaScript and C to make beginners feel comfortable, while eliminating complex or confusing features to maintain language simplicity and consistency.

### 3. Progressive Complexity

Evil Lang features are arranged by complexity, allowing learners to progress gradually:

* Basic variables and expressions
* Conditionals and loops
* Functions and recursion
* Arrays and objects
* Higher-order functions and closures

### 4. Visualization and Interactivity

We value user experience, providing rich output and interactive features:

* Built-in `print` and `input` functions
* Detailed error messages
* Visual tracing in debug mode

## 🔮 Future Development

Evil Lang is still actively developing. Here are our planned iterations:

### 1. Language Enhancements

* **Module System** - Implementing import and export mechanisms to support code reuse (planned for version 1.1.0)
* **Class and Object System** - Adding simple but complete object-oriented programming support
* **Exception Handling** - Adding try/catch mechanisms
* **Standard Library** - Building a powerful standard library including math, string processing, and file I/O
* **Asynchronous Programming** - Implementing Promise or similar mechanisms

### 2. Tools and Ecosystem

* **Improved REPL Environment** - Enhancing the interactive interpreter with features like history and auto-completion
* **VSCode Extension** - Syntax highlighting and auto-completion
* **Debugger** - Graphical step execution and variable watching
* **Package Manager** - Sharing and reusing Evil Lang code

### 3. Performance Optimization

* **Bytecode Compiler** - Compiling AST to intermediate bytecode for faster execution
* **Simple JIT Compilation** - Implementing just-in-time compilation for hot code
* **Memory Optimization** - Reducing object allocation and copying

### 4. Educational Resources

* **Interactive Tutorials** - Learning language features progressively
* **Online Interpreter** - Experiencing Evil Lang without installation
* **Compiler Principles Course** - Using Evil Lang to teach programming language implementation

## 👥 Contribution Guidelines

Evil Lang is a community-driven project, and we welcome contributions in all forms!

### Ways to Contribute

1. **Code Contributions**
   * Fix bugs or implement new features
   * Optimize existing implementations
   * Add test cases
2. **Documentation Improvements**
   * Enhance tutorials and examples
   * Translate documentation
   * Create learning resources
3. **Usage Feedback**
   * Report issues
   * Suggest improvements
   * Share experiences

### Submission Process

1. Fork the repository
2. Create a feature branch: `git checkout -b my-new-feature`
3. Commit changes: `git commit -am 'Add some feature'`
4. Push branch: `git push origin my-new-feature`
5. Submit a Pull Request

We especially welcome educators and students to participate in creating better programming language learning tools!

## 📄 License

Evil Lang is open-sourced under the MIT License.

```
MIT License

Copyright (c) 2025 Evil0ctal

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files...
```

See the [LICENSE](https://github.com/Evil0ctal/Evil-Lang/blob/main/LICENSE) file for details.

---

<p align="center">
  <sub>Made with ❤️ and Python - Evil0ctal</sub>
</p>