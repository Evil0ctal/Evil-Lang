# 函数

函数是执行特定任务的可重用代码块。它们是编写模块化和可维护程序的基础。

## 定义函数

使用 `function` 关键字定义函数：

```evil
function greet() {
    print("你好，世界！");
}

// 调用函数
greet();  // 输出：你好，世界！
```

## 函数参数

函数可以接受参数：

```evil
function greet(name) {
    print("你好，" + name + "！");
}

greet("小明");  // 输出：你好，小明！
greet("小红");  // 输出：你好，小红！
```

### 多个参数

```evil
function add(a, b) {
    return a + b;
}

let result = add(5, 3);
print("和：" + result);  // 输出：和：8
```

### 默认参数

Evil Lang 支持默认参数值：

```evil
function greet(name = "访客") {
    print("你好，" + name + "！");
}

greet();          // 输出：你好，访客！
greet("小明");    // 输出：你好，小明！
```

## 返回值

函数可以使用 `return` 语句返回值：

```evil
function multiply(a, b) {
    return a * b;
}

let product = multiply(4, 5);
print("乘积：" + product);  // 输出：乘积：20
```

### 提前返回

```evil
function divide(a, b) {
    if (b == 0) {
        print("错误：除数不能为零！");
        return null;
    }
    return a / b;
}

let result = divide(10, 2);   // 返回 5
let error = divide(10, 0);    // 打印错误，返回 null
```

## 函数表达式

函数可以赋值给变量：

```evil
let square = function(x) {
    return x * x;
};

print(square(5));  // 输出：25
```

## 高阶函数

函数可以接受其他函数作为参数：

```evil
function applyOperation(a, b, operation) {
    return operation(a, b);
}

function add(x, y) {
    return x + y;
}

function multiply(x, y) {
    return x * y;
}

print(applyOperation(5, 3, add));       // 输出：8
print(applyOperation(5, 3, multiply));  // 输出：15
```

## 闭包

函数可以访问其外部作用域的变量：

```evil
function makeCounter() {
    let count = 0;
    
    return function() {
        count = count + 1;
        return count;
    };
}

let counter = makeCounter();
print(counter());  // 输出：1
print(counter());  // 输出：2
print(counter());  // 输出：3
```

## 递归函数

函数可以调用自身：

```evil
function factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

print("5! = " + factorial(5));  // 输出：5! = 120
```

### 斐波那契示例

```evil
function fibonacci(n) {
    if (n <= 1) {
        return n;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

// 打印前 10 个斐波那契数
for (let i = 0; i < 10; i = i + 1) {
    print("F(" + i + ") = " + fibonacci(i));
}
```

## 可变参数

处理可变数量的参数：

```evil
function sum() {
    let total = 0;
    for (let i = 0; i < arguments.length; i = i + 1) {
        total = total + arguments[i];
    }
    return total;
}

print(sum(1, 2, 3));        // 输出：6
print(sum(1, 2, 3, 4, 5));  // 输出：15
```

## 嵌套函数

函数可以在其他函数内部定义：

```evil
function outerFunction(x) {
    function innerFunction(y) {
        return x + y;
    }
    
    return innerFunction(10);
}

print(outerFunction(5));  // 输出：15
```

## 函数组合

组合多个函数：

```evil
function compose(f, g) {
    return function(x) {
        return f(g(x));
    };
}

function double(x) {
    return x * 2;
}

function addOne(x) {
    return x + 1;
}

let doubleThenAddOne = compose(addOne, double);
print(doubleThenAddOne(5));  // 输出：11 (5 * 2 + 1)
```

## 实际示例

### 数组处理

```evil
function map(array, fn) {
    let result = [];
    for (let i = 0; i < array.length; i = i + 1) {
        push(result, fn(array[i]));
    }
    return result;
}

function filter(array, predicate) {
    let result = [];
    for (let i = 0; i < array.length; i = i + 1) {
        if (predicate(array[i])) {
            push(result, array[i]);
        }
    }
    return result;
}

let numbers = [1, 2, 3, 4, 5];
let doubled = map(numbers, function(x) { return x * 2; });
let evens = filter(numbers, function(x) { return x % 2 == 0; });

print("加倍：" + doubled);  // 输出：加倍：[2, 4, 6, 8, 10]
print("偶数：" + evens);    // 输出：偶数：[2, 4]
```

### 记忆化

```evil
function memoize(fn) {
    let cache = {};
    
    return function(n) {
        if (cache[n] != null) {
            return cache[n];
        }
        
        let result = fn(n);
        cache[n] = result;
        return result;
    };
}

// 记忆化的斐波那契
let fib = memoize(function(n) {
    if (n <= 1) return n;
    return fib(n - 1) + fib(n - 2);
});

print("Fib(40) = " + fib(40));  // 比非记忆化版本快得多
```

### 工具函数库

```evil
// 字符串工具
function capitalize(str) {
    if (str.length == 0) return str;
    return toUpper(charAt(str, 0)) + substring(str, 1, str.length);
}

function repeat(str, times) {
    let result = "";
    for (let i = 0; i < times; i = i + 1) {
        result = result + str;
    }
    return result;
}

// 数组工具
function find(array, predicate) {
    for (let i = 0; i < array.length; i = i + 1) {
        if (predicate(array[i])) {
            return array[i];
        }
    }
    return null;
}

function every(array, predicate) {
    for (let i = 0; i < array.length; i = i + 1) {
        if (!predicate(array[i])) {
            return false;
        }
    }
    return true;
}

// 使用示例
print(capitalize("hello"));     // "Hello"
print(repeat("*", 5));         // "*****"

let users = [
    {name: "小明", age: 25},
    {name: "小红", age: 30},
    {name: "小刚", age: 28}
];

let user = find(users, function(u) { return u.name == "小红"; });
print(user.age);  // 30

let allAdults = every(users, function(u) { return u.age >= 18; });
print(allAdults); // true
```

### 柯里化

```evil
function curry(fn) {
    return function(a) {
        return function(b) {
            return fn(a, b);
        };
    };
}

function add(a, b) {
    return a + b;
}

let curriedAdd = curry(add);
let add5 = curriedAdd(5);

print(add5(3));   // 8
print(add5(10));  // 15
```

## 最佳实践

1. **使用描述性名称**：函数名应清楚地表明其功能
   ```evil
   // 好
   function calculateTotalPrice(items, taxRate) { ... }
   
   // 不好
   function calc(x, y) { ... }
   ```

2. **保持函数简短**：每个函数应该只做一件事
   ```evil
   // 好：单一职责
   function validateEmail(email) { ... }
   function sendEmail(to, subject, body) { ... }
   
   // 不好：多重职责
   function processEmail(email, subject, body) {
       // 验证和发送都在一个函数中
   }
   ```

3. **避免副作用**：优先使用不修改外部状态的纯函数
   ```evil
   // 纯函数
   function add(a, b) {
       return a + b;
   }
   
   // 有副作用的函数
   let total = 0;
   function addToTotal(value) {
       total = total + value;  // 修改外部变量
   }
   ```

4. **文档复杂函数**：添加注释解释参数和返回值
5. **使用一致的参数顺序**：将最重要的参数放在前面

## 下一步

- 学习[类和对象](classes-objects.md)进行面向对象编程
- 探索[模块](modules.md)将函数组织成库
- 学习[异常处理](exception-handling.md)进行错误管理