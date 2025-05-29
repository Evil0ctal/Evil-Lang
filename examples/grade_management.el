// Student Grade Management System - 学生成绩管理系统
// 功能完整的成绩管理系统，支持多科目、统计分析和报表生成

class Student {
    constructor(id, name, className) {
        this.id = id;
        this.name = name;
        this.className = className;
        this.grades = {};  // 科目 -> 成绩列表
        this.attendance = 0;
        this.totalDays = 0;
    }
    
    addGrade(subject, score, examType = "普通测验") {
        if (!this.grades[subject]) {
            this.grades[subject] = [];
        }
        
        push(this.grades[subject], {
            score: score,
            examType: examType,
            date: getCurrentTime()
        });
    }
    
    getAverageGrade(subject) {
        if (!this.grades[subject] || this.grades[subject].length == 0) {
            return null;
        }
        
        let total = 0;
        let grades = this.grades[subject];
        
        for (let i = 0; i < grades.length; i = i + 1) {
            total = total + grades[i].score;
        }
        
        return total / grades.length;
    }
    
    getOverallAverage() {
        let subjects = keys(this.grades);
        if (subjects.length == 0) {
            return 0;
        }
        
        let total = 0;
        let count = 0;
        
        for (let i = 0; i < subjects.length; i = i + 1) {
            let avg = this.getAverageGrade(subjects[i]);
            if (avg != null) {
                total = total + avg;
                count = count + 1;
            }
        }
        
        return count > 0 ? total / count : 0;
    }
    
    markAttendance(present) {
        this.totalDays = this.totalDays + 1;
        if (present) {
            this.attendance = this.attendance + 1;
        }
    }
    
    getAttendanceRate() {
        if (this.totalDays == 0) {
            return 100;
        }
        return (this.attendance / this.totalDays) * 100;
    }
    
    getGradeLevel(score) {
        if (score >= 90) return "A";
        if (score >= 80) return "B";
        if (score >= 70) return "C";
        if (score >= 60) return "D";
        return "F";
    }
    
    generateReport() {
        print("\n📊 学生成绩报告");
        print("=" + repeat("=", 50));
        print("学号: " + this.id);
        print("姓名: " + this.name);
        print("班级: " + this.className);
        print("出勤率: " + round(this.getAttendanceRate()) + "% (" + this.attendance + "/" + this.totalDays + ")");
        print("\n各科成绩：");
        
        let subjects = keys(this.grades);
        for (let i = 0; i < subjects.length; i = i + 1) {
            let subject = subjects[i];
            let avg = this.getAverageGrade(subject);
            let gradeLevel = this.getGradeLevel(avg);
            
            print("\n" + subject + ":");
            print("  平均分: " + round(avg * 10) / 10 + " (" + gradeLevel + ")");
            print("  考试记录:");
            
            let grades = this.grades[subject];
            for (let j = 0; j < grades.length; j = j + 1) {
                let grade = grades[j];
                print("    - " + grade.examType + ": " + grade.score + " 分");
            }
        }
        
        print("\n总平均分: " + round(this.getOverallAverage() * 10) / 10);
        print("=" + repeat("=", 50));
    }
}

class GradeManagementSystem {
    constructor() {
        this.students = [];
        this.subjects = ["语文", "数学", "英语", "物理", "化学", "生物"];
        this.nextId = 1001;
    }
    
    addStudent(name, className) {
        let student = new Student(this.nextId, name, className);
        push(this.students, student);
        this.nextId = this.nextId + 1;
        print("✅ 学生添加成功！学号: " + student.id);
        return student;
    }
    
    findStudent(id) {
        for (let i = 0; i < this.students.length; i = i + 1) {
            if (this.students[i].id == id) {
                return this.students[i];
            }
        }
        return null;
    }
    
    findStudentsByClass(className) {
        let result = [];
        for (let i = 0; i < this.students.length; i = i + 1) {
            if (this.students[i].className == className) {
                push(result, this.students[i]);
            }
        }
        return result;
    }
    
    recordGrade(studentId, subject, score, examType) {
        let student = this.findStudent(studentId);
        if (student == null) {
            print("❌ 未找到学号为 " + studentId + " 的学生");
            return false;
        }
        
        if (score < 0 || score > 100) {
            print("❌ 分数必须在 0-100 之间");
            return false;
        }
        
        student.addGrade(subject, score, examType);
        print("✅ 成绩录入成功！");
        return true;
    }
    
    batchInputGrades(className, subject, examType) {
        let classStudents = this.findStudentsByClass(className);
        if (classStudents.length == 0) {
            print("❌ 未找到班级 " + className + " 的学生");
            return;
        }
        
        print("\n📝 批量录入 " + className + " 班 " + subject + " " + examType + " 成绩");
        print("输入 -1 跳过该学生\n");
        
        for (let i = 0; i < classStudents.length; i = i + 1) {
            let student = classStudents[i];
            let score = toNumber(input(student.name + " (" + student.id + "): "));
            
            if (score != null && score >= 0 && score <= 100) {
                student.addGrade(subject, score, examType);
            } else if (score != -1) {
                print("  ⚠️ 无效分数，跳过");
            }
        }
        
        print("✅ 批量录入完成！");
    }
    
    generateClassReport(className) {
        let classStudents = this.findStudentsByClass(className);
        if (classStudents.length == 0) {
            print("❌ 未找到班级 " + className + " 的学生");
            return;
        }
        
        print("\n📊 " + className + " 班级成绩报告");
        print("=" + repeat("=", 60));
        print("学生人数: " + classStudents.length);
        
        // 计算各科平均分
        print("\n各科平均分：");
        for (let i = 0; i < this.subjects.length; i = i + 1) {
            let subject = this.subjects[i];
            let total = 0;
            let count = 0;
            
            for (let j = 0; j < classStudents.length; j = j + 1) {
                let avg = classStudents[j].getAverageGrade(subject);
                if (avg != null) {
                    total = total + avg;
                    count = count + 1;
                }
            }
            
            if (count > 0) {
                let classAvg = total / count;
                print(subject + ": " + round(classAvg * 10) / 10 + " 分");
            }
        }
        
        // 学生排名
        print("\n学生综合排名：");
        
        // 计算排名
        let rankings = [];
        for (let i = 0; i < classStudents.length; i = i + 1) {
            let student = classStudents[i];
            push(rankings, {
                student: student,
                average: student.getOverallAverage()
            });
        }
        
        // 简单的冒泡排序
        for (let i = 0; i < rankings.length - 1; i = i + 1) {
            for (let j = 0; j < rankings.length - i - 1; j = j + 1) {
                if (rankings[j].average < rankings[j + 1].average) {
                    let temp = rankings[j];
                    rankings[j] = rankings[j + 1];
                    rankings[j + 1] = temp;
                }
            }
        }
        
        // 显示排名
        for (let i = 0; i < rankings.length; i = i + 1) {
            let rank = rankings[i];
            print((i + 1) + ". " + rank.student.name + 
                  " - 平均分: " + round(rank.average * 10) / 10 +
                  " 出勤率: " + round(rank.student.getAttendanceRate()) + "%");
        }
        
        print("=" + repeat("=", 60));
    }
    
    analyzeStudent(studentId) {
        let student = this.findStudent(studentId);
        if (student == null) {
            print("❌ 未找到学生");
            return;
        }
        
        student.generateReport();
        
        // 额外的分析
        print("\n📈 成绩分析：");
        
        let subjects = keys(student.grades);
        let strengths = [];
        let weaknesses = [];
        
        for (let i = 0; i < subjects.length; i = i + 1) {
            let subject = subjects[i];
            let avg = student.getAverageGrade(subject);
            
            if (avg >= 85) {
                push(strengths, subject + " (" + round(avg) + "分)");
            } else if (avg < 70) {
                push(weaknesses, subject + " (" + round(avg) + "分)");
            }
        }
        
        if (strengths.length > 0) {
            print("优势科目: " + join(strengths, ", "));
        }
        
        if (weaknesses.length > 0) {
            print("需要加强: " + join(weaknesses, ", "));
        }
        
        let overall = student.getOverallAverage();
        if (overall >= 90) {
            print("\n⭐ 优秀学生！继续保持！");
        } else if (overall >= 80) {
            print("\n👍 良好！还有进步空间！");
        } else if (overall >= 70) {
            print("\n📚 继续努力，你可以做得更好！");
        } else {
            print("\n💪 需要更多努力，不要放弃！");
        }
    }
    
    exportData() {
        print("\n📄 导出学生数据");
        print("=" + repeat("=", 80));
        print("学号\t姓名\t班级\t总平均分\t出勤率");
        print("-" + repeat("-", 79));
        
        for (let i = 0; i < this.students.length; i = i + 1) {
            let student = this.students[i];
            print(student.id + "\t" + 
                  student.name + "\t" + 
                  student.className + "\t" + 
                  round(student.getOverallAverage()) + "\t\t" + 
                  round(student.getAttendanceRate()) + "%");
        }
        
        print("=" + repeat("=", 80));
        print("总计: " + this.students.length + " 名学生");
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

function join(array, delimiter) {
    let result = "";
    for (let i = 0; i < array.length; i = i + 1) {
        if (i > 0) {
            result = result + delimiter;
        }
        result = result + array[i];
    }
    return result;
}

function keys(obj) {
    // 模拟获取对象键的函数
    let result = [];
    for (let key in obj) {
        push(result, key);
    }
    return result;
}

// 主程序
function main() {
    print("🎓 欢迎使用学生成绩管理系统");
    
    let system = new GradeManagementSystem();
    
    // 添加一些示例数据
    print("\n初始化示例数据...");
    
    // 添加学生
    let students = [
        {name: "张三", class: "高三1班"},
        {name: "李四", class: "高三1班"},
        {name: "王五", class: "高三1班"},
        {name: "赵六", class: "高三2班"},
        {name: "钱七", class: "高三2班"}
    ];
    
    for (let i = 0; i < students.length; i = i + 1) {
        let s = system.addStudent(students[i].name, students[i].class);
        
        // 添加出勤记录
        for (let j = 0; j < 20; j = j + 1) {
            s.markAttendance(random() > 0.1);  // 90% 出勤率
        }
        
        // 添加成绩
        let subjects = ["语文", "数学", "英语"];
        for (let j = 0; j < subjects.length; j = j + 1) {
            let baseScore = 60 + floor(random() * 30);
            s.addGrade(subjects[j], baseScore + floor(random() * 10), "期中考试");
            s.addGrade(subjects[j], baseScore + floor(random() * 15), "期末考试");
        }
    }
    
    let running = true;
    
    while (running) {
        print("\n📚 ===== 主菜单 =====");
        print("1. 添加学生");
        print("2. 录入成绩");
        print("3. 批量录入成绩");
        print("4. 查看学生报告");
        print("5. 查看班级报告");
        print("6. 学生成绩分析");
        print("7. 记录出勤");
        print("8. 导出数据");
        print("9. 退出系统");
        
        let choice = input("\n请选择操作 (1-9): ");
        
        if (choice == "1") {
            let name = input("学生姓名: ");
            let className = input("班级: ");
            system.addStudent(name, className);
            
        } else if (choice == "2") {
            let id = toNumber(input("学生学号: "));
            if (id == null) {
                print("❌ 无效的学号");
                continue;
            }
            
            print("\n可选科目: " + join(system.subjects, ", "));
            let subject = input("科目: ");
            let score = toNumber(input("分数 (0-100): "));
            let examType = input("考试类型 (如: 期中考试): ");
            
            if (score != null) {
                system.recordGrade(id, subject, score, examType);
            } else {
                print("❌ 无效的分数");
            }
            
        } else if (choice == "3") {
            let className = input("班级: ");
            print("\n可选科目: " + join(system.subjects, ", "));
            let subject = input("科目: ");
            let examType = input("考试类型: ");
            
            system.batchInputGrades(className, subject, examType);
            
        } else if (choice == "4") {
            let id = toNumber(input("学生学号: "));
            if (id != null) {
                let student = system.findStudent(id);
                if (student != null) {
                    student.generateReport();
                } else {
                    print("❌ 未找到学生");
                }
            }
            
        } else if (choice == "5") {
            let className = input("班级名称: ");
            system.generateClassReport(className);
            
        } else if (choice == "6") {
            let id = toNumber(input("学生学号: "));
            if (id != null) {
                system.analyzeStudent(id);
            }
            
        } else if (choice == "7") {
            let className = input("班级: ");
            let students = system.findStudentsByClass(className);
            
            if (students.length > 0) {
                print("\n记录出勤 (1=出席, 0=缺席):");
                for (let i = 0; i < students.length; i = i + 1) {
                    let present = input(students[i].name + ": ") == "1";
                    students[i].markAttendance(present);
                }
                print("✅ 出勤记录完成");
            } else {
                print("❌ 未找到该班级学生");
            }
            
        } else if (choice == "8") {
            system.exportData();
            
        } else if (choice == "9") {
            print("\n👋 感谢使用成绩管理系统！");
            running = false;
            
        } else {
            print("❌ 无效的选择");
        }
    }
}

// 启动系统
main();