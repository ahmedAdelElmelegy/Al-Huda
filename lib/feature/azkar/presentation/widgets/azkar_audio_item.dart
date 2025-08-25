import 'package:al_huda/feature/azkar/data/model/zikr.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AzkarAudioItem extends StatefulWidget {
  final Zikr zikr;
  final int index;
  const AzkarAudioItem({super.key, required this.zikr, required this.index});

  @override
  State<AzkarAudioItem> createState() => _AzkarAudioItemState();
}

class _AzkarAudioItemState extends State<AzkarAudioItem> {
  final AudioPlayer audioPlayer = AudioPlayer();
  int? currentlyPlayingIndex;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String fixAudioPath(String originalPath) {
    String path = originalPath;

    if (path.startsWith('/')) {
      path = path.substring(1);
    }

    if (!path.startsWith('assets/')) {
      path = path;
    }

    return path;
  }

  Future<void> playAudio(String audioUrl, int index) async {
    try {
      if (currentlyPlayingIndex == index) {
        await audioPlayer.stop();
        setState(() {
          currentlyPlayingIndex = null;
        });
      } else {
        await audioPlayer.play(AssetSource(audioUrl));
        setState(() {
          currentlyPlayingIndex = index;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Cannot play audio: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        currentlyPlayingIndex == widget.index ? Icons.pause : Icons.play_arrow,
        color: Colors.green,
      ),
      onPressed: () => playAudio(fixAudioPath(widget.zikr.audio), widget.index),
    );
  }
}
