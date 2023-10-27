import 'package:decimal/decimal.dart';
import 'package:math_expressions/math_expressions.dart';

class DecimalNumber extends Literal {
  /// Creates a number literal with given value.
  /// Always holds a double internally.
  DecimalNumber(Decimal value) : super(value);

  @override
  bool isConstant() => true;

  @override
  double getConstantValue() => value;

  @override
  dynamic evaluate(EvaluationType type, ContextModel context) {
    if (type == EvaluationType.REAL) {
      return value;
    }

    if (type == EvaluationType.INTERVAL) {
      // interpret number as interval
      final IntervalLiteral intLit = IntervalLiteral.fromSingle(this);
      return intLit.evaluate(type, context);
    }

    if (type == EvaluationType.VECTOR) {
      // interpret number as scalar
      return value;
    }

    throw UnsupportedError('Number $this can not be interpreted as: $type');
  }

  @override
  Expression derive(String toVar) => DecimalNumber(Decimal.parse('0.0'));
}