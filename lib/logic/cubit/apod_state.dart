import 'package:nasa_cosmos_messenger/data/models/apod_model.dart';

abstract class ApodState {}

class ApodInitial extends ApodState {}

class ApodLoading extends ApodState {}

class ApodSuccess extends ApodState {
  final ApodModel apod;
  
  ApodSuccess(this.apod);
}

class ApodFailure extends ApodState {
  final String errorMessage;
  
  ApodFailure(this.errorMessage);
}