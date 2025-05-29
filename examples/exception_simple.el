// Simple Exception Handling Examples
// 简单的异常处理示例

// Function that validates input
// 验证输入的函数
func validateAge(age) {
    if (age < 0) {
        throw "Age cannot be negative!";
    }
    if (age > 150) {
        throw "Age seems unrealistic!";
    }
    return "Valid age: " + age;
}

print("=== Age Validation ===");

// Test valid ages
try {
    print(validateAge(25));
    print(validateAge(65));
} catch (e) {
    print("Validation error: " + e);
}

// Test invalid ages
try {
    print(validateAge(-5));
} catch (e) {
    print("Validation error: " + e);
}

try {
    print(validateAge(200));
} catch (e) {
    print("Validation error: " + e);
}

// Function with multiple error conditions
// 有多个错误条件的函数
func processData(data) {
    try {
        if (data == null) {
            throw "Data cannot be null!";
        }
        if (data == "") {
            throw "Data cannot be empty!";
        }
        
        // Process the data
        return "Processed: " + data;
    } finally {
        print("Data processing completed");
    }
}

print("\n=== Data Processing ===");

print(processData("Hello"));

try {
    print(processData(null));
} catch (e) {
    print("Processing failed: " + e);
}

try {
    print(processData(""));
} catch (e) {
    print("Processing failed: " + e);
}

// Error with string concatenation
// 带字符串拼接的错误
print("\n=== String Error Messages ===");

func checkPassword(password) {
    if (password.length < 8) {
        throw "Password too short! Must be at least 8 characters.";
    }
    if (password == "password") {
        throw "Password too common!";
    }
    return "Password accepted";
}

try {
    print(checkPassword("abc"));
} catch (e) {
    print("Password error: " + e);
}

try {
    print(checkPassword("password"));
} catch (e) {
    print("Password error: " + e);
}

try {
    print(checkPassword("securePass123"));
} catch (e) {
    print("Password error: " + e);
}