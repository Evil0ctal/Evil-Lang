// Evil Lang 类型系统示例
// 演示类型检查和转换功能

print("=== Type System Demo ===");
print("");

// typeof 函数 - 获取值的类型
print("Type checking with typeof:");
print("typeof(42) = " + typeof(42));                    // "number"
print("typeof(3.14) = " + typeof(3.14));                // "number"
print("typeof(\"hello\") = " + typeof("hello"));        // "string"
print("typeof(true) = " + typeof(true));                // "boolean"
print("typeof(false) = " + typeof(false));              // "boolean"
print("typeof(null) = " + typeof(null));                // "null"
print("typeof([1, 2, 3]) = " + typeof([1, 2, 3]));     // "array"
print("typeof({a: 1}) = " + typeof({a: 1}));           // "object"
print("typeof(toNumber) = " + typeof(toNumber));        // "function"

print("");
print("Type conversion:");

// 数字转换
print("toNumber(\"123\") = " + toNumber("123"));       // 123
print("toNumber(\"3.14\") = " + toNumber("3.14"));     // 3.14
print("toNumber(true) = " + numberAdd(toNumber(true), 0));    // 1
print("toNumber(false) = " + numberAdd(toNumber(false), 0));  // 0

// 使用类型转换的计算
var strNum1 = "10";
var strNum2 = "20";
print("");
print("String concatenation vs numeric addition:");
print("\"10\" + \"20\" = " + (strNum1 + strNum2));                     // "1020"
print("toNumber(\"10\") + toNumber(\"20\") = " + 
      (toNumber(strNum1) + toNumber(strNum2)));                        // 30

// 数学函数示例
print("");
print("Math functions:");
print("abs(-5) = " + abs(-5));                         // 5
print("round(3.7) = " + round(3.7));                   // 4
print("round(3.14159, 2) = " + round(3.14159, 2));     // 3.14
print("min(5, 2, 8, 1) = " + min(5, 2, 8, 1));        // 1
print("max(5, 2, 8, 1) = " + max(5, 2, 8, 1));        // 8

// 类型安全的函数
func safeDiv(a, b) {
    // 确保参数是数字
    var numA = toNumber(a);
    var numB = toNumber(b);
    
    if (numB == 0) {
        print("Error: Division by zero!");
        return null;
    }
    
    return numA / numB;
}

print("");
print("Type-safe division:");
print("safeDiv(10, 2) = " + safeDiv(10, 2));           // 5
print("safeDiv(\"10\", \"2\") = " + safeDiv("10", "2")); // 5
print("safeDiv(10, 0) = " + safeDiv(10, 0));           // null (with error message)