import 'package:bloc/bloc.dart';
import 'package:flutterapp/services/video_controller_service.dart';
import 'video_player.dart';


class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  final VideoControllerService _videoControllerService;

  VideoPlayerBloc(this._videoControllerService) : super(VideoPlayerStateInitial());

  @override
  VideoPlayerState get initialState => VideoPlayerStateInitial();

  @override
  Stream<VideoPlayerState> mapEventToState(VideoPlayerEvent event) async* {
    if (event is VideoSelectedEvent) {
      yield VideoPlayerStateLoading();
      try {
        final videoController = await _videoControllerService.getControllerForVideo(event.video);
        yield VideoPlayerStateLoaded(event.video, videoController);
      } catch (e) {
//        yield VideoPlayerStateError(e.toString() ?? 'An unknown error occurred');
      }
    }
  }
}
