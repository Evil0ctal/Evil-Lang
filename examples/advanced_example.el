// Evil Lang 高级功能示例程序

// 1. 数组操作
var numbers = [1, 2, 3, 4, 5];
print("数组第三个元素: " + numbers[2]);  // 数组索引从0开始

// 修改数组元素
numbers[0] = 10;
print("修改后的数组第一个元素: " + numbers[0]);

// 2. 函数定义与调用
func add(a, b) {
    return a + b;
}

func factorial(n) {
    if (n <= 1) {
        return 1;
    } else {
        return n * factorial(n - 1);
    }
}

print("2 + 3 = " + add(2, 3));
print("5的阶乘是: " + factorial(5));

// 3. 用户输入
var name = input("请输入您的名字: ");
print("您好, " + name + "!");

// 4. For循环
print("使用for循环计数:");
for (var i = 0; i < 5; i = i + 1) {
    print(i);
}

// 5. Break和Continue
print("演示break:");
var j = 0;
while (j < 10) {
    if (j == 5) {
        break;
    }
    print(j);
    j = j + 1;
}

print("演示continue:");
for (var k = 0; k < 5; k = k + 1) {
    if (k == 2) {
        continue;
    }
    print(k);
}

// 6. 函数作为一等公民
func applyAndPrint(value, operation) {
    print(operation(value));
}

func double(x) {
    return x * 2;
}

func square(x) {
    return x * x;
}

applyAndPrint(5, double);  // 输出10
applyAndPrint(5, square);  // 输出25

// 7. 嵌套函数和闭包
func createCounter() {
    var count = 0;

    func increment() {
        count = count + 1;
        return count;
    }

    return increment;
}

var counter = createCounter();
print(counter());  // 输出1
print(counter());  // 输出2
print(counter());  // 输出3