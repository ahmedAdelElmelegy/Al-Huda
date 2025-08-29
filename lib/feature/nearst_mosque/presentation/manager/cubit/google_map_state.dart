part of 'google_map_cubit.dart';

@immutable
sealed class GoogleMapState {}

final class GoogleMapInitial extends GoogleMapState {}

final class GoogleMapLoading extends GoogleMapState {}

final class GoogleMapLoaded extends GoogleMapState {
  final String city;
  final String country;
  GoogleMapLoaded(this.city, this.country);
}

final class UpdateCurrentLocation extends GoogleMapState {}

final class GetCurrentLocationLoading extends GoogleMapState {}

final class GetCurrentLocationLoaded extends GoogleMapState {}

final class GetCurrentLocationError extends GoogleMapState {
  final String message;
  GetCurrentLocationError(this.message);
}

final class GetRouteLoading extends GoogleMapState {}

final class GetRouteFailure extends GoogleMapState {}

final class GetRouteSuccess extends GoogleMapState {}

final class SearchPlaceLoading extends GoogleMapState {}

final class SearchPlaceFailure extends GoogleMapState {}

final class SearchPlaceSuccess extends GoogleMapState {}

final class GetCityNameAndCountryNameSuccess extends GoogleMapState {}

final class GetCityNameAndCountryNameFailure extends GoogleMapState {}

final class GetCityNameAndCountryNameLoading extends GoogleMapState {}
