import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart' as FlutterLibphonenumber;
import 'package:meet8/bloc/user_bloc.dart';
import 'package:meet8/bloc/user_event.dart';
import 'package:meet8/data/repository/user_repository_impl.dart';
import 'package:meet8/domain/helper/database_helper.dart';
import 'package:meet8/domain/repository/user_repository.dart';
import 'package:meet8/pages/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();
  final userRepository = UserRepositoryImpl(dbHelper);
  await FlutterLibphonenumber.init();
  runApp(MyApp(repository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(repository)..add(LoadUsers()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomePage(),
      ),
    );
  }
}
