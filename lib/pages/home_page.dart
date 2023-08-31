import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
import 'package:learn_bloc/cubit/home_cubit/home_cubit.dart';
import 'package:learn_bloc/main.dart';
import 'package:learn_bloc/pages/detail_page.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailCubit, DetailState>(
      listener: (context, state) {
        if(state is DetailDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully Deleted!")));
        }

        if (state is DetailDeleteSuccess || state is DetailCreateSuccess) {
          homeCubit.fetchTodos();
        }

        if (state is DetailUpdateSuccess) {
          homeCubit.fetchTodos();
        }
      },
      bloc: detailCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TODOS"),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          // buildWhen: (previous, current) {
          //   return true;
          // },
          builder: (context, state) {
            final items = state.todos;

            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: items.length,
                  itemBuilder: (ctx, i) {
                    final item = items[i];
                    return ListTile(
                      onLongPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailPage(todo: item)));
                      },
                      leading: Checkbox(
                        value: item.isCompleted,
                        onChanged: (bool? value) {
                          detailCubit.complete(item);
                        },
                      ),
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
      ),
    );
  }
}
