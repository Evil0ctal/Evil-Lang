# Data Types

Evil Lang is a dynamically typed language with several built-in data types.

## Numbers

Numbers in Evil Lang can be integers or floating-point values:

```javascript
var integer = 42;
var float = 3.14159;
var negative = -10;
var scientific = 1.23e-4;  // Scientific notation
```

### Number Operations

```javascript
var a = 10 + 5;   // Addition: 15
var b = 10 - 5;   // Subtraction: 5
var c = 10 * 5;   // Multiplication: 50
var d = 10 / 5;   // Division: 2
var e = 10 % 3;   // Modulo: 1

// Built-in math functions
var absolute = abs(-42);        // 42
var rounded = round(3.7);       // 4
var minimum = min(5, 3, 8);     // 3
var maximum = max(5, 3, 8);     // 8
```

## Strings

Strings are sequences of characters enclosed in double quotes:

```javascript
var name = "Evil Lang";
var message = "Hello, World!";
var unicode = "你好世界 🌍";  // Full Unicode support
```

### String Properties and Operations

```javascript
var text = "Hello";

// Length property
print(text.length);  // 5

// String concatenation
var greeting = "Hello" + " " + "World";

// Built-in string functions
var upper = toUpper("hello");          // "HELLO"
var lower = toLower("HELLO");          // "hello"
var trimmed = trim("  hello  ");       // "hello"
var substr = substring("hello", 1, 4); // "ell"
var index = indexOf("hello", "ll");    // 2
```

## Booleans

Boolean values represent true or false:

```javascript
var isTrue = true;
var isFalse = false;

// Boolean operations
var and = true && false;    // false
var or = true || false;     // true
var not = !true;            // false

// Comparison results in booleans
var greater = 10 > 5;       // true
var equal = 5 == 5;         // true
```

## Null

The `null` value represents the absence of a value:

```javascript
var nothing = null;

// Checking for null
if (nothing == null) {
    print("Value is null");
}
```

## Arrays

Arrays are ordered collections of values:

```javascript
// Array creation
var numbers = [1, 2, 3, 4, 5];
var mixed = [1, "hello", true, null];
var nested = [[1, 2], [3, 4]];

// Accessing elements
print(numbers[0]);     // 1 (first element)
print(numbers[4]);     // 5 (last element)

// Array properties
print(numbers.length); // 5

// Modifying arrays
numbers[0] = 10;       // Change first element
numbers[5] = 6;        // Add new element

// Array operations
push(numbers, 7);      // Add to end
var last = pop(numbers);  // Remove from end
var first = shift(numbers); // Remove from beginning
unshift(numbers, 0);   // Add to beginning
```

## Objects

Objects are key-value pairs (similar to dictionaries or maps):

```javascript
// Object creation
var person = {
    name: "Alice",
    age: 30,
    city: "New York"
};

// Accessing properties
print(person.name);    // "Alice"
print(person.age);     // 30

// Modifying properties
person.age = 31;
person.email = "alice@example.com";  // Add new property

// Complex objects
var company = {
    name: "Tech Corp",
    employees: [
        {name: "Alice", role: "Developer"},
        {name: "Bob", role: "Designer"}
    ],
    founded: 2020
};
```

## Functions

Functions are first-class values in Evil Lang:

```javascript
// Function as a value
var greet = func(name) {
    return "Hello, " + name;
};

// Passing functions as arguments
func map(array, fn) {
    var result = [];
    for (var i = 0; i < array.length; i = i + 1) {
        result[i] = fn(array[i]);
    }
    return result;
}

var numbers = [1, 2, 3];
var doubled = map(numbers, func(x) { return x * 2; });
print(doubled);  // [2, 4, 6]

// Returning functions
func makeAdder(x) {
    return func(y) {
        return x + y;
    };
}

var add5 = makeAdder(5);
print(add5(3));  // 8
```

## Type Checking

Use the `typeof` function to check the type of a value:

```javascript
print(typeof(42));           // "number"
print(typeof("hello"));      // "string"
print(typeof(true));         // "boolean"
print(typeof(null));         // "null"
print(typeof([1, 2, 3]));    // "array"
print(typeof({a: 1}));       // "object"
print(typeof(print));        // "function"
```

## Type Conversion

Evil Lang performs automatic type conversion in some cases:

```javascript
// String concatenation converts numbers to strings
var result = "The answer is " + 42;  // "The answer is 42"

// Comparison with == allows type coercion
print(5 == "5");    // false (no automatic conversion)
print(true == 1);   // false (no automatic conversion)

// Explicit conversion
var str = toString(42);        // "42"
var num = 0 + "42";           // Type error - cannot add string to number
```

## Truthiness

In conditional contexts, values are evaluated as truthy or falsy:

- **Falsy values**: `false`, `null`, `0`, `""` (empty string)
- **Truthy values**: Everything else

```javascript
if (0) {
    print("This won't print");
}

if (1) {
    print("This will print");
}

if ("") {
    print("This won't print");
}

if ("hello") {
    print("This will print");
}
```

## Next Steps

Now that you understand data types, explore:
- [Control Flow](control-flow.md) - Using conditionals and loops
- [Functions](functions.md) - Creating and using functions
- [Classes and Objects](classes-objects.md) - Object-oriented programming