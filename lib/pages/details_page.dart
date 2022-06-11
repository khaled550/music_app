import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/cubit/home_cubit.dart';
import 'package:music_app/data/model/track_details.dart';
import 'package:music_app/pages/no_connection.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Track track = Track();
    String lyricsBody = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Details'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is DetailsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ConnectionError) {
          return const NoConnectionPage();
        }
        track = (state is DetailsLoaded) ? state.trackDetails.message!.body!.track! : track;
        lyricsBody = (state is LyricsLoaded)
            ? state.trackLyrics.message!.body!.lyrics!.lyricsBody!
            : lyricsBody;
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextColumn(
                'Name',
                track.trackName!,
              ),
              _buildTextColumn(
                'Artist',
                track.artistName!,
              ),
              _buildTextColumn(
                'Album Name',
                track.albumName!,
              ),
              _buildTextColumn(
                'Explicit',
                (track.explicit! == 1) ? 'True' : 'False',
              ),
              _buildTextColumn(
                'Rating',
                track.trackRating!.toString(),
              ),
              _buildTextColumn('Lyrics', lyricsBody),
            ],
          ),
        );
      }),
    );
  }

  _buildTextColumn(String title, String text) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
}
