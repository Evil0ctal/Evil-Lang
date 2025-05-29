// Evil Lang Feature Showcase
// 展示Evil Lang的主要功能

print("=== Evil Lang Feature Showcase ===\n");

// 1. Variables and Basic Types
// 变量和基本类型
print("1. Basic Types:");
var name = "Evil Lang";
var version = 1.0;
var isAwesome = true;
var nothing = null;

print("  Name: " + name);
print("  Version: " + toString(version));
print("  Is Awesome: " + toString(isAwesome));
print("  Nothing: " + toString(nothing));

// 2. Arrays and Array Operations
// 数组和数组操作
print("\n2. Arrays:");
var fruits = ["apple", "banana", "orange"];
print("  Fruits: " + toString(fruits));
push(fruits, "grape");
print("  After push: " + toString(fruits));
print("  First fruit: " + fruits[0]);
print("  Last fruit: " + fruits[fruits.length - 1]);

// 3. Objects/Dictionaries
// 对象/字典
print("\n3. Objects:");
var person = {
    name: "Alice",
    age: 25,
    city: "Wonderland"
};
print("  Person: " + person.name + ", " + person.age + " years old from " + person.city);

// 4. Functions
// 函数
print("\n4. Functions:");

func greet(name) {
    return "Hello, " + name + "!";
}

func factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

print("  " + greet("World"));
print("  Factorial of 5: " + factorial(5));

// 5. Control Flow
// 控制流
print("\n5. Control Flow:");

// If-else
var score = 85;
if (score >= 90) {
    print("  Grade: A");
} else if (score >= 80) {
    print("  Grade: B");
} else if (score >= 70) {
    print("  Grade: C");
} else {
    print("  Grade: F");
}

// For loop
print("  Counting: ");
for (var i = 1; i <= 5; i = i + 1) {
    print("    " + i);
}

// While loop
print("  Countdown: ");
var count = 3;
while (count > 0) {
    print("    " + count + "...");
    count = count - 1;
}
print("    Blast off!");

// 6. String Operations
// 字符串操作
print("\n6. String Operations:");
var text = "  Hello, Evil Lang!  ";
print("  Original: '" + text + "'");
print("  Trimmed: '" + trim(text) + "'");
print("  Uppercase: " + toUpper(text));
print("  Length: " + text.length);

var email = "user@example.com";
var atIndex = indexOf(email, "@");
print("  Email domain: " + substring(email, atIndex + 1));

// 7. Classes and Objects
// 类和对象
print("\n7. Classes and OOP:");

class Animal {
    constructor(name, sound) {
        this.name = name;
        this.sound = sound;
    }
    
    speak() {
        print("  " + this.name + " says: " + this.sound);
    }
}

class Dog extends Animal {
    constructor(name) {
        this.name = name;
        this.sound = "Woof!";
    }
    
    wagTail() {
        print("  " + this.name + " is wagging its tail!");
    }
}

var cat = new Animal("Whiskers", "Meow!");
var dog = new Dog("Buddy");

cat.speak();
dog.speak();
dog.wagTail();

// 8. Exception Handling
// 异常处理
print("\n8. Exception Handling:");

func divide(a, b) {
    if (b == 0) {
        throw "Division by zero error!";
    }
    return a / b;
}

try {
    print("  10 / 2 = " + divide(10, 2));
    print("  10 / 0 = " + divide(10, 0));
} catch (e) {
    print("  Caught error: " + e);
} finally {
    print("  Division operation completed.");
}

// 9. Higher-Order Programming
// 高阶编程
print("\n9. Advanced Programming:");

// Closure example
func makeCounter() {
    var count = 0;
    
    func increment() {
        count = count + 1;
        return count;
    }
    
    return increment;
}

var counter = makeCounter();
print("  Counter: " + counter());
print("  Counter: " + counter());
print("  Counter: " + counter());

// 10. Practical Example - Simple Calculator
// 实用示例 - 简单计算器
print("\n10. Calculator Example:");

class Calculator {
    constructor() {
        this.result = 0;
    }
    
    add(x) {
        this.result = this.result + x;
        return this;
    }
    
    subtract(x) {
        this.result = this.result - x;
        return this;
    }
    
    multiply(x) {
        this.result = this.result * x;
        return this;
    }
    
    getResult() {
        return this.result;
    }
    
    reset() {
        this.result = 0;
        return this;
    }
}

var calc = new Calculator();
calc.add(10).multiply(2).subtract(5);
print("  (0 + 10) * 2 - 5 = " + calc.getResult());

print("\n=== End of Showcase ===");
print("Evil Lang - Simple, Powerful, and Fun!");