# Control Flow

Control flow statements allow you to control the execution path of your program based on conditions and loops.

## If Statements

The `if` statement executes code based on a condition:

```evil
if (x > 0) {
    print("x is positive");
}
```

### If-Else

Add an `else` clause to handle the false case:

```evil
let score = 85;

if (score >= 90) {
    print("Grade: A");
} else {
    print("Grade: B or below");
}
```

### If-Else If-Else

Chain multiple conditions:

```evil
let score = 75;

if (score >= 90) {
    print("Grade: A");
} else if (score >= 80) {
    print("Grade: B");
} else if (score >= 70) {
    print("Grade: C");
} else if (score >= 60) {
    print("Grade: D");
} else {
    print("Grade: F");
}
```

## Loops

### While Loop

The `while` loop executes code as long as a condition is true:

```evil
let i = 0;
while (i < 5) {
    print("Count: " + i);
    i = i + 1;
}
```

### For Loop

The `for` loop provides a compact way to iterate:

```evil
// Traditional for loop
for (let i = 0; i < 5; i = i + 1) {
    print("Index: " + i);
}

// Iterate over array
let fruits = ["apple", "banana", "orange"];
for (let i = 0; i < fruits.length; i = i + 1) {
    print("Fruit: " + fruits[i]);
}
```

### Break Statement

Exit a loop early with `break`:

```evil
let i = 0;
while (true) {
    if (i >= 5) {
        break;
    }
    print("Count: " + i);
    i = i + 1;
}
```

### Continue Statement

Skip the rest of the current iteration with `continue`:

```evil
for (let i = 0; i < 10; i = i + 1) {
    if (i % 2 == 0) {
        continue;  // Skip even numbers
    }
    print("Odd: " + i);
}
```

## Nested Control Structures

Control structures can be nested:

```evil
for (let i = 1; i <= 3; i = i + 1) {
    print("Outer loop: " + i);
    
    for (let j = 1; j <= 3; j = j + 1) {
        if (i == j) {
            continue;
        }
        print("  Inner loop: " + j);
    }
}
```

## Return Statement

Exit a function and optionally return a value:

```evil
function findFirst(arr, target) {
    for (let i = 0; i < arr.length; i = i + 1) {
        if (arr[i] == target) {
            return i;  // Return index if found
        }
    }
    return -1;  // Return -1 if not found
}

let numbers = [10, 20, 30, 40];
let index = findFirst(numbers, 30);
print("Found at index: " + index);  // Output: Found at index: 2
```

## Conditional Expressions

Evil Lang supports ternary-like conditional expressions:

```evil
let age = 18;
let status = age >= 18 ? "adult" : "minor";
print("Status: " + status);  // Output: Status: adult
```

## Practical Examples

### Menu System

```evil
let running = true;
while (running) {
    print("\n=== Menu ===");
    print("1. Say Hello");
    print("2. Calculate");
    print("3. Exit");
    
    let choice = input("Enter choice: ");
    
    if (choice == "1") {
        print("Hello, World!");
    } else if (choice == "2") {
        let a = toNumber(input("Enter first number: "));
        let b = toNumber(input("Enter second number: "));
        print("Sum: " + (a + b));
    } else if (choice == "3") {
        print("Goodbye!");
        running = false;
    } else {
        print("Invalid choice!");
    }
}
```

### Number Guessing Game

```evil
let secret = floor(random() * 100) + 1;
let attempts = 0;
let found = false;

print("I'm thinking of a number between 1 and 100!");

while (!found) {
    let guess = toNumber(input("Your guess: "));
    attempts = attempts + 1;
    
    if (guess < secret) {
        print("Too low!");
    } else if (guess > secret) {
        print("Too high!");
    } else {
        found = true;
        print("Correct! You got it in " + attempts + " attempts!");
    }
}
```

## Best Practices

1. **Use meaningful conditions**: Make your conditions clear and readable
2. **Avoid deep nesting**: Consider refactoring deeply nested structures
3. **Use break and continue judiciously**: They can make code harder to follow
4. **Consider early returns**: Return early from functions to reduce nesting
5. **Initialize loop variables**: Always initialize variables used in loops

## Next Steps

- Learn about [Functions](functions.md) to organize your code
- Explore [Exception Handling](exception-handling.md) for error management
- Study [Classes and Objects](classes-objects.md) for object-oriented programming