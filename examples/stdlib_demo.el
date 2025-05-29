// Evil Lang 标准库使用示例

print("=== Standard Library Demo ===");
print("");

// 导入标准库模块
import "math" as Math;
import "array" as Array;

// 使用数学模块
print("Math module:");
print("Math.PI = " + Math.PI);
print("Math.sqrt(16) = " + Math.sqrt(16));
print("Math.pow(2, 8) = " + Math.pow(2, 8));
print("Math.sin(Math.PI / 2) ≈ " + Math.sin(Math.PI / 2));
print("Math.random() = " + Math.random());
print("Math.randomInt(1, 10) = " + Math.randomInt(1, 10));

print("");

// 使用数组模块
print("Array module:");
var nums = [1, 2, 3, 4, 5];
print("Original array: " + Array.join(nums, ", "));

// map 操作
var squared = Array.map(nums, func(x) { return x * x; });
print("Squared: " + Array.join(squared, ", "));

// filter 操作
var evens = Array.filter(nums, func(x) { return x % 2 == 0; });
print("Even numbers: " + Array.join(evens, ", "));

// reduce 操作
var sum = Array.reduce(nums, func(acc, x) { return acc + x; }, 0);
print("Sum: " + sum);

// range 函数
var range = Array.range(0, 10, 2);
print("Range(0, 10, 2): " + Array.join(range, ", "));

// 数组操作
var arr1 = [1, 2, 3];
var arr2 = [4, 5, 6];
var combined = Array.concat(arr1, arr2);
print("Concat [1,2,3] + [4,5,6]: " + Array.join(combined, ", "));

var reversed = Array.reverse(combined);
print("Reversed: " + Array.join(reversed, ", "));

// 高级示例：生成斐波那契数列
print("");
print("Fibonacci sequence using Array.map:");
var indices = Array.range(0, 10, 1);
var fibs = Array.map(indices, func(i) {
    if (i <= 1) {
        return i;
    }
    var a = 0;
    var b = 1;
    for (var j = 2; j <= i; j = j + 1) {
        var temp = a + b;
        a = b;
        b = temp;
    }
    return b;
});
print("First 10 Fibonacci numbers: " + Array.join(fibs, ", "));

// 使用 every 和 some
var allPositive = Array.every(nums, func(x) { return x > 0; });
var hasEven = Array.some(nums, func(x) { return x % 2 == 0; });
print("");
print("All positive? " + allPositive);
print("Has even number? " + hasEven);