import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    return BlocListener<DetailCubit, DetailState>(
      bloc: detailCubit,
      listener: (context, state) {
        if(state is DetailFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((detailCubit.state as DetailFailure).message)));
        }

        if((state is DetailCreateSuccess || state is DetailUpdateSuccess) && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
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

            BlocBuilder<DetailCubit, DetailState>(
              bloc: detailCubit,
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
      ),
    );
  }
}
