// Todo List Manager - 任务管理器
// 一个功能完整的命令行任务管理应用

class Todo {
    constructor(id, title, description = "", priority = "medium") {
        this.id = id;
        this.title = title;
        this.description = description;
        this.priority = priority;  // low, medium, high
        this.completed = false;
        this.createdAt = getCurrentTime();
        this.completedAt = null;
    }
    
    complete() {
        this.completed = true;
        this.completedAt = getCurrentTime();
    }
    
    toString() {
        let status = this.completed ? "[✓]" : "[ ]";
        let priorityIcon = "";
        
        if (this.priority == "high") {
            priorityIcon = "🔴";
        } else if (this.priority == "medium") {
            priorityIcon = "🟡";
        } else {
            priorityIcon = "🟢";
        }
        
        return status + " " + priorityIcon + " #" + this.id + " " + this.title;
    }
}

class TodoManager {
    constructor() {
        this.todos = [];
        this.nextId = 1;
    }
    
    addTodo(title, description = "", priority = "medium") {
        let todo = new Todo(this.nextId, title, description, priority);
        push(this.todos, todo);
        this.nextId = this.nextId + 1;
        print("✅ 任务添加成功：" + todo.toString());
        return todo;
    }
    
    listTodos(showCompleted = true) {
        print("\n📋 任务列表：");
        print("=" + repeat("-", 50));
        
        let pendingCount = 0;
        let completedCount = 0;
        
        for (let i = 0; i < this.todos.length; i = i + 1) {
            let todo = this.todos[i];
            
            if (todo.completed) {
                completedCount = completedCount + 1;
                if (showCompleted) {
                    print(todo.toString());
                }
            } else {
                pendingCount = pendingCount + 1;
                print(todo.toString());
            }
        }
        
        print("=" + repeat("-", 50));
        print("📊 统计：待完成 " + pendingCount + " | 已完成 " + completedCount);
    }
    
    completeTodo(id) {
        let todo = this.findTodoById(id);
        if (todo == null) {
            print("❌ 错误：未找到ID为 " + id + " 的任务");
            return false;
        }
        
        if (todo.completed) {
            print("⚠️  任务已经完成");
            return false;
        }
        
        todo.complete();
        print("✅ 任务完成：" + todo.toString());
        return true;
    }
    
    deleteTodo(id) {
        for (let i = 0; i < this.todos.length; i = i + 1) {
            if (this.todos[i].id == id) {
                let removed = this.todos[i];
                // 移除元素
                this.todos = concat(slice(this.todos, 0, i), slice(this.todos, i + 1, this.todos.length));
                print("🗑️  删除任务：" + removed.title);
                return true;
            }
        }
        
        print("❌ 错误：未找到ID为 " + id + " 的任务");
        return false;
    }
    
    viewTodo(id) {
        let todo = this.findTodoById(id);
        if (todo == null) {
            print("❌ 错误：未找到ID为 " + id + " 的任务");
            return;
        }
        
        print("\n📄 任务详情：");
        print("=" + repeat("-", 30));
        print("ID: " + todo.id);
        print("标题: " + todo.title);
        print("描述: " + (todo.description == "" ? "无" : todo.description));
        print("优先级: " + todo.priority);
        print("状态: " + (todo.completed ? "已完成" : "待完成"));
        print("创建时间: " + this.formatTime(todo.createdAt));
        if (todo.completed) {
            print("完成时间: " + this.formatTime(todo.completedAt));
        }
        print("=" + repeat("-", 30));
    }
    
    filterByPriority(priority) {
        print("\n🎯 优先级筛选：" + priority);
        print("=" + repeat("-", 30));
        
        let count = 0;
        for (let i = 0; i < this.todos.length; i = i + 1) {
            let todo = this.todos[i];
            if (todo.priority == priority && !todo.completed) {
                print(todo.toString());
                count = count + 1;
            }
        }
        
        if (count == 0) {
            print("没有找到该优先级的待办任务");
        }
    }
    
    getStatistics() {
        let stats = {
            total: this.todos.length,
            completed: 0,
            pending: 0,
            high: 0,
            medium: 0,
            low: 0
        };
        
        for (let i = 0; i < this.todos.length; i = i + 1) {
            let todo = this.todos[i];
            
            if (todo.completed) {
                stats.completed = stats.completed + 1;
            } else {
                stats.pending = stats.pending + 1;
                
                if (todo.priority == "high") {
                    stats.high = stats.high + 1;
                } else if (todo.priority == "medium") {
                    stats.medium = stats.medium + 1;
                } else {
                    stats.low = stats.low + 1;
                }
            }
        }
        
        print("\n📊 任务统计：");
        print("=" + repeat("-", 30));
        print("总任务数: " + stats.total);
        print("已完成: " + stats.completed + " (" + this.percentage(stats.completed, stats.total) + "%)");
        print("待完成: " + stats.pending + " (" + this.percentage(stats.pending, stats.total) + "%)");
        print("\n待完成任务优先级分布：");
        print("🔴 高优先级: " + stats.high);
        print("🟡 中优先级: " + stats.medium);
        print("🟢 低优先级: " + stats.low);
        print("=" + repeat("-", 30));
    }
    
    findTodoById(id) {
        for (let i = 0; i < this.todos.length; i = i + 1) {
            if (this.todos[i].id == id) {
                return this.todos[i];
            }
        }
        return null;
    }
    
    formatTime(timestamp) {
        // 简单的时间格式化
        return "时间戳: " + timestamp;
    }
    
    percentage(part, total) {
        if (total == 0) return 0;
        return floor((part / total) * 100);
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

function showMenu() {
    print("\n🗂️  任务管理器菜单：");
    print("1. 添加任务");
    print("2. 查看所有任务");
    print("3. 完成任务");
    print("4. 删除任务");
    print("5. 查看任务详情");
    print("6. 按优先级筛选");
    print("7. 查看统计信息");
    print("8. 退出");
}

// 主程序
function main() {
    print("🎯 欢迎使用 Evil Lang 任务管理器！");
    
    let manager = new TodoManager();
    let running = true;
    
    // 添加一些示例任务
    manager.addTodo("学习 Evil Lang", "阅读官方文档并练习", "high");
    manager.addTodo("完成项目报告", "准备下周的项目进度报告", "high");
    manager.addTodo("购买生活用品", "牛奶、面包、水果", "low");
    manager.addTodo("锻炼身体", "晚上跑步30分钟", "medium");
    
    while (running) {
        showMenu();
        let choice = input("\n请选择操作 (1-8): ");
        
        if (choice == "1") {
            let title = input("任务标题: ");
            let description = input("任务描述 (可选): ");
            let priority = input("优先级 (low/medium/high) [默认: medium]: ");
            
            if (priority == "") {
                priority = "medium";
            }
            
            if (priority != "low" && priority != "medium" && priority != "high") {
                print("⚠️  无效的优先级，使用默认值 medium");
                priority = "medium";
            }
            
            manager.addTodo(title, description, priority);
            
        } else if (choice == "2") {
            let showCompleted = input("显示已完成任务？(y/n) [默认: y]: ");
            manager.listTodos(showCompleted != "n");
            
        } else if (choice == "3") {
            manager.listTodos(false);
            let id = toNumber(input("请输入要完成的任务ID: "));
            if (id != null) {
                manager.completeTodo(id);
            } else {
                print("⚠️  无效的ID");
            }
            
        } else if (choice == "4") {
            manager.listTodos();
            let id = toNumber(input("请输入要删除的任务ID: "));
            if (id != null) {
                let confirm = input("确认删除？(y/n): ");
                if (confirm == "y") {
                    manager.deleteTodo(id);
                }
            } else {
                print("⚠️  无效的ID");
            }
            
        } else if (choice == "5") {
            let id = toNumber(input("请输入任务ID: "));
            if (id != null) {
                manager.viewTodo(id);
            } else {
                print("⚠️  无效的ID");
            }
            
        } else if (choice == "6") {
            let priority = input("请输入优先级 (low/medium/high): ");
            if (priority == "low" || priority == "medium" || priority == "high") {
                manager.filterByPriority(priority);
            } else {
                print("⚠️  无效的优先级");
            }
            
        } else if (choice == "7") {
            manager.getStatistics();
            
        } else if (choice == "8") {
            print("\n👋 感谢使用任务管理器，再见！");
            running = false;
            
        } else {
            print("⚠️  无效的选择，请重试");
        }
    }
}

// 运行主程序
main();