import string
from enum import IntEnum
from anytree import Node, RenderTree


class Symbol(IntEnum):
    Letter = 0
    Number = 1
    Operator = 2
    Whitespace = 3
    Delimiter = 4
    OpenParen = 5
    CloseParen = 6
    Booleano = 7
    Bool = 8
    OpenList = 9


charset_symbol = {
    Symbol.Letter: string.ascii_letters,
    Symbol.Number: string.digits,
    Symbol.Operator: ['+', '-', '*', '/', '%'],
    Symbol.Whitespace: string.whitespace,
    Symbol.OpenParen: ['('],
    Symbol.OpenList: ['&'],
    Symbol.CloseParen: [')'],
    Symbol.Booleano: ['#'],
}


def char_to_symbol(char):
    for charset in charset_symbol:
        if char in charset_symbol[charset]:
            return charset
    return None


class State(IntEnum):
    Zero = 0    # Espacio
    One = 1     # ID
    Two = 2     # Numeros
    Three = 3   # Operadores
    Four = 4    # Parentesis Abierto
    Five = 5    # Parentesis Cerrado
    Six = 6     # Lista Abierta
    Seven = 7   # Boolean
    Error = 8


class Action(IntEnum):
    Shift = 0
    Reduce = 1
    Dispose = 2

# Inicializar con errores
rows = range(len(State))
cols = range(len(Symbol))
tt = [[(State.Error, Action.Dispose) for col in cols] for row in rows]


# Estado 0 - Comiendo espacios en blanco
tt[State.Zero][Symbol.Whitespace] = (State.Zero, Action.Dispose)
tt[State.Zero][Symbol.Letter] = (State.One, Action.Dispose)
tt[State.Zero][Symbol.Number] = (State.Two, Action.Dispose)
tt[State.Zero][Symbol.Operator] = (State.Three, Action.Dispose)
tt[State.Zero][Symbol.OpenParen] = (State.Four, Action.Dispose)
tt[State.Zero][Symbol.CloseParen] = (State.Five, Action.Dispose)
tt[State.Zero][Symbol.OpenList] = (State.Six, Action.Dispose)
tt[State.Zero][Symbol.Booleano] = (State.Seven, Action.Dispose)

# Estado 1 - Reconociendo ID
tt[State.One][Symbol.Letter] = (State.One, Action.Shift)
tt[State.One][Symbol.Number] = (State.One, Action.Shift)
tt[State.One][Symbol.Operator] = (State.One, Action.Shift)
tt[State.One][Symbol.Whitespace] = (State.Zero, Action.Reduce)
tt[State.One][Symbol.CloseParen] = (State.Five, Action.Reduce)

# Estado 2 - Reconociendo numeros
tt[State.Two][Symbol.Number] = (State.Two, Action.Shift)
tt[State.Two][Symbol.Whitespace] = (State.Zero, Action.Reduce)
tt[State.Two][Symbol.Operator] = (State.Three, Action.Reduce)
tt[State.Two][Symbol.CloseParen] = (State.Five, Action.Reduce)

# Estado 3 - Reconociendo operadores
tt[State.Three][Symbol.Number] = (State.Two, Action.Reduce)
tt[State.Three][Symbol.Whitespace] = (State.Zero, Action.Reduce)
tt[State.Three][Symbol.Letter] = (State.One, Action.Reduce)

# Estado 4 - Reconociendo parentesis abierto
tt[State.Four][Symbol.Whitespace] = (State.Zero, Action.Reduce)
tt[State.Four][Symbol.Letter] = (State.One, Action.Reduce)
tt[State.Four][Symbol.Number] = (State.Two, Action.Reduce)
tt[State.Four][Symbol.Operator] = (State.Three, Action.Reduce)

# Estado 5 - Reconociendo parentesis cerrado
tt[State.Five][Symbol.Whitespace] = (State.Zero, Action.Reduce)
tt[State.Five][Symbol.CloseParen] = (State.Five, Action.Reduce)

# Estado 6 - Reconociendo Listas
tt[State.Six][Symbol.OpenParen] = (State.Zero, Action.Reduce)

# Estado 7 - Reconociendo Bool
tt[State.Seven][Symbol.Letter] = (State.Zero, Action.Reduce)

class Token(IntEnum):
    Identifier = 0
    Number = 1
    Operator = 2
    OpenParen = 3
    CloseParen = 4
    OpenList = 5
    BooleanT = 6
    BooleanF = 7
    ERROR = 8


def scan(source_code, state=State.Zero, char_buffer=[]):
    tokens = []
    source_code += ' ' #Añadiendo un espacio en blanco adicional para reconocer EOF y no crear otro estado
    for char in source_code:
        symbol = char_to_symbol(char)
        (next_state, action) = tt[state][symbol]

        if next_state == State.Error:
            return 'ERROR'

        if action == Action.Dispose:
            char_buffer.clear()
        elif action == Action.Reduce:
            if state == State.One:
                tokens.append((Token.Identifier, ''.join(char_buffer)))
            elif state == State.Two:
                tokens.append((Token.Number, ''.join(char_buffer)))
            elif state == State.Three:
                tokens.append((Token.Operator, ''.join(char_buffer)))
            elif state == State.Four:
                tokens.append((Token.OpenParen, ''.join(char_buffer)))
            elif state == State.Five:
                tokens.append((Token.CloseParen, ''.join(char_buffer)))
            elif state == State.Six:
                tokens.append((Token.OpenList, ''.join(char_buffer)))
            elif state == State.Seven:
                if (char == 't'):
                    tokens.append((Token.BooleanT, ''.join(char_buffer)))
                elif (char == 'f'):
                    tokens.append((Token.BooleanF, ''.join(char_buffer)))
                else:
                    return 'Error'

            char_buffer.clear()

        char_buffer.append(char)
        state = next_state

    return tokens

def match(token, tokens):
    if tokens and token == tokens[0]:
        tokens.pop(0)
        return True

    return False


def exp(tokens, parent_node):
    if match(Token.OpenParen, tokens):
        exp_node = Node('EXP', parent=parent_node)
        Node('OPEN_PAREN', parent=exp_node)
        fun(tokens, exp_node)
        params(tokens, exp_node)
        if match(Token.CloseParen, tokens):
            Node('CLOSE_PAREN', parent=exp_node)
        else:
            tokens.append('Esperaba un CLOSE_PAREN')
    else:
        tokens.append('Esperaba un OPEN_PAREN o un BOOL esta mal escrito')


def fun(tokens, parent_node):
    if match(Token.Operator, tokens):
        fun_node = Node('FUN', parent=parent_node)
        Node('OPERATOR', parent=fun_node)
    elif match(Token.Identifier, tokens):
        fun_node = Node('FUN', parent=parent_node)
        Node('ID', parent=fun_node)
    else:
        tokens.append('Esperaba un ID o un OPERADOR')


def params(tokens, parent_node):
    params_node = Node('PARAMS', parent=parent_node)
    if match(Token.Number, tokens):
        param_node = Node('PARAM', parent=params_node)
        Node('NUMBER', parent=param_node)
        params(tokens, params_node)
    elif match(Token.Identifier, tokens):
        param_node = Node('PARAM', parent=params_node)
        Node('ID', parent=param_node)
        params(tokens, params_node)
    elif match(Token.BooleanT, tokens):
        param_node = Node('PARAM', parent=params_node)
        bool_node = Node('BOOL', parent=param_node)
        Node('BOOL_TRUE', parent=bool_node)
        params(tokens, params_node)
    elif match(Token.BooleanF, tokens):
        param_node = Node('PARAM', parent=params_node)
        bool_node = Node('BOOL', parent=param_node)
        Node('BOOL_FALSE', parent=bool_node)
        params(tokens, params_node)
    elif match(Token.OpenList, tokens):
        param_node = Node('PARAM', parent=params_node)
        list_node = Node('LIST', parent=param_node)
        Node('OPEN_LIST', parent=list_node)
        params(tokens, list_node)
        if match(Token.CloseParen, tokens):
            Node('CLOSE_LIST', parent=list_node)
        else:
            tokens.append('Esperaba un CLOSE_PAREN_LIST')
        params(tokens, params_node)
    elif match(Token.OpenParen, tokens):
        param_node = Node('PARAM', parent=params_node)
        Node('OPEN_PAREN', parent=param_node)
        fun(tokens, param_node)
        params(tokens, param_node)
        if match(Token.CloseParen, tokens):
            Node('CLOSE_PAREN', parent=param_node)
        else:
            tokens.append('Esperaba un CLOSE_PAREN')
        params(tokens, params_node)
    else:
        return


def parse(tokens, parse_tree=None):
    root = Node('PROGRAM')
    exp(tokens, root)

    if tokens:
        print(f'ERROR {tokens}')
        return None
    else:
        print('AWESOME')
        for pre, fill, node in RenderTree(root):
            print("%s%s" % (pre, node.name))
        return parse_tree


def only_tokens(token_tuples):
    return [t[0] for t in token_tuples]

test1 = '(t #f &(params 324) (* kdasjn 3847))'

print(parse(only_tokens(scan(test1))))
