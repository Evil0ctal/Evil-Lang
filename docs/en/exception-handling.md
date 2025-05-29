# Exception Handling

Exception handling allows you to gracefully manage errors and unexpected situations in your programs.

## Try-Catch Blocks

Use `try-catch` to handle exceptions:

```evil
try {
    let result = 10 / 0;  // This might cause an error
    print("Result: " + result);
} catch (error) {
    print("An error occurred: " + error);
}
```

## Throwing Exceptions

Use the `throw` statement to raise exceptions:

```evil
function divide(a, b) {
    if (b == 0) {
        throw "Division by zero error";
    }
    return a / b;
}

try {
    let result = divide(10, 0);
} catch (error) {
    print("Caught error: " + error);  // Output: Caught error: Division by zero error
}
```

## Finally Block

The `finally` block always executes, regardless of whether an exception occurred:

```evil
try {
    print("Trying something risky...");
    throw "Something went wrong!";
} catch (error) {
    print("Caught: " + error);
} finally {
    print("Cleanup code runs regardless");
}

// Output:
// Trying something risky...
// Caught: Something went wrong!
// Cleanup code runs regardless
```

## Exception Objects

Create more informative exception objects:

```evil
function createError(type, message) {
    return {
        type: type,
        message: message,
        timestamp: getCurrentTime()
    };
}

function validateAge(age) {
    if (age < 0) {
        throw createError("ValidationError", "Age cannot be negative");
    }
    if (age > 150) {
        throw createError("ValidationError", "Age seems unrealistic");
    }
    return true;
}

try {
    validateAge(-5);
} catch (error) {
    print("Error Type: " + error.type);
    print("Error Message: " + error.message);
}
```

## Nested Try-Catch

Handle exceptions at different levels:

```evil
function processFile(filename) {
    try {
        let data = readFile(filename);  // Might throw
        
        try {
            let parsed = parseJSON(data);  // Might throw
            return parsed;
        } catch (parseError) {
            print("Failed to parse file: " + parseError);
            throw "Invalid file format";
        }
    } catch (readError) {
        print("Failed to read file: " + readError);
        throw "File access error";
    }
}

try {
    let result = processFile("config.json");
} catch (error) {
    print("Operation failed: " + error);
}
```

## Re-throwing Exceptions

Catch, log, and re-throw exceptions:

```evil
function riskyOperation() {
    throw "Operation failed";
}

function performTask() {
    try {
        riskyOperation();
    } catch (error) {
        print("Logging error: " + error);
        throw error;  // Re-throw for caller to handle
    }
}

try {
    performTask();
} catch (error) {
    print("Task failed: " + error);
}
```

## Custom Exception Types

Create specialized exception classes:

```evil
class ValidationError extends Error {
    constructor(field, value, message) {
        super(message);
        this.field = field;
        this.value = value;
    }
    
    toString() {
        return "ValidationError in field '" + this.field + 
               "': " + this.message + " (value: " + this.value + ")";
    }
}

class NetworkError extends Error {
    constructor(url, statusCode) {
        super("Network request failed");
        this.url = url;
        this.statusCode = statusCode;
    }
}

function validateEmail(email) {
    if (!contains(email, "@")) {
        throw new ValidationError("email", email, "Invalid email format");
    }
}

try {
    validateEmail("invalid-email");
} catch (error) {
    if (error instanceof ValidationError) {
        print("Validation failed: " + error.toString());
    } else {
        print("Unexpected error: " + error);
    }
}
```

## Error Propagation

Design error handling strategies:

```evil
class Database {
    constructor() {
        this.connected = false;
    }
    
    connect() {
        // Simulate connection attempt
        if (random() < 0.3) {
            throw new NetworkError("db://localhost", 500);
        }
        this.connected = true;
    }
    
    query(sql) {
        if (!this.connected) {
            throw "Database not connected";
        }
        // Execute query...
        return [];
    }
}

function getUserData(userId) {
    let db = new Database();
    
    try {
        db.connect();
        return db.query("SELECT * FROM users WHERE id = " + userId);
    } catch (error) {
        if (error instanceof NetworkError) {
            print("Network issue: " + error.url);
            return null;
        } else {
            throw error;  // Propagate unexpected errors
        }
    }
}

// Usage with proper error handling
try {
    let userData = getUserData(123);
    if (userData == null) {
        print("Using cached data instead");
    }
} catch (error) {
    print("Fatal error: " + error);
}
```

## Practical Examples

### Input Validation System

```evil
class InputValidator {
    constructor() {
        this.errors = [];
    }
    
    validate(data, rules) {
        this.errors = [];
        
        for (let field in rules) {
            try {
                this.validateField(field, data[field], rules[field]);
            } catch (error) {
                push(this.errors, error);
            }
        }
        
        if (this.errors.length > 0) {
            throw {
                type: "ValidationError",
                errors: this.errors
            };
        }
        
        return true;
    }
    
    validateField(name, value, rule) {
        if (rule.required && (value == null || value == "")) {
            throw {field: name, message: "Field is required"};
        }
        
        if (rule.minLength && value.length < rule.minLength) {
            throw {field: name, message: "Too short (min: " + rule.minLength + ")"};
        }
        
        if (rule.maxLength && value.length > rule.maxLength) {
            throw {field: name, message: "Too long (max: " + rule.maxLength + ")"};
        }
        
        if (rule.pattern && !matches(value, rule.pattern)) {
            throw {field: name, message: "Invalid format"};
        }
    }
}

// Usage
let validator = new InputValidator();
let formData = {
    username: "ab",
    email: "invalid",
    password: "12345"
};

let rules = {
    username: {required: true, minLength: 3, maxLength: 20},
    email: {required: true, pattern: ".*@.*\\..*"},
    password: {required: true, minLength: 8}
};

try {
    validator.validate(formData, rules);
    print("Validation passed!");
} catch (error) {
    print("Validation failed:");
    for (let i = 0; i < error.errors.length; i = i + 1) {
        let e = error.errors[i];
        print("  - " + e.field + ": " + e.message);
    }
}
```

### Retry Mechanism

```evil
function retry(fn, maxAttempts = 3, delay = 1000) {
    let lastError;
    
    for (let attempt = 1; attempt <= maxAttempts; attempt = attempt + 1) {
        try {
            return fn();
        } catch (error) {
            lastError = error;
            print("Attempt " + attempt + " failed: " + error);
            
            if (attempt < maxAttempts) {
                print("Retrying in " + delay + "ms...");
                sleep(delay);
                delay = delay * 2;  // Exponential backoff
            }
        }
    }
    
    throw "All " + maxAttempts + " attempts failed. Last error: " + lastError;
}

// Simulated unreliable operation
function unreliableOperation() {
    if (random() < 0.7) {
        throw "Network timeout";
    }
    return "Success!";
}

try {
    let result = retry(unreliableOperation, 5, 500);
    print("Operation succeeded: " + result);
} catch (error) {
    print("Operation failed after retries: " + error);
}
```

## Best Practices

1. **Specific Catches**: Catch specific exception types when possible
2. **Clean Up Resources**: Use finally blocks to ensure cleanup
3. **Meaningful Messages**: Provide clear, actionable error messages
4. **Don't Swallow Errors**: Always handle or re-throw exceptions
5. **Log Errors**: Record errors for debugging and monitoring
6. **Fail Fast**: Validate inputs early to catch errors sooner

## Common Patterns

### Guard Clauses

```evil
function processOrder(order) {
    // Validate early
    if (!order) {
        throw "Order is required";
    }
    if (!order.items || order.items.length == 0) {
        throw "Order must contain items";
    }
    if (order.total <= 0) {
        throw "Invalid order total";
    }
    
    // Process valid order
    return processValidOrder(order);
}
```

### Error Transformation

```evil
function getUserProfile(userId) {
    try {
        let data = fetchFromAPI("/users/" + userId);
        return parseUserData(data);
    } catch (error) {
        // Transform low-level errors to domain errors
        if (contains(error, "404")) {
            throw "User not found";
        } else if (contains(error, "Network")) {
            throw "Unable to connect to server";
        } else {
            throw "Failed to load user profile";
        }
    }
}
```

## Next Steps

- Explore [Built-in Functions](../reference/builtin-functions.md) for error utilities
- Learn about [Debugging](../guide/debugging.md) techniques
- Study [Best Practices](../guide/best-practices.md) for robust applications