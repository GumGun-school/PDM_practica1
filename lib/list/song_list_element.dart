import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica1/banner/provider/fav_button.dart';
import 'package:provider/provider.dart';

import '../banner/song_banner.dart';

class SongListElement extends StatelessWidget {
  final Map<String, String> currentSong;
  final List<Map<String, String>> songList;
  final int index;
  SongListElement({Key? key, required this.currentSong, required this.songList, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FavButton>().startFromFav();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongBanner(
              currentSong: currentSong,
              songList: songList,
              index: index,
              faved: true,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              //color: Color.fromRGBO(20, 20, 20, 1),
              image: DecorationImage(
                  image: NetworkImage("${currentSong["image"]}"),
                  fit: BoxFit.fitHeight),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                FaIcon(
                  Icons.favorite,
                  color: Color.fromRGBO(80, 80, 80, 1),
                ),
                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(80, 80, 80, 1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${currentSong["title"]}",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 30),
                      ),
                      Text(
                        "${currentSong["artist"]}",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
