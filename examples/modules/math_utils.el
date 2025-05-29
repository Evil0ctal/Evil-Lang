// Evil Lang 数学工具模块
// 提供额外的数学函数

// 常量
export var PI = 3.14159265359;
export var E = 2.71828182846;

// 平方函数
export func square(x) {
    return x * x;
}

// 立方函数
export func cube(x) {
    return x * x * x;
}

// 幂函数
export func pow(base, exp) {
    var result = 1;
    for (var i = 0; i < exp; i = i + 1) {
        result = result * base;
    }
    return result;
}

// 阶乘函数
export func factorial(n) {
    if (n <= 1) {
        return 1;
    }
    return n * factorial(n - 1);
}

// 斐波那契数列
export func fibonacci(n) {
    if (n <= 1) {
        return n;
    }
    var a = 0;
    var b = 1;
    for (var i = 2; i <= n; i = i + 1) {
        var temp = a + b;
        a = b;
        b = temp;
    }
    return b;
}

// 最大公约数
export func gcd(a, b) {
    while (b != 0) {
        var temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

// 最小公倍数
export func lcm(a, b) {
    return (a * b) / gcd(a, b);
}

// 判断是否为质数
export func isPrime(n) {
    if (n <= 1) {
        return false;
    }
    if (n <= 3) {
        return true;
    }
    if (n % 2 == 0 || n % 3 == 0) {
        return false;
    }
    
    var i = 5;
    while (i * i <= n) {
        if (n % i == 0 || n % (i + 2) == 0) {
            return false;
        }
        i = i + 6;
    }
    return true;
}