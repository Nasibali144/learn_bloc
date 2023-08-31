import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
import 'package:learn_bloc/cubit/home_cubit/home_cubit.dart';
import 'package:learn_bloc/main.dart';
import 'package:learn_bloc/model/todo_model.dart';

class DetailPage extends StatelessWidget {
  final Todo? todo;
  DetailPage({Key? key, this.todo}) : super(key: key);

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  void initState() {
    titleCtrl.text = todo?.title ?? "";
    descCtrl.text = todo?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailCubit>();
    initState();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          IconButton(
            onPressed: () {
              if(todo == null) {
                cubit.create(titleCtrl.text, descCtrl.text);
              } else {
                cubit.edit(todo!, titleCtrl.text, descCtrl.text);
              }
            },
            icon: const Icon(Icons.save),
          ),

        ],
      ),
      body:  Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(hintText: "Title"),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(hintText: "Description"),
                ),
                const SizedBox(height: 15),

              ],
            ),
          ),

          BlocConsumer<DetailCubit, DetailState>(
            listener: (context, state) {
              if(state is DetailFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }

              if((state is DetailCreateSuccess || state is DetailUpdateSuccess) && context.mounted) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              /// builder
              if(state is DetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
