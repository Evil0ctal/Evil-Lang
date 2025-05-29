// Text-Based RPG Game - 文字冒险游戏
// 一个简单但有趣的回合制RPG游戏

// 游戏角色基类
class Character {
    constructor(name, health, attack, defense) {
        this.name = name;
        this.maxHealth = health;
        this.health = health;
        this.attack = attack;
        this.defense = defense;
        this.level = 1;
        this.alive = true;
    }
    
    takeDamage(damage) {
        let actualDamage = max(damage - this.defense, 1);
        this.health = this.health - actualDamage;
        
        if (this.health <= 0) {
            this.health = 0;
            this.alive = false;
        }
        
        return actualDamage;
    }
    
    attackTarget(target) {
        let baseDamage = this.attack + floor(random() * 6) + 1;
        return target.takeDamage(baseDamage);
    }
    
    getHealthBar() {
        let percentage = this.health / this.maxHealth;
        let barLength = 20;
        let filled = floor(percentage * barLength);
        let empty = barLength - filled;
        
        return "[" + repeat("█", filled) + repeat("░", empty) + "]";
    }
    
    displayStatus() {
        print(this.name + " - 等级 " + this.level);
        print("生命值: " + this.health + "/" + this.maxHealth + " " + this.getHealthBar());
        print("攻击力: " + this.attack + " | 防御力: " + this.defense);
    }
}

// 玩家类
class Player extends Character {
    constructor(name, playerClass) {
        // 根据职业设置不同属性
        if (playerClass == "warrior") {
            super(name, 120, 15, 10);
            this.className = "战士";
            this.skills = ["重击", "防御姿态", "战吼"];
        } else if (playerClass == "mage") {
            super(name, 80, 20, 5);
            this.className = "法师";
            this.skills = ["火球术", "冰霜护甲", "闪电链"];
        } else {
            super(name, 100, 12, 8);
            this.className = "游侠";
            this.skills = ["精准射击", "闪避", "陷阱"];
        }
        
        this.experience = 0;
        this.gold = 50;
        this.potions = 3;
        this.inventory = [];
    }
    
    usePotion() {
        if (this.potions <= 0) {
            print("💊 你没有药水了！");
            return false;
        }
        
        let healAmount = 30 + floor(random() * 20);
        this.health = min(this.health + healAmount, this.maxHealth);
        this.potions = this.potions - 1;
        print("💊 你使用了药水，恢复了 " + healAmount + " 点生命值！");
        print("剩余药水: " + this.potions);
        return true;
    }
    
    useSkill(skillIndex, target) {
        if (skillIndex < 0 || skillIndex >= this.skills.length) {
            return 0;
        }
        
        let skill = this.skills[skillIndex];
        let damage = 0;
        
        print("⚔️ " + this.name + " 使用了 " + skill + "！");
        
        if (skill == "重击") {
            damage = this.attack * 2;
            return target.takeDamage(damage);
        } else if (skill == "火球术") {
            damage = this.attack * 1.8 + floor(random() * 10);
            return target.takeDamage(damage);
        } else if (skill == "精准射击") {
            damage = this.attack * 1.5 + 10;
            return target.takeDamage(damage);
        } else if (skill == "防御姿态" || skill == "冰霜护甲" || skill == "闪避") {
            this.defense = this.defense + 5;
            print("🛡️ 防御力提升！");
            return 0;
        } else {
            damage = this.attack + floor(random() * 15);
            return target.takeDamage(damage);
        }
    }
    
    gainExperience(exp) {
        this.experience = this.experience + exp;
        print("✨ 获得 " + exp + " 点经验值！");
        
        // 升级检查
        let requiredExp = this.level * 100;
        if (this.experience >= requiredExp) {
            this.levelUp();
        }
    }
    
    levelUp() {
        this.level = this.level + 1;
        this.maxHealth = this.maxHealth + 20;
        this.health = this.maxHealth;
        this.attack = this.attack + 5;
        this.defense = this.defense + 3;
        
        print("\n🎉 升级了！你现在是等级 " + this.level + "！");
        print("💪 所有属性提升！");
        print("❤️ 生命值完全恢复！");
    }
}

// 怪物类
class Monster extends Character {
    constructor(type) {
        if (type == "goblin") {
            super("哥布林", 50, 8, 3);
            this.expReward = 30;
            this.goldReward = 10 + floor(random() * 20);
            this.description = "一个矮小但凶猛的绿皮生物";
        } else if (type == "orc") {
            super("兽人", 80, 12, 5);
            this.expReward = 50;
            this.goldReward = 20 + floor(random() * 30);
            this.description = "一个强壮的兽人战士";
        } else if (type == "dragon") {
            super("幼龙", 150, 20, 10);
            this.expReward = 100;
            this.goldReward = 100 + floor(random() * 100);
            this.description = "一条喷火的幼龙，极其危险！";
        } else {
            super("史莱姆", 30, 5, 2);
            this.expReward = 20;
            this.goldReward = 5 + floor(random() * 10);
            this.description = "一团黏糊糊的果冻状生物";
        }
    }
}

// 战斗系统
class BattleSystem {
    constructor(player, monster) {
        this.player = player;
        this.monster = monster;
        this.turn = 1;
    }
    
    start() {
        print("\n⚔️ ===== 战斗开始！ =====");
        print("💀 遭遇了 " + this.monster.name + "！");
        print("📝 " + this.monster.description);
        print("");
        
        while (this.player.alive && this.monster.alive) {
            print("\n--- 回合 " + this.turn + " ---");
            this.displayBattleStatus();
            
            // 玩家回合
            let action = this.playerTurn();
            if (!action) continue;  // 如果选择了无效操作，重新选择
            
            // 检查怪物是否死亡
            if (!this.monster.alive) {
                this.victory();
                break;
            }
            
            // 怪物回合
            this.monsterTurn();
            
            // 检查玩家是否死亡
            if (!this.player.alive) {
                this.defeat();
                break;
            }
            
            this.turn = this.turn + 1;
        }
    }
    
    displayBattleStatus() {
        print("\n[玩家] " + this.player.name + " (" + this.player.className + ")");
        print(this.player.getHealthBar() + " " + this.player.health + "/" + this.player.maxHealth);
        
        print("\n[怪物] " + this.monster.name);
        print(this.monster.getHealthBar() + " " + this.monster.health + "/" + this.monster.maxHealth);
    }
    
    playerTurn() {
        print("\n你的回合：");
        print("1. 普通攻击");
        print("2. 使用技能");
        print("3. 使用药水 (" + this.player.potions + " 剩余)");
        print("4. 查看状态");
        
        let choice = input("选择行动 (1-4): ");
        
        if (choice == "1") {
            let damage = this.player.attackTarget(this.monster);
            print("⚔️ 你对 " + this.monster.name + " 造成了 " + damage + " 点伤害！");
            return true;
            
        } else if (choice == "2") {
            print("\n选择技能：");
            for (let i = 0; i < this.player.skills.length; i = i + 1) {
                print((i + 1) + ". " + this.player.skills[i]);
            }
            
            let skillChoice = toNumber(input("选择 (1-" + this.player.skills.length + "): ")) - 1;
            if (skillChoice >= 0 && skillChoice < this.player.skills.length) {
                let damage = this.player.useSkill(skillChoice, this.monster);
                if (damage > 0) {
                    print("💥 造成了 " + damage + " 点伤害！");
                }
                return true;
            } else {
                print("❌ 无效的选择！");
                return false;
            }
            
        } else if (choice == "3") {
            if (this.player.usePotion()) {
                return true;
            }
            return false;
            
        } else if (choice == "4") {
            this.player.displayStatus();
            print("\n💰 金币: " + this.player.gold);
            print("✨ 经验: " + this.player.experience);
            print("💊 药水: " + this.player.potions);
            return false;
            
        } else {
            print("❌ 无效的选择！");
            return false;
        }
    }
    
    monsterTurn() {
        print("\n" + this.monster.name + " 的回合：");
        
        // 怪物AI：简单的攻击逻辑
        if (random() < 0.8) {
            let damage = this.monster.attackTarget(this.player);
            print("💢 " + this.monster.name + " 对你造成了 " + damage + " 点伤害！");
        } else {
            print("💨 " + this.monster.name + " 的攻击未命中！");
        }
    }
    
    victory() {
        print("\n🎉 ===== 胜利！ =====");
        print("你击败了 " + this.monster.name + "！");
        print("💰 获得 " + this.monster.goldReward + " 金币！");
        this.player.gold = this.player.gold + this.monster.goldReward;
        this.player.gainExperience(this.monster.expReward);
        
        // 掉落物品
        if (random() < 0.3) {
            print("💊 发现了一瓶药水！");
            this.player.potions = this.player.potions + 1;
        }
    }
    
    defeat() {
        print("\n💀 ===== 战败！ =====");
        print("你被 " + this.monster.name + " 击败了...");
        print("游戏结束！");
    }
}

// 商店系统
class Shop {
    constructor() {
        this.items = [
            {name: "生命药水", cost: 30, effect: "恢复生命值"},
            {name: "力量药剂", cost: 50, effect: "永久提升攻击力+3"},
            {name: "防御药剂", cost: 50, effect: "永久提升防御力+3"},
            {name: "经验卷轴", cost: 100, effect: "获得50点经验"}
        ];
    }
    
    visit(player) {
        print("\n🏪 ===== 神秘商店 =====");
        print("商人: 欢迎光临，勇士！看看有什么需要的吗？");
        print("你的金币: 💰 " + player.gold);
        
        let shopping = true;
        while (shopping) {
            print("\n商品列表：");
            for (let i = 0; i < this.items.length; i = i + 1) {
                let item = this.items[i];
                print((i + 1) + ". " + item.name + " - " + item.cost + " 金币 (" + item.effect + ")");
            }
            print("5. 离开商店");
            
            let choice = toNumber(input("\n选择要购买的物品 (1-5): "));
            
            if (choice >= 1 && choice <= 4) {
                let item = this.items[choice - 1];
                
                if (player.gold >= item.cost) {
                    player.gold = player.gold - item.cost;
                    print("✅ 购买了 " + item.name + "！");
                    
                    // 应用物品效果
                    if (item.name == "生命药水") {
                        player.potions = player.potions + 1;
                    } else if (item.name == "力量药剂") {
                        player.attack = player.attack + 3;
                        print("💪 攻击力永久提升！");
                    } else if (item.name == "防御药剂") {
                        player.defense = player.defense + 3;
                        print("🛡️ 防御力永久提升！");
                    } else if (item.name == "经验卷轴") {
                        player.gainExperience(50);
                    }
                } else {
                    print("❌ 金币不足！");
                }
                
            } else if (choice == 5) {
                print("商人: 欢迎下次光临！");
                shopping = false;
            } else {
                print("❌ 无效的选择！");
            }
        }
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

// 游戏主循环
function main() {
    print("🗡️ ===== Evil Lang RPG 冒险游戏 =====");
    print("欢迎来到充满危险与机遇的奇幻世界！\n");
    
    let playerName = input("请输入你的角色名: ");
    print("\n选择你的职业：");
    print("1. 战士 - 高生命值和防御");
    print("2. 法师 - 高攻击力");
    print("3. 游侠 - 平衡型");
    
    let classChoice = input("选择 (1-3): ");
    let playerClass = "ranger";
    
    if (classChoice == "1") {
        playerClass = "warrior";
    } else if (classChoice == "2") {
        playerClass = "mage";
    }
    
    let player = new Player(playerName, playerClass);
    print("\n角色创建成功！");
    player.displayStatus();
    
    let shop = new Shop();
    let gameRunning = true;
    let battlesWon = 0;
    
    while (gameRunning && player.alive) {
        print("\n🗺️ ===== 冒险菜单 =====");
        print("1. 进入战斗");
        print("2. 访问商店");
        print("3. 查看状态");
        print("4. 使用药水");
        print("5. 退出游戏");
        
        let choice = input("\n选择行动 (1-5): ");
        
        if (choice == "1") {
            // 随机遭遇怪物
            let monsterTypes = ["slime", "goblin", "orc"];
            if (battlesWon > 5) {
                push(monsterTypes, "dragon");
            }
            
            let randomType = monsterTypes[floor(random() * monsterTypes.length)];
            let monster = new Monster(randomType);
            
            let battle = new BattleSystem(player, monster);
            battle.start();
            
            if (player.alive) {
                battlesWon = battlesWon + 1;
                print("\n战斗胜利次数: " + battlesWon);
            }
            
        } else if (choice == "2") {
            shop.visit(player);
            
        } else if (choice == "3") {
            print("\n📊 ===== 角色状态 =====");
            player.displayStatus();
            print("💰 金币: " + player.gold);
            print("✨ 经验: " + player.experience);
            print("💊 药水: " + player.potions);
            print("🏆 战斗胜利: " + battlesWon);
            
        } else if (choice == "4") {
            if (player.health < player.maxHealth) {
                player.usePotion();
            } else {
                print("❤️ 你的生命值已满！");
            }
            
        } else if (choice == "5") {
            print("\n感谢游玩！你的最终战绩：");
            print("🏆 战斗胜利: " + battlesWon);
            print("⭐ 最终等级: " + player.level);
            print("💰 总金币: " + player.gold);
            gameRunning = false;
            
        } else {
            print("❌ 无效的选择！");
        }
    }
    
    print("\n游戏结束！");
}

// 启动游戏
main();