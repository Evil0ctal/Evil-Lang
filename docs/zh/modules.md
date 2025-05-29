# 模块

模块允许您将代码组织成可重用的库，并管理应用程序不同部分之间的依赖关系。

## 创建模块

模块就是导出函数、类或值的 Evil Lang 文件：

```evil
// math_utils.el
export function add(a, b) {
    return a + b;
}

export function multiply(a, b) {
    return a * b;
}

export let PI = 3.14159;
```

## 导入模块

使用 `import` 语句使用其他模块的代码：

```evil
// main.el
import { add, multiply, PI } from "./math_utils.el";

print(add(5, 3));        // 输出：8
print(multiply(4, 7));   // 输出：28
print("PI = " + PI);     // 输出：PI = 3.14159
```

## 导入语法

### 命名导入

按名称导入特定的导出：

```evil
import { functionA, functionB } from "./module.el";
```

### 导入所有

将所有导出作为对象导入：

```evil
import * as utils from "./math_utils.el";

print(utils.add(5, 3));       // 输出：8
print(utils.multiply(4, 7));  // 输出：28
```

### 别名导入

重命名导入以避免冲突：

```evil
import { add as sum, multiply as mult } from "./math_utils.el";

print(sum(5, 3));   // 输出：8
print(mult(4, 7));  // 输出：28
```

## 导出语法

### 命名导出

导出单个项目：

```evil
// 导出函数
export function calculate(x, y) {
    return x + y;
}

// 导出变量
export let version = "1.0.0";

// 导出类
export class Calculator {
    constructor() {
        this.result = 0;
    }
}
```

### 声明后导出

在声明后导出项目：

```evil
function helper() {
    return "辅助函数";
}

let config = {
    debug: true,
    version: "1.0.0"
};

export { helper, config };
```

### 默认导出

导出单个默认值：

```evil
// logger.el
export default function log(message) {
    print("[日志] " + message);
}

// main.el
import log from "./logger.el";
log("应用程序启动");  // 输出：[日志] 应用程序启动
```

## 模块组织

### 文件结构

将模块组织在逻辑目录结构中：

```
project/
├── main.el
├── utils/
│   ├── math.el
│   ├── string.el
│   └── array.el
├── models/
│   ├── user.el
│   └── product.el
└── stdlib/
    ├── math.el
    └── array.el
```

### 相对导入

使用相对路径导入本地模块：

```evil
// 从 utils/math.el
import { helper } from "./string.el";  // 同一目录
import { User } from "../models/user.el";  // 父目录
```

### 标准库导入

从标准库导入：

```evil
import { sqrt, pow, abs } from "stdlib/math.el";
import { map, filter, reduce } from "stdlib/array.el";

let numbers = [1, 4, 9, 16];
let roots = map(numbers, sqrt);
print(roots);  // 输出：[1, 2, 3, 4]
```

## 实际示例

### 数学库模块

```evil
// libs/advanced_math.el
import { sqrt } from "stdlib/math.el";

export function distance(x1, y1, x2, y2) {
    let dx = x2 - x1;
    let dy = y2 - y1;
    return sqrt(dx * dx + dy * dy);
}

export function average(numbers) {
    if (numbers.length == 0) return 0;
    
    let sum = 0;
    for (let i = 0; i < numbers.length; i = i + 1) {
        sum = sum + numbers[i];
    }
    return sum / numbers.length;
}

export class Vector {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    
    add(other) {
        return new Vector(this.x + other.x, this.y + other.y);
    }
    
    magnitude() {
        return sqrt(this.x * this.x + this.y * this.y);
    }
}
```

### 配置模块

```evil
// config/settings.el
export let config = {
    appName: "我的应用",
    version: "1.0.0",
    debug: true,
    maxRetries: 3,
    timeout: 5000
};

export function get(key) {
    return config[key];
}

export function set(key, value) {
    config[key] = value;
}

export function isDebugMode() {
    return config.debug;
}
```

### 服务模块

```evil
// services/user_service.el
import { User } from "../models/user.el";
import { isDebugMode } from "../config/settings.el";

let users = [];

export function createUser(name, email) {
    let user = new User(name, email);
    push(users, user);
    
    if (isDebugMode()) {
        print("创建用户：" + name);
    }
    
    return user;
}

export function findUserByEmail(email) {
    for (let i = 0; i < users.length; i = i + 1) {
        if (users[i].email == email) {
            return users[i];
        }
    }
    return null;
}

export function getAllUsers() {
    return users;
}
```

### 工具模块集合

```evil
// utils/validation.el
export function isEmail(str) {
    return contains(str, "@") && contains(str, ".");
}

export function isPhoneNumber(str) {
    // 简单的中国手机号验证
    return str.length == 11 && startsWith(str, "1");
}

export function isValidPassword(password) {
    return password.length >= 8;
}

// utils/format.el
export function formatCurrency(amount) {
    return "¥" + toFixed(amount, 2);
}

export function formatDate(date) {
    // 简单的日期格式化
    return date.year + "-" + padZero(date.month) + "-" + padZero(date.day);
}

function padZero(num) {
    return num < 10 ? "0" + num : toString(num);
}

// main.el
import * as validation from "./utils/validation.el";
import { formatCurrency, formatDate } from "./utils/format.el";

let email = "user@example.com";
if (validation.isEmail(email)) {
    print("有效的邮箱");
}

let price = 99.5;
print(formatCurrency(price));  // 输出：¥99.50
```

## 模块最佳实践

### 1. 单一职责

每个模块应该有一个单一、明确的目的：

```evil
// 好：专注的模块
// date_utils.el
export function formatDate(date) { /* ... */ }
export function parseDate(str) { /* ... */ }
export function addDays(date, days) { /* ... */ }

// 不好：混合关注点
// utils.el
export function formatDate(date) { /* ... */ }
export function calculateTax(amount) { /* ... */ }
export function sendEmail(to, subject) { /* ... */ }
```

### 2. 避免循环依赖

防止模块相互导入：

```evil
// 不好：循环依赖
// a.el
import { b } from "./b.el";
export function a() { return b(); }

// b.el
import { a } from "./a.el";
export function b() { return a(); }

// 好：重构以避免循环依赖
// common.el
export function common() { /* ... */ }

// a.el
import { common } from "./common.el";
export function a() { return common(); }

// b.el
import { common } from "./common.el";
export function b() { return common(); }
```

### 3. 导出接口

只导出必要的内容：

```evil
// implementation.el
function internalHelper() {
    // 未导出 - 仅内部使用
}

export function publicAPI() {
    return internalHelper();
}
```

### 4. 模块文档

记录模块的目的和导出：

```evil
// geometry.el
// 模块：几何工具
// 提供 2D 几何计算函数

export function calculateArea(shape) {
    // 根据形状类型计算面积
}

export function calculatePerimeter(shape) {
    // 根据形状类型计算周长
}
```

## 模块加载

Evil Lang 使用模块缓存避免重复加载模块：

```evil
// module1.el
print("加载 module1");
export let value = 42;

// main.el
import { value } from "./module1.el";  // 打印：加载 module1
import { value as v2 } from "./module1.el";  // 不打印 - 已加载

print(value);   // 输出：42
print(v2);      // 输出：42
```

## 模块模式

### 工厂模式

```evil
// factory/car_factory.el
import { Sedan } from "../models/sedan.el";
import { SUV } from "../models/suv.el";
import { Truck } from "../models/truck.el";

export function createCar(type, options) {
    if (type == "sedan") {
        return new Sedan(options);
    } else if (type == "suv") {
        return new SUV(options);
    } else if (type == "truck") {
        return new Truck(options);
    } else {
        throw "未知的汽车类型：" + type;
    }
}
```

### 单例模式

```evil
// services/database.el
let instance = null;

class Database {
    constructor() {
        if (instance != null) {
            return instance;
        }
        
        this.connection = null;
        instance = this;
    }
    
    connect() {
        // 连接到数据库
        this.connection = "已连接";
    }
}

export default function getDatabase() {
    if (instance == null) {
        instance = new Database();
    }
    return instance;
}
```

## 下一步

- 学习[异常处理](exception-handling.md)进行错误管理
- 探索[标准库](../reference/stdlib.md)模块
- 学习[最佳实践](../guide/best-practices.md)用于大型项目