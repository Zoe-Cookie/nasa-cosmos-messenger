import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://api.nasa.gov/planetary/apod';

  final String _apiKey = dotenv.env['NASA_API_KEY'] ?? 'DEMO_KEY';

  Future<ApodModel> getApodByDate(String date) async {
    try {
      final response = await _dio.get(_baseUrl, queryParameters: {'api_key': _apiKey, 'date': date, 'thumbs': true});

      return ApodModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load APOD data: $e');
    }
  }
}
