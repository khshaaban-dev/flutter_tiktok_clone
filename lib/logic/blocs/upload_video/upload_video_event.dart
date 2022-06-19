part of 'upload_video_bloc.dart';

abstract class UploadVideoEvent extends Equatable {
  const UploadVideoEvent();

  @override
  List<Object> get props => [];
}

class UploadVideoToStorageEvent extends UploadVideoEvent {
  final File videoFile;
  final String videoPath;
  final String caption;
  final String songName;
  const UploadVideoToStorageEvent({
    required this.videoFile,
    required this.videoPath,
    required this.songName,
    required this.caption,
  });
}

class PushProgressToScreenEvent extends UploadVideoEvent {
  final double progress;
  const PushProgressToScreenEvent({
    required this.progress,
  });
}
