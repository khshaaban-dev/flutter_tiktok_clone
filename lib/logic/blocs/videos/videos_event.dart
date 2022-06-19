part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class VideosStartFeatchEvent extends VideosEvent {}

class VideosFeatchMoreVideosEvent extends VideosEvent {}
