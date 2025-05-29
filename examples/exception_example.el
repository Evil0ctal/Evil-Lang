// Evil Lang Exception Handling Example
// 异常处理示例

// Basic try-catch example
// 基本的try-catch示例
print("=== Basic Exception Handling ===");

try {
    print("In try block");
    throw "Something went wrong!";
    print("This won't be executed");
} catch (e) {
    print("Caught exception: " + e);
}

print("Program continues after exception handling");

// Try-catch-finally example
// Try-catch-finally示例
print("\n=== Try-Catch-Finally ===");

try {
    print("Opening resource...");
    throw "Error occurred!";
} catch (err) {
    print("Handling error: " + err);
} finally {
    print("Cleaning up resources (finally block always executes)");
}

// Division by zero with error handling
// 除零错误处理
print("\n=== Division by Zero Handling ===");

func safeDivide(a, b) {
    try {
        if (b == 0) {
            throw "Division by zero error!";
        }
        return a / b;
    } catch (e) {
        print("Error in division: " + e);
        return null;
    }
}

var result = safeDivide(10, 2);
print("10 / 2 = " + result);

result = safeDivide(10, 0);
print("10 / 0 = " + result);

// Nested try-catch
// 嵌套的try-catch
print("\n=== Nested Exception Handling ===");

try {
    print("Outer try block");
    
    try {
        print("Inner try block");
        throw "Inner exception";
    } catch (e) {
        print("Inner catch: " + e);
        throw "Re-throwing from inner catch";
    }
    
} catch (e) {
    print("Outer catch: " + e);
}

// Finally without catch
// 只有finally没有catch
print("\n=== Finally Without Catch ===");

func testFinally() {
    try {
        print("In try block");
        return "Return from try";
    } finally {
        print("Finally block executes even with return");
    }
}

var finallyResult = testFinally();
print("Function returned: " + finallyResult);