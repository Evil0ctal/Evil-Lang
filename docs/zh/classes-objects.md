# 类和对象

Evil Lang 支持面向对象编程，包括类、对象、继承和方法。

## 定义类

使用 `class` 关键字定义类：

```evil
class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    greet() {
        print("你好，我是" + this.name);
    }
}

// 创建实例
let person = new Person("小明", 25);
person.greet();  // 输出：你好，我是小明
```

## 构造函数

`constructor` 方法在创建新实例时被调用：

```evil
class Rectangle {
    constructor(width, height) {
        this.width = width;
        this.height = height;
    }
    
    area() {
        return this.width * this.height;
    }
}

let rect = new Rectangle(5, 3);
print("面积：" + rect.area());  // 输出：面积：15
```

## 实例属性

使用点号访问和修改实例属性：

```evil
class Car {
    constructor(brand, model) {
        this.brand = brand;
        this.model = model;
        this.speed = 0;
    }
    
    accelerate(amount) {
        this.speed = this.speed + amount;
        print(this.brand + " 速度：" + this.speed);
    }
}

let car = new Car("丰田", "凯美瑞");
car.accelerate(50);  // 输出：丰田 速度：50
car.accelerate(30);  // 输出：丰田 速度：80
```

## 方法

方法是定义在类中的函数：

```evil
class Calculator {
    constructor() {
        this.result = 0;
    }
    
    add(value) {
        this.result = this.result + value;
        return this;  // 返回 this 用于链式调用
    }
    
    multiply(value) {
        this.result = this.result * value;
        return this;
    }
    
    getResult() {
        return this.result;
    }
}

let calc = new Calculator();
let result = calc.add(5).multiply(3).add(2).getResult();
print("结果：" + result);  // 输出：结果：17
```

## 继承

使用 `extends` 关键字创建子类：

```evil
class Animal {
    constructor(name) {
        this.name = name;
    }
    
    speak() {
        print(this.name + " 发出声音");
    }
}

class Dog extends Animal {
    constructor(name, breed) {
        super(name);  // 调用父类构造函数
        this.breed = breed;
    }
    
    speak() {
        print(this.name + " 汪汪叫！");
    }
    
    wagTail() {
        print(this.name + " 摇尾巴");
    }
}

let dog = new Dog("旺财", "金毛");
dog.speak();     // 输出：旺财 汪汪叫！
dog.wagTail();   // 输出：旺财 摇尾巴
```

## Super 关键字

使用 `super` 调用父类方法：

```evil
class Shape {
    constructor(color) {
        this.color = color;
    }
    
    describe() {
        return "一个" + this.color + "的形状";
    }
}

class Circle extends Shape {
    constructor(color, radius) {
        super(color);
        this.radius = radius;
    }
    
    describe() {
        return super.describe() + "（半径为" + this.radius + "的圆形）";
    }
    
    area() {
        return 3.14159 * this.radius * this.radius;
    }
}

let circle = new Circle("红色", 5);
print(circle.describe());  // 输出：一个红色的形状（半径为5的圆形）
print("面积：" + circle.area());  // 输出：面积：78.53975
```

## 静态方法

定义属于类本身的方法：

```evil
class MathUtils {
    static add(a, b) {
        return a + b;
    }
    
    static multiply(a, b) {
        return a * b;
    }
}

// 无需创建实例即可调用静态方法
print(MathUtils.add(5, 3));       // 输出：8
print(MathUtils.multiply(4, 7));  // 输出：28
```

## Getter 和 Setter

创建计算属性：

```evil
class Temperature {
    constructor(celsius) {
        this._celsius = celsius;
    }
    
    getCelsius() {
        return this._celsius;
    }
    
    setCelsius(value) {
        this._celsius = value;
    }
    
    getFahrenheit() {
        return (this._celsius * 9/5) + 32;
    }
    
    setFahrenheit(value) {
        this._celsius = (value - 32) * 5/9;
    }
}

let temp = new Temperature(25);
print("摄氏：" + temp.getCelsius());      // 输出：摄氏：25
print("华氏：" + temp.getFahrenheit());   // 输出：华氏：77
```

## 组合

组合对象创建更复杂的功能：

```evil
class Engine {
    constructor(horsepower) {
        this.horsepower = horsepower;
        this.running = false;
    }
    
    start() {
        this.running = true;
        print("引擎启动");
    }
    
    stop() {
        this.running = false;
        print("引擎停止");
    }
}

class Car {
    constructor(brand, engine) {
        this.brand = brand;
        this.engine = engine;
    }
    
    start() {
        print("启动 " + this.brand);
        this.engine.start();
    }
    
    stop() {
        print("停止 " + this.brand);
        this.engine.stop();
    }
}

let engine = new Engine(200);
let car = new Car("本田", engine);
car.start();  // 输出：启动 本田 \n 引擎启动
```

## 实际示例

### 银行账户系统

```evil
class BankAccount {
    constructor(owner, initialBalance = 0) {
        this.owner = owner;
        this.balance = initialBalance;
        this.transactions = [];
    }
    
    deposit(amount) {
        if (amount <= 0) {
            print("无效的存款金额");
            return false;
        }
        
        this.balance = this.balance + amount;
        push(this.transactions, {
            type: "存款",
            amount: amount,
            balance: this.balance
        });
        print("存入：¥" + amount);
        return true;
    }
    
    withdraw(amount) {
        if (amount <= 0) {
            print("无效的取款金额");
            return false;
        }
        
        if (amount > this.balance) {
            print("余额不足");
            return false;
        }
        
        this.balance = this.balance - amount;
        push(this.transactions, {
            type: "取款",
            amount: amount,
            balance: this.balance
        });
        print("取出：¥" + amount);
        return true;
    }
    
    getBalance() {
        return this.balance;
    }
    
    printStatement() {
        print("\n=== 银行对账单 ===");
        print("账户持有人：" + this.owner);
        print("当前余额：¥" + this.balance);
        print("\n交易记录：");
        
        for (let i = 0; i < this.transactions.length; i = i + 1) {
            let t = this.transactions[i];
            print("  " + t.type + "：¥" + t.amount + " （余额：¥" + t.balance + "）");
        }
    }
}

// 使用
let account = new BankAccount("张三", 100);
account.deposit(50);
account.withdraw(30);
account.deposit(100);
account.printStatement();
```

### 游戏角色系统

```evil
class Character {
    constructor(name, health, damage) {
        this.name = name;
        this.health = health;
        this.maxHealth = health;
        this.damage = damage;
        this.alive = true;
    }
    
    attack(target) {
        if (!this.alive) {
            print(this.name + " 无法攻击（已死亡）");
            return;
        }
        
        print(this.name + " 攻击 " + target.name + " 造成 " + this.damage + " 点伤害");
        target.takeDamage(this.damage);
    }
    
    takeDamage(amount) {
        if (!this.alive) return;
        
        this.health = this.health - amount;
        print(this.name + " 受到 " + amount + " 点伤害（生命值：" + this.health + "/" + this.maxHealth + "）");
        
        if (this.health <= 0) {
            this.health = 0;
            this.alive = false;
            print(this.name + " 已被击败！");
        }
    }
    
    heal(amount) {
        if (!this.alive) {
            print(this.name + " 无法治疗（已死亡）");
            return;
        }
        
        this.health = min(this.health + amount, this.maxHealth);
        print(this.name + " 恢复 " + amount + " 点生命值（生命值：" + this.health + "/" + this.maxHealth + "）");
    }
}

class Warrior extends Character {
    constructor(name) {
        super(name, 150, 25);
        this.armor = 10;
    }
    
    takeDamage(amount) {
        let reducedDamage = max(amount - this.armor, 0);
        print(this.name + " 的护甲减少了 " + (amount - reducedDamage) + " 点伤害");
        super.takeDamage(reducedDamage);
    }
    
    berserkerRage() {
        if (!this.alive) return;
        
        print(this.name + " 进入狂暴状态！");
        this.damage = this.damage * 2;
        this.armor = 0;
    }
}

// 战斗模拟
let hero = new Warrior("勇士");
let monster = new Character("哥布林", 80, 15);

hero.attack(monster);
monster.attack(hero);
hero.berserkerRage();
hero.attack(monster);
hero.attack(monster);
```

### 图形系统

```evil
class Point {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
    
    distanceTo(other) {
        let dx = this.x - other.x;
        let dy = this.y - other.y;
        return sqrt(dx * dx + dy * dy);
    }
}

class Shape {
    constructor(position, color) {
        this.position = position;
        this.color = color;
    }
    
    move(dx, dy) {
        this.position.x = this.position.x + dx;
        this.position.y = this.position.y + dy;
    }
}

class Circle extends Shape {
    constructor(position, color, radius) {
        super(position, color);
        this.radius = radius;
    }
    
    area() {
        return 3.14159 * this.radius * this.radius;
    }
    
    contains(point) {
        return this.position.distanceTo(point) <= this.radius;
    }
}

class Rectangle extends Shape {
    constructor(position, color, width, height) {
        super(position, color);
        this.width = width;
        this.height = height;
    }
    
    area() {
        return this.width * this.height;
    }
    
    contains(point) {
        return point.x >= this.position.x && 
               point.x <= this.position.x + this.width &&
               point.y >= this.position.y && 
               point.y <= this.position.y + this.height;
    }
}

// 使用
let circle = new Circle(new Point(100, 100), "红色", 50);
let rect = new Rectangle(new Point(200, 200), "蓝色", 80, 60);

print("圆形面积：" + circle.area());
print("矩形面积：" + rect.area());

let testPoint = new Point(120, 120);
print("点在圆形内：" + circle.contains(testPoint));
print("点在矩形内：" + rect.contains(testPoint));
```

## 最佳实践

1. **封装**：保持内部细节私有，只暴露必要的方法
2. **单一职责**：每个类应该有一个明确的目的
3. **优先组合**：在可能的情况下使用组合而不是继承
4. **有意义的名称**：为类和方法使用清晰、描述性的名称
5. **初始化属性**：始终在构造函数中初始化属性

## 下一步

- 学习[模块](modules.md)将类组织成库
- 探索[异常处理](exception-handling.md)进行错误管理
- 学习[内置函数](../reference/builtin-functions.md)了解实用方法