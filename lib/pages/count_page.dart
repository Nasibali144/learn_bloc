import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/cubit/counter_cubit/counter_cubit.dart';
import 'package:learn_bloc/main.dart';

class CountPage extends StatelessWidget {
  const CountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext countPageContext) {
    return BlocProvider(
      // value: counterCubit,
      create: (providerContext) => CounterCubit(),
      child: Builder(
        builder: (builderContext) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () => builderContext.read<CounterCubit>().increment(),
                        child: const Text(
                          "+1",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      BlocBuilder<CounterCubit, int>(
                        builder: (context, state) => Text(
                          "$state",
                          style: const TextStyle(fontSize: 30),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => builderContext.read<CounterCubit>().decrement(),
                        child: const Text(
                          "-1",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
