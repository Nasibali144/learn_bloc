import 'package:flutter/material.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
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

    initState();

    detailCubit.stream.listen((state) {
      /// listen
      if(detailCubit.state is DetailFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((detailCubit.state as DetailFailure).message)));
      }

      if((detailCubit.state is DetailCreateSuccess || detailCubit.state is DetailUpdateSuccess) && context.mounted) {
        Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: [
          IconButton(
            onPressed: () {
              if(todo == null) {
                detailCubit.create(titleCtrl.text, descCtrl.text);
              } else {
                detailCubit.edit(todo!, titleCtrl.text, descCtrl.text);
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

          StreamBuilder(
            initialData: detailCubit.state,
            stream: detailCubit.stream,
            builder: (context, snapshot) {

              /// builder
              if(detailCubit.state is DetailLoading) {
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
