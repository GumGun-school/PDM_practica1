import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica1/banner/provider/fav_button.dart';
import 'package:practica1/provider/song_list_prov.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SongBanner extends StatelessWidget {
  final Map<String, String> currentSong;
  final List<Map<String, String>> songList;
  final int index;
  final bool faved;
  SongBanner({
    Key? key,
    required this.currentSong,
    required this.songList,
    required this.index,
    required this.faved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                  SizedBox(width: 10),
                  Text(
                    "Here you go",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ],
              ),
              IconButton(
                onPressed: () async {
                  if (context.read<SongListProv>().songIndex(currentSong) !=
                      -1) {
                    bool? delete = await showDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Eliminar de favoritos'),
                          content: const Text(
                              'El elemento sera eliminado de tus favoritos Quieres continuar?'),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('Eliminar'),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (delete == null) {
                      delete = false;
                    }
                    if (delete) {
                      context.read<FavButton>().changeButton();
                      context.read<SongListProv>().deleteSong(currentSong);
                    }
                  } else {
                    context.read<FavButton>().changeButton();
                    context.read<SongListProv>().addSong(currentSong);
                  }
                },
                icon: FaIcon(
                  (context.watch<FavButton>().faved)
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Image.network(
            "${currentSong["image"]}",
            width: 240,
            //fit: BoxFit.cover,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "${currentSong["title"]}",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
          ),
          Text(
            "${currentSong["album"]}",
            style: TextStyle(fontSize: 25),
          ),
          Text(
            "${currentSong["artist"]}",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            "${currentSong["release_date"]}",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 40,
          ),
          Text("Abrir con"),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  String url = "${[currentSong["spotifyMusicLink"]]}";
                  try {
                    launchUrl(Uri.parse(url));
                  } catch (error) {}

                  //html.window.open("${[currentSong["spotifyMusicLink"]]}", 'new tab');
                  print('abrir spotify');
                },
                icon: FaIcon(FontAwesomeIcons.spotify),
                iconSize: 40,
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                onPressed: () {
                  String url = "${[currentSong["listn"]]}";
                  try {
                    launchUrl(Uri.parse(url));
                  } catch (error) {}
                  //html.window.open(, 'new tab');
                  print('logo que no se que sea');
                },
                icon: FaIcon(FontAwesomeIcons.info),
                iconSize: 40,
              ),
              SizedBox(
                width: 30,
              ),
              IconButton(
                onPressed: () {
                  String url = "${[currentSong["appleMusicLink"]]}";
                  try {
                    launchUrl(Uri.parse(url));
                  } catch (error) {}
                  //html.window.open("${[currentSong["appleMusicLink"]]}", 'new tab');
                  print('abrir appleMusic');
                },
                icon: FaIcon(FontAwesomeIcons.apple),
                iconSize: 40,
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getHigh(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text('A dialog is a type of modal window that\n'
              'appears in front of app content to\n'
              'provide critical information, or prompt\n'
              'for a decision to be made.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
