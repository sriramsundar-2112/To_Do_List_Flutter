import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/task.dart';
import 'providers/task_provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_task_screen.dart';
import 'screens/task_details_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Initialize Firebase
  await Firebase.initializeApp();

  // 📦 Initialize Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskPriorityAdapter());
  await Hive.openBox<Task>('tasks');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system, // 🌗 Auto switch
        theme: ThemeData(
          brightness: Brightness.light,
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        home: FirebaseAuth.instance.currentUser == null
            ? const LoginScreen()
            : const HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          LoginScreen.routeName: (ctx) => const LoginScreen(),
          AddEditTaskScreen.routeName: (ctx) => const AddEditTaskScreen(),
          TaskDetailsScreen.routeName: (ctx) => const TaskDetailsScreen(),
        },
      ),
    );
  }
}
