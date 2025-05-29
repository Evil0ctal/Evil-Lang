#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 词法分析器 / Lexical Analyzer
# Author: Evil0ctal
# Date: 2025-05-04

from enum import Enum, auto


# 标记类型
class TokenType(Enum):
    """Token types enumeration 标记类型枚举"""
    NUMBER = auto()  # 数字
    STRING = auto()  # 字符串
    IDENTIFIER = auto()  # 标识符
    KEYWORD = auto()  # 关键字
    OPERATOR = auto()  # 操作符
    LPAREN = auto()  # 左括号
    RPAREN = auto()  # 右括号
    LBRACE = auto()  # 左花括号
    RBRACE = auto()  # 右花括号
    LBRACKET = auto()  # 左方括号 [
    RBRACKET = auto()  # 右方括号 ]
    SEMICOLON = auto()  # 分号
    COMMA = auto()  # 逗号 ,
    COLON = auto()  # 冒号 :
    DOT = auto()  # 点 .
    EOF = auto()  # 文件结束


# 关键词
KEYWORDS = {
    'var': 'VAR',
    'if': 'IF',
    'else': 'ELSE',
    'while': 'WHILE',
    'for': 'FOR',
    'print': 'PRINT',
    'input': 'INPUT',
    'true': 'TRUE',
    'false': 'FALSE',
    'null': 'NULL',
    'func': 'FUNC',
    'return': 'RETURN',
    'break': 'BREAK',
    'continue': 'CONTINUE',
    'array': 'ARRAY',
    'import': 'IMPORT',
    'export': 'EXPORT',
    'from': 'FROM',
    'as': 'AS',
    'class': 'CLASS',
    'extends': 'EXTENDS',
    'new': 'NEW',
    'this': 'THIS',
    'super': 'SUPER',
    'constructor': 'CONSTRUCTOR',
    'try': 'TRY',
    'catch': 'CATCH',
    'finally': 'FINALLY',
    'throw': 'THROW',
}


# 标记类
class Token:
    """Token class with position tracking 带位置追踪的标记类"""

    def __init__(self, token_type, value, line, column):
        self.type = token_type
        self.value = value
        self.line = line
        self.column = column

    def __str__(self):
        return f"Token({self.type}, '{self.value}', {self.line}:{self.column})"


# 词法分析器
class Lexer:
    """Lexical analyzer with Unicode support 支持Unicode的词法分析器"""

    def __init__(self, source_code):
        self.source = source_code
        self.position = 0
        self.line = 1
        self.column = 1
        self.current_char = self.source[0] if self.source else None

    def save_state(self):
        """Save the current lexer state 保存当前词法分析器状态"""
        return {
            'position': self.position,
            'line': self.line,
            'column': self.column,
            'current_char': self.current_char
        }

    def restore_state(self, state):
        """Restore the lexer to a saved state 恢复词法分析器到保存的状态"""
        self.position = state['position']
        self.line = state['line']
        self.column = state['column']
        self.current_char = state['current_char']

    def advance(self):
        """Advance to next character 前进到下一个字符"""
        self.position += 1

        if self.current_char == '\n':
            self.line += 1
            self.column = 1
        else:
            self.column += 1

        self.current_char = self.source[self.position] if self.position < len(self.source) else None

    def skip_whitespace(self):
        """Skip whitespace characters 跳过空白字符"""
        while self.current_char is not None and self.current_char.isspace():
            self.advance()

    def skip_comment(self):
        """Skip single-line comments 跳过双斜杠后的单行注释"""
        if self.current_char == '/' and self.peek() == '/':
            self.advance()  # 跳过第一个斜杠
            self.advance()  # 跳过第二个斜杠

            while self.current_char is not None and self.current_char != '\n':
                self.advance()

    def peek(self):
        """Look ahead one character 向前查看一个字符"""
        peek_pos = self.position + 1
        if peek_pos >= len(self.source):
            return None
        return self.source[peek_pos]

    def get_number(self):
        """Parse numeric literals 解析数字字面量"""
        start_column = self.column
        result = ''

        while self.current_char is not None and (self.current_char.isdigit() or self.current_char == '.'):
            result += self.current_char
            self.advance()

        try:
            if '.' in result:
                return Token(TokenType.NUMBER, float(result), self.line, start_column)
            else:
                return Token(TokenType.NUMBER, int(result), self.line, start_column)
        except ValueError:
            raise Exception(f"Invalid number format: {result} at {self.line}:{start_column}")

    def get_identifier(self):
        """Parse identifiers and keywords 解析标识符和关键词"""
        start_column = self.column
        start_line = self.line
        result = ''

        while self.current_char is not None and (self.current_char.isalnum() or self.current_char == '_'):
            result += self.current_char
            self.advance()

        # First check if it's a keyword
        if result in KEYWORDS:
            token_type = TokenType.KEYWORD
            token_value = KEYWORDS[result]
        else:
            token_type = TokenType.IDENTIFIER
            token_value = result

        return Token(token_type, token_value, start_line, start_column)

    def get_string(self):
        """Parse string literals with escape sequences 解析带转义序列的字符串字面量"""
        start_column = self.column
        self.advance()  # 跳过开始的引号
        result = ''

        while self.current_char is not None and self.current_char != '"':
            if self.current_char == '\\':
                self.advance()
                if self.current_char == 'n':
                    result += '\n'
                elif self.current_char == 't':
                    result += '\t'
                elif self.current_char == '\\':
                    result += '\\'
                elif self.current_char == '"':
                    result += '"'
                else:
                    result += '\\' + self.current_char
            else:
                result += self.current_char
            self.advance()

        if self.current_char is None:
            raise Exception(f"Unterminated string at {self.line}:{start_column}")

        self.advance()  # 跳过结束的引号
        return Token(TokenType.STRING, result, self.line, start_column)

    def get_next_token(self):
        """Main tokenization loop 标记化主循环"""
        while self.current_char is not None:
            # 跳过空白字符
            if self.current_char.isspace():
                self.skip_whitespace()
                continue

            # 跳过注释
            if self.current_char == '/' and self.peek() == '/':
                self.skip_comment()
                continue

            # 数字
            if self.current_char.isdigit():
                return self.get_number()

            # 标识符和关键词
            if self.current_char.isalpha() or self.current_char == '_':
                return self.get_identifier()

            # 字符串
            if self.current_char == '"':
                return self.get_string()

            # 各种标点符号和操作符
            if self.current_char == '(':
                token = Token(TokenType.LPAREN, '(', self.line, self.column)
                self.advance()
                return token

            if self.current_char == ')':
                token = Token(TokenType.RPAREN, ')', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '{':
                token = Token(TokenType.LBRACE, '{', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '}':
                token = Token(TokenType.RBRACE, '}', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '[':
                token = Token(TokenType.LBRACKET, '[', self.line, self.column)
                self.advance()
                return token

            if self.current_char == ']':
                token = Token(TokenType.RBRACKET, ']', self.line, self.column)
                self.advance()
                return token

            if self.current_char == ',':
                token = Token(TokenType.COMMA, ',', self.line, self.column)
                self.advance()
                return token

            if self.current_char == ':':
                token = Token(TokenType.COLON, ':', self.line, self.column)
                self.advance()
                return token

            if self.current_char == '.':
                token = Token(TokenType.DOT, '.', self.line, self.column)
                self.advance()
                return token

            if self.current_char == ';':
                token = Token(TokenType.SEMICOLON, ';', self.line, self.column)
                self.advance()
                return token

            # 操作符
            if self.current_char in '+-*/%=<>!&|?':  # 添加了 '?' 和 '%' 支持三元运算符和模运算
                column = self.column
                op = self.current_char
                self.advance()

                # 处理双字符操作符: ==, !=, <=, >=, &&, ||
                if self.current_char in '=&|':
                    if (op == '=' and self.current_char == '=') or \
                            (op == '!' and self.current_char == '=') or \
                            (op == '<' and self.current_char == '=') or \
                            (op == '>' and self.current_char == '=') or \
                            (op == '&' and self.current_char == '&') or \
                            (op == '|' and self.current_char == '|'):
                        op += self.current_char
                        self.advance()

                return Token(TokenType.OPERATOR, op, self.line, column)

            # 未识别的字符
            raise Exception(f"Unexpected character: '{self.current_char}' at {self.line}:{self.column}")

        # 文件结束
        return Token(TokenType.EOF, None, self.line, self.column)
