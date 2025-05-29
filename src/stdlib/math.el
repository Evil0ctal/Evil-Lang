// Evil Lang 标准库 - 数学模块
// 提供扩展的数学函数

// 数学常量
export var PI = 3.141592653589793;
export var E = 2.718281828459045;
export var SQRT2 = 1.4142135623730951;
export var LN2 = 0.6931471805599453;
export var LN10 = 2.302585092994046;

// 基础数学函数
export func abs(x) {
    if (x < 0) {
        return -x;
    }
    return x;
}

export func sign(x) {
    if (x > 0) {
        return 1;
    } else if (x < 0) {
        return -1;
    }
    return 0;
}

export func max(a, b) {
    if (a > b) {
        return a;
    }
    return b;
}

export func min(a, b) {
    if (a < b) {
        return a;
    }
    return b;
}

// 幂和根
export func pow(base, exp) {
    if (exp == 0) {
        return 1;
    }
    
    var result = 1;
    var n = abs(exp);
    
    for (var i = 0; i < n; i = i + 1) {
        result = result * base;
    }
    
    if (exp < 0) {
        return 1 / result;
    }
    return result;
}

export func sqrt(x) {
    if (x < 0) {
        return null; // 暂不支持复数
    }
    if (x == 0) {
        return 0;
    }
    
    // 牛顿迭代法
    var guess = x / 2;
    var epsilon = 0.00001;
    
    while (abs(guess * guess - x) > epsilon) {
        guess = (guess + x / guess) / 2;
    }
    
    return guess;
}

// 取整函数
export func floor(x) {
    if (x >= 0) {
        return numberSub(x, x % 1);
    }
    return numberSub(x, x % 1) - 1;
}

export func ceil(x) {
    if (x % 1 == 0) {
        return x;
    }
    if (x > 0) {
        return floor(x) + 1;
    }
    return floor(x);
}

export func round(x) {
    if (x >= 0) {
        return floor(x + 0.5);
    }
    return ceil(x - 0.5);
}

// 三角函数（简单近似）
export func factorial(n) {
    if (n <= 1) {
        return 1;
    }
    var result = 1;
    for (var i = 2; i <= n; i = i + 1) {
        result = result * i;
    }
    return result;
}

// 使用泰勒级数近似
export func sin(x) {
    // 将 x 限制在 [-2π, 2π] 范围内
    while (x > 2 * PI) {
        x = x - 2 * PI;
    }
    while (x < -2 * PI) {
        x = x + 2 * PI;
    }
    
    var result = 0;
    var sign = 1;
    
    // 使用前几项泰勒级数
    for (var n = 0; n < 10; n = n + 1) {
        var term = pow(x, 2 * n + 1) / factorial(2 * n + 1);
        result = result + sign * term;
        sign = -sign;
    }
    
    return result;
}

export func cos(x) {
    return sin(x + PI / 2);
}

// 随机数生成（简单的线性同余生成器）
var _randomSeed = 12345;

export func random() {
    // 简单的 LCG 算法
    _randomSeed = (_randomSeed * 1103515245 + 12345) % 2147483648;
    return _randomSeed / 2147483648;
}

export func randomInt(min, max) {
    return floor(random() * (max - min + 1)) + min;
}

// 其他实用函数
export func clamp(x, min, max) {
    if (x < min) {
        return min;
    }
    if (x > max) {
        return max;
    }
    return x;
}

export func lerp(a, b, t) {
    return a + (b - a) * t;
}