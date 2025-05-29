// Evil Lang Comprehensive Example
// 综合示例 - 展示所有主要功能

// Import math library
import "math" as Math;

print("=== Evil Lang Feature Showcase ===\n");

// 1. Classes and Objects with Exception Handling
// 类和对象与异常处理
class Person {
    constructor(name, age) {
        if (age < 0) {
            throw "Age cannot be negative!";
        }
        this.name = name;
        this.age = age;
        this.hobbies = [];
    }
    
    addHobby(hobby) {
        push(this.hobbies, hobby);
    }
    
    introduce() {
        var intro = "Hi, I'm " + this.name + ", " + this.age + " years old.";
        if (this.hobbies.length > 0) {
            intro = intro + " I enjoy: " + join(", ", this.hobbies);
        }
        return intro;
    }
}

// 2. Function with Error Handling
// 带错误处理的函数
func createPerson(name, age) {
    try {
        return new Person(name, age);
    } catch (e) {
        print("Error creating person: " + e);
        return null;
    }
}

print("1. Creating people with validation:");
var alice = createPerson("Alice", 25);
var invalid = createPerson("Invalid", -5);

if (alice != null) {
    alice.addHobby("reading");
    alice.addHobby("coding");
    print("  " + alice.introduce());
}

// 3. String Manipulation
// 字符串操作
print("\n2. String Processing:");
var email = "  John.Doe@Example.COM  ";
print("  Original email: '" + email + "'");
print("  Cleaned email: '" + toLower(trim(email)) + "'");

// Split and process
var parts = split(toLower(trim(email)), "@");
print("  Username: " + parts[0]);
print("  Domain: " + parts[1]);

// 4. Array Operations and Functional Style
// 数组操作和函数式风格
print("\n3. Array Processing:");
var numbers = [5, 2, 8, 1, 9, 3, 7];
print("  Original: " + toString(numbers));
print("  Sorted: " + toString(arraySort(numbers)));
print("  Reversed: " + toString(arrayReverse(numbers)));

// Find statistics
func arraySum(arr) {
    var sum = 0;
    for (var i = 0; i < arr.length; i = i + 1) {
        sum = sum + arr[i];
    }
    return sum;
}

func arrayAverage(arr) {
    if (arr.length == 0) {
        throw "Cannot calculate average of empty array";
    }
    return arraySum(arr) / arr.length;
}

print("  Sum: " + arraySum(numbers));
print("  Average: " + arrayAverage(numbers));

// 5. Object-Oriented Design Pattern
// 面向对象设计模式
print("\n4. Design Pattern - Observer:");

class EventEmitter {
    constructor() {
        this.listeners = {};
    }
    
    on(event, callback) {
        var listeners = this.listeners;
        if (listeners[event] == null) {
            listeners[event] = [];
        }
        var eventListeners = listeners[event];
        push(eventListeners, callback);
    }
    
    emit(event, data) {
        var listeners = this.listeners;
        var eventListeners = listeners[event];
        if (eventListeners != null) {
            for (var i = 0; i < eventListeners.length; i = i + 1) {
                var callback = eventListeners[i];
                callback(data);
            }
        }
    }
}

// Create event emitter
var emitter = new EventEmitter();

// Add listeners
func messageHandler1(data) {
    print("  Received message: " + data);
}

func messageHandler2(data) {
    print("  Message length: " + data.length);
}

emitter.on("message", messageHandler1);
emitter.on("message", messageHandler2);

// Emit events
emitter.emit("message", "Hello, EventEmitter!");

// 6. Error Recovery Pattern
// 错误恢复模式
print("\n5. Robust File Processing Simulation:");

func processFile(filename) {
    try {
        if (indexOf(filename, ".txt") == -1) {
            throw "Only .txt files are supported";
        }
        
        // Simulate processing
        print("  Processing " + filename + "...");
        
        if (filename == "corrupt.txt") {
            throw "File is corrupted";
        }
        
        return "Successfully processed " + filename;
    } catch (e) {
        print("  Error: " + e);
        return null;
    } finally {
        print("  Cleanup for " + filename);
    }
}

var files = ["document.txt", "image.jpg", "corrupt.txt", "data.txt"];
var results = [];

for (var i = 0; i < files.length; i = i + 1) {
    var result = processFile(files[i]);
    if (result != null) {
        push(results, result);
    }
}

print("\nSuccessfully processed " + results.length + " out of " + files.length + " files");

// 7. Module System Usage
// 模块系统使用
print("\n6. Using Math Module:");
print("  Math.PI ≈ " + Math.PI);
print("  Math.abs(-42) = " + Math.abs(-42));
print("  Math.pow(2, 10) = " + Math.pow(2, 10));
print("  Math.sqrt(16) = " + Math.sqrt(16));

// 8. Complex Data Structure
// 复杂数据结构
print("\n7. Building a Todo List Application:");

class TodoItem {
    constructor(id, text, completed) {
        this.id = id;
        this.text = text;
        this.completed = completed || false;
        this.createdAt = "2024-01-01"; // Simplified date
    }
    
    toggle() {
        this.completed = !this.completed;
    }
    
    toString() {
        return "[" + (this.completed ? "✓" : " ") + "] " + this.text;
    }
}

class TodoList {
    constructor() {
        this.items = [];
        this.nextId = 1;
    }
    
    add(text) {
        var item = new TodoItem(this.nextId, text, false);
        push(this.items, item);
        this.nextId = this.nextId + 1;
        return item;
    }
    
    findById(id) {
        var items = this.items;
        for (var i = 0; i < items.length; i = i + 1) {
            var item = items[i];
            if (item.id == id) {
                return item;
            }
        }
        return null;
    }
    
    complete(id) {
        var item = this.findById(id);
        if (item != null) {
            item.toggle();
            return true;
        }
        return false;
    }
    
    display() {
        var items = this.items;
        print("  Todo List (" + items.length + " items):");
        for (var i = 0; i < items.length; i = i + 1) {
            var item = items[i];
            print("    " + item.id + ". " + item.toString());
        }
    }
}

var todos = new TodoList();
todos.add("Learn Evil Lang");
todos.add("Build awesome projects");
todos.add("Share with community");

todos.complete(1);
todos.display();

print("\n=== End of Showcase ===");
print("Evil Lang - A powerful and expressive programming language!");