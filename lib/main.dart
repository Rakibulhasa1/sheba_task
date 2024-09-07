import 'package:flutter/material.dart';
import 'package:sheba_task/pages/todo_list_page.dart';
import 'package:sheba_task/services/notification_service.dart';
import 'pages/login_page.dart';
import 'utils/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initialize();
  final isLoggedIn = await LocalStorage.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: isLoggedIn ? TodoListPage() : LoginPage(),
    );
  }
}
