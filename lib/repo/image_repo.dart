import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:picsum_gallery/models/picsum_image_model.dart';

class PicsumImageRepository {
  Future<List<PicsumImage>> getNetworkImages(int pageKey) async {
    try {
      var endPointUrl =
          Uri.parse('https://picsum.photos/v2/list?page=$pageKey');
      final response = await http.get(endPointUrl);
      if (response.statusCode == 200) {
        final List<dynamic> decodedList = jsonDecode(response.body) as List;
        final List<PicsumImage> _imageList = decodedList.map((listItem) {
          return PicsumImage.fromJson(listItem);
        }).toList();

        return _imageList;
      } else {
        throw Exception('API call not successful');
      }
    } on SocketException {
      throw Exception('No internet connection :(');
    } on HttpException {
      throw Exception('Could\'nt retrieve images! Sorry! :(');
    } on FormatException {
      throw Exception('Bad response format! :(');
    } catch (error) {
      throw Exception('Unknown Error');
    }
  }
}
