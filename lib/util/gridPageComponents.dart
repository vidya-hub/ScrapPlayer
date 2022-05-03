import 'package:flutter/material.dart';
import 'package:webmp3/models/gridMusicModel.dart';
import 'package:webmp3/screens/albumpage.dart';

Widget getGridCard(
  GridMusicModel gridMusicModel,
  BuildContext context,
) {
  return InkWell(
    onTap: () {
      // print(gridMusicModel.movieAlbumLink);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return AlbumPage(
            albumModel: gridMusicModel,
          );
        },
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Card(
            child: Image.network(
              gridMusicModel.movieImage ?? "",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ),
    ),
  );
}

AppBar titleAppBar() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.green,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "WEB MP3",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        Icon(
          Icons.music_note_rounded,
          color: Colors.black,
        ),
      ],
    ),
  );
}
