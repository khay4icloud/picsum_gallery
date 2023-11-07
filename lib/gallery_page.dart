import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:picsum_gallery/models/picsum_image_model.dart';

class GalleryPage extends StatefulWidget {
  GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final _scrollController = ScrollController();
  int _currentPage = 1;
  final List<PicsumImage> _totalImageList = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMore);
    getNetworkImages(_currentPage);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      setState(() {
        _currentPage++;
        getNetworkImages(_currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Picsum Pagination'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _totalImageList.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              ListTile(
                title: Text(
                    '${index + 1}. ${_totalImageList[index].author} current page = $_currentPage'),
              ),
              Image.network(_totalImageList[index].downloadUrl)
            ],
          );
        },
      ),
    );
  }

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
        setState(() {
          _totalImageList.addAll(_imageList);
        });
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
      print(error);
      throw Exception('Unknown Error');
    }
  }
}
