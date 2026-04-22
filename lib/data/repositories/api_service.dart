import 'package:dio/dio.dart';
import '../models/apod_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://api.nasa.gov/planetary/apod';

  final String _apiKey = 'DEMO_KEY';

  Future<ApodModel> getApodByDate(String date) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {'api_key': _apiKey, 'date': date, 'thumbs': true});

      return ApodModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load APOD data: $e');
    }
  }
}
