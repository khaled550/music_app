import 'dart:convert';

import 'package:music_app/data/model/track_lyrics.dart';

import '../dio_helper.dart';

class TrackLyricsApi {
  static const String url = 'track.lyrics.get';

  Future<TrackLyrics> getTrackLyricsData({required trackId}) async {
    TrackLyrics trackDetails = TrackLyrics();
    await DioHelper.getData(
      url: url,
      query: {
        'track_id': trackId,
        'apikey': 'd138941f35146392cfd09d0a6781be45',
      },
    ).then((value) {
      //print(value.data);
      trackDetails = TrackLyrics.fromJson(json.decode(value.data) as Map<String, dynamic>);
      //print(trackDetails.trackName);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return trackDetails;
  }
}
