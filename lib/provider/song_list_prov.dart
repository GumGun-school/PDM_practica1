import 'package:flutter/cupertino.dart';

class SongListProv with ChangeNotifier {
  List<Map<String, String>> songList = [
    {
      "artist": "Imagine Dragons",
      "title": "Warriors",
      "album": "Warriors",
      "release_date": "2014-09-18",
      "image":
          "https://i.scdn.co/image/d3acaeb069f37d8e257221f7224c813c5fa6024e",
      "spotifyMusicLink":
          "https://open.spotify.com/artist/53XhwfbYqKCa1cC15pYq2q",
      "listn": "https://lis.tn/pDbEyg",
      "appleMusicLink":
          "https://music.apple.com/us/album/euphoria/1463650965?app=music&at=1000l33QU&i=1463650969&mt=1",
    },
  ];

  void addSongTest() {
    songList.add({
      "artist": "Echos",
      "title": "Euphoria",
      "album": "Even Though You're Gone",
      "release_date": "2018-11-16",
      "image":
          "https://i.scdn.co/image/ab67616d0000b2735ae92adeac517dbcac9decaa",
      "spotifyMusicLink":
          "https://open.spotify.com/artist/6SnMMbLQ4iS8WIyt3ksmCR",
      "listn": "https://lis.tn/pDbEyg",
      "appleMusicLink":
          "https://music.apple.com/us/album/euphoria/1463650965?app=music&at=1000l33QU&i=1463650969&mt=1",
    });
    notifyListeners();
  }

  void addSong(Map<String,String> song) {
    songList.add(song);
    notifyListeners();
  }

  int songIndex(Map<String,String> content){
    return songList.indexWhere((element) => element == content);
  }

  bool deleteSong(Map<String,String> content) {
    int index = songIndex(content);
    if(index==-1){
      print("not in array");
    }else{
      songList.removeAt(index);
    }
    notifyListeners();
    return true;
  }
}
