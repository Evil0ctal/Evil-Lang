# Tutorial: Building a Calculator

In this tutorial, we'll build a simple calculator in Evil Lang, progressively adding features to demonstrate various language concepts.

## Step 1: Basic Arithmetic Calculator

Let's start with a simple calculator that can perform basic operations:

```javascript
// Basic Calculator v1.0
print("=== Simple Calculator ===");

// Basic arithmetic functions
func add(a, b) {
    return a + b;
}

func subtract(a, b) {
    return a - b;
}

func multiply(a, b) {
    return a * b;
}

func divide(a, b) {
    if (b == 0) {
        print("Error: Division by zero!");
        return null;
    }
    return a / b;
}

// Test our calculator
print("10 + 5 = " + add(10, 5));
print("10 - 5 = " + subtract(10, 5));
print("10 * 5 = " + multiply(10, 5));
print("10 / 5 = " + divide(10, 5));
print("10 / 0 = " + divide(10, 0));
```

## Step 2: Adding User Input

Now let's make it interactive:

```javascript
// Interactive Calculator v2.0
print("=== Interactive Calculator ===");

func calculate() {
    var num1 = input("Enter first number: ");
    var operator = input("Enter operator (+, -, *, /): ");
    var num2 = input("Enter second number: ");
    
    // Note: input returns strings, but Evil Lang handles conversion
    var result = null;
    
    if (operator == "+") {
        result = num1 + num2;
    } else if (operator == "-") {
        result = num1 - num2;
    } else if (operator == "*") {
        result = num1 * num2;
    } else if (operator == "/") {
        if (num2 == 0) {
            print("Error: Division by zero!");
            return;
        }
        result = num1 / num2;
    } else {
        print("Error: Invalid operator!");
        return;
    }
    
    print("Result: " + result);
}

// Run the calculator
calculate();
```

## Step 3: Object-Oriented Calculator

Let's refactor using classes:

```javascript
// OOP Calculator v3.0
class Calculator {
    constructor() {
        this.history = [];
    }
    
    add(a, b) {
        var result = a + b;
        this.saveToHistory(a + " + " + b + " = " + result);
        return result;
    }
    
    subtract(a, b) {
        var result = a - b;
        this.saveToHistory(a + " - " + b + " = " + result);
        return result;
    }
    
    multiply(a, b) {
        var result = a * b;
        this.saveToHistory(a + " * " + b + " = " + result);
        return result;
    }
    
    divide(a, b) {
        if (b == 0) {
            throw "Division by zero error!";
        }
        var result = a / b;
        this.saveToHistory(a + " / " + b + " = " + result);
        return result;
    }
    
    saveToHistory(operation) {
        push(this.history, operation);
    }
    
    showHistory() {
        print("\n=== Calculation History ===");
        if (this.history.length == 0) {
            print("No calculations yet.");
            return;
        }
        
        for (var i = 0; i < this.history.length; i = i + 1) {
            print((i + 1) + ". " + this.history[i]);
        }
    }
}

// Using the calculator
var calc = new Calculator();

print("Calculator created. Testing operations:");
print("5 + 3 = " + calc.add(5, 3));
print("10 - 4 = " + calc.subtract(10, 4));
print("6 * 7 = " + calc.multiply(6, 7));
print("20 / 4 = " + calc.divide(20, 4));

calc.showHistory();
```

## Step 4: Advanced Calculator with Error Handling

Let's add more features and proper error handling:

```javascript
// Advanced Calculator v4.0
class AdvancedCalculator extends Calculator {
    constructor() {
        this.history = [];
        this.memory = 0;
    }
    
    // Additional operations
    power(base, exponent) {
        var result = 1;
        for (var i = 0; i < exponent; i = i + 1) {
            result = result * base;
        }
        this.saveToHistory(base + " ^ " + exponent + " = " + result);
        return result;
    }
    
    sqrt(n) {
        if (n < 0) {
            throw "Cannot calculate square root of negative number!";
        }
        // Simple approximation using Newton's method
        var guess = n / 2;
        for (var i = 0; i < 10; i = i + 1) {
            guess = (guess + n / guess) / 2;
        }
        this.saveToHistory("sqrt(" + n + ") = " + guess);
        return guess;
    }
    
    // Memory operations
    memoryStore(value) {
        this.memory = value;
        print("Stored " + value + " in memory");
    }
    
    memoryRecall() {
        return this.memory;
    }
    
    memoryClear() {
        this.memory = 0;
        print("Memory cleared");
    }
    
    // Safe calculation with error handling
    calculate(expression) {
        try {
            print("Calculating: " + expression);
            // This is a simplified expression evaluator
            // In a real calculator, you'd parse the expression properly
            
            // For this example, we'll handle simple two-operand expressions
            var parts = split(expression, " ");
            if (parts.length != 3) {
                throw "Invalid expression format. Use: number operator number";
            }
            
            var num1 = parts[0];
            var operator = parts[1];
            var num2 = parts[2];
            
            var result = null;
            
            if (operator == "+") {
                result = this.add(num1, num2);
            } else if (operator == "-") {
                result = this.subtract(num1, num2);
            } else if (operator == "*") {
                result = this.multiply(num1, num2);
            } else if (operator == "/") {
                result = this.divide(num1, num2);
            } else if (operator == "^") {
                result = this.power(num1, num2);
            } else {
                throw "Unknown operator: " + operator;
            }
            
            return result;
            
        } catch (error) {
            print("Calculation error: " + error);
            return null;
        }
    }
}

// Interactive calculator session
func runCalculator() {
    var calc = new AdvancedCalculator();
    var running = true;
    
    print("\n=== Advanced Calculator ===");
    print("Commands: ");
    print("  - Enter expression (e.g., '5 + 3')");
    print("  - 'sqrt n' for square root");
    print("  - 'mem' for memory operations");
    print("  - 'history' to show history");
    print("  - 'quit' to exit");
    
    while (running) {
        var input_str = input("\ncalc> ");
        
        if (input_str == "quit") {
            running = false;
            print("Goodbye!");
        } else if (input_str == "history") {
            calc.showHistory();
        } else if (indexOf(input_str, "sqrt") == 0) {
            var parts = split(input_str, " ");
            if (parts.length == 2) {
                try {
                    var result = calc.sqrt(parts[1]);
                    print("Result: " + result);
                } catch (e) {
                    print("Error: " + e);
                }
            }
        } else if (input_str == "mem") {
            print("Memory: " + calc.memoryRecall());
        } else {
            var result = calc.calculate(input_str);
            if (result != null) {
                print("Result: " + result);
            }
        }
    }
}

// Run the interactive calculator
runCalculator();
```

## Key Concepts Demonstrated

This tutorial demonstrated:

1. **Functions** - Basic arithmetic operations
2. **Control Flow** - If/else statements for operator selection
3. **User Input** - Interactive calculator
4. **Classes** - Object-oriented design
5. **Inheritance** - AdvancedCalculator extends Calculator
6. **Arrays** - History storage
7. **Exception Handling** - Try/catch for error management
8. **Loops** - Interactive calculator loop
9. **String Operations** - Parsing expressions

## Exercises

Try extending the calculator with:

1. **Percentage calculations** - Add a percentage function
2. **Scientific functions** - Add sin, cos, tan (using approximations)
3. **Expression parser** - Handle complex expressions like "2 + 3 * 4"
4. **Unit conversions** - Add length, weight, temperature conversions
5. **Graphing** - Plot simple functions using ASCII art

## Next Steps

- Learn about [Module System](../modules.md) to organize calculator functions
- Explore [Standard Library](../standard-library.md) for more built-in functions
- Try the [Text Adventure Game Tutorial](text-game.md) for a different project