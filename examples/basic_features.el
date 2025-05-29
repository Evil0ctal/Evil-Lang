// Evil Lang 基础特性演示
// 展示基本语法和功能

print("=== Basic Features Demo ===");
print("");

// 1. 变量和基本运算
print("Variables and basic operations:");
var x = 10;
var y = 20;
print("x = " + x);
print("y = " + y);
print("x + y = " + (x + y));
print("x * y = " + (x * y));

// 2. 条件语句
print("");
print("Conditional statements:");
var score = 85;
if (score >= 90) {
    print("Grade: A");
} else if (score >= 80) {
    print("Grade: B");
} else if (score >= 70) {
    print("Grade: C");
} else {
    print("Grade: F");
}

// 3. 循环
print("");
print("Loops:");
print("for loop:");
for (var i = 1; i <= 5; i = i + 1) {
    print("  i = " + i);
}

print("while loop:");
var j = 5;
while (j > 0) {
    print("  j = " + j);
    j = j - 1;
}

// 4. 数组
print("");
print("Arrays:");
var arr = [10, 20, 30, 40, 50];
print("Array: " + arr);
print("arr[0] = " + arr[0]);
print("arr[2] = " + arr[2]);
print("arr.length = " + arr.length);

// 5. 对象
print("");
print("Objects:");
var person = {
    name: "Alice",
    age: 25,
    city: "Beijing"
};
print("Person object:");
print("  name: " + person.name);
print("  age: " + person.age);
print("  city: " + person.city);

// 6. 函数
print("");
print("Functions:");

func add(a, b) {
    return a + b;
}

func multiply(a, b) {
    return a * b;
}

print("add(3, 4) = " + add(3, 4));
print("multiply(3, 4) = " + multiply(3, 4));

// 7. 递归
print("");
print("Recursion:");

func factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

print("factorial(5) = " + factorial(5));

// 8. 内置函数
print("");
print("Built-in functions:");
print("Math functions:");
print("  abs(-10) = " + abs(-10));
print("  round(3.7) = " + round(3.7));
print("  min(5, 2, 8) = " + min(5, 2, 8));
print("  max(5, 2, 8) = " + max(5, 2, 8));

// 9. 三元运算符
print("");
print("Ternary operator:");
var age = 18;
var status = age >= 18 ? "adult" : "minor";
print("Age " + age + " is " + status);

// 10. 字符串操作
print("");
print("String operations:");
var str1 = "Hello";
var str2 = "World";
var combined = str1 + " " + str2 + "!";
print("Combined string: " + combined);