// Evil Lang String Standard Library
// 字符串标准库

// Check if character is uppercase
// 检查字符是否为大写
export func isUpper(char) {
    return char >= 'A' && char <= 'Z';
}

// Check if character is lowercase
// 检查字符是否为小写
export func isLower(char) {
    return char >= 'a' && char <= 'z';
}

// Check if character is digit
// 检查字符是否为数字
export func isDigit(char) {
    return char >= '0' && char <= '9';
}

// Check if character is letter
// 检查字符是否为字母
export func isLetter(char) {
    return isUpper(char) || isLower(char);
}

// Check if character is alphanumeric
// 检查字符是否为字母或数字
export func isAlphaNum(char) {
    return isLetter(char) || isDigit(char);
}

// Check if string starts with prefix
// 检查字符串是否以前缀开始
export func startsWith(str, prefix) {
    if (prefix.length > str.length) {
        return false;
    }
    for (var i = 0; i < prefix.length; i = i + 1) {
        if (str[i] != prefix[i]) {
            return false;
        }
    }
    return true;
}

// Check if string ends with suffix
// 检查字符串是否以后缀结束
export func endsWith(str, suffix) {
    if (suffix.length > str.length) {
        return false;
    }
    var start = str.length - suffix.length;
    for (var i = 0; i < suffix.length; i = i + 1) {
        if (str[start + i] != suffix[i]) {
            return false;
        }
    }
    return true;
}

// Find index of substring
// 查找子字符串的索引
export func indexOf(str, substr) {
    var strLen = str.length;
    var subLen = substr.length;
    
    if (subLen > strLen) {
        return -1;
    }
    
    for (var i = 0; i <= strLen - subLen; i = i + 1) {
        var found = true;
        for (var j = 0; j < subLen; j = j + 1) {
            if (str[i + j] != substr[j]) {
                found = false;
                break;
            }
        }
        if (found) {
            return i;
        }
    }
    return -1;
}

// Extract substring
// 提取子字符串
export func substring(str, start, end) {
    if (start < 0) {
        start = 0;
    }
    if (end > str.length) {
        end = str.length;
    }
    if (start >= end) {
        return "";
    }
    
    var result = "";
    for (var i = start; i < end; i = i + 1) {
        result = result + str[i];
    }
    return result;
}

// Replace all occurrences of a substring
// 替换所有出现的子字符串
export func replace(str, search, replacement) {
    var result = "";
    var i = 0;
    var searchLen = search.length;
    
    while (i < str.length) {
        var found = true;
        if (i + searchLen <= str.length) {
            for (var j = 0; j < searchLen; j = j + 1) {
                if (str[i + j] != search[j]) {
                    found = false;
                    break;
                }
            }
        } else {
            found = false;
        }
        
        if (found) {
            result = result + replacement;
            i = i + searchLen;
        } else {
            result = result + str[i];
            i = i + 1;
        }
    }
    
    return result;
}

// Trim whitespace from both ends
// 去除两端的空白字符
export func trim(str) {
    var start = 0;
    var end = str.length - 1;
    
    // Find first non-whitespace character
    while (start < str.length) {
        var char = str[start];
        if (char != ' ' && char != '\t' && char != '\n' && char != '\r') {
            break;
        }
        start = start + 1;
    }
    
    // Find last non-whitespace character
    while (end >= 0) {
        var char = str[end];
        if (char != ' ' && char != '\t' && char != '\n' && char != '\r') {
            break;
        }
        end = end - 1;
    }
    
    if (start > end) {
        return "";
    }
    
    return substring(str, start, end + 1);
}

// Split string by delimiter
// 按分隔符分割字符串
export func split(str, delimiter) {
    var result = [];
    var current = "";
    var delimLen = delimiter.length;
    var i = 0;
    
    if (delimLen == 0) {
        // Split into individual characters
        for (i = 0; i < str.length; i = i + 1) {
            result[result.length] = str[i];
        }
        return result;
    }
    
    while (i < str.length) {
        var found = true;
        if (i + delimLen <= str.length) {
            for (var j = 0; j < delimLen; j = j + 1) {
                if (str[i + j] != delimiter[j]) {
                    found = false;
                    break;
                }
            }
        } else {
            found = false;
        }
        
        if (found) {
            result[result.length] = current;
            current = "";
            i = i + delimLen;
        } else {
            current = current + str[i];
            i = i + 1;
        }
    }
    
    // Add the last part
    result[result.length] = current;
    
    return result;
}

// Join array elements into string
// 将数组元素连接成字符串
export func join(arr, separator) {
    if (arr.length == 0) {
        return "";
    }
    
    var result = arr[0];
    for (var i = 1; i < arr.length; i = i + 1) {
        result = result + separator + arr[i];
    }
    return result;
}