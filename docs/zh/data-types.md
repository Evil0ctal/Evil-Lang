# 数据类型

Evil Lang 支持多种数据类型，包括原始类型和复合类型。

## 原始类型

### 数字（Number）

Evil Lang 中的所有数字都是浮点数：

```evil
let integer = 42;         // 整数
let float = 3.14159;      // 浮点数
let negative = -273.15;   // 负数
let scientific = 6.022e23; // 科学计数法
let hex = 0xFF;           // 十六进制（255）
let binary = 0b1010;      // 二进制（10）
```

数字运算：
```evil
let a = 10;
let b = 3;

print(a + b);    // 13
print(a - b);    // 7
print(a * b);    // 30
print(a / b);    // 3.3333...
print(a % b);    // 1
print(a ** b);   // 1000

// 数学函数
print(sqrt(16));      // 4
print(abs(-5));       // 5
print(floor(3.7));    // 3
print(ceil(3.2));     // 4
print(round(3.5));    // 4
```

### 字符串（String）

字符串是不可变的字符序列：

```evil
let single = '单引号字符串';
let double = "双引号字符串";
let empty = "";

// 转义字符
let escaped = "第一行\n第二行\t带制表符";
let quote = "他说：\"你好！\"";
let path = "C:\\Users\\Documents";

// 字符串长度
let message = "Hello";
print(message.length);  // 5
```

字符串操作：
```evil
let str = "Hello, World!";

// 大小写转换
print(toUpper(str));      // "HELLO, WORLD!"
print(toLower(str));      // "hello, world!"

// 字符串查找
print(indexOf(str, "World"));     // 7
print(contains(str, "Hello"));    // true
print(startsWith(str, "Hello"));  // true
print(endsWith(str, "!"));        // true

// 字符串操作
print(substring(str, 0, 5));      // "Hello"
print(replace(str, "World", "Evil")); // "Hello, Evil!"
print(trim("  空格  "));          // "空格"
```

### 布尔值（Boolean）

布尔值表示真或假：

```evil
let isTrue = true;
let isFalse = false;

// 布尔运算
print(true && false);   // false
print(true || false);   // true
print(!true);          // false

// 比较产生布尔值
print(5 > 3);          // true
print(10 == 10);       // true
print("a" != "b");     // true
```

### 空值（Null）

`null` 表示空值或缺失值：

```evil
let nothing = null;
let result = getValue();  // 可能返回 null

if (result == null) {
    print("没有值");
}
```

## 复合类型

### 数组（Array）

数组是有序的值集合：

```evil
// 创建数组
let numbers = [1, 2, 3, 4, 5];
let mixed = ["text", 42, true, null];
let nested = [[1, 2], [3, 4]];
let empty = [];

// 访问元素
print(numbers[0]);     // 1（第一个元素）
print(numbers[4]);     // 5（最后一个元素）
print(nested[0][1]);   // 2（嵌套访问）

// 修改元素
numbers[0] = 10;
print(numbers);        // [10, 2, 3, 4, 5]

// 数组长度
print(numbers.length); // 5
```

数组操作：
```evil
let arr = [1, 2, 3];

// 添加元素
push(arr, 4);          // arr = [1, 2, 3, 4]
unshift(arr, 0);       // arr = [0, 1, 2, 3, 4]

// 删除元素
let last = pop(arr);   // last = 4, arr = [0, 1, 2, 3]
let first = shift(arr); // first = 0, arr = [1, 2, 3]

// 数组切片
let subset = slice(arr, 1, 3);  // [2, 3]

// 数组连接
let combined = concat([1, 2], [3, 4]); // [1, 2, 3, 4]

// 数组操作
reverse(arr);          // arr = [3, 2, 1]
sort(arr);            // arr = [1, 2, 3]
```

高级数组操作：
```evil
let numbers = [1, 2, 3, 4, 5];

// Map: 转换每个元素
let doubled = map(numbers, function(x) {
    return x * 2;
});
print(doubled);  // [2, 4, 6, 8, 10]

// Filter: 筛选元素
let evens = filter(numbers, function(x) {
    return x % 2 == 0;
});
print(evens);    // [2, 4]

// Reduce: 归约到单个值
let sum = reduce(numbers, function(acc, x) {
    return acc + x;
}, 0);
print(sum);      // 15
```

### 对象（Object）

对象是键值对的集合：

```evil
// 创建对象
let person = {
    name: "张三",
    age: 25,
    city: "北京",
    hobbies: ["阅读", "编程", "旅行"]
};

// 访问属性
print(person.name);        // "张三"
print(person["age"]);      // 25

// 修改属性
person.age = 26;
person["city"] = "上海";

// 添加新属性
person.email = "zhangsan@example.com";
person["phone"] = "123-456-7890";

// 嵌套对象
let company = {
    name: "科技公司",
    address: {
        street: "中关村大街1号",
        city: "北京",
        zip: "100000"
    },
    employees: [
        {name: "李四", position: "工程师"},
        {name: "王五", position: "设计师"}
    ]
};

print(company.address.city);           // "北京"
print(company.employees[0].name);      // "李四"
```

对象操作：
```evil
let obj = {a: 1, b: 2, c: 3};

// 获取键和值
let keys = keys(obj);      // ["a", "b", "c"]
let values = values(obj);  // [1, 2, 3]

// 检查属性
print(hasProperty(obj, "a"));    // true
print(hasProperty(obj, "d"));    // false

// 动态属性访问
let prop = "b";
print(obj[prop]);  // 2
```

### 函数（Function）

函数是一等公民，可以赋值给变量：

```evil
// 函数声明
function add(a, b) {
    return a + b;
}

// 函数表达式
let multiply = function(a, b) {
    return a * b;
};

// 函数作为值
let operation = add;
print(operation(5, 3));  // 8

// 高阶函数
function applyTwice(fn, x) {
    return fn(fn(x));
}

function double(x) {
    return x * 2;
}

print(applyTwice(double, 5));  // 20
```

## 类型检查

### typeof 运算符

```evil
print(typeof(42));           // "number"
print(typeof("hello"));      // "string"
print(typeof(true));         // "boolean"
print(typeof(null));         // "null"
print(typeof([1, 2, 3]));    // "array"
print(typeof({a: 1}));       // "object"
print(typeof(function(){})); // "function"
```

### 类型转换

```evil
// 转换为数字
print(toNumber("42"));      // 42
print(toNumber("3.14"));    // 3.14
print(toNumber("abc"));     // null
print(toNumber(true));      // 1
print(toNumber(false));     // 0

// 转换为字符串
print(toString(42));        // "42"
print(toString(true));      // "true"
print(toString([1, 2]));    // "[1, 2]"
print(toString({a: 1}));    // "{a: 1}"

// 转换为布尔值
print(toBoolean(1));        // true
print(toBoolean(0));        // false
print(toBoolean("text"));   // true
print(toBoolean(""));       // false
print(toBoolean(null));     // false
print(toBoolean([]));       // true
```

## 真值和假值

在条件语句中，以下值被视为假：
- `false`
- `null`
- `0`
- `""` （空字符串）

其他所有值都被视为真：

```evil
if (0) {
    print("不会执行");
}

if ("") {
    print("不会执行");
}

if (null) {
    print("不会执行");
}

if (1) {
    print("会执行");
}

if ("text") {
    print("会执行");
}

if ([]) {
    print("会执行");  // 空数组是真值！
}
```

## 下一步

- 学习[控制流](control-flow.md)使用这些数据类型
- 探索[函数](functions.md)处理数据
- 了解[类和对象](classes-objects.md)创建自定义类型