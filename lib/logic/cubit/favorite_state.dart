import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';

class FavoriteState {
  final List<ApodModel> favorites;
  final bool isLoading;

  FavoriteState({
    required this.favorites,
    this.isLoading = false,
  });

  FavoriteState copyWith({
    List<ApodModel>? favorites,
    bool? isLoading,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}