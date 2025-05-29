# 控制流

控制流语句允许您根据条件和循环控制程序的执行路径。

## If 语句

`if` 语句根据条件执行代码：

```evil
if (x > 0) {
    print("x 是正数");
}
```

### If-Else

添加 `else` 子句处理假值情况：

```evil
let score = 85;

if (score >= 90) {
    print("成绩：A");
} else {
    print("成绩：B 或以下");
}
```

### If-Else If-Else

链接多个条件：

```evil
let score = 75;

if (score >= 90) {
    print("成绩：优秀");
} else if (score >= 80) {
    print("成绩：良好");
} else if (score >= 70) {
    print("成绩：中等");
} else if (score >= 60) {
    print("成绩：及格");
} else {
    print("成绩：不及格");
}
```

## 循环

### While 循环

`while` 循环在条件为真时执行代码：

```evil
let i = 0;
while (i < 5) {
    print("计数：" + i);
    i = i + 1;
}
```

### For 循环

`for` 循环提供了一种紧凑的迭代方式：

```evil
// 传统 for 循环
for (let i = 0; i < 5; i = i + 1) {
    print("索引：" + i);
}

// 遍历数组
let fruits = ["苹果", "香蕉", "橙子"];
for (let i = 0; i < fruits.length; i = i + 1) {
    print("水果：" + fruits[i]);
}
```

### Break 语句

使用 `break` 提前退出循环：

```evil
let i = 0;
while (true) {
    if (i >= 5) {
        break;
    }
    print("计数：" + i);
    i = i + 1;
}
```

### Continue 语句

使用 `continue` 跳过当前迭代的剩余部分：

```evil
for (let i = 0; i < 10; i = i + 1) {
    if (i % 2 == 0) {
        continue;  // 跳过偶数
    }
    print("奇数：" + i);
}
```

## 嵌套控制结构

控制结构可以嵌套：

```evil
for (let i = 1; i <= 3; i = i + 1) {
    print("外层循环：" + i);
    
    for (let j = 1; j <= 3; j = j + 1) {
        if (i == j) {
            continue;
        }
        print("  内层循环：" + j);
    }
}
```

## Return 语句

退出函数并可选地返回一个值：

```evil
function findFirst(arr, target) {
    for (let i = 0; i < arr.length; i = i + 1) {
        if (arr[i] == target) {
            return i;  // 找到时返回索引
        }
    }
    return -1;  // 未找到时返回 -1
}

let numbers = [10, 20, 30, 40];
let index = findFirst(numbers, 30);
print("在索引 " + index + " 处找到");  // 输出：在索引 2 处找到
```

## 条件表达式

Evil Lang 支持三元条件表达式：

```evil
let age = 18;
let status = age >= 18 ? "成年人" : "未成年人";
print("状态：" + status);  // 输出：状态：成年人
```

## 实际示例

### 菜单系统

```evil
let running = true;
while (running) {
    print("\n=== 菜单 ===");
    print("1. 打招呼");
    print("2. 计算");
    print("3. 退出");
    
    let choice = input("请选择：");
    
    if (choice == "1") {
        print("你好，世界！");
    } else if (choice == "2") {
        let a = toNumber(input("输入第一个数字："));
        let b = toNumber(input("输入第二个数字："));
        print("和为：" + (a + b));
    } else if (choice == "3") {
        print("再见！");
        running = false;
    } else {
        print("无效选择！");
    }
}
```

### 猜数字游戏

```evil
let secret = floor(random() * 100) + 1;
let attempts = 0;
let found = false;

print("我想了一个 1 到 100 之间的数字！");

while (!found) {
    let guess = toNumber(input("你的猜测："));
    attempts = attempts + 1;
    
    if (guess < secret) {
        print("太小了！");
    } else if (guess > secret) {
        print("太大了！");
    } else {
        found = true;
        print("正确！你用了 " + attempts + " 次猜对了！");
    }
}
```

### 查找素数

```evil
function isPrime(n) {
    if (n <= 1) {
        return false;
    }
    
    for (let i = 2; i <= sqrt(n); i = i + 1) {
        if (n % i == 0) {
            return false;
        }
    }
    
    return true;
}

print("前 20 个素数：");
let count = 0;
let num = 2;

while (count < 20) {
    if (isPrime(num)) {
        print(num);
        count = count + 1;
    }
    num = num + 1;
}
```

### 模式打印

```evil
// 打印金字塔
let height = 5;
for (let i = 1; i <= height; i = i + 1) {
    let spaces = "";
    let stars = "";
    
    // 添加空格
    for (let j = 0; j < height - i; j = j + 1) {
        spaces = spaces + " ";
    }
    
    // 添加星号
    for (let j = 0; j < 2 * i - 1; j = j + 1) {
        stars = stars + "*";
    }
    
    print(spaces + stars);
}
```

## 最佳实践

1. **使用有意义的条件**：让条件清晰易读
   ```evil
   // 好
   if (age >= 18) { ... }
   
   // 不好
   if (a >= b) { ... }  // a 和 b 是什么？
   ```

2. **避免深层嵌套**：考虑重构深层嵌套的结构
   ```evil
   // 使用提前返回减少嵌套
   function processData(data) {
       if (data == null) {
           return null;
       }
       
       if (data.length == 0) {
           return [];
       }
       
       // 主要逻辑
       return transform(data);
   }
   ```

3. **谨慎使用 break 和 continue**：它们可能使代码难以理解
4. **考虑提前返回**：从函数提前返回可以减少嵌套
5. **初始化循环变量**：始终初始化循环中使用的变量

## 下一步

- 学习[函数](functions.md)组织代码
- 探索[异常处理](exception-handling.md)进行错误管理
- 学习[类和对象](classes-objects.md)进行面向对象编程