import 'package:rambo/providers/category_provider.dart';
import 'package:rambo/providers/cekout_provider.dart';
import 'package:rambo/providers/product_provider.dart';

import 'package:rambo/views/screen/cart/cart_screen.dart';
import 'package:rambo/views/screen/dashboard/dashboard_screen.dart';

import 'package:rambo/views/screen/fav/favorit_screen.dart';
import 'package:rambo/views/screen/intro/intro_screen.dart';
import 'package:rambo/views/screen/login/login_screen.dart';

import 'package:rambo/views/screen/profile/edit_profile.dart';

import 'package:rambo/views/screen/regis2/regis_screen2.dart';
import 'package:rambo/views/screen/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  Stream<User?> authStateChanges() {
    return FirebaseAuth.instance.authStateChanges();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (contex) => ProductProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (contex) => CategoryProvider(),
        ),
        ChangeNotifierProvider<CekProvider>(
          create: (contex) => CekProvider(),
        ),
        // Provider lainnya jika ada
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apps',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisFullScreen(),
          '/home': (context) => const DashboardScreen(),
          '/favorite': (context) => const FavoritScreen(),
          '/edit': (context) => const EditProfile(),
          '/cart': (context) => const CartScreen(),
        },
        home: StreamBuilder<User?>(
          stream: authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final user = snapshot.data;
              if (user == null) {
                // Pengguna tidak masuk
                // Navigasi ke layar masuk atau tampilkan konten sesuai kebutuhan
                return const SplashScrren(); // Contoh: Navigasi ke layar masuk
              } else {
                // Pengguna berhasil masuk
                // Lanjutkan dengan konten aplikasi yang sesuai
                return const IntroScreen(); // Contoh: Navigasi ke layar utama
              }
            }
            return const CircularProgressIndicator(); // atau widget lain yang sesuai
          },
        ),
      ),
    );
  }
}
