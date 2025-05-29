// Simple Text Adventure Game in Evil Lang
// 简单的文字冒险游戏

print("=== Welcome to Evil Lang Adventure! ===\n");

// Game state
var playerName = "Hero";
var playerHealth = 100;
var playerGold = 50;
var currentLocation = "town";

// Locations
var locations = {
    town: {
        name: "Town Square",
        description: "A bustling town square with a fountain in the center."
    },
    forest: {
        name: "Dark Forest", 
        description: "A mysterious forest filled with ancient trees."
    },
    cave: {
        name: "Crystal Cave",
        description: "A cave sparkling with magical crystals."
    }
};

// Display game status
func showStatus() {
    print("\n--- Status ---");
    print("Name: " + playerName);
    print("Health: " + playerHealth + "/100");
    print("Gold: " + playerGold);
    
    var locationName = "Unknown";
    var locationDesc = "No description";
    
    if (currentLocation == "town") {
        locationName = locations.town.name;
        locationDesc = locations.town.description;
    } else if (currentLocation == "forest") {
        locationName = locations.forest.name;
        locationDesc = locations.forest.description;
    } else if (currentLocation == "cave") {
        locationName = locations.cave.name;
        locationDesc = locations.cave.description;
    }
    
    print("Location: " + locationName);
    print("Description: " + locationDesc);
}

// Simple combat system
func battle(enemyName, enemyHealth, enemyDamage, reward) {
    print("\n⚔️ Battle with " + enemyName + "!");
    
    while (enemyHealth > 0 && playerHealth > 0) {
        // Player attacks
        var playerDamage = 15;
        enemyHealth = enemyHealth - playerDamage;
        print("You deal " + playerDamage + " damage to " + enemyName);
        
        if (enemyHealth <= 0) {
            print("Victory! You defeated " + enemyName);
            playerGold = playerGold + reward;
            print("You gained " + reward + " gold!");
            break;
        }
        
        // Enemy attacks
        playerHealth = playerHealth - enemyDamage;
        print(enemyName + " deals " + enemyDamage + " damage to you");
        
        if (playerHealth <= 0) {
            print("You have been defeated...");
            break;
        }
    }
}

// Adventure scenarios
func townAdventure() {
    print("\nIn the town, you meet a merchant.");
    print("Merchant: 'Would you like to buy a health potion for 20 gold?'");
    
    if (playerGold >= 20) {
        print("You buy the health potion.");
        playerGold = playerGold - 20;
        playerHealth = 100;
        print("Your health is fully restored!");
    } else {
        print("You don't have enough gold.");
    }
}

func forestAdventure() {
    print("\nIn the forest, you encounter a wild wolf!");
    battle("Wolf", 30, 10, 25);
}

func caveAdventure() {
    print("\nIn the cave, you find a treasure chest!");
    var treasure = 100;
    playerGold = playerGold + treasure;
    print("You found " + treasure + " gold!");
    
    print("\nBut suddenly, a cave troll appears!");
    battle("Cave Troll", 50, 20, 50);
}

// Main game loop simulation
print("Enter your name: ");
playerName = "Adventurer"; // Would use input() in real implementation

showStatus();

// Simulate player choices
print("\n\n=== Your Adventure Begins ===");

// Visit town
currentLocation = "town";
print("\n📍 Traveling to " + locations.town.name + "...");
showStatus();
townAdventure();

// Visit forest
if (playerHealth > 0) {
    currentLocation = "forest";
    print("\n📍 Traveling to " + locations.forest.name + "...");
    showStatus();
    forestAdventure();
}

// Visit cave
if (playerHealth > 0) {
    currentLocation = "cave";
    print("\n📍 Traveling to " + locations.cave.name + "...");
    showStatus();
    caveAdventure();
}

// Game ending
print("\n\n=== Game Over ===");
if (playerHealth > 0) {
    print("Congratulations, " + playerName + "!");
    print("You survived the adventure with " + playerHealth + " health");
    print("and collected " + playerGold + " gold!");
    print("\n🏆 You are a true hero! 🏆");
} else {
    print("Game Over, " + playerName + "...");
    print("You were defeated in battle.");
    print("Better luck next time!");
}

print("\nThanks for playing Evil Lang Adventure!");