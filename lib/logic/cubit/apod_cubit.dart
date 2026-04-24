import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';
import 'package:nasa_cosmos_messenger/data/repositories/api_service.dart';
import 'package:nasa_cosmos_messenger/logic/cubit/apod_state.dart';

class ApodCubit extends Cubit<ApodState> {
  final ApiService _apiService;

  ApodCubit(this._apiService) : super(ApodInitial());

  Future<void> fetchApod(String date) async {
    emit(ApodLoading());

    try {
      final ApodModel apod = await _apiService.getApodByDate(date);

      emit(ApodSuccess(apod));
      
    } catch (e) {
      emit(ApodFailure('無法取得太空圖，請檢查日期格式或網路連線。'));
    }
  }
}