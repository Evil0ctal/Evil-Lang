// ===================================================================
// Evil Lang 全面综合示例程序
// 这个文件展示了Evil Lang的所有主要特性
// 运行方式: python evil_lang.py complete_example.el
// ===================================================================

// ==================== 1. 基础变量和数据类型 ====================
print("\n===== 1. 基础变量和数据类型 =====");

var integer = 42;
var float_num = 3.14159;
var string_val = "Evil Lang很有趣!";
var boolean_val = true;
var null_val = null;

print("整数: " + integer);
print("浮点数: " + float_num);
print("字符串: " + string_val);
print("布尔值: " + boolean_val);
print("空值: " + null_val);

// 基本运算符
print("\n基本运算:");
print("42 + 8 = " + (integer + 8));
print("42 - 8 = " + (integer - 8));
print("42 * 2 = " + (integer * 2));
print("42 / 5 = " + (integer / 5));

// 比较和逻辑运算符
print("\n比较和逻辑运算:");
print("42 > 30? " + (integer > 30));
print("42 < 30? " + (integer < 30));
print("42 == 42? " + (integer == 42));
print("42 != 42? " + (integer != 42));
print("true && false = " + (true && false));
print("true || false = " + (true || false));
print("!true = " + (!true));

// ==================== 2. 数组操作 ====================
print("\n===== 2. 数组操作 =====");

var numbers = [1, 2, 3, 4, 5];
print("原始数组: " + numbers);
print("数组第三个元素: " + numbers[2]);  // 索引从0开始

// 修改数组元素
numbers[0] = 10;
print("修改后的数组: " + numbers);

// 创建和使用更复杂的数组
var nested_array = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
];
print("嵌套数组的第二行第三列: " + nested_array[1][2]);  // 应该是6

// 创建包含不同类型的数组
var mixed_array = [42, "文本", true, [1, 2, 3]];
print("混合类型数组: " + mixed_array);

// ==================== 3. 控制结构 ====================
print("\n===== 3. 控制结构 =====");

// if-else 条件语句
var temperature = 22;
print("当前温度: " + temperature + "°C");

if (temperature < 0) {
    print("天气很冷，注意保暖!");
} else if (temperature < 10) {
    print("天气凉爽，带件外套!");
} else if (temperature < 20) {
    print("天气适宜，很舒适!");
} else if (temperature < 30) {
    print("天气温暖，可以穿单衣!");
} else {
    print("天气炎热，记得防晒!");
}

// while 循环
print("\nWhile循环示例:");
var counter = 1;
while (counter <= 3) {
    print("While循环第" + counter + "次");
    counter = counter + 1;
}

// for 循环
print("\nFor循环示例:");
for (var i = 3; i > 0; i = i - 1) {
    print("倒计时: " + i);
}

// break 示例
print("\nBreak示例:");
var j = 0;
while (j < 10) {
    if (j == 5) {
        print("到达5，跳出循环!");
        break;
    }
    print("j = " + j);
    j = j + 1;
}

// continue 示例
print("\nContinue示例:");
for (var k = 0; k < 5; k = k + 1) {
    if (k == 2) {
        print("跳过2!");
        continue;
    }
    print("k = " + k);
}

// ==================== 4. 函数定义与调用 ====================
print("\n===== 4. 函数定义与调用 =====");

// 基本函数
func add(a, b) {
    return a + b;
}

print("2 + 3 = " + add(2, 3));

// 递归函数
func factorial(n) {
    if (n <= 1) {
        return 1;
    } else {
        return n * factorial(n - 1);
    }
}

print("5的阶乘是: " + factorial(5));

// 带有多个参数的函数
func calculateVolume(length, width, height) {
    return length * width * height;
}

print("长方体体积(2x3x4): " + calculateVolume(2, 3, 4));

// 带默认逻辑的函数
func greet(name, formal) {
    if (formal) {
        return "尊敬的 " + name + "，您好!";
    } else {
        return "嘿, " + name + "!";
    }
}

print(greet("张三", true));
print(greet("李四", false));

// ==================== 5. 高阶函数 ====================
print("\n===== 5. 高阶函数 =====");

// 函数作为参数
func applyAndPrint(value, operation) {
    print("计算结果: " + operation(value));
}

func double(x) {
    return x * 2;
}

func square(x) {
    return x * x;
}

applyAndPrint(5, double);  // 输出10
applyAndPrint(5, square);  // 输出25

// 返回函数的函数
func makeMultiplier(factor) {
    func multiplier(x) {
        return x * factor;
    }

    return multiplier;
}

var triple = makeMultiplier(3);
var quadruple = makeMultiplier(4);

print("Triple of 7: " + triple(7));
print("Quadruple of 7: " + quadruple(7));

// 使用函数进行数据转换
func mapArray(arr, transform) {
    var result = [];
    for (var i = 0; i < arr.length; i = i + 1) {
        result[i] = transform(arr[i]);
    }
    return result;
}

var originalArray = [1, 2, 3, 4, 5];
var doubledArray = mapArray(originalArray, double);
var squaredArray = mapArray(originalArray, square);

print("原始数组: " + originalArray);
print("加倍后: " + doubledArray);
print("平方后: " + squaredArray);

// ==================== 6. 闭包 ====================
print("\n===== 6. 闭包 =====");

// 简单计数器闭包
func createCounter(start) {
    var count = start;

    func increment() {
        count = count + 1;
        return count;
    }

    return increment;
}

var counter1 = createCounter(0);
var counter2 = createCounter(10);

print("Counter1第1次: " + counter1());  // 1
print("Counter1第2次: " + counter1());  // 2
print("Counter1第3次: " + counter1());  // 3
print("Counter2第1次: " + counter2());  // 11
print("Counter2第2次: " + counter2());  // 12

// 更复杂的闭包示例：带记忆功能的斐波那契函数
func createFibonacciWithMemory() {
    var memory = [0, 1];  // 缓存已计算的结果

    func fibonacci(n) {
        if (n >= memory.length) {
            for (var i = memory.length; i <= n; i = i + 1) {
                memory[i] = memory[i-1] + memory[i-2];
            }
        }
        return memory[n];
    }

    return fibonacci;
}

var fib = createFibonacciWithMemory();
print("Fibonacci(10): " + fib(10));
print("Fibonacci(15): " + fib(15));
print("Fibonacci(20): " + fib(20));

// ==================== 7. 用户交互 ====================
print("\n===== 7. 用户交互 =====");

// 基本输入
var name = input("请输入您的名字: ");
print("您好, " + name + "!");

// 计算器示例
var num1 = input("请输入第一个数字: ");
var num2 = input("请输入第二个数字: ");
print("两数之和: " + (num1 + num2));  // 注意：这会是字符串拼接，不是数字相加
print("正确的两数之和: " + add(num1, num2));  // 这里假设add函数会自动转换字符串为数字

// ==================== 8. 综合应用：待办事项管理器 ====================
print("\n===== 8. 综合应用：待办事项管理器 =====");

func createTodoManager() {
    var todos = [];
    var nextId = 1;

    // 添加待办事项
    func addTodo(task, priority) {
        var todo = {
            "id": nextId,
            "task": task,
            "priority": priority,
            "completed": false,
            "created": "今天"  // 在实际应用中，这会是真正的日期
        };

        todos[todos.length] = todo;
        nextId = nextId + 1;
        return todo.id;
    }

    // 标记待办事项为完成
    func completeTodo(id) {
        for (var i = 0; i < todos.length; i = i + 1) {
            if (todos[i].id == id) {
                todos[i].completed = true;
                return true;
            }
        }
        return false;
    }

    // 按优先级过滤待办事项
    func filterByPriority(priority) {
        var filtered = [];
        var count = 0;

        for (var i = 0; i < todos.length; i = i + 1) {
            if (todos[i].priority == priority) {
                filtered[count] = todos[i];
                count = count + 1;
            }
        }

        return filtered;
    }

    // 显示所有待办事项
    func displayTodos() {
        if (todos.length == 0) {
            print("没有待办事项。");
            return;
        }

        print("待办事项列表:");
        for (var i = 0; i < todos.length; i = i + 1) {
            var status = todos[i].completed ? "[✓]" : "[ ]";
            var priorityDisplay = "";

            if (todos[i].priority == "high") {
                priorityDisplay = "[高]";
            } else if (todos[i].priority == "medium") {
                priorityDisplay = "[中]";
            } else {
                priorityDisplay = "[低]";
            }

            print(status + " #" + todos[i].id + " " + priorityDisplay + " " + todos[i].task);
        }
    }

    // 返回所有功能
    return [addTodo, completeTodo, filterByPriority, displayTodos];
}

// 使用待办事项管理器
print("创建待办事项管理器...");
var todoManager = createTodoManager();
var addTodo = todoManager[0];
var completeTodo = todoManager[1];
var filterByPriority = todoManager[2];
var displayTodos = todoManager[3];

// 添加几个待办事项
addTodo("完成Evil Lang示例程序", "high");
addTodo("学习闭包概念", "medium");
addTodo("测试数组操作", "low");
addTodo("编写更多示例", "high");

// 显示所有待办事项
displayTodos();

// 完成一些待办事项
print("\n标记一些任务为完成状态...");
completeTodo(1);
completeTodo(3);

// 再次显示所有待办事项
displayTodos();

// 按优先级筛选
print("\n仅显示高优先级任务:");
var highPriorityTasks = filterByPriority("high");
for (var i = 0; i < highPriorityTasks.length; i = i + 1) {
    var status = highPriorityTasks[i].completed ? "[✓]" : "[ ]";
    print(status + " #" + highPriorityTasks[i].id + " " + highPriorityTasks[i].task);
}

// ==================== 程序结束 ====================
print("\n===== 程序结束 =====");
print("感谢使用Evil Lang全面示例程序！");