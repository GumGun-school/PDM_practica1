import 'package:flutter/material.dart';
import 'package:practica1/banner/provider/fav_button.dart';
import 'package:practica1/home/home_page.dart';
import 'package:practica1/login/login.dart';
import 'package:practica1/provider/song_list_prov.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home/provider/listen_button.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ListenButton()),
      ChangeNotifierProvider(create: (_) => FavButton()),
      ChangeNotifierProvider(create: (_) => SongListProv()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(colorScheme: ColorScheme.dark()),
        home: login());
  }
}
