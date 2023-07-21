// ignore_for_file: await_only_futures, unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:thanhhoa_garden/blocs/AppBlocObserver%20.dart';
import 'package:thanhhoa_garden/blocs/authentication/auth_bloc.dart';
import 'package:thanhhoa_garden/blocs/bonsai/bonsai_bloc.dart';

import 'package:thanhhoa_garden/blocs/bonsai/category/cate_bloc.dart';
import 'package:thanhhoa_garden/blocs/cart/cart_bloc.dart';
import 'package:thanhhoa_garden/blocs/feedback/feedback_bloc.dart';
import 'package:thanhhoa_garden/blocs/order/orderBloc.dart';
import 'package:thanhhoa_garden/blocs/service/service_bloc.dart';
import 'package:thanhhoa_garden/blocs/store/storeBloc.dart';
import 'package:thanhhoa_garden/models/bonsai/bonsai.dart';
import 'package:thanhhoa_garden/providers/authentication/authantication_provider.dart';
import 'package:thanhhoa_garden/providers/bonsai/bonsai_provider.dart';
import 'package:thanhhoa_garden/providers/cart/cart_provider.dart';
import 'package:thanhhoa_garden/providers/bonsai/category_provider.dart';
import 'package:thanhhoa_garden/providers/feedback/feedback_provider.dart';
import 'package:thanhhoa_garden/providers/order/order_provider.dart';
import 'package:thanhhoa_garden/providers/service/service_provider.dart';
import 'package:thanhhoa_garden/providers/store/store_provider.dart';
// import 'package:thanhhoa_garden/screens/MyHomePage.dart';
import 'package:thanhhoa_garden/screens/authentication/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thanhhoa_garden/screens/home/homePage.dart';
import 'package:thanhhoa_garden/utils/helper/shared_prefs.dart';

late SharedPreferences sharedPreferences;
// late AuthBloc authBloc;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
List<Bonsai> Listincart = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  // Bloc.observer = AppBlocObserver();
  // authBloc = AuthBloc(authProvider: AuthenticationProvider());
  // await FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var token = getTokenAuthenFromSharedPrefs();

    return MultiProvider(
      providers: [
        ListenableProvider<AuthenticationProvider>(
            create: (_) => AuthenticationProvider()),
        ListenableProvider<ServiceProvider>(create: (_) => ServiceProvider()),
        ListenableProvider<BonsaiProvider>(create: (_) => BonsaiProvider()),
        ListenableProvider<CategoryProvider>(create: (_) => CategoryProvider()),
        ListenableProvider<CartProvider>(create: (_) => CartProvider()),
        ListenableProvider<FeedbackProvider>(create: (_) => FeedbackProvider()),
        ListenableProvider<StoreProvider>(create: (_) => StoreProvider()),
        ListenableProvider<OrderProvider>(create: (_) => OrderProvider()),
        ProxyProvider<AuthenticationProvider, AuthBloc>(
          update: (_, authProvider, __) => AuthBloc(authProvider: authProvider),
        ),
        ProxyProvider<ServiceProvider, ServiceBloc>(
            update: (_, serviceProvider, __) =>
                ServiceBloc(serviceProvider: serviceProvider)),
        ProxyProvider<BonsaiProvider, BonsaiBloc>(
            update: (_, bonsaiProvider, __) =>
                BonsaiBloc(BonsaiProvider: bonsaiProvider)),
        ProxyProvider<CategoryProvider, CategoryBloc>(
            update: (_, categoryProvider, __) =>
                CategoryBloc(categoryProvider: categoryProvider)),
        ProxyProvider<CartProvider, CartBloc>(
            update: (_, cartProvider, __) =>
                CartBloc(cartProvider: cartProvider)),
        ProxyProvider<FeedbackProvider, FeedbackBloc>(
            update: (_, feedbackProvider, __) =>
                FeedbackBloc(feedbackProvider: feedbackProvider)),
        ProxyProvider<StoreProvider, StoreBloc>(
            update: (_, storeProvider, __) =>
                StoreBloc(storeProvider: storeProvider)),
        ProxyProvider<OrderProvider, OrderBloc>(
            update: (_, orderProvider, __) =>
                OrderBloc(OrderProvider: orderProvider)),
      ],
      child: MaterialApp(
        title: 'Thanh Hoa Garden',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
