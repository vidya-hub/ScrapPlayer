import 'package:flutter/material.dart';
import 'package:webmp3/models/gridMusicModel.dart';
import 'package:webmp3/screens/albumgridpage.dart';
import 'package:webmp3/service/getAlbumDataMainService.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MovieGridWidget(
        onRefresh: () async {
          setState(() {});
        },
      ),
    );
  }
}
/* 

  Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: double.infinity,
      color: Colors.grey,
      child: Text(gridMusicModel.movieName ?? ""),
    ),
  )

 */