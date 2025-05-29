// Number Guessing Game in Evil Lang
// 猜数字游戏

print("=== Welcome to Number Guessing Game! ===");
print("I'm thinking of a number between 1 and 100.");
print("Can you guess it?\n");

// Simple random number generator using time-based seed
// 使用基于时间的种子的简单随机数生成器
func simpleRandom(min, max) {
    // Use a simple formula to generate pseudo-random number
    // This is not truly random but good enough for a game
    // For simplicity, just return a fixed number in the range
    return 49;  // A number between 1 and 100
}

// Game class
class GuessingGame {
    constructor() {
        this.targetNumber = simpleRandom(1, 100);
        this.attempts = 0;
        this.maxAttempts = 10;
        this.gameOver = false;
        this.won = false;
    }
    
    makeGuess(guess) {
        if (this.gameOver) {
            print("Game is already over! Start a new game.");
            return;
        }
        
        this.attempts = this.attempts + 1;
        
        if (guess < 1 || guess > 100) {
            print("Please guess a number between 1 and 100!");
            return;
        }
        
        if (guess == this.targetNumber) {
            this.won = true;
            this.gameOver = true;
            print("🎉 Congratulations! You guessed it!");
            print("The number was " + this.targetNumber);
            print("You won in " + this.attempts + " attempts!");
        } else if (guess < this.targetNumber) {
            print("Too low! Try a higher number.");
            this.checkAttempts();
        } else {
            print("Too high! Try a lower number.");
            this.checkAttempts();
        }
    }
    
    checkAttempts() {
        var remaining = this.maxAttempts - this.attempts;
        if (remaining <= 0) {
            this.gameOver = true;
            print("\n😢 Game Over! You've used all your attempts.");
            print("The number was: " + this.targetNumber);
        } else if (remaining <= 3) {
            print("⚠️  Warning: Only " + remaining + " attempts left!");
        } else {
            print("Attempts remaining: " + remaining);
        }
    }
    
    getHint() {
        if (this.gameOver) {
            print("Game is over. No more hints!");
            return;
        }
        
        if (this.attempts < 3) {
            print("Try making a few guesses first!");
            return;
        }
        
        // Give a range hint
        var lower = this.targetNumber - 10;
        var upper = this.targetNumber + 10;
        
        if (lower < 1) {
            lower = 1;
        }
        if (upper > 100) {
            upper = 100;
        }
        
        print("Hint: The number is between " + lower + " and " + upper);
    }
}

// Function to simulate getting user input
// 模拟获取用户输入的函数
func simulateGame() {
    var game = new GuessingGame();
    
    // Simulate a game session
    var guesses = [50, 25, 37, 43, 46, 48, 49];  // Simulated guesses
    
    print("Starting automated game simulation...\n");
    
    for (var i = 0; i < guesses.length; i = i + 1) {
        if (game.gameOver) {
            break;
        }
        
        var guess = guesses[i];
        print("\nGuessing: " + guess);
        game.makeGuess(guess);
        
        // Ask for hint after 3 guesses
        if (i == 3 && !game.gameOver) {
            print("\nAsking for a hint...");
            game.getHint();
        }
    }
    
    print("\n--- Game Statistics ---");
    print("Total attempts: " + game.attempts);
    print("Game won: " + toString(game.won));
}

// Interactive game function (would use input() in real implementation)
func playInteractiveDemo() {
    print("\n=== Interactive Demo ===");
    print("In a real implementation, you would use input() to get guesses.");
    print("For now, let's simulate a game:\n");
    
    simulateGame();
}

// Leaderboard class to track high scores
class Leaderboard {
    constructor() {
        this.scores = [];
    }
    
    addScore(name, attempts) {
        var score = {
            player: name,
            attempts: attempts,
            rank: 0
        };
        push(this.scores, score);
        this.updateRanks();
    }
    
    updateRanks() {
        // Simple bubble sort for ranking
        var n = this.scores.length;
        for (var i = 0; i < n - 1; i = i + 1) {
            for (var j = 0; j < n - i - 1; j = j + 1) {
                if (this.scores[j].attempts > this.scores[j + 1].attempts) {
                    // Swap
                    var temp = this.scores[j];
                    this.scores[j] = this.scores[j + 1];
                    this.scores[j + 1] = temp;
                }
            }
        }
        
        // Update ranks
        for (var i = 0; i < n; i = i + 1) {
            this.scores[i].rank = i + 1;
        }
    }
    
    display() {
        print("\n🏆 Leaderboard 🏆");
        print("Rank | Player | Attempts");
        print("-----|--------|----------");
        
        var scores = this.scores;
        for (var i = 0; i < scores.length; i = i + 1) {
            var score = scores[i];
            print("  " + score.rank + "  | " + score.player + " | " + score.attempts);
        }
    }
}

// Main game execution
print("\n--- Game Features ---");
print("• Guess a number between 1 and 100");
print("• Get hints after 3 attempts");
print("• Maximum 10 attempts allowed");
print("• Track your score on the leaderboard");

// Play the demo
playInteractiveDemo();

// Show leaderboard example
var leaderboard = new Leaderboard();
leaderboard.addScore("Alice", 5);
leaderboard.addScore("Bob", 7);
leaderboard.addScore("Charlie", 4);
leaderboard.addScore("David", 6);

leaderboard.display();

print("\n=== Thanks for playing! ===");