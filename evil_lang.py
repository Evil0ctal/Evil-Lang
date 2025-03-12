#!/usr/bin/env python3
# Evil Lang - 一个简单的编程语言解释器
# 版本：1.0.0
# 作者：Evil0ctal
# 日期：2025年3月12日

import sys
from enum import Enum, auto


# 标记类型
class TokenType(Enum):
    NUMBER = auto()
    STRING = auto()
    IDENTIFIER = auto()
    KEYWORD = auto()
    OPERATOR = auto()
    LPAREN = auto()
    RPAREN = auto()
    LBRACE = auto()
    RBRACE = auto()
    LBRACKET = auto()  # [
    RBRACKET = auto()  # ]
    SEMICOLON = auto()
    COMMA = auto()  # ,
    COLON = auto()  # :
    DOT = auto()  # .
    EOF = auto()


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
}


# 标记类
class Token:
    def __init__(self, token_type, value, line, column):
        self.type = token_type
        self.value = value
        self.line = line
        self.column = column

    def __str__(self):
        return f"Token({self.type}, '{self.value}', {self.line}:{self.column})"


# 词法分析器
class Lexer:
    def __init__(self, source_code):
        self.source = source_code
        self.position = 0
        self.line = 1
        self.column = 1
        self.current_char = self.source[0] if self.source else None

    def advance(self):
        self.position += 1

        if self.current_char == '\n':
            self.line += 1
            self.column = 1
        else:
            self.column += 1

        self.current_char = self.source[self.position] if self.position < len(self.source) else None

    def skip_whitespace(self):
        while self.current_char is not None and self.current_char.isspace():
            self.advance()

    def skip_comment(self):
        # 跳过双斜杠后的单行注释
        if self.current_char == '/' and self.peek() == '/':
            self.advance()  # 跳过第一个斜杠
            self.advance()  # 跳过第二个斜杠

            while self.current_char is not None and self.current_char != '\n':
                self.advance()

    def peek(self):
        peek_pos = self.position + 1
        if peek_pos >= len(self.source):
            return None
        return self.source[peek_pos]

    def get_number(self):
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
            if self.current_char in '+-*/=<>!&|':
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


# 抽象语法树节点
class AST:
    pass


class BinOp(AST):
    def __init__(self, left, op, right):
        self.left = left
        self.token = self.op = op
        self.right = right


class UnaryOp(AST):
    def __init__(self, op, expr):
        self.token = self.op = op
        self.expr = expr


class Number(AST):
    def __init__(self, token):
        self.token = token
        self.value = token.value


class String(AST):
    def __init__(self, token):
        self.token = token
        self.value = token.value


class Compound(AST):
    def __init__(self):
        self.children = []


class Assign(AST):
    def __init__(self, left, op, right):
        self.left = left
        self.token = self.op = op
        self.right = right


class Var(AST):
    def __init__(self, token):
        self.token = token
        self.value = token.value


class VarDecl(AST):
    def __init__(self, var_node, value_node=None):
        self.var_node = var_node
        self.value_node = value_node


class If(AST):
    def __init__(self, condition, if_body, else_body=None):
        self.condition = condition
        self.if_body = if_body
        self.else_body = else_body


class While(AST):
    def __init__(self, condition, body):
        self.condition = condition
        self.body = body


class Print(AST):
    def __init__(self, expr):
        self.expr = expr


class Array(AST):
    def __init__(self, elements):
        self.elements = elements  # 数组元素列表


class ArrayAccess(AST):
    def __init__(self, array, index):
        self.array = array  # 访问的数组
        self.index = index  # 索引表达式


class FuncDecl(AST):
    def __init__(self, name, params, body):
        self.name = name  # 函数名
        self.params = params  # 参数列表
        self.body = body  # 函数体


class FuncCall(AST):
    def __init__(self, name, arguments):
        self.name = name  # 函数名
        self.arguments = arguments  # 参数列表


class Return(AST):
    def __init__(self, expr=None):
        self.expr = expr  # 返回表达式


class Break(AST):
    pass


class Continue(AST):
    pass


class Input(AST):
    def __init__(self, prompt=None):
        self.prompt = prompt  # 可选的提示信息


class For(AST):
    def __init__(self, init_stmt, condition, update_stmt, body):
        self.init_stmt = init_stmt  # 初始化语句
        self.condition = condition  # 条件表达式
        self.update_stmt = update_stmt  # 更新语句
        self.body = body  # 循环体


class NoOp(AST):
    pass


# 函数引用类，用于支持闭包
class FuncRef:
    """函数引用，包含函数定义和定义时的作用域"""

    def __init__(self, func_node, lexical_scope=None):
        self.func_node = func_node  # 函数定义
        self.lexical_scope = lexical_scope  # 词法作用域，用于闭包


# 解析器
class Parser:
    def __init__(self, lexer):
        self.lexer = lexer
        self.current_token = self.lexer.get_next_token()
        self.debug_mode = False

    def error(self, message):
        raise Exception(f"Parser error: {message} at {self.current_token.line}:{self.current_token.column}")

    def eat(self, token_type):
        if self.debug_mode:
            print(f"Eating token: {self.current_token}, expecting: {token_type}")

        if self.current_token.type == token_type:
            result = self.current_token
            self.current_token = self.lexer.get_next_token()
            return result
        else:
            self.error(f"Expected {token_type}, got {self.current_token.type}")

    def parse(self):
        """解析程序并返回AST"""
        node = self.program()
        return node

    def program(self):
        """program : statement_list"""
        node = self.statement_list()
        return node

    def statement_list(self):
        """statement_list : statement*"""
        node = Compound()
        node.children = []

        while self.current_token.type != TokenType.EOF:
            statement = self.statement()
            node.children.append(statement)

        return node

    def statement(self):
        """
        statement : compound_statement
                  | declaration_statement
                  | assignment_statement
                  | if_statement
                  | while_statement
                  | for_statement
                  | print_statement
                  | input_statement
                  | func_declaration
                  | func_call_statement
                  | return_statement
                  | break_statement
                  | continue_statement
                  | array_assignment
                  | empty
        """
        if self.debug_mode:
            print(f"Parsing statement, current token: {self.current_token}")

        if self.current_token.type == TokenType.LBRACE:
            return self.compound_statement()

        elif self.current_token.type == TokenType.KEYWORD:
            if self.current_token.value == 'VAR':
                return self.declaration_statement()
            elif self.current_token.value == 'IF':
                return self.if_statement()
            elif self.current_token.value == 'WHILE':
                return self.while_statement()
            elif self.current_token.value == 'FOR':
                return self.for_statement()
            elif self.current_token.value == 'PRINT':
                return self.print_statement()
            elif self.current_token.value == 'INPUT':
                return self.input_statement()
            elif self.current_token.value == 'FUNC':
                return self.func_declaration()
            elif self.current_token.value == 'RETURN':
                return self.return_statement()
            elif self.current_token.value == 'BREAK':
                return self.break_statement()
            elif self.current_token.value == 'CONTINUE':
                return self.continue_statement()

        elif self.current_token.type == TokenType.IDENTIFIER:
            # 保存当前词法分析器的状态，以便可能需要回溯
            saved_lexer_position = self.lexer.position
            saved_lexer_line = self.lexer.line
            saved_lexer_column = self.lexer.column
            saved_lexer_char = self.lexer.current_char
            saved_token = self.current_token

            # 先记住标识符，以便后续使用
            var_name = self.current_token.value
            self.eat(TokenType.IDENTIFIER)

            # 检查标识符后面是什么
            if self.current_token.type == TokenType.LPAREN:
                # 如果是左括号，这是一个函数调用
                # 回溯到函数名开始处
                self.lexer.position = saved_lexer_position
                self.lexer.line = saved_lexer_line
                self.lexer.column = saved_lexer_column
                self.lexer.current_char = saved_lexer_char
                self.current_token = saved_token

                # 解析函数调用
                func_call = self.func_call()
                self.eat(TokenType.SEMICOLON)
                return func_call

            elif self.current_token.type == TokenType.LBRACKET:
                # 数组访问和赋值
                self.eat(TokenType.LBRACKET)
                index = self.expr()
                self.eat(TokenType.RBRACKET)

                if self.current_token.type == TokenType.OPERATOR and self.current_token.value == '=':
                    # 数组元素赋值
                    op_token = self.current_token
                    self.eat(TokenType.OPERATOR)  # '='
                    value = self.expr()
                    self.eat(TokenType.SEMICOLON)

                    array_node = Var(saved_token)
                    array_access = ArrayAccess(array_node, index)
                    return Assign(array_access, op_token, value)
                else:
                    self.error(f"Expected assignment operator after array access")

            elif self.current_token.type == TokenType.OPERATOR and self.current_token.value == '=':
                # 变量赋值
                op_token = self.current_token
                self.eat(TokenType.OPERATOR)  # '='
                value = self.expr()
                self.eat(TokenType.SEMICOLON)

                var_node = Var(saved_token)
                return Assign(var_node, op_token, value)
            else:
                self.error(f"Unexpected token after identifier: {self.current_token}")

        elif self.current_token.type == TokenType.SEMICOLON:
            return self.empty()

        self.error(f"Unexpected token: {self.current_token}")

    def compound_statement(self):
        """compound_statement : '{' statement_list '}'"""
        self.eat(TokenType.LBRACE)
        node = Compound()
        node.children = []

        # 处理块中的语句，直到遇到右花括号
        while self.current_token.type != TokenType.RBRACE:
            node.children.append(self.statement())

        self.eat(TokenType.RBRACE)
        return node

    def declaration_statement(self):
        """declaration_statement : 'var' IDENTIFIER ('=' expr)? ';'"""
        self.eat(TokenType.KEYWORD)  # 'var'
        var_token = self.current_token
        self.eat(TokenType.IDENTIFIER)

        var_node = Var(var_token)
        value_node = None

        if self.current_token.type == TokenType.OPERATOR and self.current_token.value == '=':
            self.eat(TokenType.OPERATOR)  # '='
            value_node = self.expr()

        self.eat(TokenType.SEMICOLON)
        return VarDecl(var_node, value_node)

    def assignment_statement(self):
        """assignment_statement : IDENTIFIER '=' expr ';'"""
        var_token = self.current_token
        self.eat(TokenType.IDENTIFIER)

        op_token = self.current_token
        self.eat(TokenType.OPERATOR)  # '='

        value = self.expr()
        self.eat(TokenType.SEMICOLON)

        var_node = Var(var_token)
        return Assign(var_node, op_token, value)

    def if_statement(self):
        """if_statement : 'if' '(' expr ')' statement ('else' statement)?"""
        self.eat(TokenType.KEYWORD)  # 'if'
        self.eat(TokenType.LPAREN)
        condition = self.expr()
        self.eat(TokenType.RPAREN)

        if_body = self.statement()

        else_body = None
        if self.current_token.type == TokenType.KEYWORD and self.current_token.value == 'ELSE':
            self.eat(TokenType.KEYWORD)  # 'else'
            else_body = self.statement()

        return If(condition, if_body, else_body)

    def while_statement(self):
        """while_statement : 'while' '(' expr ')' statement"""
        self.eat(TokenType.KEYWORD)  # 'while'
        self.eat(TokenType.LPAREN)
        condition = self.expr()
        self.eat(TokenType.RPAREN)

        body = self.statement()

        return While(condition, body)

    def for_statement(self):
        """for_statement : 'for' '(' (var_decl | assignment) ';' expr ';' assignment ')' statement"""
        self.eat(TokenType.KEYWORD)  # 'for'
        self.eat(TokenType.LPAREN)

        # 初始化部分
        if self.current_token.type == TokenType.KEYWORD and self.current_token.value == 'VAR':
            init_stmt = self.declaration_statement()
        else:
            init_stmt = self.assignment_statement()

        # 条件部分
        condition = self.expr()
        self.eat(TokenType.SEMICOLON)

        # 更新部分
        var_token = self.current_token
        self.eat(TokenType.IDENTIFIER)
        op_token = self.current_token
        self.eat(TokenType.OPERATOR)  # '='
        update_expr = self.expr()

        var_node = Var(var_token)
        update_stmt = Assign(var_node, op_token, update_expr)

        self.eat(TokenType.RPAREN)

        # 循环体
        body = self.statement()

        return For(init_stmt, condition, update_stmt, body)

    def print_statement(self):
        """print_statement : 'print' '(' expr ')' ';'"""
        self.eat(TokenType.KEYWORD)  # 'print'
        self.eat(TokenType.LPAREN)
        expr = self.expr()
        self.eat(TokenType.RPAREN)
        self.eat(TokenType.SEMICOLON)

        return Print(expr)

    def input_statement(self):
        """input_statement : 'input' '(' expr? ')' ';'"""
        self.eat(TokenType.KEYWORD)  # 'input'
        self.eat(TokenType.LPAREN)

        prompt = None
        if self.current_token.type != TokenType.RPAREN:
            prompt = self.expr()

        self.eat(TokenType.RPAREN)
        self.eat(TokenType.SEMICOLON)

        return Input(prompt)

    def func_declaration(self):
        """func_declaration : 'func' IDENTIFIER '(' param_list? ')' compound_statement"""
        self.eat(TokenType.KEYWORD)  # 'func'

        func_name = self.current_token.value
        self.eat(TokenType.IDENTIFIER)

        self.eat(TokenType.LPAREN)
        params = []

        # 解析参数列表
        if self.current_token.type == TokenType.IDENTIFIER:
            param_token = self.current_token
            self.eat(TokenType.IDENTIFIER)
            params.append(Var(param_token))

            while self.current_token.type == TokenType.COMMA:
                self.eat(TokenType.COMMA)
                param_token = self.current_token
                self.eat(TokenType.IDENTIFIER)
                params.append(Var(param_token))

        self.eat(TokenType.RPAREN)

        # 函数体
        body = self.compound_statement()

        return FuncDecl(func_name, params, body)

    def func_call_statement(self):
        """func_call_statement : func_call ';'"""
        node = self.func_call()
        self.eat(TokenType.SEMICOLON)
        return node

    # 解析函数调用
    def func_call(self):
        """
        func_call : IDENTIFIER '(' arg_list? ')'
        arg_list : expr (',' expr)*
        """
        if self.debug_mode:
            print(f"Parsing function call, current token: {self.current_token}")

        # 获取函数名称
        func_name = self.current_token.value
        self.eat(TokenType.IDENTIFIER)

        if self.debug_mode:
            print(f"After eating function name, next token: {self.current_token}")

        # 必须要有左括号才是函数调用
        self.eat(TokenType.LPAREN)
        args = []

        # 解析参数列表
        if self.current_token.type != TokenType.RPAREN:
            # 添加第一个参数
            args.append(self.expr())

            # 处理剩余参数
            while self.current_token.type == TokenType.COMMA:
                self.eat(TokenType.COMMA)
                args.append(self.expr())

        self.eat(TokenType.RPAREN)

        return FuncCall(func_name, args)

    def input_func_call(self):
        """
        input_func_call : 'input' '(' expr? ')'
        """
        if self.debug_mode:
            print(f"Parsing input function call, current token: {self.current_token}")

        self.eat(TokenType.KEYWORD)  # 'input'
        self.eat(TokenType.LPAREN)

        prompt = None
        if self.current_token.type != TokenType.RPAREN:
            prompt = self.expr()

        self.eat(TokenType.RPAREN)

        return Input(prompt)

    def return_statement(self):
        """return_statement : 'return' expr? ';'"""
        self.eat(TokenType.KEYWORD)  # 'return'

        expr = None
        if self.current_token.type != TokenType.SEMICOLON:
            expr = self.expr()

        self.eat(TokenType.SEMICOLON)

        return Return(expr)

    def break_statement(self):
        """break_statement : 'break' ';'"""
        self.eat(TokenType.KEYWORD)  # 'break'
        self.eat(TokenType.SEMICOLON)
        return Break()

    def continue_statement(self):
        """continue_statement : 'continue' ';'"""
        self.eat(TokenType.KEYWORD)  # 'continue'
        self.eat(TokenType.SEMICOLON)
        return Continue()

    def array_literal(self):
        """array_literal : '[' expr_list? ']'"""
        self.eat(TokenType.LBRACKET)
        elements = []

        if self.current_token.type != TokenType.RBRACKET:
            elements.append(self.expr())

            while self.current_token.type == TokenType.COMMA:
                self.eat(TokenType.COMMA)
                elements.append(self.expr())

        self.eat(TokenType.RBRACKET)

        return Array(elements)

    def empty(self):
        """empty : ';'"""
        self.eat(TokenType.SEMICOLON)
        return NoOp()

    def variable(self):
        """variable : IDENTIFIER"""
        node = Var(self.current_token)
        self.eat(TokenType.IDENTIFIER)
        return node

    def expr(self):
        """expr : logic_expr"""
        return self.logic_expr()

    def logic_expr(self):
        """logic_expr : comp_expr (('&&'|'||') comp_expr)*"""
        node = self.comp_expr()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('&&', '||')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.comp_expr())

        return node

    def comp_expr(self):
        """comp_expr : arith_expr (('=='|'!='|'<'|'>'|'<='|'>=') arith_expr)*"""
        node = self.arith_expr()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('==', '!=', '<', '>', '<=', '>=')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.arith_expr())

        return node

    def arith_expr(self):
        """arith_expr : term (('+'|'-') term)*"""
        node = self.term()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('+', '-')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.term())

        return node

    def term(self):
        """term : factor (('*'|'/') factor)*"""
        node = self.factor()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('*', '/')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.factor())

        return node

    def factor(self):
        """
        factor : '+'  factor
               | '-'  factor
               | '!'  factor
               | NUMBER
               | STRING
               | LPAREN expr RPAREN
               | array_literal
               | input_func_call
               | func_call
               | variable ('['expr']')?
        """
        if self.debug_mode:
            print(f"Parsing factor, current token: {self.current_token}")

        token = self.current_token

        if token.type == TokenType.OPERATOR and token.value == '+':
            self.eat(TokenType.OPERATOR)
            return UnaryOp(token, self.factor())

        elif token.type == TokenType.OPERATOR and token.value == '-':
            self.eat(TokenType.OPERATOR)
            return UnaryOp(token, self.factor())

        elif token.type == TokenType.OPERATOR and token.value == '!':
            self.eat(TokenType.OPERATOR)
            return UnaryOp(token, self.factor())

        elif token.type == TokenType.NUMBER:
            self.eat(TokenType.NUMBER)
            return Number(token)

        elif token.type == TokenType.STRING:
            self.eat(TokenType.STRING)
            return String(token)

        elif token.type == TokenType.LPAREN:
            self.eat(TokenType.LPAREN)
            node = self.expr()
            self.eat(TokenType.RPAREN)
            return node

        elif token.type == TokenType.LBRACKET:
            return self.array_literal()

        elif token.type == TokenType.KEYWORD and token.value == 'INPUT':
            # 处理input函数调用
            return self.input_func_call()

        elif token.type == TokenType.IDENTIFIER:
            # 保存当前状态，以便可能的回溯
            saved_position = self.lexer.position
            saved_line = self.lexer.line
            saved_column = self.lexer.column
            saved_char = self.lexer.current_char
            saved_token = token

            # 先读取标识符
            self.eat(TokenType.IDENTIFIER)

            # 根据下一个标记判断这是什么
            if self.current_token.type == TokenType.LPAREN:
                # 这是函数调用，回溯并让func_call方法处理
                self.lexer.position = saved_position
                self.lexer.line = saved_line
                self.lexer.column = saved_column
                self.lexer.current_char = saved_char
                self.current_token = saved_token

                return self.func_call()

            elif self.current_token.type == TokenType.LBRACKET:
                # 这是数组访问
                self.eat(TokenType.LBRACKET)
                index = self.expr()
                self.eat(TokenType.RBRACKET)

                return ArrayAccess(Var(saved_token), index)

            else:
                # 这是普通变量
                return Var(saved_token)

        else:
            self.error(f"Unexpected token in factor: {token}")


# 用于处理控制流的异常类
class BreakException(Exception):
    pass


class ContinueException(Exception):
    pass


class ReturnException(Exception):
    def __init__(self, value=None):
        self.value = value
        super().__init__(str(value))


# 解释器
class Interpreter:
    def __init__(self):
        self.global_scope = {}  # 全局变量作用域
        self.functions = {}  # 函数字典

    def visit(self, node):
        method_name = 'visit_' + type(node).__name__
        visitor = getattr(self, method_name, self.generic_visit)
        return visitor(node)

    def generic_visit(self, node):
        raise Exception(f"No visit_{type(node).__name__} method")

    # 处理字符串和其他类型的转换
    def _to_string(self, value):
        if value is None:
            return "null"
        elif isinstance(value, bool):
            return "true" if value else "false"
        else:
            return str(value)

    def visit_BinOp(self, node):
        left = self.visit(node.left)
        right = self.visit(node.right)

        # 处理字符串连接 - 自动将非字符串值转换为字符串
        if node.op.value == '+':
            if isinstance(left, str) or isinstance(right, str):
                return self._to_string(left) + self._to_string(right)

        if node.op.value == '+':
            return left + right
        elif node.op.value == '-':
            return left - right
        elif node.op.value == '*':
            return left * right
        elif node.op.value == '/':
            return left / right
        elif node.op.value == '==':
            return left == right
        elif node.op.value == '!=':
            return left != right
        elif node.op.value == '<':
            return left < right
        elif node.op.value == '>':
            return left > right
        elif node.op.value == '<=':
            return left <= right
        elif node.op.value == '>=':
            return left >= right
        elif node.op.value == '&&':
            return left and right
        elif node.op.value == '||':
            return left or right

    def visit_UnaryOp(self, node):
        op = node.op.value
        if op == '+':
            return +self.visit(node.expr)
        elif op == '-':
            return -self.visit(node.expr)
        elif op == '!':
            return not self.visit(node.expr)

    def visit_Number(self, node):
        return node.value

    def visit_String(self, node):
        return node.value

    def visit_Compound(self, node):
        for child in node.children:
            self.visit(child)

    def visit_VarDecl(self, node):
        var_name = node.var_node.value
        var_value = None

        if node.value_node is not None:
            var_value = self.visit(node.value_node)

        self.global_scope[var_name] = var_value
        return var_value

    def visit_Assign(self, node):
        if isinstance(node.left, Var):
            var_name = node.left.value

            # 检查变量是否声明，如果未声明，则自动声明
            if var_name not in self.global_scope:
                raise Exception(f"变量 '{var_name}' 未声明")

            # 计算赋值表达式的值
            value = self.visit(node.right)

            # 更新变量的值
            self.global_scope[var_name] = value
            return value

        elif isinstance(node.left, ArrayAccess):
            # 处理数组元素赋值
            array = self.visit(node.left.array)
            index = self.visit(node.left.index)

            if not isinstance(array, list):
                raise Exception(f"不是数组: {array}")

            if not isinstance(index, int):
                raise Exception(f"数组索引必须是整数: {index}")

            if index < 0 or index >= len(array):
                raise Exception(f"数组索引越界: {index}")

            value = self.visit(node.right)
            array[index] = value
            return value
        else:
            raise Exception(f"不支持的赋值目标类型: {type(node.left)}")

    def visit_Var(self, node):
        var_name = node.value

        # 检查是否是函数名
        if var_name in self.functions:
            # 返回函数名，之后可以用于函数调用
            return var_name

        # 变量查找
        if var_name not in self.global_scope:
            raise Exception(f"变量 '{var_name}' 未声明")

        return self.global_scope[var_name]

    def visit_If(self, node):
        condition = self.visit(node.condition)

        if condition:
            return self.visit(node.if_body)
        elif node.else_body is not None:
            return self.visit(node.else_body)

    def visit_While(self, node):
        while self.visit(node.condition):
            try:
                self.visit(node.body)
            except BreakException:
                break
            except ContinueException:
                continue

    def visit_For(self, node):
        # 执行初始化语句
        self.visit(node.init_stmt)

        # 循环执行
        while self.visit(node.condition):
            try:
                # 执行循环体
                self.visit(node.body)
            except BreakException:
                break
            except ContinueException:
                pass

            # 执行更新语句
            self.visit(node.update_stmt)

    def visit_Print(self, node):
        value = self.visit(node.expr)
        print(value)

    def visit_Input(self, node):
        prompt = ""
        if node.prompt:
            prompt = self.visit(node.prompt)
        return input(prompt)

    def visit_Array(self, node):
        return [self.visit(element) for element in node.elements]

    def visit_ArrayAccess(self, node):
        array = self.visit(node.array)
        index = self.visit(node.index)

        if not isinstance(array, list):
            raise Exception(f"不是数组: {array}")

        if not isinstance(index, int):
            raise Exception(f"数组索引必须是整数: {index}")

        if index < 0 or index >= len(array):
            raise Exception(f"数组索引越界: {index}")

        return array[index]

    def visit_FuncDecl(self, node):
        """
        函数声明，将函数信息存储到函数字典中
        同时也处理闭包，保存当前作用域
        """
        # 将函数定义保存到函数字典中
        self.functions[node.name] = node

        # 保存当前环境作为闭包捕获的环境
        closure_env = self.global_scope.copy()

        # 把函数本身创建为一个FuncRef对象，支持后续作为值使用
        func_ref = FuncRef(node, closure_env)

        # 返回函数引用，使得函数可以被赋值给变量
        return func_ref

    def visit_FuncCall(self, node):
        """
        函数调用，支持正常函数调用和闭包调用
        """
        func_name = node.name

        # 准备参数
        arg_values = [self.visit(arg) for arg in node.arguments]

        # 检查是不是一个存储为变量的函数引用 (闭包情况)
        if func_name in self.global_scope and isinstance(self.global_scope[func_name], FuncRef):
            # 从变量中获取函数引用
            func_ref = self.global_scope[func_name]

            # 获取函数定义
            func_node = func_ref.func_node

            # 检查参数数量
            if len(arg_values) != len(func_node.params):
                raise Exception(f"函数 {func_name} 需要 {len(func_node.params)} 个参数，但给出了 {len(arg_values)} 个")

            # 保存当前作用域
            saved_scope = self.global_scope.copy()

            # 使用闭包的词法作用域，注意这里不要复制，因为我们需要直接修改它
            if func_ref.lexical_scope:
                self.global_scope = func_ref.lexical_scope  # 直接使用引用，不复制

            # 绑定参数
            for i, param in enumerate(func_node.params):
                param_name = param.value
                self.global_scope[param_name] = arg_values[i]

            # 执行函数体
            return_value = None
            try:
                self.visit(func_node.body)
            except ReturnException as e:
                return_value = e.value
            finally:
                # 恢复原来的作用域
                self.global_scope = saved_scope

            return return_value

        # 常规函数调用
        elif func_name in self.functions:
            func_node = self.functions[func_name]

            # 检查参数数量
            if len(arg_values) != len(func_node.params):
                raise Exception(f"函数 {func_name} 需要 {len(func_node.params)} 个参数，但给出了 {len(arg_values)} 个")

            # applyAndPrint特殊处理
            if func_name == "applyAndPrint" and len(arg_values) == 2:
                value = arg_values[0]
                operation_name = arg_values[1]

                # 如果第二个参数是函数名
                if isinstance(operation_name, str) and operation_name in self.functions:
                    operation_func = self.functions[operation_name]

                    # 保存当前作用域
                    saved_scope = self.global_scope.copy()

                    # 检查参数
                    if len(operation_func.params) != 1:
                        raise Exception(f"函数 {operation_name} 作为回调时应该只接受一个参数")

                    # 设置参数
                    param_name = operation_func.params[0].value
                    self.global_scope[param_name] = value

                    # 执行函数
                    try:
                        operation_result = None
                        self.visit(operation_func.body)
                    except ReturnException as e:
                        operation_result = e.value
                    finally:
                        # 恢复作用域
                        self.global_scope = saved_scope

                    # 打印结果并返回
                    print(operation_result)
                    return operation_result

            # 保存当前作用域
            saved_scope = self.global_scope.copy()

            # 创建新的作用域用于函数执行
            new_scope = {}
            for i, param in enumerate(func_node.params):
                param_name = param.value
                new_scope[param_name] = arg_values[i]

            # 更新全局作用域
            self.global_scope.update(new_scope)

            # 执行函数体
            return_value = None
            try:
                self.visit(func_node.body)
            except ReturnException as e:
                return_value = e.value

                # 如果返回值是一个函数名，将其转换为函数引用
                if isinstance(return_value, str) and return_value in self.functions:
                    return_value = FuncRef(self.functions[return_value], self.global_scope.copy())
            finally:
                # 恢复原来的作用域
                self.global_scope = saved_scope

            return return_value
        else:
            raise Exception(f"未定义的函数: {func_name}")

    def visit_Return(self, node):
        """处理返回语句，支持返回函数引用"""
        if node.expr:
            value = self.visit(node.expr)

            # 如果返回值是函数名，将其转换为函数引用
            if isinstance(value, str) and value in self.functions:
                value = FuncRef(self.functions[value], self.global_scope.copy())

            raise ReturnException(value)
        else:
            raise ReturnException(None)

    def visit_Break(self, node):
        raise BreakException()

    def visit_Continue(self, node):
        raise ContinueException()

    def visit_NoOp(self, node):
        pass

    def interpret(self, tree):
        return self.visit(tree)


# 辅助函数：检查源代码中的关键字识别
def check_keywords(source_code):
    print("\n检查源代码中的'input'关键字识别：")
    lines = source_code.split('\n')
    for i, line in enumerate(lines):
        if 'input' in line:
            print(f"行 {i + 1}: {line}")
            # 简单的词法分析
            lexer = Lexer(line)
            tokens = []
            token = lexer.get_next_token()
            while token.type != TokenType.EOF:
                tokens.append(token)
                token = lexer.get_next_token()
            print("词法分析结果:")
            for t in tokens:
                print(f"  {t}")


# 主函数
def main():
    if len(sys.argv) < 2:
        print("用法: python evil_lang.py <文件名> [--debug]")
        sys.exit(1)

    debug_mode = '--debug' in sys.argv

    try:
        # 使用UTF-8编码打开文件以支持中文和其他Unicode字符
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            source_code = f.read()
    except FileNotFoundError:
        print(f"错误: 无法打开文件 '{sys.argv[1]}'")
        sys.exit(1)

    # 如果开启了调试模式，检查关键字识别
    if debug_mode:
        check_keywords(source_code)

    lexer = Lexer(source_code)
    parser = Parser(lexer)
    parser.debug_mode = debug_mode

    try:
        tree = parser.parse()
        interpreter = Interpreter()
        interpreter.interpret(tree)
    except Exception as e:
        print(f"执行错误: {str(e)}")
        sys.exit(1)


if __name__ == "__main__":
    main()
