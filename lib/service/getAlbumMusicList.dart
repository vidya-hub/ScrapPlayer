import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:webmp3/models/SongModel.dart';
import 'package:webmp3/service/getAlbumDataMainService.dart';

class AlbumSongsList {
  static Future<List<SongModel>?> getSongModel(
    String albumUrl,
    String albumMainUrl,
  ) async {
    String albumResponse = await getWebSiteBody(albumUrl);
    Document document = parse(albumResponse);
    Element? albumBody = getAlbumListBody(
      document,
      albumMainUrl,
    );
    List<Element>? finalAlbumList = getAlbumList(albumBody);
    if (finalAlbumList!.isNotEmpty) {
      List<SongModel>? finalSongModelList = getSongModelList(finalAlbumList);
      return finalSongModelList;
    } else {
      return [];
    }
  }

// get that body contains list of p tags
  static Element? getAlbumListBody(Document document, String albumUrl) {
    Element? albumMainBody = (document
        .getElementById("site-content")
        ?.children
        .first
        .getElementsByTagName("span")
        .where(
          (element) => (element.className) == "h-entry",
        ))?.first;

    return (albumMainBody);
  }

  // from that body get list of p tags

  static List<Element>? getAlbumList(
    Element? albumBody,
  ) {
    List<Element>? getElements =
        albumBody?.getElementsByTagName("p")[2].children;
    List<Element>? finalAlbumList = (getElements?.where((element) {
      return element.localName == "a";
    }).toList());
    return finalAlbumList;
  }

  // from each and every p tag extract album url with song name
  static List<SongModel>? getSongModelList(
    List<Element>? albumTagsList,
  ) {
    return List.generate(
      albumTagsList!.length,
      (index) {
        return getSongModelFromElement(
          albumTagsList[index],
        );
      },
    );
  }

  static SongModel getSongModelFromElement(Element element) {
    String? songLink = element.attributes["href"];
    String? songName = element.text;
    // print(songName);
    return SongModel(
      songName: songName,
      songLink: songLink,
    );
  }
}
