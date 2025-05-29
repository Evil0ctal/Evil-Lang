# Built-in Functions Reference

Evil Lang provides a comprehensive set of built-in functions for common programming tasks.

## I/O Functions

### print(value)
Outputs a value to the console.
```evil
print("Hello, World!");  // Output: Hello, World!
print(42);               // Output: 42
```

### input(prompt)
Reads user input from the console.
```evil
let name = input("Enter your name: ");
print("Hello, " + name);
```

## Type Conversion

### toNumber(value)
Converts a value to a number.
```evil
let num = toNumber("42");      // 42
let float = toNumber("3.14");  // 3.14
let invalid = toNumber("abc"); // null
```

### toString(value)
Converts a value to a string.
```evil
let str1 = toString(42);       // "42"
let str2 = toString(true);     // "true"
let str3 = toString([1, 2]);   // "[1, 2]"
```

### toBoolean(value)
Converts a value to a boolean.
```evil
toBoolean(1);        // true
toBoolean(0);        // false
toBoolean("text");   // true
toBoolean("");       // false
toBoolean(null);     // false
```

## Math Functions

### abs(x)
Returns the absolute value.
```evil
abs(-5);    // 5
abs(3.14);  // 3.14
```

### sqrt(x)
Returns the square root.
```evil
sqrt(16);   // 4
sqrt(2);    // 1.414...
```

### pow(base, exponent)
Returns base raised to exponent.
```evil
pow(2, 3);   // 8
pow(5, 2);   // 25
```

### min(a, b)
Returns the smaller of two values.
```evil
min(5, 3);    // 3
min(-1, -5);  // -5
```

### max(a, b)
Returns the larger of two values.
```evil
max(5, 3);    // 5
max(-1, -5);  // -1
```

### floor(x)
Rounds down to the nearest integer.
```evil
floor(3.7);   // 3
floor(-2.1);  // -3
```

### ceil(x)
Rounds up to the nearest integer.
```evil
ceil(3.1);    // 4
ceil(-2.9);   // -2
```

### round(x)
Rounds to the nearest integer.
```evil
round(3.5);   // 4
round(3.4);   // 3
round(-2.5);  // -2
```

### random()
Returns a random number between 0 and 1.
```evil
let r = random();  // 0.73945...
let dice = floor(random() * 6) + 1;  // 1-6
```

### sin(x), cos(x), tan(x)
Trigonometric functions (x in radians).
```evil
sin(0);           // 0
cos(3.14159);     // -1
tan(0.785398);    // ~1
```

## String Functions

### length (property)
Returns the length of a string.
```evil
let str = "Hello";
print(str.length);  // 5
```

### toUpper(str)
Converts string to uppercase.
```evil
toUpper("hello");  // "HELLO"
```

### toLower(str)
Converts string to lowercase.
```evil
toLower("HELLO");  // "hello"
```

### trim(str)
Removes leading and trailing whitespace.
```evil
trim("  hello  ");  // "hello"
```

### substring(str, start, end)
Extracts a portion of a string.
```evil
substring("Hello World", 0, 5);   // "Hello"
substring("Hello World", 6, 11);  // "World"
```

### indexOf(str, search)
Finds the first occurrence of a substring.
```evil
indexOf("Hello World", "World");  // 6
indexOf("Hello World", "xyz");    // -1
```

### replace(str, search, replacement)
Replaces occurrences of a substring.
```evil
replace("Hello World", "World", "Evil");  // "Hello Evil"
```

### split(str, delimiter)
Splits a string into an array.
```evil
split("a,b,c", ",");        // ["a", "b", "c"]
split("Hello World", " ");  // ["Hello", "World"]
```

### join(array, delimiter)
Joins array elements into a string.
```evil
join(["a", "b", "c"], "-");  // "a-b-c"
join([1, 2, 3], ", ");       // "1, 2, 3"
```

### startsWith(str, prefix)
Checks if string starts with prefix.
```evil
startsWith("Hello World", "Hello");  // true
startsWith("Hello World", "World");  // false
```

### endsWith(str, suffix)
Checks if string ends with suffix.
```evil
endsWith("Hello World", "World");  // true
endsWith("Hello World", "Hello");  // false
```

### contains(str, search)
Checks if string contains substring.
```evil
contains("Hello World", "lo W");  // true
contains("Hello World", "xyz");   // false
```

### charAt(str, index)
Returns character at index.
```evil
charAt("Hello", 0);  // "H"
charAt("Hello", 4);  // "o"
```

## Array Functions

### length (property)
Returns the length of an array.
```evil
let arr = [1, 2, 3];
print(arr.length);  // 3
```

### push(array, element)
Adds element to end of array.
```evil
let arr = [1, 2];
push(arr, 3);  // arr is now [1, 2, 3]
```

### pop(array)
Removes and returns last element.
```evil
let arr = [1, 2, 3];
let last = pop(arr);  // last = 3, arr = [1, 2]
```

### shift(array)
Removes and returns first element.
```evil
let arr = [1, 2, 3];
let first = shift(arr);  // first = 1, arr = [2, 3]
```

### unshift(array, element)
Adds element to beginning of array.
```evil
let arr = [2, 3];
unshift(arr, 1);  // arr is now [1, 2, 3]
```

### slice(array, start, end)
Returns a portion of an array.
```evil
let arr = [1, 2, 3, 4, 5];
slice(arr, 1, 4);  // [2, 3, 4]
```

### concat(array1, array2)
Combines two arrays.
```evil
concat([1, 2], [3, 4]);  // [1, 2, 3, 4]
```

### reverse(array)
Reverses array in place.
```evil
let arr = [1, 2, 3];
reverse(arr);  // arr is now [3, 2, 1]
```

### sort(array)
Sorts array in place.
```evil
let arr = [3, 1, 4, 1, 5];
sort(arr);  // arr is now [1, 1, 3, 4, 5]
```

### map(array, fn)
Creates new array by applying function to each element.
```evil
let numbers = [1, 2, 3];
let doubled = map(numbers, function(x) { return x * 2; });
// doubled = [2, 4, 6]
```

### filter(array, predicate)
Creates new array with elements that pass test.
```evil
let numbers = [1, 2, 3, 4, 5];
let evens = filter(numbers, function(x) { return x % 2 == 0; });
// evens = [2, 4]
```

### reduce(array, fn, initial)
Reduces array to single value.
```evil
let numbers = [1, 2, 3, 4];
let sum = reduce(numbers, function(acc, x) { return acc + x; }, 0);
// sum = 10
```

## Type Checking

### typeof(value)
Returns the type of a value.
```evil
typeof(42);          // "number"
typeof("hello");     // "string"
typeof(true);        // "boolean"
typeof([1, 2]);      // "array"
typeof({x: 1});      // "object"
typeof(null);        // "null"
```

### instanceof(value, Type)
Checks if value is instance of Type.
```evil
class Person {
    constructor(name) {
        this.name = name;
    }
}

let p = new Person("Alice");
instanceof(p, Person);  // true
```

## Utility Functions

### len(value)
Returns length of string or array.
```evil
len("Hello");    // 5
len([1, 2, 3]);  // 3
```

### range(start, end, step)
Creates array of numbers.
```evil
range(0, 5);      // [0, 1, 2, 3, 4]
range(1, 10, 2);  // [1, 3, 5, 7, 9]
```

### sleep(milliseconds)
Pauses execution for specified time.
```evil
print("Wait...");
sleep(1000);  // Wait 1 second
print("Done!");
```

### getCurrentTime()
Returns current timestamp.
```evil
let start = getCurrentTime();
// ... do something ...
let elapsed = getCurrentTime() - start;
print("Elapsed time: " + elapsed + "ms");
```

## Object Functions

### keys(object)
Returns array of object keys.
```evil
let obj = {name: "Alice", age: 30};
keys(obj);  // ["name", "age"]
```

### values(object)
Returns array of object values.
```evil
let obj = {name: "Alice", age: 30};
values(obj);  // ["Alice", 30]
```

### hasProperty(object, property)
Checks if object has property.
```evil
let obj = {name: "Alice"};
hasProperty(obj, "name");  // true
hasProperty(obj, "age");   // false
```

## Examples

### Working with Collections

```evil
// Array processing
let numbers = range(1, 11);  // [1, 2, ..., 10]
let evens = filter(numbers, function(n) { return n % 2 == 0; });
let doubled = map(evens, function(n) { return n * 2; });
let sum = reduce(doubled, function(a, b) { return a + b; }, 0);
print("Sum of doubled evens: " + sum);  // 60

// String manipulation
let text = "  Hello, World!  ";
text = trim(text);
text = replace(text, "World", "Evil Lang");
text = toUpper(text);
print(text);  // "HELLO, EVIL LANG!"
```

### Math Operations

```evil
// Calculate circle properties
let radius = 5;
let area = PI * pow(radius, 2);
let circumference = 2 * PI * radius;

print("Radius: " + radius);
print("Area: " + round(area * 100) / 100);
print("Circumference: " + round(circumference * 100) / 100);

// Generate random integers
function randomInt(min, max) {
    return floor(random() * (max - min + 1)) + min;
}

for (let i = 0; i < 5; i = i + 1) {
    print("Random 1-10: " + randomInt(1, 10));
}
```

## Next Steps

- Explore [Standard Library](stdlib.md) modules
- Learn about [Custom Functions](../functions.md)
- Study [Best Practices](../guide/best-practices.md)