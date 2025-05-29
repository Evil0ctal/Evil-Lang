// Test method call
class Test {
    constructor() {
        this.x = 10;
    }
    
    show() {
        print("x = " + this.x);
    }
}

var obj = new Test();
obj.show();