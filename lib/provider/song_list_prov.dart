import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SongListProv with ChangeNotifier {
  List<Map<String, String>> songList = [];

/*
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
*/

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

  void addSong(Map<String, String> song) {
    songList.add(song);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favorites': songList});

    notifyListeners();
  }

  int songIndex(Map<String, String> content) {
    return songList.indexWhere((element) => element == content);
  }

  bool deleteSong(Map<String, String> content) {
    int index = songIndex(content);
    if (index == -1) {
      print("not in array");
    } else {
      songList.removeAt(index);
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'favorites': songList});
    }
    notifyListeners();
    return true;
  }

  Future<void> getSongs() async {
    var id = FirebaseAuth.instance.currentUser!.uid;
    final db = FirebaseFirestore.instance.collection('users').doc(id);
    final user = await db.get();
    if (user.data()!['favorites'] != null) {
      var songListStr = user.data()!;
      var tmp = json.encode(songListStr['favorites']);
      List<dynamic> jsonInput = jsonDecode(tmp);
      var obj = decode(jsonInput[0]);
      print(obj);
      songList = [];
      for (var entry in jsonInput) {
        songList.add(decode(entry));
      }
      print(songList);

    } else {
      songList = [];
    }
  }

  Map<String, String> decode(var test){
    Map<String, String> ret={};
    try{
      ret["image"]=test["image"];
      ret["listn"]=test["listn"];
      ret["spotifyMusicLink"]=test["spotifyMusicLink"];
      ret["release_date"]=test["release_date"];
      ret["artist"]=test["artist"];
      ret["album"]=test["album"];
      ret["title"]=test["title"];
      ret["appleMusicLink"]=test["appleMusicLink"];
    }catch(error){
      return {};
    }
    return ret;
  }
}
