import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:provider/provider.dart';
import 'package:university_app/cache/cache_file/sound_cache.dart';
import 'package:university_app/cache/widgets/fab.dart';
import 'package:university_app/controllers/api_settings.dart';
import 'package:university_app/controllers/home_api_controller.dart';
import 'package:university_app/models/cache/sound/sound.dart';
import 'package:university_app/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:university_app/widgets/voice.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/no_cache.dart';
import '../../controller/hive_provider.dart';
import 'cached_voice_widget.dart';
import 'package:path/path.dart' as p;

class AudioCacheScreen extends StatefulWidget {
  const AudioCacheScreen({Key? key}) : super(key: key);

  @override
  State<AudioCacheScreen> createState() => _AudioCacheScreenState();
}

class _AudioCacheScreenState extends State<AudioCacheScreen>
    with WidgetsBindingObserver {
  List<SoundModel> _sounds = [];
  late Future<Box<SoundModel>?> _future;
  final _player = AudioPlayer();
  Duration defaultDuration = Duration(milliseconds: 1);

  get index => null;

  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    super.initState();

    //  _initAudioPlayer(widget.id.toString());
  }

  void _initAudioPlayer(String filePath) async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      //var url = "https://dargonsoftt.com/upload/res/audio/1652816494_file_example_MP3_5MG.mp3";
      defaultDuration =
          (await _player.setAudioSource(AudioSource.file(filePath)))!;
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Release decoders and buffers back to the operating system making them
    // available for other apps to use.
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _future = Provider.of<HiveProvider>(context).openSoundBox();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: FutureBuilder<Box<SoundModel>?>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  Box<SoundModel>? temp = snapshot.data;
                  return ValueListenableBuilder<Box<SoundModel>>(
                    valueListenable: temp!.listenable(),
                    builder: (context, box, _) {
                      _sounds = box.values.toList();
                      return Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Stack(children: [
                                ListView.builder(
                                  itemCount: _sounds.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        String? path = await CacheSound()
                                            .getFilePath(
                                                _sounds[index].id,
                                                p
                                                    .extension(
                                                        _sounds[index].res)
                                                    .toLowerCase());
                                        _initAudioPlayer(path ?? "");
                                      },
                                      child: CacheVoiceWidget(
                                        model: _sounds[index],
                                        onTapDelete: () async {
                                          await CacheSound()
                                              .deleteSoundModel(_sounds[index]);
                                        },
                                      ),
                                    );
                                  },
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: DeleteAllButton(
                                    onTapDeleteAll: () async {
                                      final Box<SoundModel>? box =
                                          await _future;
                                      CacheSound().removeAllCached(box!);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color(0xff4BABEC),
                                  Color(0xff3F8FC5),
                                  Color(0xff33749F),
                                ],
                              ),
                              color: Color(AppUtils.blueColor),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            width: double.infinity,
                            child: Center(
                              child: ControlButtons(_player),
                            ),
                          ),
                          // Display seek bar. Using StreamBuilder, this widget rebuilds
                          // each time the position, buffered position or duration changes.

                          Container(
                            width: double.infinity,
                            //color: Color(AppUtils.blueColor),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Color(0xff33749F),
                                  Color(0xff2B6185)
                                ],
                              ),
                            ),
                            child: StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return SeekBar(
                                  onChanged: _player.seek,
                                  duration:
                                      positionData?.duration ?? Duration.zero,
                                  position:
                                      positionData?.position ?? Duration.zero,
                                  bufferedPosition:
                                      positionData?.bufferedPosition ??
                                          Duration.zero,
                                  onChangeEnd: _player.seek,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const NoCacheFound(resType: 'أصوات');
                }
              }),
        ),
      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text('name' ,style: AppUtils.h2,),
        // Opens volume slider dialog
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                iconSize: 50.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(
                  Icons.pause,
                  color: Colors.white,
                ),
                iconSize: 50.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(
                  Icons.replay,
                  color: Colors.white,
                ),
                iconSize: 50.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    required Future<void> Function(Duration? position, {int? index})
        onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Color(AppUtils.blueColor),
            inactiveTrackColor: Colors.grey.shade400,
            trackHeight: 5.0,
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
            overlayColor: Colors.purple.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: _width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _positionText,
                style: TextStyle(
                    color: Colors.black,
                    // fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: _width * 0.04),
              ),
              Text(
                _durationText,
                style: TextStyle(
                    color: Colors.red,
                    //  fontFamily: MyFont.alegreyaSansRegular,
                    fontSize: _width * 0.04),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String get _durationText =>
      "${widget.duration.inMinutes.remainder(60).toString().padLeft(2, '0')}"
      ":${widget.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}";

  String get _positionText =>
      "${widget.position.inMinutes.remainder(60).toString().padLeft(2, '0')}"
      ":${widget.position.inSeconds.remainder(60).toString().padLeft(2, '0')}";
}

void showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required double value,
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text(
                '${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                style: TextStyle(
                  fontFamily: 'Fixed',
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? value,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
