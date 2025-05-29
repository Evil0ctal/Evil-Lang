// Evil Lang Class Example
// 测试类和对象系统

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

// Define a class with inheritance
// 定义一个带继承的类
class Student extends Person {
    constructor(name, age, school) {
        // Call parent constructor
        super(name, age);
        this.school = school;
    }
    
    // Override introduce method
    introduce() {
        print("Hi, I'm " + this.name + ", " + this.age + " years old, studying at " + this.school);
    }
    
    // New method
    study() {
        print(this.name + " is studying hard at " + this.school);
    }
}

// Create student instance
// 创建学生实例
var student1 = new Student("Charlie", 20, "MIT");

// Call methods
// 调用方法
student1.introduce();
student1.study();
student1.haveBirthday(); // Inherited method