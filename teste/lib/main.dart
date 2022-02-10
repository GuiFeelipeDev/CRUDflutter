import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/provider/users.dart';
import 'package:teste/routes/app_routes.dart';
import 'package:teste/views/user_form.dart';
import 'package:teste/views/user_formEdit.dart';
import 'package:teste/views/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Users(),
          )

    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
    
          primarySwatch: Colors.blue,
        ),
        routes: {
          AppRoutes.HOME: (_) => UserList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
          AppRoutes.USER_FORMEDIT: (_) => UserFormEdit(),
        },
      ),
    );
  }
}


