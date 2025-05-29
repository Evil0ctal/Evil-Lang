// Evil Lang Class Example - Basic
// 测试基本的类和对象系统

// Define a simple Person class
// 定义一个简单的Person类
class Person {
    // Constructor
    constructor(name, age) {
        this.name = name;
        this.age = age;
    }
    
    // Method to introduce
    introduce() {
        print("Hi, I'm " + this.name + " and I'm " + this.age + " years old.");
    }
    
    // Method to have birthday
    haveBirthday() {
        this.age = this.age + 1;
        print(this.name + " is now " + this.age + " years old!");
    }
}

// Create instances
// 创建实例
var person1 = new Person("Alice", 25);
var person2 = new Person("Bob", 30);

// Call methods
// 调用方法
person1.introduce();
person2.introduce();

// Have birthday
// 过生日
person1.haveBirthday();

// Access properties
// 访问属性
print(person1.name + "'s age is now: " + person1.age);