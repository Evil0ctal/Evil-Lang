# Classes and Objects

Evil Lang supports object-oriented programming with classes, objects, inheritance, and methods.

## Defining Classes

Use the `class` keyword to define a class:

```evil
class Person {
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    greet() {
        print("Hello, I'm " + this.name);
    }
}

// Create an instance
let person = new Person("Alice", 25);
person.greet();  // Output: Hello, I'm Alice
```

## Constructor

The `constructor` method is called when creating a new instance:

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
print("Area: " + rect.area());  // Output: Area: 15
```

## Instance Properties

Access and modify instance properties using dot notation:

```evil
class Car {
    constructor(brand, model) {
        this.brand = brand;
        this.model = model;
        this.speed = 0;
    }
    
    accelerate(amount) {
        this.speed = this.speed + amount;
        print(this.brand + " speed: " + this.speed);
    }
}

let car = new Car("Toyota", "Camry");
car.accelerate(50);  // Output: Toyota speed: 50
car.accelerate(30);  // Output: Toyota speed: 80
```

## Methods

Methods are functions defined inside a class:

```evil
class Calculator {
    constructor() {
        this.result = 0;
    }
    
    add(value) {
        this.result = this.result + value;
        return this;  // Return this for chaining
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
print("Result: " + result);  // Output: Result: 17
```

## Inheritance

Use the `extends` keyword to create a subclass:

```evil
class Animal {
    constructor(name) {
        this.name = name;
    }
    
    speak() {
        print(this.name + " makes a sound");
    }
}

class Dog extends Animal {
    constructor(name, breed) {
        super(name);  // Call parent constructor
        this.breed = breed;
    }
    
    speak() {
        print(this.name + " barks!");
    }
    
    wagTail() {
        print(this.name + " wags tail");
    }
}

let dog = new Dog("Buddy", "Golden Retriever");
dog.speak();     // Output: Buddy barks!
dog.wagTail();   // Output: Buddy wags tail
```

## Super Keyword

Use `super` to call parent class methods:

```evil
class Shape {
    constructor(color) {
        this.color = color;
    }
    
    describe() {
        return "A " + this.color + " shape";
    }
}

class Circle extends Shape {
    constructor(color, radius) {
        super(color);
        this.radius = radius;
    }
    
    describe() {
        return super.describe() + " (circle with radius " + this.radius + ")";
    }
    
    area() {
        return 3.14159 * this.radius * this.radius;
    }
}

let circle = new Circle("red", 5);
print(circle.describe());  // Output: A red shape (circle with radius 5)
print("Area: " + circle.area());  // Output: Area: 78.53975
```

## Static Methods

Define methods that belong to the class itself:

```evil
class MathUtils {
    static add(a, b) {
        return a + b;
    }
    
    static multiply(a, b) {
        return a * b;
    }
}

// Call static methods without creating an instance
print(MathUtils.add(5, 3));       // Output: 8
print(MathUtils.multiply(4, 7));  // Output: 28
```

## Getters and Setters

Create computed properties:

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
print("Celsius: " + temp.getCelsius());      // Output: Celsius: 25
print("Fahrenheit: " + temp.getFahrenheit()); // Output: Fahrenheit: 77
```

## Composition

Combine objects to create more complex functionality:

```evil
class Engine {
    constructor(horsepower) {
        this.horsepower = horsepower;
        this.running = false;
    }
    
    start() {
        this.running = true;
        print("Engine started");
    }
    
    stop() {
        this.running = false;
        print("Engine stopped");
    }
}

class Car {
    constructor(brand, engine) {
        this.brand = brand;
        this.engine = engine;
    }
    
    start() {
        print("Starting " + this.brand);
        this.engine.start();
    }
    
    stop() {
        print("Stopping " + this.brand);
        this.engine.stop();
    }
}

let engine = new Engine(200);
let car = new Car("Honda", engine);
car.start();  // Output: Starting Honda \n Engine started
```

## Practical Examples

### Bank Account System

```evil
class BankAccount {
    constructor(owner, initialBalance = 0) {
        this.owner = owner;
        this.balance = initialBalance;
        this.transactions = [];
    }
    
    deposit(amount) {
        if (amount <= 0) {
            print("Invalid deposit amount");
            return false;
        }
        
        this.balance = this.balance + amount;
        push(this.transactions, {
            type: "deposit",
            amount: amount,
            balance: this.balance
        });
        print("Deposited: $" + amount);
        return true;
    }
    
    withdraw(amount) {
        if (amount <= 0) {
            print("Invalid withdrawal amount");
            return false;
        }
        
        if (amount > this.balance) {
            print("Insufficient funds");
            return false;
        }
        
        this.balance = this.balance - amount;
        push(this.transactions, {
            type: "withdrawal",
            amount: amount,
            balance: this.balance
        });
        print("Withdrew: $" + amount);
        return true;
    }
    
    getBalance() {
        return this.balance;
    }
    
    printStatement() {
        print("\n=== Bank Statement ===");
        print("Owner: " + this.owner);
        print("Current Balance: $" + this.balance);
        print("\nTransactions:");
        
        for (let i = 0; i < this.transactions.length; i = i + 1) {
            let t = this.transactions[i];
            print("  " + t.type + ": $" + t.amount + " (Balance: $" + t.balance + ")");
        }
    }
}

// Usage
let account = new BankAccount("John Doe", 100);
account.deposit(50);
account.withdraw(30);
account.deposit(100);
account.printStatement();
```

### Game Character System

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
            print(this.name + " cannot attack (dead)");
            return;
        }
        
        print(this.name + " attacks " + target.name + " for " + this.damage + " damage");
        target.takeDamage(this.damage);
    }
    
    takeDamage(amount) {
        if (!this.alive) return;
        
        this.health = this.health - amount;
        print(this.name + " takes " + amount + " damage (Health: " + this.health + "/" + this.maxHealth + ")");
        
        if (this.health <= 0) {
            this.health = 0;
            this.alive = false;
            print(this.name + " has been defeated!");
        }
    }
    
    heal(amount) {
        if (!this.alive) {
            print(this.name + " cannot be healed (dead)");
            return;
        }
        
        this.health = min(this.health + amount, this.maxHealth);
        print(this.name + " heals for " + amount + " (Health: " + this.health + "/" + this.maxHealth + ")");
    }
}

class Warrior extends Character {
    constructor(name) {
        super(name, 150, 25);
        this.armor = 10;
    }
    
    takeDamage(amount) {
        let reducedDamage = max(amount - this.armor, 0);
        print(this.name + "'s armor reduces damage by " + (amount - reducedDamage));
        super.takeDamage(reducedDamage);
    }
    
    berserkerRage() {
        if (!this.alive) return;
        
        print(this.name + " enters berserker rage!");
        this.damage = this.damage * 2;
        this.armor = 0;
    }
}

// Battle simulation
let hero = new Warrior("Conan");
let monster = new Character("Goblin", 80, 15);

hero.attack(monster);
monster.attack(hero);
hero.berserkerRage();
hero.attack(monster);
hero.attack(monster);
```

## Best Practices

1. **Encapsulation**: Keep internal details private, expose only necessary methods
2. **Single Responsibility**: Each class should have one clear purpose
3. **Favor Composition**: Use composition over inheritance when possible
4. **Meaningful Names**: Use clear, descriptive names for classes and methods
5. **Initialize Properties**: Always initialize properties in the constructor

## Next Steps

- Learn about [Modules](modules.md) to organize classes into libraries
- Explore [Exception Handling](exception-handling.md) for error management
- Study [Built-in Functions](../reference/builtin-functions.md) for utility methods