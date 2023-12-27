import 'dart:convert';

import 'package:flutter_bloc_course/0_data/exceptions/exceptions.dart';
import 'package:flutter_bloc_course/0_data/models/advice_model.dart';
import "package:http/http.dart" as http;

abstract class AdviceRemoteDataSource {
  Future<AdviceModel> getRandomAdviceFromapi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDataSource {
  final client = http.Client();
  @override
  Future<AdviceModel> getRandomAdviceFromapi() async {
    final response = await client.get(
      Uri.parse('https://api.flutter-community.com/api/v1/advice'),
    );

    if (response.statusCode == 200) {
      final responsebody = json.decode(response.body);

      return AdviceModel.fromMap(responsebody);
    } else {
      throw ServerException();
    }
  }
}
