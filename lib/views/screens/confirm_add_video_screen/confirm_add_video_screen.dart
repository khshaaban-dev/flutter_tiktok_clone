import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/constants.dart';
import '../../../data/repostories/upload_video_repostory.dart';
import '../../../logic/blocs/upload_video/upload_video_bloc.dart';
import '../../loading/loading_screen.dart';

import '../../widgets/custom_text_input_feild.dart';
import 'package:video_player/video_player.dart';

import '../screens.dart';

class ConfirmAddVideoScreen extends StatefulWidget {
  static const String route = '/confirm_add_video_screen';

  final File videoFile;

  final String videoPath;
  const ConfirmAddVideoScreen({
    Key? key,
    required this.videoPath,
    required this.videoFile,
  }) : super(key: key);

  @override
  State<ConfirmAddVideoScreen> createState() => _ConfirmAddVideoScreenState();
}

class _ConfirmAddVideoScreenState extends State<ConfirmAddVideoScreen> {
  late VideoPlayerController videoPlayerController;
  late TextEditingController songController;
  late TextEditingController captionController;
  @override
  void initState() {
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    songController = TextEditingController();
    captionController = TextEditingController();
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadVideoBloc(
        uploadVideoRepostory:
            RepositoryProvider.of<UploadVideoRepostory>(context),
      ),
      child: Scaffold(
        body: BlocConsumer<UploadVideoBloc, UploadVideoState>(
          listener: (context, state) {
            if (state is VideoProgressState) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Uloading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }
            if (state is UploadVideoDoneState) {
              Navigator.pushNamed(context, MainScreen.route);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: VideoPlayer(
                    videoPlayerController,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextInputFormFeild(
                          controller: songController,
                          icon: Icons.music_note,
                          labelText: 'song name',
                          validate: (value) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomTextInputFormFeild(
                          controller: captionController,
                          icon: Icons.closed_caption,
                          labelText: 'caption',
                          validate: (value) {
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                        ),
                        onPressed: () {
                          context.read<UploadVideoBloc>().add(
                                UploadVideoToStorageEvent(
                                  videoFile: widget.videoFile,
                                  videoPath: widget.videoPath,
                                  songName: songController.text,
                                  caption: captionController.text,
                                ),
                              );
                          // final repo =
                          //     RepositoryProvider.of<UploadVideoRepostory>(
                          //         context);
                          // repo.uploadVideo(
                          //   file: widget.videoFile,
                          //   videoPath: widget.videoPath,
                          //   songName: songController.text,
                          //   caption: captionController.text,
                          // // );
                        },
                        child: const Text(
                          'Share!',
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
