import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/domain/constants.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/routes/router.dart';
import 'package:shop_app/ui/screens/auth_screen.dart';
import 'package:shop_app/ui/screens/products_overview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, value, previous) => Products(value.token),
          create: null,
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Order>(
          create: null,
          update: (context, value, previous) => Order(value.token),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: APP_NAME.data,
          theme: ThemeData.dark().copyWith(
              primaryColor: Colors.purple,
              accentColor: Colors.deepOrange,
              backgroundColor: Colors.black,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.deepOrange,
              ),
              buttonBarTheme:
                  ButtonBarThemeData(alignment: MainAxisAlignment.center),
              snackBarTheme: SnackBarThemeData(
                  actionTextColor: Colors.white,
                  backgroundColor: Colors.black,
                  contentTextStyle: const TextStyle(color: Colors.white))),
          themeMode: ThemeMode.dark,
          initialRoute: auth.isLoggedIn
              ? ProductsOverviewScreen.routeName
              : AuthScreen.routeName,
          routes: appRoutes,
        ),
      ),
    );
  }
}
