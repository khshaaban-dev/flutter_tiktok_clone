import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repostories/videos_repostory.dart';

part 'videos_event.dart';
part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideoRepostory videoRepostory;
  VideosBloc({VideoRepostory? repostory})
      : videoRepostory = repostory ?? VideoRepostory(),
        super(const VideosState.empty()) {
    on<VideosStartFeatchEvent>((event, emit) async {
      emit(const VideosState(
        error: null,
        videos: null,
        loading: true,
      ));
      try {
        final allVideos = await videoRepostory.getAllVideos();
        emit(
          VideosState(
            loading: false,
            error: null,
            videos: allVideos ?? [],
          ),
        );
      } on Exception catch (e) {
        emit(VideosState(
          error: e.toString(),
          loading: false,
          videos: null,
        ));
      }
    });
    on<VideosFeatchMoreVideosEvent>((event, emit) async {
      try {
        emit(VideosState(
          error: null,
          videos: state.videos ?? [],
          loading: true,
        ));
        final lastDocument = state.videos!.last;
        final nextVideos =
            await videoRepostory.getMoreVideos(documentSnapshot: lastDocument);

        final updatedData = state.videos!.followedBy(nextVideos ?? []);

        emit(VideosState(
          error: null,
          videos: updatedData,
          loading: false,
        ));
      } on Exception catch (e) {
        emit(VideosState(
          videos: state.videos ?? [],
          loading: false,
          error: e.toString(),
        ));
      }
    });
  }
}
