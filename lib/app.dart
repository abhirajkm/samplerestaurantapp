import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/index.dart';
import 'package:restaurant_app/routes.dart';
import 'package:restaurant_app/screens/home.dart';
import 'package:restaurant_app/utils/text.dart';
import 'package:restaurant_app/utils/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderTree.get(context),
      child: MaterialApp(
        title: appTitle,
        theme: appTheme,
        home: const HomeScreen(),
        routes: AppRoutes.get(context),
      ),
    );
  }
}


