// Evil Lang String Functions Example
// 字符串函数示例

print("=== String Basic Operations ===");

// String length
var greeting = "Hello, World!";
print("String: " + greeting);
print("Length: " + greeting.length);

// Character access
print("\nFirst char: " + charAt(greeting, 0));
print("Last char: " + charAt(greeting, greeting.length - 1));

// Case conversion
print("\n=== Case Conversion ===");
var text = "Hello World";
print("Original: " + text);
print("Uppercase: " + toUpper(text));
print("Lowercase: " + toLower(text));

// Substring operations
print("\n=== Substring Operations ===");
var sentence = "The quick brown fox";
print("Original: " + sentence);
print("Substring(4, 9): " + substring(sentence, 4, 9));
print("Substring(10): " + substring(sentence, 10));

// String search
print("\n=== String Search ===");
print("Index of 'quick': " + indexOf(sentence, "quick"));
print("Index of 'slow': " + indexOf(sentence, "slow"));

// String replacement
print("\n=== String Replace ===");
var message = "Hello, Hello, Hello!";
print("Original: " + message);
print("Replace 'Hello' with 'Hi': " + replace(message, "Hello", "Hi"));

// String trimming
print("\n=== String Trim ===");
var padded = "   Hello World   ";
print("Original: '" + padded + "'");
print("Trimmed: '" + trim(padded) + "'");

// String split and join
print("\n=== String Split/Join ===");
var csv = "apple,banana,orange,grape";
print("CSV: " + csv);
var fruits = split(csv, ",");
print("Split result:");
for (var i = 0; i < fruits.length; i = i + 1) {
    print("  [" + i + "] " + fruits[i]);
}

// Join with different separator
var joined = join(" | ", fruits);
print("Joined with ' | ': " + joined);

// Split by whitespace
var words = "  Hello   World   From   Evil   Lang  ";
var wordArray = split(trim(words));
print("\nSplit by whitespace: ");
for (var i = 0; i < wordArray.length; i = i + 1) {
    print("  Word " + i + ": '" + wordArray[i] + "'");
}

// Practical example: Email validation
print("\n=== Email Validation Example ===");

func isValidEmail(email) {
    // Basic email validation
    var atIndex = indexOf(email, "@");
    if (atIndex <= 0) {
        return false;
    }
    
    var dotIndex = indexOf(email, ".");
    if (dotIndex <= atIndex + 1) {
        return false;
    }
    
    // Check if there's content after the dot
    if (dotIndex >= email.length - 1) {
        return false;
    }
    
    return true;
}

var emails = ["test@example.com", "invalid.email", "@test.com", "test@", "valid@email.org"];
for (var i = 0; i < emails.length; i = i + 1) {
    var email = emails[i];
    print(email + " is " + (isValidEmail(email) ? "valid" : "invalid"));
}

// String concatenation example
print("\n=== String Building ===");
var parts = ["Hello", " ", "from", " ", "Evil", " ", "Lang", "!"];
var result = "";
for (var i = 0; i < parts.length; i = i + 1) {
    result = stringConcat(result, parts[i]);
}
print("Built string: " + result);