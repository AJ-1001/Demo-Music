/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListenMusic(),
    );
  }
}

class ListenMusic extends StatelessWidget {
  const ListenMusic({super.key});

  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Mp3s').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Card(
                    child: Text(snapshot.data[Index].data["Song_name"]),
                  ),
                );
              });
        }
      },
    );
  }
}


class ListenMusic extends StatefulWidget {
  const ListenMusic({super.key});

  @override
  State<ListenMusic> createState() => _ListenMusicState();
}

class _ListenMusicState extends State<ListenMusic> {
  final songstream = FirebaseFirestore.instance.collection('Mp3s').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: songstream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Connsection");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loadin");
          }
          var docs = snapshot.data!.docs;
          return Text('$docs.length');
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListenMusic(),
    );
  }
}

class ListenMusic extends StatefulWidget {
  @override
  _ListenMusicState createState() => _ListenMusicState();
}

class _ListenMusicState extends State<ListenMusic> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> allAudio = [];
  int index = 0;

  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Mp3s').get();
    return qn.docs;
  }

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          allAudio.add(value[i].data()["Song_url"]);
        }
      });
    });
  }

  void playPrevious() async {
    if (index > 0) {
      index--;
      await audioPlayer.setSourceUrl(allAudio[index]);
      audioPlayer.resume();
    }
  }

  void playNext() async {
    if (index < allAudio.length - 1) {
      index++;
      await audioPlayer.setSourceUrl(allAudio[index]);
      audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: playPrevious,
            icon: const Icon(
              Icons.skip_previous,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              audioPlayer.pause();
            },
            icon: const Icon(
              Icons.pause,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              audioPlayer.resume();
            },
            icon: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: playNext,
            icon: const Icon(
              Icons.skip_next,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListenMusic(),
    );
  }
}

class ListenMusic extends StatefulWidget {
  @override
  _ListenMusicState createState() => _ListenMusicState();
}

class _ListenMusicState extends State<ListenMusic> {
  AudioPlayer audioPlayer = AudioPlayer();
  List<String> allAudio = [
    "https://firebasestorage.googleapis.com/v0/b/musicapp-156cc.appspot.com/o/Mp3s%2Fspotifydown.com%20-%20Memory%20Reboot.mp3.mp3?alt=media&token=f0a9e600-452b-4fff-9766-eb1f0e43d48c",
    "https://firebasestorage.googleapis.com/v0/b/musicapp-156cc.appspot.com/o/Mp3s%2FOrdinary%20Person%20(From%20_Leo_).mp3.mp3?alt=media&token=c641ce36-9959-4026-8680-769953e9d260",
    "https://firebasestorage.googleapis.com/v0/b/musicapp-156cc.appspot.com/o/Mp3s%2FI'm%20Scared%20(From%20_Leo_).mp3.mp3?alt=media&token=f02ccb8c-340a-41b4-9847-4bcf2eb6c888",
  ];
  int index = 0;

  Future getData() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Mp3s').get();
    return qn.docs;
  }

  Future<void> playPrevious() async {
    if (index > 0) {
      index--;
      await audioPlayer.play(UrlSource(allAudio[index]));
      audioPlayer.resume();
    }
  }

  Future<void> playNext() async {
    if (index < allAudio.length - 1) {
      index++;
      await audioPlayer.play(UrlSource(allAudio[index]));
      audioPlayer.resume();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music App'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: playPrevious,
                icon: const Icon(
                  Icons.skip_previous,
                  color: Color.fromARGB(255, 0, 0, 0),
                  size: 30,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              audioPlayer.pause();
            },
            icon: const Icon(
              Icons.pause,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              audioPlayer.resume();
            },
            icon: const Icon(
              Icons.play_arrow,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
          ),
          IconButton(
            onPressed: playNext,
            icon: const Icon(
              Icons.skip_next,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
