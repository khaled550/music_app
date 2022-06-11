part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  Song tracks;

  HomeLoaded({required this.tracks});
}

class HomeError extends HomeState {
  String error;

  HomeError({required this.error});
}

class DetailsLoading extends HomeState {}

class DetailsLoaded extends HomeState {
  TrackDetails trackDetails;

  DetailsLoaded({required this.trackDetails});
}

class DetailsError extends HomeState {
  String error;

  DetailsError({required this.error});
}

class LyricsLoading extends HomeState {}

class LyricsLoaded extends HomeState {
  TrackLyrics trackLyrics;

  LyricsLoaded({required this.trackLyrics});
}

class LyricsError extends HomeState {
  String error;

  LyricsError({required this.error});
}

class ConnectionInitial extends HomeState {}

class ConnectionLoaded extends HomeState {
  bool isConnected;

  ConnectionLoaded({required this.isConnected});
}

class ConnectionError extends HomeState {
  String error;

  ConnectionError({required this.error});
}
