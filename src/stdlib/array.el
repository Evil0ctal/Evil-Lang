// Evil Lang 标准库 - 数组模块
// 提供数组操作函数

// 获取数组长度
export func length(arr) {
    return arr.length;
}

// 添加元素到数组末尾
export func push(arr, element) {
    arr[arr.length] = element;
    return arr;
}

// 从数组末尾移除元素
export func pop(arr) {
    if (arr.length == 0) {
        return null;
    }
    var lastIndex = arr.length - 1;
    var element = arr[lastIndex];
    // 暂时无法真正删除元素，返回新数组
    var newArr = [];
    for (var i = 0; i < lastIndex; i = i + 1) {
        newArr[i] = arr[i];
    }
    return element; // 返回被移除的元素
}

// 在数组开头添加元素
export func unshift(arr, element) {
    var newArr = [element];
    for (var i = 0; i < arr.length; i = i + 1) {
        newArr[i + 1] = arr[i];
    }
    return newArr;
}

// 从数组开头移除元素
export func shift(arr) {
    if (arr.length == 0) {
        return null;
    }
    var first = arr[0];
    var newArr = [];
    for (var i = 1; i < arr.length; i = i + 1) {
        newArr[i - 1] = arr[i];
    }
    return first; // 返回被移除的元素
}

// 连接两个数组
export func concat(arr1, arr2) {
    var result = [];
    var index = 0;
    
    for (var i = 0; i < arr1.length; i = i + 1) {
        result[index] = arr1[i];
        index = index + 1;
    }
    
    for (var i = 0; i < arr2.length; i = i + 1) {
        result[index] = arr2[i];
        index = index + 1;
    }
    
    return result;
}

// 获取数组切片
export func slice(arr, start, end) {
    if (start < 0) {
        start = arr.length + start;
    }
    if (end == null) {
        end = arr.length;
    }
    if (end < 0) {
        end = arr.length + end;
    }
    
    var result = [];
    var index = 0;
    
    for (var i = start; i < end && i < arr.length; i = i + 1) {
        result[index] = arr[i];
        index = index + 1;
    }
    
    return result;
}

// 查找元素的索引
export func indexOf(arr, element) {
    for (var i = 0; i < arr.length; i = i + 1) {
        if (arr[i] == element) {
            return i;
        }
    }
    return -1;
}

// 检查数组是否包含元素
export func includes(arr, element) {
    return indexOf(arr, element) != -1;
}

// 反转数组
export func reverse(arr) {
    var result = [];
    var len = arr.length;
    for (var i = 0; i < len; i = i + 1) {
        result[i] = arr[len - 1 - i];
    }
    return result;
}

// 映射函数
export func map(arr, fn) {
    var result = [];
    for (var i = 0; i < arr.length; i = i + 1) {
        result[i] = fn(arr[i], i, arr);
    }
    return result;
}

// 过滤函数
export func filter(arr, predicate) {
    var result = [];
    var index = 0;
    for (var i = 0; i < arr.length; i = i + 1) {
        if (predicate(arr[i], i, arr)) {
            result[index] = arr[i];
            index = index + 1;
        }
    }
    return result;
}

// 归约函数
export func reduce(arr, fn, initial) {
    var acc = initial;
    var start = 0;
    
    if (acc == null && arr.length > 0) {
        acc = arr[0];
        start = 1;
    }
    
    for (var i = start; i < arr.length; i = i + 1) {
        acc = fn(acc, arr[i], i, arr);
    }
    
    return acc;
}

// 查找满足条件的第一个元素
export func find(arr, predicate) {
    for (var i = 0; i < arr.length; i = i + 1) {
        if (predicate(arr[i], i, arr)) {
            return arr[i];
        }
    }
    return null;
}

// 检查是否所有元素都满足条件
export func every(arr, predicate) {
    for (var i = 0; i < arr.length; i = i + 1) {
        if (!predicate(arr[i], i, arr)) {
            return false;
        }
    }
    return true;
}

// 检查是否至少有一个元素满足条件
export func some(arr, predicate) {
    for (var i = 0; i < arr.length; i = i + 1) {
        if (predicate(arr[i], i, arr)) {
            return true;
        }
    }
    return false;
}

// 使用分隔符连接数组元素
export func join(arr, separator) {
    if (separator == null) {
        separator = ",";
    }
    
    if (arr.length == 0) {
        return "";
    }
    
    var result = "" + arr[0];
    for (var i = 1; i < arr.length; i = i + 1) {
        result = result + separator + arr[i];
    }
    
    return result;
}

// 创建指定范围的数组
export func range(start, end, step) {
    if (step == null) {
        step = 1;
    }
    
    var result = [];
    var index = 0;
    
    if (step > 0) {
        for (var i = start; i < end; i = i + step) {
            result[index] = i;
            index = index + 1;
        }
    } else if (step < 0) {
        for (var i = start; i > end; i = i + step) {
            result[index] = i;
            index = index + 1;
        }
    }
    
    return result;
}