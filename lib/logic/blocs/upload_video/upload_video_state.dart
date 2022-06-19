part of 'upload_video_bloc.dart';

abstract class UploadVideoState extends Equatable {
  const UploadVideoState();

  @override
  List<Object> get props => [];
}

class UploadVideoInitial extends UploadVideoState {}

class VideoProgressState extends UploadVideoState {
  @override
  List<Object> get props => [];
}

class UploadVideoDoneState extends UploadVideoState {}

class VideoUploadErrorState extends UploadVideoState {
  final AuthError error;
  const VideoUploadErrorState({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
