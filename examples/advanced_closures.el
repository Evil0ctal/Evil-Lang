// Evil Lang 高级闭包示例
// 演示闭包的高级用法和状态管理

print("=== Advanced Closures Demo ===");
print("");

// 1. 计数器工厂
func makeCounter(initial) {
    var count = initial;
    
    return {
        increment: func() {
            count = count + 1;
            return count;
        },
        decrement: func() {
            count = count - 1;
            return count;
        },
        reset: func() {
            count = initial;
            return count;
        },
        getValue: func() {
            return count;
        }
    };
}

print("Counter factory:");
var counter1 = makeCounter(0);
var counter2 = makeCounter(100);

print("counter1.increment() = " + counter1.increment()); // 1
print("counter1.increment() = " + counter1.increment()); // 2
print("counter2.decrement() = " + counter2.decrement()); // 99
print("counter1.getValue() = " + counter1.getValue());   // 2
print("counter2.getValue() = " + counter2.getValue());   // 99

// 2. 私有变量模拟
func createBankAccount(initialBalance) {
    var balance = initialBalance;
    var history = [];
    
    func addToHistory(action, amount) {
        history[history.length] = action + ": " + amount;
    }
    
    return {
        deposit: func(amount) {
            if (amount > 0) {
                balance = balance + amount;
                addToHistory("Deposit", amount);
                return true;
            }
            return false;
        },
        withdraw: func(amount) {
            if (amount > 0 && amount <= balance) {
                balance = balance - amount;
                addToHistory("Withdraw", amount);
                return true;
            }
            return false;
        },
        getBalance: func() {
            return balance;
        },
        getHistory: func() {
            return history;
        }
    };
}

print("");
print("Bank account with private state:");
var account = createBankAccount(1000);

print("Initial balance: " + account.getBalance());
account.deposit(500);
print("After deposit 500: " + account.getBalance());
account.withdraw(200);
print("After withdraw 200: " + account.getBalance());
print("Transaction history: " + account.getHistory());

// 3. 函数记忆化（Memoization）
func memoize(fn) {
    var cache = {};
    
    return func(n) {
        var key = "" + n; // 转换为字符串作为键
        
        if (cache[key] != null) {
            print("(cache hit for " + n + ")");
            return cache[key];
        }
        
        print("(computing for " + n + ")");
        var result = fn(n);
        cache[key] = result;
        return result;
    };
}

// 斐波那契数列（递归版）
func fibonacci(n) {
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// 记忆化的斐波那契
var memoFib = memoize(func(n) {
    if (n <= 1) {
        return n;
    }
    // 注意：这里仍然是递归调用原始函数
    // 在实际应用中，应该使用动态规划
    var a = 0;
    var b = 1;
    for (var i = 2; i <= n; i = i + 1) {
        var temp = a + b;
        a = b;
        b = temp;
    }
    return b;
});

print("");
print("Memoization demo:");
print("memoFib(10) = " + memoFib(10));
print("memoFib(10) = " + memoFib(10)); // 第二次调用使用缓存
print("memoFib(15) = " + memoFib(15));

// 4. 事件处理器
func createEventEmitter() {
    var handlers = {};
    
    return {
        on: func(event, handler) {
            if (handlers[event] == null) {
                handlers[event] = [];
            }
            handlers[event][handlers[event].length] = handler;
        },
        emit: func(event, data) {
            if (handlers[event] != null) {
                for (var i = 0; i < handlers[event].length; i = i + 1) {
                    handlers[event][i](data);
                }
            }
        }
    };
}

print("");
print("Event emitter:");
var emitter = createEventEmitter();

emitter.on("message", func(data) {
    print("Handler 1: " + data);
});

emitter.on("message", func(data) {
    print("Handler 2: " + data);
});

emitter.emit("message", "Hello, Events!");

// 5. 链式调用构建器
func createBuilder() {
    var config = {
        name: "",
        age: 0,
        city: ""
    };
    
    var builder = {
        setName: func(name) {
            config.name = name;
            return builder; // 返回自身以支持链式调用
        },
        setAge: func(age) {
            config.age = age;
            return builder;
        },
        setCity: func(city) {
            config.city = city;
            return builder;
        },
        build: func() {
            return config;
        }
    };
    
    return builder;
}

print("");
print("Builder pattern with chaining:");
var person = createBuilder()
    .setName("Alice")
    .setAge(25)
    .setCity("Beijing")
    .build();

print("Built person: name=" + person.name + ", age=" + person.age + ", city=" + person.city);