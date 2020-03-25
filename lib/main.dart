import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_block.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final TextEditingController _controllerNum1 = TextEditingController();
  final TextEditingController _controllerNum2 = TextEditingController();
  final CalculatorBloc _calculatorBloc = CalculatorBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: BlocProvider<CalculatorBloc>(
        builder: (context) => _calculatorBloc,
        child: BlocListener<CalculatorBloc, CalculatorState>(
          listener: (context, state) {
            if (state is CalculatorError) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('${state.error}'),
              ));
            }
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controllerNum1,
                    decoration: InputDecoration(
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: _controllerNum2,
                    decoration: InputDecoration(
                    ),
                    keyboardType: TextInputType.number,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text('+'),
                          onPressed: () {
                            calculate(Operation.plus);
                          },
                        ),
                      ),

                      Expanded(
                        child: RaisedButton(
                          child: Text('-'),
                          onPressed: () {
                            calculate(Operation.minus);
                          },
                        ),
                      ),

                      Expanded(
                        child: RaisedButton(
                          child: Text('*'),
                          onPressed: () {
                            calculate(Operation.multiple);
                          },
                        ),
                      ),

                      Expanded(
                        child: RaisedButton(
                          child: Text('/'),
                          onPressed: () {
                            calculate(Operation.divide);
                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 8.0),
                  BlocBuilder<CalculatorBloc, CalculatorState>(
                    builder: (context, state) {
                      if (state is CalculatorInitial) {
                        return Text(' ');
                      } else if (state is CalculatorResult) {
                        return Text(' ${state.result}');
                      } else if (state is CalculatorError) {
                        return Text('${state.error}');
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void calculate(Operation operation) {
    int num1 = int.parse(_controllerNum1.text.toString());
    int num2 = int.parse(_controllerNum2.text.toString());
    _calculatorBloc.add(CalculatorEvent(operation, num1, num2));
  }
}
