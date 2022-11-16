import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica1/list/song_list_element.dart';
import 'package:practica1/provider/song_list_prov.dart';
import 'package:provider/provider.dart';

class SongList extends StatelessWidget {
  SongList({Key? key}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(width: 5),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: FaIcon(FontAwesomeIcons.arrowLeft),
              ),
              Text("faved Songs")
            ],
          ),
          _songArea(context),
        ],
      ),
    );
  }

  Widget _songArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height - 100,
      child: _songList(context, context.watch<SongListProv>().songList),
    );
  }

  Widget _songList(BuildContext context, List<Map<String,String>> songList) {
    return ListView.builder(
      itemCount: songList.length,
      itemBuilder: (BuildContext context, int index) {
        return SongListElement(
            currentSong: songList[index],
            songList: songList,
            index: index,
          );
      },
    );
  }
}
