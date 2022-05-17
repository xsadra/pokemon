import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/core.dart';

abstract class ShapesRemoteDataSource {
  Future<String> getShapes(int id);
}

class ShapesRemoteDataSourceImpl implements ShapesRemoteDataSource {
  final Dio dio;

  ShapesRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<String> getShapes(int id) async {
    log(App.api.shapesBaseApiUrl + id.toString(),
        name: 'ShapesRemoteDataSource');
    final response = await dio
        .get(
          App.api.shapesBaseApiUrl + id.toString(),
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
        )
        .timeout(const Duration(seconds: 30))
        .catchError((onError) {
      throw ServerException();
    });

    String shapes = (response.data['name'] as String);
    log(shapes, name: 'ShapesRemoteDataSourceImpl');
    return shapes;
  }
}
