// Exception Handling with Classes
// 异常处理与类的结合

// BankAccount class with exception handling
// 带异常处理的银行账户类
class BankAccount {
    constructor(initialBalance) {
        if (initialBalance < 0) {
            throw "Initial balance cannot be negative!";
        }
        this.balance = initialBalance;
        this.transactions = [];
    }
    
    deposit(amount) {
        try {
            if (amount <= 0) {
                throw "Deposit amount must be positive!";
            }
            this.balance = this.balance + amount;
            this.transactions[this.transactions.length] = "Deposit: " + amount;
            return this.balance;
        } catch (e) {
            print("Deposit error: " + e);
            return null;
        }
    }
    
    withdraw(amount) {
        if (amount <= 0) {
            throw "Withdrawal amount must be positive!";
        }
        if (amount > this.balance) {
            throw "Insufficient funds! Current balance: " + this.balance;
        }
        this.balance = this.balance - amount;
        this.transactions[this.transactions.length] = "Withdrawal: " + amount;
        return this.balance;
    }
    
    getBalance() {
        return this.balance;
    }
    
    printTransactions() {
        print("Transaction History:");
        for (var i = 0; i < this.transactions.length; i = i + 1) {
            print("  " + this.transactions[i]);
        }
    }
}

// Test the BankAccount class
print("=== Banking System with Exception Handling ===");

// Test creating account with negative balance
try {
    var badAccount = new BankAccount(-100);
} catch (e) {
    print("Failed to create account: " + e);
}

// Create a valid account
var account = new BankAccount(1000);
print("Account created with balance: " + account.getBalance());

// Test deposits
account.deposit(500);
account.deposit(-100);  // This will be caught internally
print("Balance after deposits: " + account.getBalance());

// Test withdrawals with exception handling
try {
    account.withdraw(200);
    print("Withdrawal successful. New balance: " + account.getBalance());
    
    // Try to withdraw too much
    account.withdraw(2000);
} catch (e) {
    print("Withdrawal failed: " + e);
}

// Show final state
print("\nFinal balance: " + account.getBalance());
account.printTransactions();