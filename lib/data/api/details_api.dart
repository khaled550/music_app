import 'dart:convert';

import 'package:music_app/data/model/track_details.dart';

import '../dio_helper.dart';

class DetailsApi {
  static const String url = 'track.get';

  Future<TrackDetails> getTrackDetailsData({required trackId}) async {
    TrackDetails trackDetails = TrackDetails();
    await DioHelper.getData(
      url: url,
      query: {
        'track_id': trackId,
        'apikey': 'd138941f35146392cfd09d0a6781be45',
      },
    ).then((value) {
      print(value.data);
      trackDetails = TrackDetails.fromJson(json.decode(value.data) as Map<String, dynamic>);
      //print(trackDetails.trackName);
    }).onError((error, stackTrace) {
      print(error.toString());
    });
    return trackDetails;
  }
}
