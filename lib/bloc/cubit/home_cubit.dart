import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:music_app/data/api/details_api.dart';
import 'package:music_app/data/api/home_api.dart';
import 'package:music_app/data/api/track_lyrics_api.dart';
import 'package:music_app/data/model/track_lyrics.dart';

import '../../data/model/track.dart';
import '../../data/model/track_details.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeApi homeApi;
  final DetailsApi detailsApi;
  final TrackLyricsApi trackLyricsApi;

  HomeCubit(this.homeApi, this.detailsApi, this.trackLyricsApi) : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  Future<void> getTracksData() async {
    emit(HomeLoading());
    try {
      final Song tracks = await homeApi.getTracksData();
      emit(HomeLoaded(tracks: tracks));
    } catch (e) {
      emit(HomeError(error: e.toString()));
    }
  }

  Future<void> getTracksDetailsData(int trackId) async {
    emit(DetailsLoading());
    try {
      final TrackDetails trackDetails = await detailsApi.getTrackDetailsData(
        trackId: trackId,
      );
      emit(DetailsLoaded(trackDetails: trackDetails));
      getTracksLyricsData(trackId);
    } catch (e) {
      emit(DetailsError(error: e.toString()));
    }
  }

  Future<void> getTracksLyricsData(int trackId) async {
    try {
      final TrackLyrics trackLyrics = await trackLyricsApi.getTrackLyricsData(
        trackId: trackId,
      );
      emit(LyricsLoaded(trackLyrics: trackLyrics));
    } catch (e) {
      emit(LyricsError(error: e.toString()));
    }
  }

  Connectivity connectivity = Connectivity();

  bool isConnected = false;

  Future<void> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      connect();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      connect();
    } else {
      disconnect();
    }
    startMoitoring();
  }

  startMoitoring() async {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        disconnect();
      } else {
        connect();
      }
    });
  }

  connect() {
    isConnected = true;
    emit(ConnectionLoaded(isConnected: isConnected));
    print('Connected!');
    getTracksData();
  }

  disconnect() {
    isConnected = false;
    emit(ConnectionError(error: 'No Internet Connection!'));
    print('No Internet Connection!');
  }
}
