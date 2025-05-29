// Bank ATM Simulation - 银行ATM模拟系统
// 功能完整的ATM系统，支持多账户、转账、账单支付等

class Account {
    constructor(accountNumber, pin, ownerName, initialBalance = 0) {
        this.accountNumber = accountNumber;
        this.pin = pin;
        this.ownerName = ownerName;
        this.balance = initialBalance;
        this.transactions = [];
        this.dailyWithdrawLimit = 5000;
        this.dailyWithdrawn = 0;
        this.lastResetDate = getCurrentTime();
        this.locked = false;
        this.failedAttempts = 0;
    }
    
    verifyPin(inputPin) {
        if (this.locked) {
            return false;
        }
        
        if (inputPin == this.pin) {
            this.failedAttempts = 0;
            return true;
        } else {
            this.failedAttempts = this.failedAttempts + 1;
            if (this.failedAttempts >= 3) {
                this.locked = true;
                print("⚠️ 账户已被锁定！请联系银行客服。");
            }
            return false;
        }
    }
    
    deposit(amount) {
        if (amount <= 0) {
            return false;
        }
        
        this.balance = this.balance + amount;
        this.addTransaction("存款", amount, this.balance);
        return true;
    }
    
    withdraw(amount) {
        if (amount <= 0) {
            print("❌ 无效的金额");
            return false;
        }
        
        if (amount > this.balance) {
            print("❌ 余额不足");
            return false;
        }
        
        // 检查每日取款限额
        this.resetDailyLimit();
        if (this.dailyWithdrawn + amount > this.dailyWithdrawLimit) {
            print("❌ 超过每日取款限额 (￥" + this.dailyWithdrawLimit + ")");
            print("今日已取: ￥" + this.dailyWithdrawn);
            return false;
        }
        
        this.balance = this.balance - amount;
        this.dailyWithdrawn = this.dailyWithdrawn + amount;
        this.addTransaction("取款", -amount, this.balance);
        return true;
    }
    
    transfer(targetAccount, amount) {
        if (amount <= 0) {
            print("❌ 无效的金额");
            return false;
        }
        
        if (amount > this.balance) {
            print("❌ 余额不足");
            return false;
        }
        
        this.balance = this.balance - amount;
        targetAccount.balance = targetAccount.balance + amount;
        
        this.addTransaction("转出至 " + targetAccount.accountNumber, -amount, this.balance);
        targetAccount.addTransaction("转入自 " + this.accountNumber, amount, targetAccount.balance);
        
        return true;
    }
    
    addTransaction(type, amount, balance) {
        push(this.transactions, {
            type: type,
            amount: amount,
            balance: balance,
            timestamp: getCurrentTime()
        });
        
        // 保持最近50条记录
        if (this.transactions.length > 50) {
            shift(this.transactions);
        }
    }
    
    getRecentTransactions(count = 10) {
        let start = max(0, this.transactions.length - count);
        let recent = [];
        
        for (let i = start; i < this.transactions.length; i = i + 1) {
            push(recent, this.transactions[i]);
        }
        
        return recent;
    }
    
    resetDailyLimit() {
        // 简单模拟：每次运行重置
        // 实际应该基于日期
        if (getCurrentTime() - this.lastResetDate > 86400000) {
            this.dailyWithdrawn = 0;
            this.lastResetDate = getCurrentTime();
        }
    }
    
    changePin(oldPin, newPin) {
        if (oldPin != this.pin) {
            print("❌ 原密码错误");
            return false;
        }
        
        if (newPin.length != 4) {
            print("❌ 新密码必须是4位数字");
            return false;
        }
        
        this.pin = newPin;
        print("✅ 密码修改成功");
        return true;
    }
}

class ATMSystem {
    constructor() {
        this.accounts = {};
        this.currentAccount = null;
        this.sessionActive = false;
        
        // 初始化一些测试账户
        this.initializeTestAccounts();
    }
    
    initializeTestAccounts() {
        // 创建测试账户
        this.accounts["1234567890"] = new Account("1234567890", "1234", "张三", 10000);
        this.accounts["0987654321"] = new Account("0987654321", "5678", "李四", 5000);
        this.accounts["1111222233"] = new Account("1111222233", "1111", "王五", 20000);
        
        print("🏦 系统已初始化");
        print("测试账户：");
        print("  账号: 1234567890, 密码: 1234, 余额: ￥10000");
        print("  账号: 0987654321, 密码: 5678, 余额: ￥5000");
        print("  账号: 1111222233, 密码: 1111, 余额: ￥20000");
    }
    
    insertCard(accountNumber) {
        if (this.accounts[accountNumber] == null) {
            print("❌ 无效的账户");
            return false;
        }
        
        if (this.accounts[accountNumber].locked) {
            print("❌ 此账户已被锁定");
            return false;
        }
        
        this.currentAccount = this.accounts[accountNumber];
        return true;
    }
    
    login(pin) {
        if (this.currentAccount == null) {
            return false;
        }
        
        if (this.currentAccount.verifyPin(pin)) {
            this.sessionActive = true;
            print("✅ 登录成功");
            print("欢迎，" + this.currentAccount.ownerName + "！");
            return true;
        } else {
            print("❌ 密码错误");
            if (this.currentAccount.failedAttempts < 3) {
                print("剩余尝试次数: " + (3 - this.currentAccount.failedAttempts));
            }
            return false;
        }
    }
    
    logout() {
        this.currentAccount = null;
        this.sessionActive = false;
        print("👋 感谢使用，再见！");
    }
    
    checkBalance() {
        if (!this.sessionActive) return;
        
        print("\n💰 账户余额");
        print("=" + repeat("=", 40));
        print("账户: " + this.currentAccount.accountNumber);
        print("户主: " + this.currentAccount.ownerName);
        print("余额: ￥" + formatMoney(this.currentAccount.balance));
        print("=" + repeat("=", 40));
    }
    
    performDeposit() {
        if (!this.sessionActive) return;
        
        print("\n💵 存款");
        let amount = toNumber(input("请输入存款金额: ￥"));
        
        if (amount == null || amount <= 0) {
            print("❌ 无效的金额");
            return;
        }
        
        // 检查合理金额
        if (amount > 100000) {
            print("❌ 单笔存款不能超过10万元");
            return;
        }
        
        if (this.currentAccount.deposit(amount)) {
            print("✅ 存款成功！");
            print("存入金额: ￥" + formatMoney(amount));
            print("当前余额: ￥" + formatMoney(this.currentAccount.balance));
        }
    }
    
    performWithdraw() {
        if (!this.sessionActive) return;
        
        print("\n💸 取款");
        print("每日取款限额: ￥" + this.currentAccount.dailyWithdrawLimit);
        print("今日已取: ￥" + this.currentAccount.dailyWithdrawn);
        
        // 快速取款选项
        print("\n快速取款：");
        print("1. ￥100");
        print("2. ￥500");
        print("3. ￥1000");
        print("4. ￥2000");
        print("5. 其他金额");
        
        let choice = input("请选择 (1-5): ");
        let amount = 0;
        
        if (choice == "1") amount = 100;
        else if (choice == "2") amount = 500;
        else if (choice == "3") amount = 1000;
        else if (choice == "4") amount = 2000;
        else if (choice == "5") {
            amount = toNumber(input("请输入取款金额: ￥"));
            if (amount == null) {
                print("❌ 无效的金额");
                return;
            }
        } else {
            print("❌ 无效的选择");
            return;
        }
        
        if (this.currentAccount.withdraw(amount)) {
            print("✅ 取款成功！");
            print("取出金额: ￥" + formatMoney(amount));
            print("当前余额: ￥" + formatMoney(this.currentAccount.balance));
            print("\n💵 请取走您的现金");
        }
    }
    
    performTransfer() {
        if (!this.sessionActive) return;
        
        print("\n💱 转账");
        let targetAccountNumber = input("请输入收款账号: ");
        
        if (this.accounts[targetAccountNumber] == null) {
            print("❌ 收款账号不存在");
            return;
        }
        
        if (targetAccountNumber == this.currentAccount.accountNumber) {
            print("❌ 不能转账给自己");
            return;
        }
        
        let targetAccount = this.accounts[targetAccountNumber];
        print("收款人: " + targetAccount.ownerName);
        
        let confirm = input("确认收款人正确？(y/n): ");
        if (confirm != "y") {
            print("❌ 转账已取消");
            return;
        }
        
        let amount = toNumber(input("请输入转账金额: ￥"));
        if (amount == null || amount <= 0) {
            print("❌ 无效的金额");
            return;
        }
        
        if (this.currentAccount.transfer(targetAccount, amount)) {
            print("✅ 转账成功！");
            print("转账金额: ￥" + formatMoney(amount));
            print("收款人: " + targetAccount.ownerName);
            print("当前余额: ￥" + formatMoney(this.currentAccount.balance));
        }
    }
    
    showTransactions() {
        if (!this.sessionActive) return;
        
        print("\n📜 交易记录");
        print("=" + repeat("=", 60));
        
        let transactions = this.currentAccount.getRecentTransactions();
        
        if (transactions.length == 0) {
            print("暂无交易记录");
        } else {
            print("最近 " + transactions.length + " 笔交易：\n");
            
            for (let i = transactions.length - 1; i >= 0; i = i - 1) {
                let t = transactions[i];
                let amountStr = t.amount > 0 ? 
                    "+" + formatMoney(t.amount) : 
                    formatMoney(t.amount);
                    
                print(padRight(t.type, 20) + 
                      padLeft(amountStr, 15) + 
                      "  余额: " + formatMoney(t.balance));
            }
        }
        
        print("=" + repeat("=", 60));
    }
    
    changePin() {
        if (!this.sessionActive) return;
        
        print("\n🔐 修改密码");
        let oldPin = input("请输入原密码: ");
        let newPin = input("请输入新密码 (4位数字): ");
        let confirmPin = input("请再次输入新密码: ");
        
        if (newPin != confirmPin) {
            print("❌ 两次输入的密码不一致");
            return;
        }
        
        // 验证是否为4位数字
        if (newPin.length != 4 || toNumber(newPin) == null) {
            print("❌ 密码必须是4位数字");
            return;
        }
        
        this.currentAccount.changePin(oldPin, newPin);
    }
    
    payBill() {
        if (!this.sessionActive) return;
        
        print("\n📱 账单支付");
        print("1. 手机话费");
        print("2. 水电费");
        print("3. 信用卡还款");
        print("4. 返回");
        
        let choice = input("请选择 (1-4): ");
        
        if (choice == "4") return;
        
        let billType = "";
        let billAccount = "";
        let amount = 0;
        
        if (choice == "1") {
            billType = "手机话费";
            billAccount = input("请输入手机号: ");
            amount = toNumber(input("请输入充值金额: ￥"));
        } else if (choice == "2") {
            billType = "水电费";
            billAccount = input("请输入户号: ");
            amount = toNumber(input("请输入缴费金额: ￥"));
        } else if (choice == "3") {
            billType = "信用卡还款";
            billAccount = input("请输入信用卡号: ");
            amount = toNumber(input("请输入还款金额: ￥"));
        } else {
            print("❌ 无效的选择");
            return;
        }
        
        if (amount == null || amount <= 0) {
            print("❌ 无效的金额");
            return;
        }
        
        if (amount > this.currentAccount.balance) {
            print("❌ 余额不足");
            return;
        }
        
        // 执行支付
        this.currentAccount.balance = this.currentAccount.balance - amount;
        this.currentAccount.addTransaction(billType + " - " + billAccount, -amount, this.currentAccount.balance);
        
        print("✅ 支付成功！");
        print("支付类型: " + billType);
        print("账号: " + billAccount);
        print("金额: ￥" + formatMoney(amount));
        print("当前余额: ￥" + formatMoney(this.currentAccount.balance));
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

function formatMoney(amount) {
    // 简单的金额格式化
    let sign = amount < 0 ? "-" : "";
    let absAmount = abs(amount);
    let intPart = floor(absAmount);
    let decPart = round((absAmount - intPart) * 100);
    
    if (decPart < 10) {
        return sign + intPart + ".0" + decPart;
    } else {
        return sign + intPart + "." + decPart;
    }
}

function padRight(str, length) {
    while (str.length < length) {
        str = str + " ";
    }
    return str;
}

function padLeft(str, length) {
    while (str.length < length) {
        str = " " + str;
    }
    return str;
}

function max(a, b) {
    return a > b ? a : b;
}

function shift(array) {
    // 移除并返回数组第一个元素
    if (array.length == 0) return null;
    
    let first = array[0];
    for (let i = 0; i < array.length - 1; i = i + 1) {
        array[i] = array[i + 1];
    }
    array.length = array.length - 1;
    return first;
}

// 主程序
function main() {
    print("🏧 ===== Evil Lang 银行ATM系统 =====");
    print("欢迎使用我们的自助服务\n");
    
    let atm = new ATMSystem();
    let running = true;
    
    while (running) {
        if (!atm.sessionActive) {
            // 未登录界面
            print("\n🏧 请插入银行卡");
            print("1. 插入银行卡");
            print("2. 退出");
            
            let choice = input("\n请选择 (1-2): ");
            
            if (choice == "1") {
                let accountNumber = input("请输入账号: ");
                
                if (atm.insertCard(accountNumber)) {
                    let attempts = 0;
                    let loggedIn = false;
                    
                    while (attempts < 3 && !loggedIn) {
                        let pin = input("请输入密码: ");
                        loggedIn = atm.login(pin);
                        attempts = attempts + 1;
                    }
                    
                    if (!loggedIn) {
                        atm.currentAccount = null;
                    }
                }
                
            } else if (choice == "2") {
                print("\n👋 感谢您的使用，再见！");
                running = false;
            }
            
        } else {
            // 已登录界面
            print("\n📋 主菜单");
            print("1. 查询余额");
            print("2. 存款");
            print("3. 取款");
            print("4. 转账");
            print("5. 查看交易记录");
            print("6. 修改密码");
            print("7. 账单支付");
            print("8. 退出");
            
            let choice = input("\n请选择服务 (1-8): ");
            
            if (choice == "1") {
                atm.checkBalance();
                
            } else if (choice == "2") {
                atm.performDeposit();
                
            } else if (choice == "3") {
                atm.performWithdraw();
                
            } else if (choice == "4") {
                atm.performTransfer();
                
            } else if (choice == "5") {
                atm.showTransactions();
                
            } else if (choice == "6") {
                atm.changePin();
                
            } else if (choice == "7") {
                atm.payBill();
                
            } else if (choice == "8") {
                atm.logout();
                
            } else {
                print("❌ 无效的选择");
            }
        }
    }
}

// 启动ATM系统
main();