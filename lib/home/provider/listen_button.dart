import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;


class ListenButton with ChangeNotifier {
  bool isRecording = false;
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

  final record = Record();

  Future<String?> recordSong() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    isRecording = true;
    notifyListeners();
    try {
      if (await record.hasPermission()) {
        await record.start(
          path: '${tempPath}/cancion.mp3',
          encoder: AudioEncoder.aacHe,
          bitRate: 128000,
          samplingRate: 44100,
        );
        await Future.delayed(Duration(seconds: 8));
        isRecording = false;
        notifyListeners();
        return await record.stop();
      }
    } catch (error) {
      isRecording = false;
      notifyListeners();
      print(error);
      return null;
    }
  }

  Future<dynamic> recieveSong(String song) async {
    
    File file = File(song);
    List<int> fileBytes = await file.readAsBytes();
    String finalFile = base64Encode(fileBytes);
    

    http.Response response = await http.post(
      Uri.parse('https://api.audd.io/'),
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      body: jsonEncode(
        <String, dynamic>{
          'api_token': 'bec0a20feec12528f6425d3e11cb16c9',
          'return': 'apple_music,spotify',
          'audio': finalFile,
          'method': 'recognize',
        },
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return null;
    }
  }

  Map<String, String> parseResponse(var raw){
    Map<String, String> assembled = {};
    try{
    assembled["artist"]=raw["result"]["artist"];
    assembled["title"]=raw["result"]["title"];
    assembled["album"]=raw["result"]["album"];
    assembled["release_date"]=raw["result"]["release_date"];
    assembled["image"]=raw["result"]["spotify"]["album"]["images"][0]["url"];
    assembled["spotifyMusicLink"]=raw["result"]["spotify"]["external_urls"]["spotify"];
    assembled["listn"]=raw["result"]["song_link"];
    assembled["appleMusicLink"]=raw["result"]["apple_music"]["url"];
    }catch(err){
      return {};
    }
    return assembled;
  }

  void toggleRecording() {
    isRecording = !isRecording;
    if (isRecording) {
      print("state");
    }
    notifyListeners();
  }
}
