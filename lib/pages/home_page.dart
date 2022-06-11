import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app/bloc/cubit/home_cubit.dart';
import 'package:music_app/pages/no_connection.dart';

import '../data/model/track.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TrackList> trackList = [];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Trending'),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ConnectionError) {
            return const NoConnectionPage();
          }
          trackList = (state is HomeLoaded && state is! ConnectionError)
              ? state.tracks.message!.body!.trackList!
              : trackList;
          return _buildHomePage(
            trackList,
            context,
          );
        },
      ),
    );
  }

  ListView _buildHomePage(List<TrackList> trackList, BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx, index) => ListTile(
        leading: const Icon(Icons.library_music),
        title: Text(trackList[index].track!.trackName!),
        subtitle: Text(trackList[index].track!.albumName!),
        trailing: Text(trackList[index].track!.artistName!),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: trackList[index].track!.trackId,
          );
        },
      ),
      separatorBuilder: (context, index) => const Divider(
        thickness: 1.5,
      ),
      itemCount: trackList.length,
    );
  }
}
