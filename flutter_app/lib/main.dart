import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './providers/signin_provider.dart';
import './screens/Result.dart';
import './screens/getStarted.dart';
import './screens/home.dart';
import './screens/signin.dart';
import './screens/signup.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
      ],
      child: MaterialApp(
        title: 'CanDetect',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return GetStartedPage();
            }
          },
          stream: FirebaseAuth.instance.authStateChanges(),
        ),
        initialRoute: '/',
        routes: {
          ProcessPage.routeName: (context) => ProcessPage(),
          GetStartedPage.routeName: (context) => GetStartedPage(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          SignInPage.routeName: (context) => SignInPage(),
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
