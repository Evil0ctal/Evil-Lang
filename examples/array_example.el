// Evil Lang Array Functions Example
// 数组函数示例

print("=== Array Basic Operations ===");

// Create an array
var numbers = [1, 2, 3, 4, 5];
print("Original array: " + toString(numbers));
print("Length: " + numbers.length);

// Push and pop
print("\n=== Push/Pop Operations ===");
var newLength = push(numbers, 6);
print("After push(6): " + toString(numbers) + " (length: " + newLength + ")");

var popped = pop(numbers);
print("Popped element: " + popped);
print("After pop: " + toString(numbers));

// Shift and unshift
print("\n=== Shift/Unshift Operations ===");
var fruits = ["apple", "banana", "orange"];
print("Original: " + toString(fruits));

var shifted = shift(fruits);
print("Shifted element: " + shifted);
print("After shift: " + toString(fruits));

var unshiftLength = unshift(fruits, "grape");
print("After unshift('grape'): " + toString(fruits) + " (length: " + unshiftLength + ")");

// Array slicing
print("\n=== Array Slicing ===");
var letters = ["a", "b", "c", "d", "e", "f"];
print("Original: " + toString(letters));
print("slice(1, 4): " + toString(slice(letters, 1, 4)));
print("slice(3): " + toString(slice(letters, 3)));

// Array reverse and sort
print("\n=== Reverse and Sort ===");
var mixed = [3, 1, 4, 1, 5, 9, 2, 6];
print("Original: " + toString(mixed));
print("Reversed: " + toString(arrayReverse(mixed)));
print("Sorted: " + toString(arraySort(mixed)));
print("Original unchanged: " + toString(mixed));

// Array search
print("\n=== Array Search ===");
var items = ["foo", "bar", "baz", "qux"];
print("Array: " + toString(items));
print("includes('bar'): " + includes(items, "bar"));
print("includes('xyz'): " + includes(items, "xyz"));
print("indexOf('baz'): " + arrayIndexOf(items, "baz"));
print("indexOf('xyz'): " + arrayIndexOf(items, "xyz"));

// Array concatenation
print("\n=== Array Concatenation ===");
var arr1 = [1, 2, 3];
var arr2 = [4, 5, 6];
var arr3 = [7, 8, 9];
var combined = concat(arr1, arr2, arr3);
print("concat([1,2,3], [4,5,6], [7,8,9]): " + toString(combined));

// Practical example: Stack implementation
print("\n=== Stack Implementation ===");

class Stack {
    constructor() {
        this.items = [];
    }
    
    push(item) {
        push(this.items, item);
    }
    
    pop() {
        if (this.isEmpty()) {
            throw "Stack is empty!";
        }
        return pop(this.items);
    }
    
    peek() {
        if (this.isEmpty()) {
            throw "Stack is empty!";
        }
        var items = this.items;
        return items[items.length - 1];
    }
    
    isEmpty() {
        return this.items.length == 0;
    }
    
    size() {
        return this.items.length;
    }
}

var stack = new Stack();
print("Created empty stack");

try {
    stack.push(10);
    print("Pushed 10");
    stack.push(20);
    print("Pushed 20");
    stack.push(30);
    print("Pushed 30");
    
    print("Stack size: " + stack.size());
    print("Peek: " + stack.peek());
    
    print("Pop: " + stack.pop());
    print("Pop: " + stack.pop());
    print("Stack size after pops: " + stack.size());
    
} catch (e) {
    print("Stack error: " + e);
}

// Practical example: Queue implementation
print("\n=== Queue Implementation ===");

class Queue {
    constructor() {
        this.items = [];
    }
    
    enqueue(item) {
        push(this.items, item);
    }
    
    dequeue() {
        if (this.isEmpty()) {
            throw "Queue is empty!";
        }
        return shift(this.items);
    }
    
    front() {
        if (this.isEmpty()) {
            throw "Queue is empty!";
        }
        var items = this.items;
        return items[0];
    }
    
    isEmpty() {
        return this.items.length == 0;
    }
    
    size() {
        return this.items.length;
    }
}

var queue = new Queue();
print("Created empty queue");

queue.enqueue("First");
queue.enqueue("Second");
queue.enqueue("Third");
print("Enqueued: First, Second, Third");

print("Front: " + queue.front());
print("Dequeue: " + queue.dequeue());
print("Dequeue: " + queue.dequeue());
print("Queue size: " + queue.size());