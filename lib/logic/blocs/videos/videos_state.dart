part of 'videos_bloc.dart';

class VideosState extends Equatable {
  const VideosState({
    this.error,
    this.videos = const [],
    this.loading = false,
  });
  final String? error;
  final Iterable<DocumentSnapshot>? videos;
  final bool loading;

  @override
  List<Object?> get props => [error, videos, loading];

  const VideosState.empty()
      : error = null,
        videos = const [],
        loading = false;

  VideosState copyWith({
    String? error,
    Iterable<DocumentSnapshot>? videos,
    bool? loading,
  }) {
    return VideosState(
      error: error ?? this.error,
      videos: videos ?? this.videos,
      loading: loading ?? this.loading,
    );
  }
}
