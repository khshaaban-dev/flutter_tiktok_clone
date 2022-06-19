import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/exeptions/auth_exceptions.dart';
import '../../../data/repostories/upload_video_repostory.dart';

part 'upload_video_event.dart';
part 'upload_video_state.dart';

class UploadVideoBloc extends Bloc<UploadVideoEvent, UploadVideoState> {
  final UploadVideoRepostory _uploadVideoRepostory;
  UploadVideoBloc({UploadVideoRepostory? uploadVideoRepostory})
      : _uploadVideoRepostory = uploadVideoRepostory ?? UploadVideoRepostory(),
        super(UploadVideoInitial()) {
    on<UploadVideoToStorageEvent>((event, emit) async {
      emit(VideoProgressState());
      try {
        await _uploadVideoRepostory.uploadVideo(
          file: event.videoFile,
          videoPath: event.videoPath,
          songName: event.songName,
          caption: event.caption,
        );
        emit(
          UploadVideoDoneState(),
        );
      } on AuthError catch (e) {
        emit(
          VideoUploadErrorState(error: e),
        );
      }
    });
  }
}
