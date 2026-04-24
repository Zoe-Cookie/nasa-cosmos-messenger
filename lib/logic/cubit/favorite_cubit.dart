import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_cosmos_messenger/data/repositories/favorite_repository.dart';
import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository _repository; 

  FavoriteCubit(this._repository) : super(FavoriteState(favorites: []));

  Future<void> loadFavorites() async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<ApodModel> data = await _repository.getFavorites();
      emit(state.copyWith(favorites: data, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      debugPrint('讀取收藏失敗: $e');
    }
  }

  Future<void> removeFavorite(String date) async {
    try {
      await _repository.removeFavorite(date);
      loadFavorites(); 
    } catch (e) {
      debugPrint('刪除收藏失敗: $e');
    }
  }
}