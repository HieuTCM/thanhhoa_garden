import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class ImgProvider {
  Future<String> upload(File imageFile) async {
    String result = '';
    // open a bytestream
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(
        "https://thanhhoagarden.herokuapp.com/image/convertFromFileToImageURL");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', imageFile.path.split('.').last));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    // listen for response
    await response.stream.transform(utf8.decoder).listen((value) async {
      result = value;
    });

    return result;
  }
}
