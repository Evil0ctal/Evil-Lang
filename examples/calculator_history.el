// Advanced Calculator with History - 带历史记录的高级计算器
// 支持基本运算、科学计算、历史记录和内存功能

import { sqrt, pow, sin, cos, tan, abs, floor, ceil, round, PI } from "stdlib/math.el";

class CalculatorHistory {
    constructor(maxSize = 50) {
        this.history = [];
        this.maxSize = maxSize;
    }
    
    add(expression, result) {
        let entry = {
            expression: expression,
            result: result,
            timestamp: getCurrentTime()
        };
        
        push(this.history, entry);
        
        // 保持历史记录在最大大小以内
        if (this.history.length > this.maxSize) {
            shift(this.history);
        }
    }
    
    display() {
        if (this.history.length == 0) {
            print("📜 历史记录为空");
            return;
        }
        
        print("\n📜 计算历史：");
        print("=" + repeat("=", 50));
        
        for (let i = this.history.length - 1; i >= 0; i = i - 1) {
            let entry = this.history[i];
            print((this.history.length - i) + ". " + entry.expression + " = " + entry.result);
        }
        
        print("=" + repeat("=", 50));
    }
    
    clear() {
        this.history = [];
        print("🗑️ 历史记录已清空");
    }
    
    getLast() {
        if (this.history.length > 0) {
            return this.history[this.history.length - 1].result;
        }
        return 0;
    }
}

class ScientificCalculator {
    constructor() {
        this.memory = 0;
        this.history = new CalculatorHistory();
        this.lastResult = 0;
        this.variables = {};
    }
    
    // 基本运算
    add(a, b) {
        return a + b;
    }
    
    subtract(a, b) {
        return a - b;
    }
    
    multiply(a, b) {
        return a * b;
    }
    
    divide(a, b) {
        if (b == 0) {
            throw "错误：除数不能为零";
        }
        return a / b;
    }
    
    modulo(a, b) {
        if (b == 0) {
            throw "错误：除数不能为零";
        }
        return a % b;
    }
    
    // 科学计算
    power(base, exponent) {
        return pow(base, exponent);
    }
    
    squareRoot(n) {
        if (n < 0) {
            throw "错误：不能计算负数的平方根";
        }
        return sqrt(n);
    }
    
    factorial(n) {
        if (n < 0) {
            throw "错误：不能计算负数的阶乘";
        }
        if (n == 0 || n == 1) {
            return 1;
        }
        
        let result = 1;
        for (let i = 2; i <= n; i = i + 1) {
            result = result * i;
        }
        return result;
    }
    
    // 三角函数（角度）
    sinDeg(degrees) {
        return sin(degrees * PI / 180);
    }
    
    cosDeg(degrees) {
        return cos(degrees * PI / 180);
    }
    
    tanDeg(degrees) {
        return tan(degrees * PI / 180);
    }
    
    // 内存操作
    memoryStore(value) {
        this.memory = value;
        print("💾 已存储: " + value);
    }
    
    memoryRecall() {
        print("💾 内存值: " + this.memory);
        return this.memory;
    }
    
    memoryClear() {
        this.memory = 0;
        print("💾 内存已清空");
    }
    
    memoryAdd(value) {
        this.memory = this.memory + value;
        print("💾 内存增加: " + value + " (当前: " + this.memory + ")");
    }
    
    // 变量操作
    setVariable(name, value) {
        this.variables[name] = value;
        print("📌 变量 " + name + " = " + value);
    }
    
    getVariable(name) {
        if (this.variables[name] != null) {
            return this.variables[name];
        }
        throw "错误：未定义的变量 " + name;
    }
    
    // 表达式求值
    evaluate(expression) {
        try {
            // 这里简化处理，实际应该有完整的表达式解析器
            let result = this.parseExpression(expression);
            this.lastResult = result;
            this.history.add(expression, result);
            return result;
        } catch (error) {
            print("❌ " + error);
            return null;
        }
    }
    
    // 简单的表达式解析器
    parseExpression(expr) {
        // 处理特殊常量
        if (expr == "PI" || expr == "pi") {
            return PI;
        }
        if (expr == "E" || expr == "e") {
            return 2.71828;
        }
        if (expr == "ans" || expr == "ANS") {
            return this.lastResult;
        }
        
        // 处理变量
        if (this.variables[expr] != null) {
            return this.variables[expr];
        }
        
        // 尝试转换为数字
        let num = toNumber(expr);
        if (num != null) {
            return num;
        }
        
        throw "错误：无法解析表达式 '" + expr + "'";
    }
    
    // 执行运算
    performOperation(operation, operands) {
        if (operation == "+" && operands.length == 2) {
            return this.add(operands[0], operands[1]);
        } else if (operation == "-" && operands.length == 2) {
            return this.subtract(operands[0], operands[1]);
        } else if (operation == "*" && operands.length == 2) {
            return this.multiply(operands[0], operands[1]);
        } else if (operation == "/" && operands.length == 2) {
            return this.divide(operands[0], operands[1]);
        } else if (operation == "%" && operands.length == 2) {
            return this.modulo(operands[0], operands[1]);
        } else if (operation == "^" && operands.length == 2) {
            return this.power(operands[0], operands[1]);
        } else if (operation == "sqrt" && operands.length == 1) {
            return this.squareRoot(operands[0]);
        } else if (operation == "!" && operands.length == 1) {
            return this.factorial(floor(operands[0]));
        } else if (operation == "sin" && operands.length == 1) {
            return this.sinDeg(operands[0]);
        } else if (operation == "cos" && operands.length == 1) {
            return this.cosDeg(operands[0]);
        } else if (operation == "tan" && operands.length == 1) {
            return this.tanDeg(operands[0]);
        } else if (operation == "abs" && operands.length == 1) {
            return abs(operands[0]);
        } else if (operation == "floor" && operands.length == 1) {
            return floor(operands[0]);
        } else if (operation == "ceil" && operands.length == 1) {
            return ceil(operands[0]);
        } else if (operation == "round" && operands.length == 1) {
            return round(operands[0]);
        } else {
            throw "错误：未知的操作 '" + operation + "'";
        }
    }
}

// 辅助函数
function repeat(str, times) {
    let result = "";
    for (let i = 0; i < times; i = i + 1) {
        result = result + str;
    }
    return result;
}

function displayHelp() {
    print("\n📖 计算器帮助：");
    print("=" + repeat("=", 60));
    print("基本运算：");
    print("  输入: <数字1> <运算符> <数字2>");
    print("  运算符: + - * / % ^");
    print("  示例: 5 + 3, 10 * 2, 2 ^ 8");
    
    print("\n科学函数：");
    print("  sqrt <数字>     - 平方根");
    print("  <数字> !        - 阶乘");
    print("  sin <角度>      - 正弦");
    print("  cos <角度>      - 余弦");
    print("  tan <角度>      - 正切");
    print("  abs <数字>      - 绝对值");
    print("  floor <数字>    - 向下取整");
    print("  ceil <数字>     - 向上取整");
    print("  round <数字>    - 四舍五入");
    
    print("\n特殊常量：");
    print("  PI 或 pi        - 圆周率");
    print("  E 或 e          - 自然对数底");
    print("  ans 或 ANS      - 上一个结果");
    
    print("\n内存功能：");
    print("  MS              - 存储到内存");
    print("  MR              - 调用内存");
    print("  MC              - 清空内存");
    print("  M+              - 内存加");
    
    print("\n变量功能：");
    print("  <变量> = <值>   - 设置变量");
    print("  示例: x = 10, radius = 5");
    
    print("\n其他命令：");
    print("  history         - 查看历史");
    print("  clear           - 清空历史");
    print("  help            - 显示帮助");
    print("  exit            - 退出");
    print("=" + repeat("=", 60));
}

function displayWelcome() {
    print("🧮 ===== Evil Lang 科学计算器 =====");
    print("支持基本运算、科学函数、历史记录和变量存储");
    print("输入 'help' 查看帮助，'exit' 退出\n");
}

// 主程序
function main() {
    displayWelcome();
    
    let calc = new ScientificCalculator();
    let running = true;
    
    while (running) {
        let input_str = input("\n🧮 > ");
        
        if (input_str == "exit" || input_str == "quit") {
            print("👋 感谢使用计算器！");
            running = false;
            continue;
        }
        
        if (input_str == "help") {
            displayHelp();
            continue;
        }
        
        if (input_str == "history") {
            calc.history.display();
            continue;
        }
        
        if (input_str == "clear") {
            calc.history.clear();
            continue;
        }
        
        if (input_str == "MS" || input_str == "ms") {
            calc.memoryStore(calc.lastResult);
            continue;
        }
        
        if (input_str == "MR" || input_str == "mr") {
            let value = calc.memoryRecall();
            calc.lastResult = value;
            continue;
        }
        
        if (input_str == "MC" || input_str == "mc") {
            calc.memoryClear();
            continue;
        }
        
        if (input_str == "M+" || input_str == "m+") {
            calc.memoryAdd(calc.lastResult);
            continue;
        }
        
        // 解析输入
        let parts = split(input_str, " ");
        
        try {
            let result = null;
            
            // 检查是否是变量赋值
            if (parts.length == 3 && parts[1] == "=") {
                let varName = parts[0];
                let value = calc.parseExpression(parts[2]);
                calc.setVariable(varName, value);
                continue;
            }
            
            // 处理一元运算
            if (parts.length == 2) {
                let operation = parts[0];
                let operand = calc.parseExpression(parts[1]);
                result = calc.performOperation(operation, [operand]);
            }
            // 处理阶乘特殊语法
            else if (parts.length == 1 && endsWith(parts[0], "!")) {
                let num = calc.parseExpression(substring(parts[0], 0, parts[0].length - 1));
                result = calc.performOperation("!", [num]);
                calc.history.add(parts[0], result);
            }
            // 处理二元运算
            else if (parts.length == 3) {
                let operand1 = calc.parseExpression(parts[0]);
                let operation = parts[1];
                let operand2 = calc.parseExpression(parts[2]);
                result = calc.performOperation(operation, [operand1, operand2]);
                calc.history.add(input_str, result);
            }
            // 单个值或表达式
            else if (parts.length == 1) {
                result = calc.parseExpression(parts[0]);
                calc.history.add(parts[0], result);
            } else {
                print("❌ 无效的输入格式");
                continue;
            }
            
            if (result != null) {
                calc.lastResult = result;
                print("= " + result);
                
                // 特殊值提示
                if (result == floor(result) && result > 1000000) {
                    print("  (" + formatLargeNumber(result) + ")");
                }
            }
            
        } catch (error) {
            print("❌ " + error);
        }
    }
}

// 格式化大数字
function formatLargeNumber(num) {
    if (num >= 1000000000) {
        return round(num / 1000000000 * 100) / 100 + " 十亿";
    } else if (num >= 1000000) {
        return round(num / 1000000 * 100) / 100 + " 百万";
    } else if (num >= 1000) {
        return round(num / 1000 * 100) / 100 + " 千";
    }
    return toString(num);
}

// 字符串辅助函数
function split(str, delimiter) {
    let result = [];
    let current = "";
    
    for (let i = 0; i < str.length; i = i + 1) {
        if (charAt(str, i) == delimiter) {
            if (current != "") {
                push(result, current);
                current = "";
            }
        } else {
            current = current + charAt(str, i);
        }
    }
    
    if (current != "") {
        push(result, current);
    }
    
    return result;
}

function endsWith(str, suffix) {
    if (str.length < suffix.length) {
        return false;
    }
    return substring(str, str.length - suffix.length, str.length) == suffix;
}

function charAt(str, index) {
    return substring(str, index, index + 1);
}

// 启动计算器
main();