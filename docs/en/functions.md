# Functions

Functions are reusable blocks of code that perform specific tasks. They are fundamental to writing modular and maintainable programs.

## Defining Functions

Use the `function` keyword to define a function:

```evil
function greet() {
    print("Hello, World!");
}

// Call the function
greet();  // Output: Hello, World!
```

## Function Parameters

Functions can accept parameters:

```evil
function greet(name) {
    print("Hello, " + name + "!");
}

greet("Alice");  // Output: Hello, Alice!
greet("Bob");    // Output: Hello, Bob!
```

### Multiple Parameters

```evil
function add(a, b) {
    return a + b;
}

let result = add(5, 3);
print("Sum: " + result);  // Output: Sum: 8
```

### Default Parameters

Evil Lang supports default parameter values:

```evil
function greet(name = "Guest") {
    print("Hello, " + name + "!");
}

greet();          // Output: Hello, Guest!
greet("Alice");   // Output: Hello, Alice!
```

## Return Values

Functions can return values using the `return` statement:

```evil
function multiply(a, b) {
    return a * b;
}

let product = multiply(4, 5);
print("Product: " + product);  // Output: Product: 20
```

### Early Return

```evil
function divide(a, b) {
    if (b == 0) {
        print("Error: Division by zero!");
        return null;
    }
    return a / b;
}

let result = divide(10, 2);   // Returns 5
let error = divide(10, 0);    // Prints error, returns null
```

## Function Expressions

Functions can be assigned to variables:

```evil
let square = function(x) {
    return x * x;
};

print(square(5));  // Output: 25
```

## Higher-Order Functions

Functions can accept other functions as parameters:

```evil
function applyOperation(a, b, operation) {
    return operation(a, b);
}

function add(x, y) {
    return x + y;
}

function multiply(x, y) {
    return x * y;
}

print(applyOperation(5, 3, add));       // Output: 8
print(applyOperation(5, 3, multiply));  // Output: 15
```

## Closures

Functions can access variables from their outer scope:

```evil
function makeCounter() {
    let count = 0;
    
    return function() {
        count = count + 1;
        return count;
    };
}

let counter = makeCounter();
print(counter());  // Output: 1
print(counter());  // Output: 2
print(counter());  // Output: 3
```

## Recursive Functions

Functions can call themselves:

```evil
function factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

print("5! = " + factorial(5));  // Output: 5! = 120
```

### Fibonacci Example

```evil
function fibonacci(n) {
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// Print first 10 Fibonacci numbers
for (let i = 0; i < 10; i = i + 1) {
    print("F(" + i + ") = " + fibonacci(i));
}
```

## Variable Arguments

Handle variable number of arguments:

```evil
function sum() {
    let total = 0;
    for (let i = 0; i < arguments.length; i = i + 1) {
        total = total + arguments[i];
    }
    return total;
}

print(sum(1, 2, 3));        // Output: 6
print(sum(1, 2, 3, 4, 5));  // Output: 15
```

## Nested Functions

Functions can be defined inside other functions:

```evil
function outerFunction(x) {
    function innerFunction(y) {
        return x + y;
    }
    
    return innerFunction(10);
}

print(outerFunction(5));  // Output: 15
```

## Function Composition

Combine multiple functions:

```evil
function compose(f, g) {
    return function(x) {
        return f(g(x));
    };
}

function double(x) {
    return x * 2;
}

function addOne(x) {
    return x + 1;
}

let doubleThenAddOne = compose(addOne, double);
print(doubleThenAddOne(5));  // Output: 11 (5 * 2 + 1)
```

## Practical Examples

### Array Processing

```evil
function map(array, fn) {
    let result = [];
    for (let i = 0; i < array.length; i = i + 1) {
        push(result, fn(array[i]));
    }
    return result;
}

function filter(array, predicate) {
    let result = [];
    for (let i = 0; i < array.length; i = i + 1) {
        if (predicate(array[i])) {
            push(result, array[i]);
        }
    }
    return result;
}

let numbers = [1, 2, 3, 4, 5];
let doubled = map(numbers, function(x) { return x * 2; });
let evens = filter(numbers, function(x) { return x % 2 == 0; });

print("Doubled: " + doubled);  // Output: Doubled: [2, 4, 6, 8, 10]
print("Evens: " + evens);      // Output: Evens: [2, 4]
```

### Memoization

```evil
function memoize(fn) {
    let cache = {};
    
    return function(n) {
        if (cache[n] != null) {
            return cache[n];
        }
        
        let result = fn(n);
        cache[n] = result;
        return result;
    };
}

// Memoized fibonacci
let fib = memoize(function(n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
});

print("Fib(40) = " + fib(40));  // Much faster than non-memoized version
```

## Best Practices

1. **Use descriptive names**: Function names should clearly indicate what they do
2. **Keep functions small**: Each function should do one thing well
3. **Avoid side effects**: Prefer pure functions that don't modify external state
4. **Document complex functions**: Add comments explaining parameters and return values
5. **Use consistent parameter ordering**: Put the most important parameters first

## Next Steps

- Learn about [Classes and Objects](classes-objects.md) for object-oriented programming
- Explore [Modules](modules.md) to organize functions into libraries
- Study [Exception Handling](exception-handling.md) for error management