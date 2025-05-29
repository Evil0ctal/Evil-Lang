# 异常处理

异常处理允许您优雅地管理程序中的错误和意外情况。

## Try-Catch 块

使用 `try-catch` 处理异常：

```evil
try {
    let result = 10 / 0;  // 这可能会导致错误
    print("结果：" + result);
} catch (error) {
    print("发生错误：" + error);
}
```

## 抛出异常

使用 `throw` 语句引发异常：

```evil
function divide(a, b) {
    if (b == 0) {
        throw "除零错误";
    }
    return a / b;
}

try {
    let result = divide(10, 0);
} catch (error) {
    print("捕获错误：" + error);  // 输出：捕获错误：除零错误
}
```

## Finally 块

`finally` 块总是执行，无论是否发生异常：

```evil
try {
    print("尝试执行危险操作...");
    throw "出错了！";
} catch (error) {
    print("捕获：" + error);
} finally {
    print("清理代码总是运行");
}

// 输出：
// 尝试执行危险操作...
// 捕获：出错了！
// 清理代码总是运行
```

## 异常对象

创建更有信息量的异常对象：

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
        throw createError("ValidationError", "年龄不能为负数");
    }
    if (age > 150) {
        throw createError("ValidationError", "年龄似乎不现实");
    }
    return true;
}

try {
    validateAge(-5);
} catch (error) {
    print("错误类型：" + error.type);
    print("错误消息：" + error.message);
}
```

## 嵌套 Try-Catch

在不同级别处理异常：

```evil
function processFile(filename) {
    try {
        let data = readFile(filename);  // 可能抛出异常
        
        try {
            let parsed = parseJSON(data);  // 可能抛出异常
            return parsed;
        } catch (parseError) {
            print("解析文件失败：" + parseError);
            throw "无效的文件格式";
        }
    } catch (readError) {
        print("读取文件失败：" + readError);
        throw "文件访问错误";
    }
}

try {
    let result = processFile("config.json");
} catch (error) {
    print("操作失败：" + error);
}
```

## 重新抛出异常

捕获、记录并重新抛出异常：

```evil
function riskyOperation() {
    throw "操作失败";
}

function performTask() {
    try {
        riskyOperation();
    } catch (error) {
        print("记录错误：" + error);
        throw error;  // 重新抛出供调用者处理
    }
}

try {
    performTask();
} catch (error) {
    print("任务失败：" + error);
}
```

## 自定义异常类型

创建专门的异常类：

```evil
class ValidationError extends Error {
    constructor(field, value, message) {
        super(message);
        this.field = field;
        this.value = value;
    }
    
    toString() {
        return "字段 '" + this.field + 
               "' 验证错误：" + this.message + " （值：" + this.value + "）";
    }
}

class NetworkError extends Error {
    constructor(url, statusCode) {
        super("网络请求失败");
        this.url = url;
        this.statusCode = statusCode;
    }
}

function validateEmail(email) {
    if (!contains(email, "@")) {
        throw new ValidationError("email", email, "无效的邮箱格式");
    }
}

try {
    validateEmail("invalid-email");
} catch (error) {
    if (error instanceof ValidationError) {
        print("验证失败：" + error.toString());
    } else {
        print("意外错误：" + error);
    }
}
```

## 错误传播

设计错误处理策略：

```evil
class Database {
    constructor() {
        this.connected = false;
    }
    
    connect() {
        // 模拟连接尝试
        if (random() < 0.3) {
            throw new NetworkError("db://localhost", 500);
        }
        this.connected = true;
    }
    
    query(sql) {
        if (!this.connected) {
            throw "数据库未连接";
        }
        // 执行查询...
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
            print("网络问题：" + error.url);
            return null;
        } else {
            throw error;  // 传播意外错误
        }
    }
}

// 使用适当的错误处理
try {
    let userData = getUserData(123);
    if (userData == null) {
        print("使用缓存数据代替");
    }
} catch (error) {
    print("致命错误：" + error);
}
```

## 实际示例

### 输入验证系统

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
            throw {field: name, message: "字段必填"};
        }
        
        if (rule.minLength && value.length < rule.minLength) {
            throw {field: name, message: "太短（最少：" + rule.minLength + "）"};
        }
        
        if (rule.maxLength && value.length > rule.maxLength) {
            throw {field: name, message: "太长（最多：" + rule.maxLength + "）"};
        }
        
        if (rule.pattern && !matches(value, rule.pattern)) {
            throw {field: name, message: "格式无效"};
        }
    }
}

// 使用
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
    print("验证通过！");
} catch (error) {
    print("验证失败：");
    for (let i = 0; i < error.errors.length; i = i + 1) {
        let e = error.errors[i];
        print("  - " + e.field + "：" + e.message);
    }
}
```

### 重试机制

```evil
function retry(fn, maxAttempts = 3, delay = 1000) {
    let lastError;
    
    for (let attempt = 1; attempt <= maxAttempts; attempt = attempt + 1) {
        try {
            return fn();
        } catch (error) {
            lastError = error;
            print("尝试 " + attempt + " 失败：" + error);
            
            if (attempt < maxAttempts) {
                print("在 " + delay + "ms 后重试...");
                sleep(delay);
                delay = delay * 2;  // 指数退避
            }
        }
    }
    
    throw "所有 " + maxAttempts + " 次尝试都失败了。最后的错误：" + lastError;
}

// 模拟不可靠的操作
function unreliableOperation() {
    if (random() < 0.7) {
        throw "网络超时";
    }
    return "成功！";
}

try {
    let result = retry(unreliableOperation, 5, 500);
    print("操作成功：" + result);
} catch (error) {
    print("重试后操作失败：" + error);
}
```

### 资源管理

```evil
class FileHandler {
    constructor(filename) {
        this.filename = filename;
        this.handle = null;
    }
    
    open() {
        print("打开文件：" + this.filename);
        this.handle = "file_handle_" + this.filename;
    }
    
    read() {
        if (this.handle == null) {
            throw "文件未打开";
        }
        return "文件内容";
    }
    
    close() {
        if (this.handle != null) {
            print("关闭文件：" + this.filename);
            this.handle = null;
        }
    }
}

function processFileWithCleanup(filename) {
    let file = new FileHandler(filename);
    
    try {
        file.open();
        let content = file.read();
        
        if (contains(content, "error")) {
            throw "文件包含错误";
        }
        
        return content;
    } finally {
        // 总是清理资源
        file.close();
    }
}

try {
    let result = processFileWithCleanup("data.txt");
    print("处理成功：" + result);
} catch (error) {
    print("处理失败：" + error);
}
```

## 最佳实践

1. **特定捕获**：尽可能捕获特定的异常类型
   ```evil
   try {
       // 代码
   } catch (error) {
       if (error instanceof NetworkError) {
           // 处理网络错误
       } else if (error instanceof ValidationError) {
           // 处理验证错误
       } else {
           // 处理其他错误
       }
   }
   ```

2. **清理资源**：使用 finally 块确保清理
   ```evil
   let resource = acquireResource();
   try {
       // 使用资源
   } finally {
       releaseResource(resource);
   }
   ```

3. **有意义的消息**：提供清晰、可操作的错误消息
   ```evil
   // 好
   throw "无法连接到数据库：超时（5秒）";
   
   // 不好
   throw "错误";
   ```

4. **不要吞没错误**：总是处理或重新抛出异常
5. **记录错误**：记录错误以便调试和监控
6. **快速失败**：尽早验证输入以更快地捕获错误

## 常见模式

### 保护子句

```evil
function processOrder(order) {
    // 提前验证
    if (!order) {
        throw "订单是必需的";
    }
    if (!order.items || order.items.length == 0) {
        throw "订单必须包含商品";
    }
    if (order.total <= 0) {
        throw "无效的订单总额";
    }
    
    // 处理有效订单
    return processValidOrder(order);
}
```

### 错误转换

```evil
function getUserProfile(userId) {
    try {
        let data = fetchFromAPI("/users/" + userId);
        return parseUserData(data);
    } catch (error) {
        // 将低级错误转换为领域错误
        if (contains(error, "404")) {
            throw "用户未找到";
        } else if (contains(error, "Network")) {
            throw "无法连接到服务器";
        } else {
            throw "加载用户配置文件失败";
        }
    }
}
```

## 下一步

- 探索[内置函数](../reference/builtin-functions.md)了解错误工具
- 学习[调试](../guide/debugging.md)技术
- 学习[最佳实践](../guide/best-practices.md)构建健壮的应用程序