#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Evil Lang - 语法分析器 / Parser
# Author: Evil0ctal
# Date: 2025-05-04

from .ast import *
from .lexer import TokenType
from .errors import SyntaxError, EvilLangError


class Parser:
    """Recursive descent parser with error recovery 带错误恢复的递归下降解析器"""

    def __init__(self, lexer):
        self.lexer = lexer
        self.current_token = self.lexer.get_next_token()
        self.debug_mode = False

    def error(self, error_code, token):
        """Raise a parser error with detailed information"""
        expected_token_name = self.current_token.type.name if hasattr(self, 'current_token') else "Unknown"
        got_token_name = token.type.name if hasattr(token, 'type') else "Unknown"

        message = f"Parser error: Expected {expected_token_name}, got {got_token_name}"

        # Create a syntax error with position information
        error = SyntaxError(message, token.line, token.column, self.lexer.text, getattr(self, 'filename', 'REPL'))

        # Add a stack frame for the parser
        error.add_stack_frame("parser", token.line, token.column)

        raise error

    def eat(self, token_type):
        """Consume current token if it matches expected type 如果当前标记匹配预期类型则消费它"""
        if self.debug_mode:
            print(f"Eating token: {self.current_token}, expecting: {token_type}")

        if self.current_token.type == token_type:
            result = self.current_token
            self.current_token = self.lexer.get_next_token()
            return result
        else:
            self.error(f"Expected {token_type}, got {self.current_token.type}")

    def parse(self):
        """Entry point for parsing 解析入口点"""
        node = self.program()
        return node

    def program(self):
        """Parse entire program 解析整个程序"""
        node = self.statement_list()
        return node

    def statement_list(self):
        """Parse list of statements 解析语句列表"""
        node = Compound()
        node.children = []

        while self.current_token.type != TokenType.EOF:
            statement = self.statement()
            node.children.append(statement)

        return node

    def statement(self):
        """Parse a statement 解析语句"""
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
                # 回溯并解析函数调用
                self.lexer.position = saved_lexer_position
                self.lexer.line = saved_lexer_line
                self.lexer.column = saved_lexer_column
                self.lexer.current_char = saved_lexer_char
                self.current_token = saved_token

                func_call = self.func_call()
                self.eat(TokenType.SEMICOLON)
                return func_call
            elif self.current_token.type == TokenType.OPERATOR and self.current_token.value == '=':
                # 变量赋值
                op_token = self.current_token
                self.eat(TokenType.OPERATOR)  # '='
                value = self.expr()
                self.eat(TokenType.SEMICOLON)

                var_node = Var(saved_token)
                return Assign(var_node, op_token, value)
            else:
                # 可能是数组访问、属性访问，后跟赋值操作
                # 回溯，然后使用expr方法解析复杂表达式
                self.lexer.position = saved_lexer_position
                self.lexer.line = saved_lexer_line
                self.lexer.column = saved_lexer_column
                self.lexer.current_char = saved_lexer_char
                self.current_token = saved_token

                # 解析左侧表达式
                left = self.expr()

                # 如果是赋值表达式
                if self.current_token.type == TokenType.OPERATOR and self.current_token.value == '=':
                    op_token = self.current_token
                    self.eat(TokenType.OPERATOR)  # '='
                    right = self.expr()
                    self.eat(TokenType.SEMICOLON)
                    return Assign(left, op_token, right)
                else:
                    # 必须是语句，所以应该是赋值
                    self.error(f"Expected assignment operator in statement context")

        elif self.current_token.type == TokenType.SEMICOLON:
            return self.empty()

        self.error(f"Unexpected token: {self.current_token}")

    def compound_statement(self):
        """Parse compound statement (block) 解析复合语句（块）"""
        self.eat(TokenType.LBRACE)
        node = Compound()
        node.children = []

        # 处理块中的语句，直到遇到右花括号
        while self.current_token.type != TokenType.RBRACE:
            node.children.append(self.statement())

        self.eat(TokenType.RBRACE)
        return node

    def declaration_statement(self):
        """Parse variable declaration 解析变量声明"""
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
        """Parse assignment statement 解析赋值语句"""
        var_token = self.current_token
        self.eat(TokenType.IDENTIFIER)

        op_token = self.current_token
        self.eat(TokenType.OPERATOR)  # '='

        value = self.expr()
        self.eat(TokenType.SEMICOLON)

        var_node = Var(var_token)
        return Assign(var_node, op_token, value)

    def if_statement(self):
        """Parse if statement 解析if语句"""
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
        """Parse while statement 解析while语句"""
        self.eat(TokenType.KEYWORD)  # 'while'
        self.eat(TokenType.LPAREN)
        condition = self.expr()
        self.eat(TokenType.RPAREN)

        body = self.statement()

        return While(condition, body)

    def for_statement(self):
        """Parse for statement 解析for语句"""
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
        """Parse print statement 解析print语句"""
        self.eat(TokenType.KEYWORD)  # 'print'
        self.eat(TokenType.LPAREN)
        expr = self.expr()
        self.eat(TokenType.RPAREN)
        self.eat(TokenType.SEMICOLON)

        return Print(expr)

    def input_statement(self):
        """Parse input statement 解析input语句"""
        self.eat(TokenType.KEYWORD)  # 'input'
        self.eat(TokenType.LPAREN)

        prompt = None
        if self.current_token.type != TokenType.RPAREN:
            prompt = self.expr()

        self.eat(TokenType.RPAREN)
        self.eat(TokenType.SEMICOLON)

        return Input(prompt)

    def func_declaration(self):
        """Parse function declaration 解析函数声明"""
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
        """Parse function call statement 解析函数调用语句"""
        node = self.func_call()
        self.eat(TokenType.SEMICOLON)
        return node

    def func_call(self):
        """Parse function call 解析函数调用"""
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
        """Parse input function call 解析input函数调用"""
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
        """Parse return statement 解析return语句"""
        self.eat(TokenType.KEYWORD)  # 'return'

        expr = None
        if self.current_token.type != TokenType.SEMICOLON:
            expr = self.expr()

        self.eat(TokenType.SEMICOLON)

        return Return(expr)

    def break_statement(self):
        """Parse break statement 解析break语句"""
        self.eat(TokenType.KEYWORD)  # 'break'
        self.eat(TokenType.SEMICOLON)
        return Break()

    def continue_statement(self):
        """Parse continue statement 解析continue语句"""
        self.eat(TokenType.KEYWORD)  # 'continue'
        self.eat(TokenType.SEMICOLON)
        return Continue()

    def array_literal(self):
        """Parse array literal 解析数组字面量"""
        self.eat(TokenType.LBRACKET)
        elements = []

        if self.current_token.type != TokenType.RBRACKET:
            elements.append(self.expr())

            while self.current_token.type == TokenType.COMMA:
                self.eat(TokenType.COMMA)
                elements.append(self.expr())

        self.eat(TokenType.RBRACKET)

        return Array(elements)

    def object_literal(self):
        """Parse object literal 解析对象字面量"""
        self.eat(TokenType.LBRACE)
        pairs = {}

        if self.current_token.type != TokenType.RBRACE:
            # 解析第一个键值对
            if self.current_token.type == TokenType.STRING:
                key = self.current_token.value
                self.eat(TokenType.STRING)
                self.eat(TokenType.COLON)
                value = self.expr()
                pairs[key] = value

                # 解析剩余的键值对
                while self.current_token.type == TokenType.COMMA:
                    self.eat(TokenType.COMMA)
                    if self.current_token.type == TokenType.STRING:
                        key = self.current_token.value
                        self.eat(TokenType.STRING)
                        self.eat(TokenType.COLON)
                        value = self.expr()
                        pairs[key] = value
                    else:
                        self.error(f"对象键必须是字符串，得到了: {self.current_token.type}")
            else:
                self.error(f"对象键必须是字符串，得到了: {self.current_token.type}")

        self.eat(TokenType.RBRACE)
        return ObjectLiteral(pairs)

    def empty(self):
        """Parse empty statement 解析空语句"""
        self.eat(TokenType.SEMICOLON)
        return NoOp()

    def variable(self):
        """Parse variable 解析变量"""
        node = Var(self.current_token)
        self.eat(TokenType.IDENTIFIER)
        return node

    def expr(self):
        """Parse expression 解析表达式"""
        node = self.logic_expr()

        # 检查是否有三元运算符
        if self.current_token.type == TokenType.OPERATOR and self.current_token.value == '?':
            self.eat(TokenType.OPERATOR)  # 吃掉问号
            true_expr = self.expr()  # 解析问号后面的表达式

            self.eat(TokenType.COLON)  # 吃掉冒号
            false_expr = self.expr()  # 解析冒号后面的表达式

            # 创建三元运算符节点
            node = TernaryOp(node, true_expr, false_expr)

        return node

    def logic_expr(self):
        """Parse logical expression 解析逻辑表达式"""
        node = self.comp_expr()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('&&', '||')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.comp_expr())

        return node

    def comp_expr(self):
        """Parse comparison expression 解析比较表达式"""
        node = self.arith_expr()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('==', '!=', '<', '>', '<=', '>=')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.arith_expr())

        return node

    def arith_expr(self):
        """Parse arithmetic expression 解析算术表达式"""
        node = self.term()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('+', '-')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.term())

        return node

    def term(self):
        """Parse term 解析项"""
        node = self.factor()

        while (self.current_token.type == TokenType.OPERATOR and
               self.current_token.value in ('*', '/')):
            token = self.current_token
            self.eat(TokenType.OPERATOR)
            node = BinOp(node, token, self.factor())

        return node

    def factor(self):
        """Parse factor 解析因子"""
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

        # 处理布尔值关键字
        elif token.type == TokenType.KEYWORD and token.value in ('TRUE', 'FALSE'):
            self.eat(TokenType.KEYWORD)
            return Boolean(token)

        # 处理 NULL 关键字
        elif token.type == TokenType.KEYWORD and token.value == 'NULL':
            self.eat(TokenType.KEYWORD)
            return Null(token)

        elif token.type == TokenType.LPAREN:
            self.eat(TokenType.LPAREN)
            node = self.expr()
            self.eat(TokenType.RPAREN)
            return node

        # 处理对象字面量
        elif token.type == TokenType.LBRACE:
            return self.object_literal()

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
                # 数组访问 - 支持多维数组访问
                var_node = Var(saved_token)
                node = var_node

                # 处理一个或多个方括号索引
                while self.current_token.type == TokenType.LBRACKET:
                    self.eat(TokenType.LBRACKET)
                    index = self.expr()
                    self.eat(TokenType.RBRACKET)
                    node = ArrayAccess(node, index)

                # 处理属性访问（在数组访问之后可能有属性访问）
                while self.current_token.type == TokenType.DOT:
                    self.eat(TokenType.DOT)
                    prop_token = self.current_token
                    self.eat(TokenType.IDENTIFIER)
                    node = PropertyAccess(node, prop_token.value)

                return node
            elif self.current_token.type == TokenType.DOT:
                # 这是属性访问
                var_node = Var(saved_token)
                node = var_node

                # 处理属性访问链 (obj.prop1.prop2...)
                while self.current_token.type == TokenType.DOT:
                    self.eat(TokenType.DOT)
                    prop_token = self.current_token
                    self.eat(TokenType.IDENTIFIER)
                    node = PropertyAccess(node, prop_token.value)

                return node
            else:
                # 这是普通变量
                return Var(saved_token)

        else:
            self.error(f"Unexpected token in factor: {token}")
