# 基础语法

本指南涵盖了 Evil Lang 的基础语法元素。

## 注释

Evil Lang 支持单行和多行注释：

```evil
// 这是单行注释

/*
  这是
  多行注释
*/
```

## 变量

### 声明变量

使用 `let` 关键字声明变量：

```evil
let name = "Alice";
let age = 25;
let isStudent = true;
```

### 变量赋值

变量声明后可以重新赋值：

```evil
let count = 0;
count = count + 1;  // count 现在是 1
count = count * 2;  // count 现在是 2
```

### 变量作用域

变量具有块级作用域：

```evil
let x = 10;  // 全局作用域

if (true) {
    let y = 20;  // 块级作用域
    print(x);    // 可以访问：10
    print(y);    // 可以访问：20
}

print(x);  // 可以访问：10
// print(y);  // 错误：y 不在作用域内
```

## 数据类型

### 数字

```evil
let integer = 42;
let float = 3.14;
let negative = -10;
let scientific = 1.5e3;  // 1500
```

### 字符串

```evil
let single = '单引号字符串';
let double = "双引号字符串";
let multiline = "第一行
第二行
第三行";
```

### 布尔值

```evil
let isTrue = true;
let isFalse = false;
```

### 空值

```evil
let nothing = null;
```

### 数组

```evil
let numbers = [1, 2, 3, 4, 5];
let mixed = ["hello", 42, true, null];
let nested = [[1, 2], [3, 4], [5, 6]];

// 访问数组元素
print(numbers[0]);  // 1
print(numbers[4]);  // 5

// 修改数组元素
numbers[0] = 10;
print(numbers);  // [10, 2, 3, 4, 5]
```

### 对象

```evil
let person = {
    name: "Alice",
    age: 25,
    isStudent: true
};

// 访问对象属性
print(person.name);     // Alice
print(person["age"]);   // 25

// 修改对象属性
person.age = 26;
person["isStudent"] = false;

// 添加新属性
person.city = "Beijing";
```

## 运算符

### 算术运算符

```evil
let a = 10;
let b = 3;

print(a + b);   // 13 - 加法
print(a - b);   // 7  - 减法
print(a * b);   // 30 - 乘法
print(a / b);   // 3.333... - 除法
print(a % b);   // 1  - 取模
print(a ** b);  // 1000 - 幂运算
```

### 比较运算符

```evil
let x = 5;
let y = 10;

print(x < y);   // true  - 小于
print(x > y);   // false - 大于
print(x <= 5);  // true  - 小于等于
print(x >= 5);  // true  - 大于等于
print(x == 5);  // true  - 等于
print(x != y);  // true  - 不等于
```

### 逻辑运算符

```evil
let a = true;
let b = false;

print(a && b);    // false - 逻辑与
print(a || b);    // true  - 逻辑或
print(!a);        // false - 逻辑非
```

### 赋值运算符

```evil
let x = 10;
x += 5;   // x = x + 5
x -= 3;   // x = x - 3
x *= 2;   // x = x * 2
x /= 4;   // x = x / 4
x %= 3;   // x = x % 3
```

## 表达式

### 算术表达式

```evil
let result = (10 + 5) * 2 - 3;  // 27
let complex = 2 ** 3 + sqrt(16); // 12
```

### 条件表达式（三元运算符）

```evil
let age = 18;
let status = age >= 18 ? "成年人" : "未成年人";
print(status);  // 成年人
```

### 字符串连接

```evil
let firstName = "张";
let lastName = "三";
let fullName = firstName + lastName;
print("你好，" + fullName + "！");  // 你好，张三！
```

## 语句

### 表达式语句

```evil
print("Hello");
x + 5;  // 有效但结果未使用
calculateSum(10, 20);
```

### 块语句

```evil
{
    let temp = 100;
    print(temp);
    // temp 仅在此块内有效
}
```

## 类型转换

### 隐式转换

```evil
let num = 5;
let str = "数字是：" + num;  // num 转换为字符串
print(str);  // 数字是：5
```

### 显式转换

```evil
let strNum = "42";
let num = toNumber(strNum);  // 字符串转数字
let str = toString(123);     // 数字转字符串
let bool = toBoolean(1);     // 数字转布尔值
```

## 最佳实践

1. **使用有意义的变量名**
   ```evil
   // 好
   let userAge = 25;
   let isLoggedIn = true;
   
   // 不好
   let a = 25;
   let x = true;
   ```

2. **保持一致的命名规范**
   ```evil
   let userName = "Alice";      // 驼峰命名
   let user_name = "Alice";     // 下划线命名
   // 选择一种并保持一致
   ```

3. **适当使用注释**
   ```evil
   // 计算订单总价，包括税费
   let total = subtotal + (subtotal * taxRate);
   ```

## 下一步

- 学习[控制流](control-flow.md)控制程序执行
- 探索[函数](functions.md)组织代码
- 了解[数据类型](data-types.md)的更多细节