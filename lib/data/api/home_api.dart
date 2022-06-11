import 'dart:convert';

import 'package:music_app/data/model/track.dart';

import '../dio_helper.dart';

class HomeApi {
  static const String url = 'chart.tracks.get';

  Future<Song> getTracksData() async {
    Song songModel = Song();
    await DioHelper.getData(
      url: url,
      query: {
        'apikey': 'd138941f35146392cfd09d0a6781be45',
      },
    ).then((value) {
      songModel = Song.fromJson(json.decode(
        value.data,
      ) as Map<String, dynamic>);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return songModel;
  }
}
