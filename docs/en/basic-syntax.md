# Basic Syntax

This guide covers the fundamental syntax elements of Evil Lang.

## Comments

Evil Lang supports single-line comments:

```javascript
// This is a comment
var x = 42; // Comments can also appear at the end of lines
```

## Variables

Variables are declared using the `var` keyword:

```javascript
var name = "Evil Lang";
var version = 1.0;
var isAwesome = true;
var nothing = null;
```

Variables are dynamically typed and can be reassigned:

```javascript
var x = 42;      // x is a number
x = "hello";     // now x is a string
x = [1, 2, 3];   // now x is an array
```

## Identifiers

Identifiers (variable and function names) can contain:
- Letters (a-z, A-Z)
- Digits (0-9) - but not as the first character
- Underscore (_)
- Unicode characters (including Chinese, Japanese, etc.)

```javascript
var _privateVar = 10;
var userName123 = "Alice";
var 你好 = "Hello in Chinese";
var π = 3.14159;
```

## Statements

Statements in Evil Lang must end with a semicolon:

```javascript
var x = 10;
print(x);
x = x + 5;
```

## Expressions

Evil Lang supports various types of expressions:

### Arithmetic Expressions

```javascript
var a = 10 + 5;    // Addition
var b = 20 - 8;    // Subtraction
var c = 6 * 7;     // Multiplication
var d = 15 / 3;    // Division
var e = 17 % 5;    // Modulo (remainder)
```

### String Concatenation

```javascript
var greeting = "Hello" + " " + "World";
var message = "The answer is " + 42;
```

### Comparison Expressions

```javascript
var isEqual = 5 == 5;        // true
var isNotEqual = 5 != 3;     // true
var isGreater = 10 > 5;      // true
var isLess = 3 < 7;          // true
var isGreaterEq = 5 >= 5;    // true
var isLessEq = 4 <= 8;       // true
```

### Logical Expressions

```javascript
var andResult = true && false;   // false
var orResult = true || false;    // true
var notResult = !true;           // false
```

### Ternary Operator

```javascript
var age = 18;
var status = age >= 18 ? "adult" : "minor";
print(status); // "adult"
```

## Blocks

Blocks are enclosed in curly braces and create a new scope:

```javascript
{
    var x = 10;
    print(x);  // 10
}
// x is still accessible here (function scope, not block scope)
```

## Operator Precedence

From highest to lowest precedence:

1. Parentheses: `()`
2. Member access: `.` and `[]`
3. Function call: `()`
4. Unary: `!`, `-` (negative)
5. Multiplicative: `*`, `/`, `%`
6. Additive: `+`, `-`
7. Relational: `<`, `>`, `<=`, `>=`
8. Equality: `==`, `!=`
9. Logical AND: `&&`
10. Logical OR: `||`
11. Ternary: `? :`
12. Assignment: `=`

Example:
```javascript
var result = 2 + 3 * 4;        // 14 (not 20)
var result2 = (2 + 3) * 4;     // 20
var result3 = true || false && false;  // true (AND has higher precedence)
```

## Keywords

The following words are reserved and cannot be used as identifiers:

- `var` - Variable declaration
- `func` - Function declaration
- `if`, `else` - Conditional statements
- `while`, `for` - Loop statements
- `break`, `continue` - Loop control
- `return` - Function return
- `true`, `false` - Boolean literals
- `null` - Null literal
- `print` - Output statement
- `input` - Input statement
- `class`, `extends` - Class declaration
- `new` - Object instantiation
- `this`, `super` - Object references
- `constructor` - Class constructor
- `try`, `catch`, `finally`, `throw` - Exception handling
- `import`, `export`, `from`, `as` - Module system

## Semicolons

Semicolons are required at the end of statements:

```javascript
var x = 10;  // Required
print(x);    // Required

// Exception: Block statements don't need semicolons after the closing brace
if (x > 5) {
    print("x is greater than 5");
}  // No semicolon needed here

func greet() {
    print("Hello!");
}  // No semicolon needed here
```

## Case Sensitivity

Evil Lang is case-sensitive:

```javascript
var name = "Alice";
var Name = "Bob";     // Different variable
var NAME = "Charlie"; // Also different

print(name);  // "Alice"
print(Name);  // "Bob"
print(NAME);  // "Charlie"
```

## Unicode Support

Evil Lang fully supports Unicode:

```javascript
var 名前 = "太郎";
var café = "Coffee Shop";
var 🚀 = "rocket";

print("Hello, " + 名前);
print("Let's go to " + café);
print("Launch the " + 🚀);
```

## Next Steps

Now that you understand the basic syntax, explore:
- [Data Types](data-types.md) - Learn about all data types in Evil Lang
- [Control Flow](control-flow.md) - Master conditionals and loops
- [Functions](functions.md) - Create and use functions