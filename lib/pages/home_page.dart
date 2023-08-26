import 'package:flutter/material.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
import 'package:learn_bloc/cubit/home_cubit/home_cubit.dart';
import 'package:learn_bloc/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    homeCubit.fetchTodos();

    detailCubit.stream.listen((state) {
      if(state is DetailDeleteSuccess || detailCubit.state is DetailCreateSuccess) {
        homeCubit.fetchTodos();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TODOS"),),
      body: StreamBuilder<HomeState>(
        initialData: homeCubit.state,
        stream: homeCubit.stream,
        builder: (context, snapshot) {
          final items = snapshot.data!.todos;

          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: items.length,
                itemBuilder: (ctx, i) {
                  final item = items[i];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.description),
                    trailing: IconButton(
                      onPressed: () {
                        detailCubit.delete(item.id);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/detail");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
