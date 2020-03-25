import 'package:bloc/bloc.dart';

enum Operation {
  plus,
  minus,
  multiple,
  divide
}

abstract class CalculatorState {}
class CalculatorInitial extends CalculatorState {}

class CalculatorResult extends CalculatorState {
 int result;
  CalculatorResult(this.result);
}

class CalculatorError extends CalculatorState {
   String error;
  CalculatorError(this.error);
}

class CalculatorEvent {
  Operation operation;
 int num1;
 int num2;

  CalculatorEvent(this.operation, this.num1, this.num2);
}

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  @override
  CalculatorState get initialState {
    return CalculatorInitial();
  }

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    int result = 0;
    switch (event.operation) {
      case Operation.plus:
        result = event.num1 + event.num2;
        yield CalculatorResult(result);
        break;
      case Operation.minus:
        result = event.num1 - event.num2;
        yield CalculatorResult(result);
        break;
      case Operation.multiple:
        result = event.num1 * event.num2;
        yield CalculatorResult(result);
        break;
      case Operation.divide:
        result = event.num1 ~/ event.num2;
        yield CalculatorResult(result);
        break;

      default:
        yield CalculatorError('Error');
    }
  }
}
