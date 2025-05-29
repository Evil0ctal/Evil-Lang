# Modules

Modules allow you to organize code into reusable libraries and manage dependencies between different parts of your application.

## Creating Modules

A module is simply an Evil Lang file that exports functions, classes, or values:

```evil
// math_utils.el
export function add(a, b) {
    return a + b;
}

export function multiply(a, b) {
    return a * b;
}

export let PI = 3.14159;
```

## Importing Modules

Use the `import` statement to use code from other modules:

```evil
// main.el
import { add, multiply, PI } from "./math_utils.el";

print(add(5, 3));        // Output: 8
print(multiply(4, 7));   // Output: 28
print("PI = " + PI);     // Output: PI = 3.14159
```

## Import Syntax

### Named Imports

Import specific exports by name:

```evil
import { functionA, functionB } from "./module.el";
```

### Import All

Import all exports as an object:

```evil
import * as utils from "./math_utils.el";

print(utils.add(5, 3));       // Output: 8
print(utils.multiply(4, 7));  // Output: 28
```

### Aliasing Imports

Rename imports to avoid conflicts:

```evil
import { add as sum, multiply as mult } from "./math_utils.el";

print(sum(5, 3));   // Output: 8
print(mult(4, 7));  // Output: 28
```

## Export Syntax

### Named Exports

Export individual items:

```evil
// Export functions
export function calculate(x, y) {
    return x + y;
}

// Export variables
export let version = "1.0.0";

// Export classes
export class Calculator {
    constructor() {
        this.result = 0;
    }
}
```

### Export After Declaration

Export items after they're declared:

```evil
function helper() {
    return "Helper function";
}

let config = {
    debug: true,
    version: "1.0.0"
};

export { helper, config };
```

### Default Exports

Export a single default value:

```evil
// logger.el
export default function log(message) {
    print("[LOG] " + message);
}

// main.el
import log from "./logger.el";
log("Application started");  // Output: [LOG] Application started
```

## Module Organization

### File Structure

Organize modules in a logical directory structure:

```
project/
├── main.el
├── utils/
│   ├── math.el
│   ├── string.el
│   └── array.el
├── models/
│   ├── user.el
│   └── product.el
└── stdlib/
    ├── math.el
    └── array.el
```

### Relative Imports

Use relative paths to import local modules:

```evil
// From utils/math.el
import { helper } from "./string.el";  // Same directory
import { User } from "../models/user.el";  // Parent directory
```

### Standard Library Imports

Import from the standard library:

```evil
import { sqrt, pow, abs } from "stdlib/math.el";
import { map, filter, reduce } from "stdlib/array.el";

let numbers = [1, 4, 9, 16];
let roots = map(numbers, sqrt);
print(roots);  // Output: [1, 2, 3, 4]
```

## Practical Examples

### Math Library Module

```evil
// libs/advanced_math.el
import { sqrt } from "stdlib/math.el";

export function distance(x1, y1, x2, y2) {
    let dx = x2 - x1;
    let dy = y2 - y1;
    return sqrt(dx * dx + dy * dy);
}

export function average(numbers) {
    if (numbers.length == 0) return 0;
    
    let sum = 0;
    for (let i = 0; i < numbers.length; i = i + 1) {
        sum = sum + numbers[i];
    }
    return sum / numbers.length;
}

export class Vector {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    
    add(other) {
        return new Vector(this.x + other.x, this.y + other.y);
    }
    
    magnitude() {
        return sqrt(this.x * this.x + this.y * this.y);
    }
}
```

### Configuration Module

```evil
// config/settings.el
export let config = {
    appName: "My Application",
    version: "1.0.0",
    debug: true,
    maxRetries: 3,
    timeout: 5000
};

export function get(key) {
    return config[key];
}

export function set(key, value) {
    config[key] = value;
}

export function isDebugMode() {
    return config.debug;
}
```

### Service Module

```evil
// services/user_service.el
import { User } from "../models/user.el";
import { isDebugMode } from "../config/settings.el";

let users = [];

export function createUser(name, email) {
    let user = new User(name, email);
    push(users, user);
    
    if (isDebugMode()) {
        print("Created user: " + name);
    }
    
    return user;
}

export function findUserByEmail(email) {
    for (let i = 0; i < users.length; i = i + 1) {
        if (users[i].email == email) {
            return users[i];
        }
    }
    return null;
}

export function getAllUsers() {
    return users;
}
```

## Module Best Practices

### 1. Single Responsibility

Each module should have a single, clear purpose:

```evil
// Good: Focused module
// date_utils.el
export function formatDate(date) { /* ... */ }
export function parseDate(str) { /* ... */ }
export function addDays(date, days) { /* ... */ }

// Bad: Mixed concerns
// utils.el
export function formatDate(date) { /* ... */ }
export function calculateTax(amount) { /* ... */ }
export function sendEmail(to, subject) { /* ... */ }
```

### 2. Avoid Circular Dependencies

Prevent modules from importing each other:

```evil
// Bad: Circular dependency
// a.el
import { b } from "./b.el";
export function a() { return b(); }

// b.el
import { a } from "./a.el";
export function b() { return a(); }

// Good: Refactor to avoid circular dependency
// common.el
export function common() { /* ... */ }

// a.el
import { common } from "./common.el";
export function a() { return common(); }

// b.el
import { common } from "./common.el";
export function b() { return common(); }
```

### 3. Export Interfaces

Export only what's necessary:

```evil
// implementation.el
function internalHelper() {
    // Not exported - internal only
}

export function publicAPI() {
    return internalHelper();
}
```

### 4. Module Documentation

Document module purpose and exports:

```evil
// geometry.el
// Module: Geometry utilities
// Provides functions for 2D geometric calculations

export function calculateArea(shape) {
    // Calculate area based on shape type
}

export function calculatePerimeter(shape) {
    // Calculate perimeter based on shape type
}
```

## Module Loading

Evil Lang uses a module cache to avoid reloading modules:

```evil
// module1.el
print("Loading module1");
export let value = 42;

// main.el
import { value } from "./module1.el";  // Prints: Loading module1
import { value as v2 } from "./module1.el";  // No print - already loaded

print(value);   // Output: 42
print(v2);      // Output: 42
```

## Next Steps

- Learn about [Exception Handling](exception-handling.md) for error management
- Explore the [Standard Library](../reference/stdlib.md) modules
- Study [Best Practices](../guide/best-practices.md) for larger projects