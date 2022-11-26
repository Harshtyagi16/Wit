import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wit/controller/Auth.dart';
import 'package:wit/controller/RecipeP.dart';
import 'package:wit/screens/addRecipeScreen.dart';
import 'package:wit/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Auth()),
        ChangeNotifierProxyProvider<Auth,RecipeProvider>(create: (context)=>RecipeProvider('', ''), update: (context,authC,recipe)=>RecipeProvider(authC.idToken!, authC.userId!))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: LoginScreen()
      ),
    );
  }
}


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  getPage() {

  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

