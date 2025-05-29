# 快速开始指南

让我们编写您的第一个 Evil Lang 程序！本指南将通过实践示例向您介绍基础知识。

## 第一个程序

创建一个名为 `hello.el` 的文件：

```javascript
// 我的第一个 Evil Lang 程序
print("你好，Evil Lang！");
```

运行它：
```bash
python evil_lang.py hello.el
```

输出：
```
你好，Evil Lang！
```

## 变量和基本操作

```javascript
// 变量
var name = "小明";
var age = 25;
var isStudent = true;

print("姓名：" + name);
print("年龄：" + age);
print("是学生：" + isStudent);

// 基本数学运算
var x = 10;
var y = 20;
print("和：" + (x + y));
print("积：" + (x * y));
```

## 使用函数

```javascript
// 定义函数
func greet(name) {
    return "你好，" + name + "！";
}

// 调用函数
print(greet("小红"));

// 多参数函数
func add(a, b) {
    return a + b;
}

print("5 + 3 = " + add(5, 3));
```

## 控制流

```javascript
// If-else 语句
var score = 85;

if (score >= 90) {
    print("成绩：优秀");
} else if (score >= 80) {
    print("成绩：良好");
} else {
    print("成绩：及格或以下");
}

// 循环
print("\n数到 5：");
for (var i = 1; i <= 5; i = i + 1) {
    print(i);
}

// While 循环
var count = 3;
print("\n倒计时：");
while (count > 0) {
    print(count + "...");
    count = count - 1;
}
print("发射！");
```

## 数组和对象

```javascript
// 数组
var fruits = ["苹果", "香蕉", "橙子"];
print("水果：" + fruits);
print("第一个水果：" + fruits[0]);
print("水果数量：" + fruits.length);

// 添加到数组
push(fruits, "葡萄");
print("添加葡萄后：" + fruits);

// 对象
var person = {
    name: "张三",
    age: 30,
    city: "北京"
};

print("\n个人信息：");
print("姓名：" + person.name);
print("年龄：" + person.age);
print("城市：" + person.city);
```

## 类和对象

```javascript
// 定义类
class Dog {
    constructor(name, breed) {
        this.name = name;
        this.breed = breed;
    }
    
    bark() {
        print(this.name + " 说：汪汪！");
    }
    
    describe() {
        print(this.name + " 是一只 " + this.breed);
    }
}

// 创建实例
var myDog = new Dog("小黄", "金毛犬");
myDog.describe();
myDog.bark();
```

## 异常处理

```javascript
// Try-catch 示例
func safeDivide(a, b) {
    try {
        if (b == 0) {
            throw "不能除以零！";
        }
        return a / b;
    } catch (error) {
        print("错误：" + error);
        return null;
    }
}

print("10 / 2 = " + safeDivide(10, 2));
print("10 / 0 = " + safeDivide(10, 0));
```

## 交互式输入

```javascript
// 获取用户输入
var userName = input("您的名字是什么？");
print("很高兴认识您，" + userName + "！");

var userAge = input("您多大了？");
print("您 " + userAge + " 岁了。");
```

## 完整示例：猜数字游戏

这是一个结合了各种概念的简单游戏：

```javascript
// 简单的猜数字游戏
var secretNumber = 42;
var maxTries = 5;
var tries = 0;
var won = false;

print("欢迎来到猜数字游戏！");
print("我想了一个 1 到 100 之间的数字。");
print("你有 " + maxTries + " 次机会猜对它。\n");

while (tries < maxTries && !won) {
    var guess = input("请输入你的猜测：");
    tries = tries + 1;
    
    // 将字符串转换为数字进行比较
    if (guess == secretNumber) {
        won = true;
        print("恭喜！你在第 " + tries + " 次猜对了！");
    } else if (guess < secretNumber) {
        print("太小了！再试一次。");
        print("剩余次数：" + (maxTries - tries));
    } else {
        print("太大了！再试一次。");
        print("剩余次数：" + (maxTries - tries));
    }
}

if (!won) {
    print("\n很遗憾！正确答案是 " + secretNumber);
}
```

## 下一步

恭喜！您已经学会了 Evil Lang 的基础知识。要继续您的学习之旅：

1. 探索仓库中的更多[示例](../../examples)
2. 详细了解[数据类型](data-types.md)
3. 掌握[函数和闭包](functions.md)
4. 发现[面向对象编程](classes-objects.md)
5. 理解[模块系统](modules.md)

## 学习技巧

1. **实验**：修改示例并观察结果
2. **阅读错误**：Evil Lang 提供有用的错误信息
3. **使用调试模式**：添加 `--debug` 查看代码如何被解析
4. **练习**：尝试实现小程序和游戏
5. **探索**：查看标准库中的有用函数

祝您使用 Evil Lang 编程愉快！