import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/cubit/counter_cubit/counter_cubit.dart';
import 'package:learn_bloc/cubit/detail_cubit/detail_cubit.dart';
import 'package:learn_bloc/cubit/home_cubit/home_cubit.dart';
import 'package:learn_bloc/pages/count_page.dart';
import 'package:learn_bloc/pages/detail_page.dart';
import 'package:learn_bloc/pages/home_page.dart';
import 'package:learn_bloc/service/sql_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'cubit/observer.dart';

/// service locator
final sql = SQLService();
// final homeCubit = HomeCubit();
// final detailCubit = DetailCubit();
final counterCubit = CounterCubit();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  /// Sql setting
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, "TodoApp.db");
  await sql.open(path);

  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<DetailCubit>(create: (context) => DetailCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        initialRoute: "/",
        routes: {
          "/": (context) => const HomePage(),
          "/detail": (context) => DetailPage(),
          "/count": (context) => const CountPage(),
        },
      ),
    );
  }
}
