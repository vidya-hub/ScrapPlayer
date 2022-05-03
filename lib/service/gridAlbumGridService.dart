import 'dart:developer';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:webmp3/constants.dart';
import 'package:webmp3/models/gridMusicModel.dart';
import 'package:webmp3/service/getAlbumDataMainService.dart';

class GridAlbumService {
  static Future<List<GridMusicModel>> getAlbumListData() async {
    final String responseBody = await getWebSiteBody(SITE_LINK);
    List<GridMusicModel> musicGridList = getMusicTileGrid(responseBody);
    return musicGridList;
  }

  static List<GridMusicModel> getMusicTileGrid(String response) {
    Document document = parse(response);
    Element? gridDocument = document.getElementById("featured-content-2");
    Element? ulElement = gridDocument!.getElementsByTagName("ul").first;
    List<Element>? itemList = ulElement.getElementsByTagName("li");
    List<GridMusicModel> getGridMovieList = getGridMusicList(itemList);
    return getGridMovieList;
  }

  static List<GridMusicModel> getGridMusicList(List<Element>? itemList) {
    List<GridMusicModel> _gridList = List.generate(
      itemList!.length,
      (index) {
        return getGridMovieModel(
          itemList[index],
        );
      },
    );
    return _gridList;
  }

  static GridMusicModel getGridMovieModel(Element? liItem) {
    Element? linkAttribute =
        liItem?.children.first.getElementsByTagName("a").first;
    String? movieLink = (linkAttribute?.attributes["href"] ?? "");
    String? imageLink =
        SITE_LINK + (linkAttribute?.children.first.attributes["src"] ?? "");
    String? movieName =
        (linkAttribute?.nextElementSibling?.children.first.firstChild?.text ??
            "");
    return GridMusicModel(
      movieName: movieName,
      movieImage: imageLink,
      movieAlbumLink: SITE_LINK + movieLink,
      albumMainLink: movieLink,
    );
  }
}
