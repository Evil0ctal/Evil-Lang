# Quick Start Guide

Let's write your first Evil Lang program! This guide will introduce you to the basics through hands-on examples.

## Your First Program

Create a file named `hello.el`:

```javascript
// My first Evil Lang program
print("Hello, Evil Lang!");
```

Run it:
```bash
python evil_lang.py hello.el
```

Output:
```
Hello, Evil Lang!
```

## Variables and Basic Operations

```javascript
// Variables
var name = "Alice";
var age = 25;
var isStudent = true;

print("Name: " + name);
print("Age: " + age);
print("Is student: " + isStudent);

// Basic math
var x = 10;
var y = 20;
print("Sum: " + (x + y));
print("Product: " + (x * y));
```

## Working with Functions

```javascript
// Define a function
func greet(name) {
    return "Hello, " + name + "!";
}

// Call the function
print(greet("Bob"));

// Function with multiple parameters
func add(a, b) {
    return a + b;
}

print("5 + 3 = " + add(5, 3));
```

## Control Flow

```javascript
// If-else statements
var score = 85;

if (score >= 90) {
    print("Grade: A");
} else if (score >= 80) {
    print("Grade: B");
} else {
    print("Grade: C or below");
}

// Loops
print("\nCounting to 5:");
for (var i = 1; i <= 5; i = i + 1) {
    print(i);
}

// While loop
var count = 3;
print("\nCountdown:");
while (count > 0) {
    print(count + "...");
    count = count - 1;
}
print("Blast off!");
```

## Arrays and Objects

```javascript
// Arrays
var fruits = ["apple", "banana", "orange"];
print("Fruits: " + fruits);
print("First fruit: " + fruits[0]);
print("Number of fruits: " + fruits.length);

// Add to array
push(fruits, "grape");
print("After adding grape: " + fruits);

// Objects
var person = {
    name: "Charlie",
    age: 30,
    city: "New York"
};

print("\nPerson info:");
print("Name: " + person.name);
print("Age: " + person.age);
print("City: " + person.city);
```

## Classes and Objects

```javascript
// Define a class
class Dog {
    constructor(name, breed) {
        this.name = name;
        this.breed = breed;
    }
    
    bark() {
        print(this.name + " says: Woof!");
    }
    
    describe() {
        print(this.name + " is a " + this.breed);
    }
}

// Create instances
var myDog = new Dog("Max", "Golden Retriever");
myDog.describe();
myDog.bark();
```

## Exception Handling

```javascript
// Try-catch example
func safeDivide(a, b) {
    try {
        if (b == 0) {
            throw "Cannot divide by zero!";
        }
        return a / b;
    } catch (error) {
        print("Error: " + error);
        return null;
    }
}

print("10 / 2 = " + safeDivide(10, 2));
print("10 / 0 = " + safeDivide(10, 0));
```

## Interactive Input

```javascript
// Get user input
var userName = input("What's your name? ");
print("Nice to meet you, " + userName + "!");

var userAge = input("How old are you? ");
print("You are " + userAge + " years old.");
```

## Complete Example: Number Guessing Game

Here's a simple game that combines various concepts:

```javascript
// Simple number guessing game
var secretNumber = 42;
var maxTries = 5;
var tries = 0;
var won = false;

print("Welcome to the Number Guessing Game!");
print("I'm thinking of a number between 1 and 100.");
print("You have " + maxTries + " tries to guess it.\n");

while (tries < maxTries && !won) {
    var guess = input("Enter your guess: ");
    tries = tries + 1;
    
    // Convert string to number for comparison
    if (guess == secretNumber) {
        won = true;
        print("Congratulations! You got it in " + tries + " tries!");
    } else if (guess < secretNumber) {
        print("Too low! Try again.");
        print("Tries left: " + (maxTries - tries));
    } else {
        print("Too high! Try again.");
        print("Tries left: " + (maxTries - tries));
    }
}

if (!won) {
    print("\nSorry! The number was " + secretNumber);
}
```

## Next Steps

Congratulations! You've learned the basics of Evil Lang. To continue your journey:

1. Explore more [examples](../../examples) in the repository
2. Learn about [Data Types](data-types.md) in detail
3. Master [Functions and Closures](functions.md)
4. Discover [Object-Oriented Programming](classes-objects.md)
5. Understand [Module System](modules.md)

## Tips for Learning

1. **Experiment**: Modify the examples and see what happens
2. **Read Errors**: Evil Lang provides helpful error messages
3. **Use Debug Mode**: Add `--debug` to see how your code is parsed
4. **Practice**: Try to implement small programs and games
5. **Explore**: Check the standard library for useful functions

Happy coding with Evil Lang!