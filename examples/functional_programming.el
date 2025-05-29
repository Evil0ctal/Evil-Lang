// Evil Lang 函数式编程示例
// 演示高阶函数、闭包和函数组合

print("=== Functional Programming Demo ===");
print("");

// 高阶函数：map
func map(arr, fn) {
    var result = [];
    for (var i = 0; i < arr.length; i = i + 1) {
        result[i] = fn(arr[i]);
    }
    return result;
}

// 高阶函数：filter
func filter(arr, predicate) {
    var result = [];
    var j = 0;
    for (var i = 0; i < arr.length; i = i + 1) {
        if (predicate(arr[i])) {
            result[j] = arr[i];
            j = j + 1;
        }
    }
    return result;
}

// 高阶函数：reduce
func reduce(arr, fn, initial) {
    var acc = initial;
    for (var i = 0; i < arr.length; i = i + 1) {
        acc = fn(acc, arr[i]);
    }
    return acc;
}

// 测试数据
var numbers = [1, 2, 3, 4, 5];

// map 示例
print("Map examples:");
var squared = map(numbers, func(x) { return x * x; });
print("map([1,2,3,4,5], square) = " + squared);

var doubled = map(numbers, func(x) { return x * 2; });
print("map([1,2,3,4,5], double) = " + doubled);

// filter 示例
print("");
print("Filter examples:");
var evens = filter(numbers, func(x) { return x % 2 == 0; });
print("filter([1,2,3,4,5], isEven) = " + evens);

var greaterThan3 = filter(numbers, func(x) { return x > 3; });
print("filter([1,2,3,4,5], >3) = " + greaterThan3);

// reduce 示例
print("");
print("Reduce examples:");
var sum = reduce(numbers, func(acc, x) { return acc + x; }, 0);
print("reduce([1,2,3,4,5], sum, 0) = " + sum);

var product = reduce(numbers, func(acc, x) { return acc * x; }, 1);
print("reduce([1,2,3,4,5], product, 1) = " + product);

// 函数组合
func compose(f, g) {
    return func(x) { return f(g(x)); };
}

var addOne = func(x) { return x + 1; };
var double = func(x) { return x * 2; };
var addOneThenDouble = compose(double, addOne);

print("");
print("Function composition:");
print("compose(double, addOne)(5) = " + addOneThenDouble(5)); // (5+1)*2 = 12

// 柯里化示例
func curry(fn) {
    return func(a) {
        return func(b) {
            return fn(a, b);
        };
    };
}

var add = func(a, b) { return a + b; };
var curriedAdd = curry(add);
var add5 = curriedAdd(5);

print("");
print("Currying:");
print("curry(add)(5)(3) = " + curriedAdd(5)(3));
print("add5(3) = " + add5(3));
print("add5(10) = " + add5(10));

// 实际应用：数据处理管道
print("");
print("Data processing pipeline:");
var data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

// 计算所有偶数的平方和
var result = reduce(
    map(
        filter(data, func(x) { return x % 2 == 0; }),
        func(x) { return x * x; }
    ),
    func(acc, x) { return acc + x; },
    0
);

print("Sum of squares of even numbers in [1..10] = " + result); // 4+16+36+64+100 = 220