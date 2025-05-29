// 简单的模块测试
// 测试基本的导出功能

// 定义一些变量和函数
var x = 10;
var y = 20;

func add(a, b) {
    return a + b;
}

func multiply(a, b) {
    return a * b;
}

// 导出它们
export { x, y, add, multiply };

// 测试本地使用
print("Local test:");
print("x = " + x);
print("y = " + y);
print("add(3, 4) = " + add(3, 4));
print("multiply(3, 4) = " + multiply(3, 4));