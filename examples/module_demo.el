// Evil Lang 模块系统演示
// 展示如何导入和使用模块

print("=== Module System Demo ===");
print("");

// 导入整个模块
import "./modules/math_utils.el" as math;
import "./modules/string_utils.el" as str;

// 使用导入的模块
print("Using math module:");
print("math.PI = " + math.PI);
print("math.square(5) = " + math.square(5));
print("math.cube(3) = " + math.cube(3));
print("math.factorial(5) = " + math.factorial(5));
print("math.fibonacci(10) = " + math.fibonacci(10));
print("math.isPrime(17) = " + math.isPrime(17));

print("");
print("Using string module:");
print("str.repeat('Ha', 3) = " + str.repeat("Ha", 3));
print("str.padLeft('42', 5, '0') = " + str.padLeft("42", 5, "0"));
print("str.padRight('Hello', 10, '.') = " + str.padRight("Hello", 10, "."));
print("str.trim('  Hello World  ') = '" + str.trim("  Hello World  ") + "'");

// 从模块导入特定函数
print("");
print("Importing specific functions:");

// 导入特定函数
import { square, factorial } from "./modules/math_utils.el";
import { repeat as rep, padLeft } from "./modules/string_utils.el";

print("square(7) = " + square(7));
print("factorial(6) = " + factorial(6));
print("rep('*', 10) = " + rep("*", 10));
print("padLeft('123', 6, '0') = " + padLeft("123", 6, "0"));

// 创建一个使用导入函数的函数
func formatNumber(num, width) {
    return padLeft("" + num, width, "0");
}

print("");
print("Using imported functions in local function:");
print("formatNumber(42, 5) = " + formatNumber(42, 5));
print("formatNumber(7, 3) = " + formatNumber(7, 3));