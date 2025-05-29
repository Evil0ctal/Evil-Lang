// Password Generator - 密码生成器
// 功能强大的密码生成器，支持多种选项和密码强度分析

class PasswordGenerator {
    constructor() {
        this.lowercase = "abcdefghijklmnopqrstuvwxyz";
        this.uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        this.numbers = "0123456789";
        this.symbols = "!@#$%^&*()_+-=[]{}|;:,.<>?";
        this.similarChars = "il1Lo0O";
        
        // 默认设置
        this.settings = {
            length: 12,
            useLowercase: true,
            useUppercase: true,
            useNumbers: true,
            useSymbols: false,
            excludeSimilar: false,
            minNumbers: 1,
            minSymbols: 0
        };
        
        this.history = [];
    }
    
    generate() {
        // 构建字符池
        let charPool = "";
        
        if (this.settings.useLowercase) {
            charPool = charPool + this.lowercase;
        }
        if (this.settings.useUppercase) {
            charPool = charPool + this.uppercase;
        }
        if (this.settings.useNumbers) {
            charPool = charPool + this.numbers;
        }
        if (this.settings.useSymbols) {
            charPool = charPool + this.symbols;
        }
        
        if (charPool == "") {
            print("❌ 错误：至少选择一种字符类型");
            return null;
        }
        
        // 排除相似字符
        if (this.settings.excludeSimilar) {
            let newPool = "";
            for (let i = 0; i < charPool.length; i = i + 1) {
                let char = charAt(charPool, i);
                if (!contains(this.similarChars, char)) {
                    newPool = newPool + char;
                }
            }
            charPool = newPool;
        }
        
        // 生成密码
        let password = "";
        let attempts = 0;
        
        while (attempts < 100) {
            password = this.generatePassword(charPool);
            
            if (this.validatePassword(password)) {
                push(this.history, {
                    password: password,
                    strength: this.analyzeStrength(password),
                    timestamp: getCurrentTime()
                });
                
                return password;
            }
            
            attempts = attempts + 1;
        }
        
        print("⚠️ 无法生成满足要求的密码，请调整设置");
        return null;
    }
    
    generatePassword(charPool) {
        let password = "";
        
        // 确保满足最小要求
        if (this.settings.minNumbers > 0 && this.settings.useNumbers) {
            for (let i = 0; i < this.settings.minNumbers; i = i + 1) {
                password = password + charAt(this.numbers, floor(random() * this.numbers.length));
            }
        }
        
        if (this.settings.minSymbols > 0 && this.settings.useSymbols) {
            for (let i = 0; i < this.settings.minSymbols; i = i + 1) {
                password = password + charAt(this.symbols, floor(random() * this.symbols.length));
            }
        }
        
        // 填充剩余字符
        let remaining = this.settings.length - password.length;
        for (let i = 0; i < remaining; i = i + 1) {
            password = password + charAt(charPool, floor(random() * charPool.length));
        }
        
        // 打乱密码
        return this.shuffleString(password);
    }
    
    shuffleString(str) {
        let chars = [];
        for (let i = 0; i < str.length; i = i + 1) {
            push(chars, charAt(str, i));
        }
        
        // Fisher-Yates 洗牌算法
        for (let i = chars.length - 1; i > 0; i = i - 1) {
            let j = floor(random() * (i + 1));
            let temp = chars[i];
            chars[i] = chars[j];
            chars[j] = temp;
        }
        
        let result = "";
        for (let i = 0; i < chars.length; i = i + 1) {
            result = result + chars[i];
        }
        
        return result;
    }
    
    validatePassword(password) {
        if (password.length != this.settings.length) {
            return false;
        }
        
        let numCount = 0;
        let symbolCount = 0;
        let hasLower = false;
        let hasUpper = false;
        
        for (let i = 0; i < password.length; i = i + 1) {
            let char = charAt(password, i);
            
            if (contains(this.numbers, char)) {
                numCount = numCount + 1;
            }
            if (contains(this.symbols, char)) {
                symbolCount = symbolCount + 1;
            }
            if (contains(this.lowercase, char)) {
                hasLower = true;
            }
            if (contains(this.uppercase, char)) {
                hasUpper = true;
            }
        }
        
        // 检查最小要求
        if (numCount < this.settings.minNumbers) return false;
        if (symbolCount < this.settings.minSymbols) return false;
        
        // 检查字符类型要求
        if (this.settings.useLowercase && !hasLower) return false;
        if (this.settings.useUppercase && !hasUpper) return false;
        if (this.settings.useNumbers && numCount == 0) return false;
        if (this.settings.useSymbols && symbolCount == 0) return false;
        
        return true;
    }
    
    analyzeStrength(password) {
        let score = 0;
        let feedback = [];
        
        // 长度分数
        if (password.length >= 8) score = score + 10;
        if (password.length >= 12) score = score + 10;
        if (password.length >= 16) score = score + 10;
        
        // 字符多样性
        let hasLower = false;
        let hasUpper = false;
        let hasNumber = false;
        let hasSymbol = false;
        
        for (let i = 0; i < password.length; i = i + 1) {
            let char = charAt(password, i);
            if (contains(this.lowercase, char)) hasLower = true;
            if (contains(this.uppercase, char)) hasUpper = true;
            if (contains(this.numbers, char)) hasNumber = true;
            if (contains(this.symbols, char)) hasSymbol = true;
        }
        
        if (hasLower) score = score + 10;
        if (hasUpper) score = score + 10;
        if (hasNumber) score = score + 10;
        if (hasSymbol) score = score + 20;
        
        // 模式检查
        if (!this.hasRepeatingChars(password)) score = score + 10;
        if (!this.hasSequentialChars(password)) score = score + 10;
        
        // 确定强度等级
        let strength = "";
        if (score >= 80) {
            strength = "非常强";
        } else if (score >= 60) {
            strength = "强";
        } else if (score >= 40) {
            strength = "中等";
        } else if (score >= 20) {
            strength = "弱";
        } else {
            strength = "非常弱";
        }
        
        return {
            score: score,
            strength: strength,
            hasLower: hasLower,
            hasUpper: hasUpper,
            hasNumber: hasNumber,
            hasSymbol: hasSymbol
        };
    }
    
    hasRepeatingChars(password) {
        for (let i = 0; i < password.length - 2; i = i + 1) {
            if (charAt(password, i) == charAt(password, i + 1) &&
                charAt(password, i) == charAt(password, i + 2)) {
                return true;
            }
        }
        return false;
    }
    
    hasSequentialChars(password) {
        let sequences = ["abc", "bcd", "cde", "def", "efg", "fgh", "ghi", "hij", 
                        "ijk", "jkl", "klm", "lmn", "mno", "nop", "opq", "pqr",
                        "qrs", "rst", "stu", "tuv", "uvw", "vwx", "wxy", "xyz",
                        "012", "123", "234", "345", "456", "567", "678", "789"];
        
        let lowerPass = toLower(password);
        for (let i = 0; i < sequences.length; i = i + 1) {
            if (contains(lowerPass, sequences[i])) {
                return true;
            }
        }
        
        return false;
    }
    
    generateMultiple(count) {
        let passwords = [];
        
        print("\n🔐 生成 " + count + " 个密码：");
        print("=" + repeat("=", 60));
        
        for (let i = 0; i < count; i = i + 1) {
            let password = this.generate();
            if (password != null) {
                push(passwords, password);
                let strength = this.analyzeStrength(password);
                print((i + 1) + ". " + password + " [" + strength.strength + "]");
            }
        }
        
        print("=" + repeat("=", 60));
        return passwords;
    }
    
    displaySettings() {
        print("\n⚙️ 当前设置：");
        print("密码长度: " + this.settings.length);
        print("包含小写字母: " + (this.settings.useLowercase ? "是" : "否"));
        print("包含大写字母: " + (this.settings.useUppercase ? "是" : "否"));
        print("包含数字: " + (this.settings.useNumbers ? "是" : "否"));
        print("包含符号: " + (this.settings.useSymbols ? "是" : "否"));
        print("排除相似字符: " + (this.settings.excludeSimilar ? "是" : "否"));
        print("最少数字: " + this.settings.minNumbers);
        print("最少符号: " + this.settings.minSymbols);
    }
    
    displayHistory() {
        if (this.history.length == 0) {
            print("📜 历史记录为空");
            return;
        }
        
        print("\n📜 密码生成历史：");
        print("=" + repeat("=", 60));
        
        for (let i = this.history.length - 1; i >= 0 && i >= this.history.length - 10; i = i - 1) {
            let entry = this.history[i];
            print((this.history.length - i) + ". " + entry.password + 
                  " [" + entry.strength.strength + " - " + entry.strength.score + "分]");
        }
        
        print("=" + repeat("=", 60));
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

function charAt(str, index) {
    return substring(str, index, index + 1);
}

function contains(str, search) {
    return indexOf(str, search) >= 0;
}

// 密码提示生成器
class PasswordTips {
    constructor() {
        this.tips = [
            "使用密码管理器存储密码",
            "为每个账户使用不同的密码",
            "定期更新重要账户的密码",
            "避免使用个人信息作为密码",
            "启用双因素认证增强安全性",
            "不要在公共场合输入密码",
            "避免使用常见密码如123456",
            "密码越长越安全",
            "混合使用不同类型的字符",
            "避免使用字典中的单词"
        ];
    }
    
    getRandomTip() {
        return this.tips[floor(random() * this.tips.length)];
    }
}

// 主程序
function main() {
    print("🔐 ===== Evil Lang 密码生成器 =====");
    print("生成安全、随机的密码保护您的账户\n");
    
    let generator = new PasswordGenerator();
    let tips = new PasswordTips();
    let running = true;
    
    // 显示初始提示
    print("💡 提示: " + tips.getRandomTip());
    
    while (running) {
        print("\n📋 主菜单：");
        print("1. 生成单个密码");
        print("2. 批量生成密码");
        print("3. 修改设置");
        print("4. 分析密码强度");
        print("5. 查看历史记录");
        print("6. 安全提示");
        print("7. 退出");
        
        let choice = input("\n选择操作 (1-7): ");
        
        if (choice == "1") {
            let password = generator.generate();
            if (password != null) {
                let strength = generator.analyzeStrength(password);
                
                print("\n🎉 生成的密码：");
                print("=" + repeat("=", 40));
                print("密码: " + password);
                print("长度: " + password.length);
                print("强度: " + strength.strength + " (" + strength.score + "/100)");
                
                print("\n包含：");
                if (strength.hasLower) print("  ✓ 小写字母");
                if (strength.hasUpper) print("  ✓ 大写字母");
                if (strength.hasNumber) print("  ✓ 数字");
                if (strength.hasSymbol) print("  ✓ 特殊符号");
                print("=" + repeat("=", 40));
                
                let save = input("\n保存此密码的用途？(直接回车跳过): ");
                if (save != "") {
                    print("💾 已记录密码用途: " + save);
                }
            }
            
        } else if (choice == "2") {
            let count = toNumber(input("生成多少个密码？(1-20): "));
            if (count != null && count >= 1 && count <= 20) {
                generator.generateMultiple(count);
            } else {
                print("❌ 无效的数量");
            }
            
        } else if (choice == "3") {
            let editing = true;
            while (editing) {
                generator.displaySettings();
                
                print("\n修改选项：");
                print("1. 密码长度");
                print("2. 切换小写字母");
                print("3. 切换大写字母");
                print("4. 切换数字");
                print("5. 切换符号");
                print("6. 切换排除相似字符");
                print("7. 设置最少数字");
                print("8. 设置最少符号");
                print("9. 返回主菜单");
                
                let settingChoice = input("\n选择要修改的设置 (1-9): ");
                
                if (settingChoice == "1") {
                    let length = toNumber(input("新的密码长度 (4-128): "));
                    if (length != null && length >= 4 && length <= 128) {
                        generator.settings.length = length;
                        print("✅ 密码长度设置为: " + length);
                    } else {
                        print("❌ 无效的长度");
                    }
                    
                } else if (settingChoice == "2") {
                    generator.settings.useLowercase = !generator.settings.useLowercase;
                    print("✅ 小写字母: " + (generator.settings.useLowercase ? "启用" : "禁用"));
                    
                } else if (settingChoice == "3") {
                    generator.settings.useUppercase = !generator.settings.useUppercase;
                    print("✅ 大写字母: " + (generator.settings.useUppercase ? "启用" : "禁用"));
                    
                } else if (settingChoice == "4") {
                    generator.settings.useNumbers = !generator.settings.useNumbers;
                    print("✅ 数字: " + (generator.settings.useNumbers ? "启用" : "禁用"));
                    
                } else if (settingChoice == "5") {
                    generator.settings.useSymbols = !generator.settings.useSymbols;
                    print("✅ 符号: " + (generator.settings.useSymbols ? "启用" : "禁用"));
                    
                } else if (settingChoice == "6") {
                    generator.settings.excludeSimilar = !generator.settings.excludeSimilar;
                    print("✅ 排除相似字符: " + (generator.settings.excludeSimilar ? "启用" : "禁用"));
                    
                } else if (settingChoice == "7") {
                    let min = toNumber(input("最少数字个数: "));
                    if (min != null && min >= 0) {
                        generator.settings.minNumbers = min;
                        print("✅ 设置成功");
                    }
                    
                } else if (settingChoice == "8") {
                    let min = toNumber(input("最少符号个数: "));
                    if (min != null && min >= 0) {
                        generator.settings.minSymbols = min;
                        print("✅ 设置成功");
                    }
                    
                } else if (settingChoice == "9") {
                    editing = false;
                }
            }
            
        } else if (choice == "4") {
            let password = input("输入要分析的密码: ");
            if (password != "") {
                let strength = generator.analyzeStrength(password);
                
                print("\n📊 密码分析结果：");
                print("=" + repeat("=", 40));
                print("密码: " + repeat("*", password.length) + " (已隐藏)");
                print("长度: " + password.length);
                print("强度: " + strength.strength);
                print("得分: " + strength.score + "/100");
                
                print("\n详细分析：");
                print("包含小写字母: " + (strength.hasLower ? "✓" : "✗"));
                print("包含大写字母: " + (strength.hasUpper ? "✓" : "✗"));
                print("包含数字: " + (strength.hasNumber ? "✓" : "✗"));
                print("包含特殊符号: " + (strength.hasSymbol ? "✓" : "✗"));
                
                if (generator.hasRepeatingChars(password)) {
                    print("⚠️ 包含重复字符");
                }
                if (generator.hasSequentialChars(password)) {
                    print("⚠️ 包含连续字符");
                }
                
                print("=" + repeat("=", 40));
                
                if (strength.score < 60) {
                    print("\n建议：");
                    if (!strength.hasSymbol) print("- 添加特殊符号");
                    if (password.length < 12) print("- 增加密码长度");
                    if (!strength.hasUpper || !strength.hasLower) print("- 混合大小写");
                    if (!strength.hasNumber) print("- 添加数字");
                }
            }
            
        } else if (choice == "5") {
            generator.displayHistory();
            
        } else if (choice == "6") {
            print("\n🛡️ 密码安全提示：");
            print("=" + repeat("=", 50));
            for (let i = 0; i < 5; i = i + 1) {
                print("• " + tips.getRandomTip());
            }
            print("=" + repeat("=", 50));
            
        } else if (choice == "7") {
            print("\n👋 感谢使用密码生成器！");
            print("💡 记住：" + tips.getRandomTip());
            running = false;
            
        } else {
            print("❌ 无效的选择");
        }
    }
}

// 启动程序
main();