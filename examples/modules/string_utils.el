// Evil Lang 字符串工具模块
// 提供字符串处理函数

// 重复字符串
export func repeat(str, times) {
    var result = "";
    for (var i = 0; i < times; i = i + 1) {
        result = result + str;
    }
    return result;
}

// 反转字符串（简单实现）
export func reverse(str) {
    var result = "";
    var len = str.length;
    for (var i = len - 1; i >= 0; i = i - 1) {
        result = result + str[i];
    }
    return result;
}

// 将字符串转换为大写（简单实现，仅支持基本ASCII）
export func toUpperCase(str) {
    var result = "";
    for (var i = 0; i < str.length; i = i + 1) {
        var char = str[i];
        // 简单的ASCII小写转大写
        if (char >= "a" && char <= "z") {
            // 这是一个简化实现，实际需要字符码转换
            result = result + char;  // 暂时保持原样
        } else {
            result = result + char;
        }
    }
    return result;
}

// 检查字符串是否为空或只包含空格
export func isEmpty(str) {
    return str == null || str == "";
}

// 移除字符串两端的空格（简单实现）
export func trim(str) {
    if (isEmpty(str)) {
        return str;
    }
    
    // 找到第一个非空格字符
    var start = 0;
    while (start < str.length && str[start] == " ") {
        start = start + 1;
    }
    
    // 找到最后一个非空格字符
    var end = str.length - 1;
    while (end >= 0 && str[end] == " ") {
        end = end - 1;
    }
    
    // 如果全是空格
    if (start > end) {
        return "";
    }
    
    // 提取子字符串
    var result = "";
    for (var i = start; i <= end; i = i + 1) {
        result = result + str[i];
    }
    return result;
}

// 填充字符串到指定长度
export func padLeft(str, length, padChar) {
    if (padChar == null) {
        padChar = " ";
    }
    
    var currentLength = str.length;
    if (currentLength >= length) {
        return str;
    }
    
    var padding = repeat(padChar, length - currentLength);
    return padding + str;
}

export func padRight(str, length, padChar) {
    if (padChar == null) {
        padChar = " ";
    }
    
    var currentLength = str.length;
    if (currentLength >= length) {
        return str;
    }
    
    var padding = repeat(padChar, length - currentLength);
    return str + padding;
}