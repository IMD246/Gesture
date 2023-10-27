import 'package:decimal/decimal.dart';
import 'package:gesture_test/calculator/decimal_number.dart';
import 'package:math_expressions/math_expressions.dart';

class DecimalParser extends Parser {

  @override
  Expression parse(String inputString) {
    if (inputString.trim().isEmpty) {
      throw FormatException('The given input string was empty.');
    }

    final List<Expression> exprStack = <Expression>[];
    final List<Token> inputStream = lex.tokenizeToRPN(inputString);

    for (Token currToken in inputStream) {
      Expression currExpr, left, right;

      switch (currToken.type) {
        case TokenType.VAL:
          currExpr = DecimalNumber(Decimal.parse(currToken.text));
          break;
        case TokenType.VAR:
          currExpr = Variable(currToken.text);
          break;
        case TokenType.UNMINUS:
          currExpr = -exprStack.removeLast();
          break;
        case TokenType.UNPLUS:
          currExpr = UnaryPlus(exprStack.removeLast());
          break;
        case TokenType.PLUS:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = left + right;
          break;
        case TokenType.MINUS:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = left - right;
          break;
        case TokenType.TIMES:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = left * right;
          break;
        case TokenType.DIV:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = left / right;
          break;
        case TokenType.MOD:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = left % right;
          break;
        case TokenType.POW:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = left ^ right;
          break;
        case TokenType.EFUNC:
          currExpr = Exponential(exprStack.removeLast());
          break;
        case TokenType.LOG:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = Log(left, right);
          break;
        case TokenType.LN:
          currExpr = Ln(exprStack.removeLast());
          break;
        case TokenType.SQRT:
          currExpr = Sqrt(exprStack.removeLast());
          break;
        case TokenType.ROOT:
          right = exprStack.removeLast();
          left = exprStack.removeLast();
          currExpr = Root.fromExpr(left as Number, right);
          break;
        case TokenType.SIN:
          currExpr = Sin(exprStack.removeLast());
          break;
        case TokenType.COS:
          currExpr = Cos(exprStack.removeLast());
          break;
        case TokenType.TAN:
          currExpr = Tan(exprStack.removeLast());
          break;
        case TokenType.ASIN:
          currExpr = Asin(exprStack.removeLast());
          break;
        case TokenType.ACOS:
          currExpr = Acos(exprStack.removeLast());
          break;
        case TokenType.ATAN:
          currExpr = Atan(exprStack.removeLast());
          break;
        case TokenType.ABS:
          currExpr = Abs(exprStack.removeLast());
          break;
        case TokenType.CEIL:
          currExpr = Ceil(exprStack.removeLast());
          break;
        case TokenType.FLOOR:
          currExpr = Floor(exprStack.removeLast());
          break;
        case TokenType.SGN:
          currExpr = Sgn(exprStack.removeLast());
          break;
        case TokenType.FACTORIAL:
          currExpr = Factorial(exprStack.removeLast());
          break;
        case TokenType.FUNC:
          List<Expression> args = [];
          for (var i = 0; i < currToken.argCount; ++i) {
            args.insert(0, exprStack.removeLast());
          }
          currExpr = AlgorithmicFunction(
              currToken.text, args, functionHandlers[currToken.text]);
          break;
        default:
          throw FormatException('Unsupported token: $currToken');
      }

      exprStack.add(currExpr);
    }

    if (exprStack.length > 1) {
      throw FormatException('The input String is not a correct expression');
    }

    return exprStack.last;
  }
}