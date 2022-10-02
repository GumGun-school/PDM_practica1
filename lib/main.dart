import 'package:flutter/material.dart';
import 'package:practica1/banner/provider/fav_button.dart';
import 'package:practica1/home/home_page.dart';
import 'package:practica1/provider/song_list_prov.dart';
import 'package:provider/provider.dart';

import 'home/provider/listen_button.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListenButton()),
        ChangeNotifierProvider(create: (_) => FavButton()),
        ChangeNotifierProvider(create: (_) => SongListProv()),
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(colorScheme: ColorScheme.dark()),
        home: HomePage());
  }
}
