import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:webmp3/models/SongModel.dart';
import 'package:webmp3/models/gridMusicModel.dart';
import 'package:webmp3/service/getAlbumMusicList.dart';

class AlbumPage extends StatefulWidget {
  GridMusicModel albumModel;
  AlbumPage({
    Key? key,
    required this.albumModel,
  }) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  bool isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(50, 70),
        child: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: Text(
            widget.albumModel.movieName ?? "",
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                    child: Image.network(
                      widget.albumModel.movieImage ?? "",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    widget.albumModel.movieName ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: FutureBuilder<List<SongModel>?>(
                future: AlbumSongsList.getSongModel(
                  widget.albumModel.movieAlbumLink ?? "",
                  widget.albumModel.albumMainLink ?? "",
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        SongModel? songModel = snapshot.data?[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.65,
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        songModel?.songName ?? "",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          log("Here");
                                          // if (isPlaying) {
                                          //   await AudioPlayer().stop();
                                          // } else {

                                          // }
                                          // setState(() {
                                          //   isPlaying = !isPlaying;
                                          // });

                                          await AudioPlayer()
                                              .play(songModel?.songLink ?? "")
                                              .catchError((onError) {
                                            log(onError.toString());
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.play_arrow,
                                          size: 20,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.download,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
