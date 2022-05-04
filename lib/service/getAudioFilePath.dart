import 'dart:io';
import 'dart:math';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webmp3/models/SongModel.dart';

// generate random string
String randomString(int length) {
  var rand = Random();
  var codeUnits = List.generate(length, (index) {
    return rand.nextInt(33) + 89;
  });
  return String.fromCharCodes(codeUnits);
}

Future<File?> getFile(SongModel songModel) async {
  final bytes = await readBytes(Uri.parse(songModel.songLink??""));
  final Directory? dir = await getExternalStorageDirectory();
  String getRandomString = randomString(10);
  final file = File('${dir!.path}/$getRandomString.mp3');

  await file.writeAsBytes(bytes);
  if (file.existsSync()) {
    return file;
  }
}
getDownloadFile(){}
