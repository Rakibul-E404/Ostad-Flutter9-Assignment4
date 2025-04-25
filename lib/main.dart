import 'package:flutter/material.dart';
import 'package:ostad_flutter9_assignment4/services/task_service.dart';
import 'package:provider/provider.dart';
import 'package:ostad_flutter9_assignment4/services/auth_service.dart';
import 'package:ostad_flutter9_assignment4/views/auth/login_screen.dart';
import 'package:ostad_flutter9_assignment4/views/home_screen.dart';

void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => AuthService()),
//       ],
//       child: MaterialApp(
//         title: 'Task Manager',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           fontFamily: 'Poppins',
//         ),
//         home: AuthWrapper(),
//       ),
//     );
//   }
// }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, TaskService>(
          create: (context) => TaskService(Provider.of<AuthService>(context, listen: false)),
          update: (context, authService, taskService) => TaskService(authService),
        ),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
        ),
        home: AuthWrapper(),
      ),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    if (authService.isAuthenticated) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}



