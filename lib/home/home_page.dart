import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practica1/home/provider/listen_button.dart';
import 'package:practica1/list/song_list.dart';
import 'package:practica1/login/login.dart';
import 'package:provider/provider.dart';

import '../banner/provider/fav_button.dart';
import '../banner/song_banner.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 90),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                (context.watch<ListenButton>().isRecording)
                    ? "Escuchando..."
                    : "Toque para escuchar",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 90,
          ),
          GestureDetector(
            onTap: () async {
              var song = await context.read<ListenButton>().recordSong();
              var info;
              try {
                info = await context.read<ListenButton>().recieveSong(song!);
              } catch (err) {}
              if (info["result"] != null) {
                print(info);
                var assembled =
                    await context.read<ListenButton>().parseResponse(info);

                print(assembled);
                context.read<FavButton>().startFromListener();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SongBanner(
                      currentSong: assembled,
                      songList: context.read<ListenButton>().songList,
                      index: 1,
                      faved: true,
                    ),
                  ),
                );
              }
            },
            child: AvatarGlow(
              animate: context.watch<ListenButton>().isRecording,
              glowColor: Colors.white,
              endRadius: 100.0,
              duration: Duration(milliseconds: 1000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/732/732110.png?w=740&t=st=1664657117~exp=1664657717~hmac=dd7e20a5ccb78ec1dbb41a967a3345487b0ea7a51d47ff98b501558ad826750e")),
              ),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongList(),
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(
                      Icons.favorite,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 30),
              GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => login(),
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(
                      Icons.logout_sharp,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
