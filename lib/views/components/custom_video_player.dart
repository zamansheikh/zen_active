import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoPath;
  final String thumbnailPath;
  final bool playFromAsset;
  final double? borderRadius;
  final bool showSeekbar;

  const CustomVideoPlayer({
    super.key,
    required this.videoPath,
    required this.thumbnailPath, // Thumbnail for lazy loading
    this.playFromAsset = false,
    this.borderRadius,
    this.showSeekbar = false,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  String? _errorMessage;
  bool _isSeeking = false;
  late Duration _videoDuration;
  late Duration _currentPosition;
  bool _showSeekbar = false;
  Timer? _seekbarHideTimer;

  @override
  void initState() {
    super.initState();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoPath))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
          _videoDuration = _controller.value.duration;
          _currentPosition = Duration.zero;
          _controller.setLooping(true);
          _controller.setVolume(0.0);
        });
      }).catchError((error) {
        setState(() {
          _errorMessage = 'Error loading video: ${error.toString()}';
        });
      });

    _controller.addListener(() {
      if (_controller.value.hasError && mounted) {
        setState(() {
          _errorMessage = _controller.value.errorDescription;
        });
      }
      if (!_isSeeking) {
        setState(() {
          _currentPosition = _controller.value.position;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _seekbarHideTimer?.cancel();
    super.dispose();
  }

  void _togglePlay() {
    if (!_isInitialized) {
      _initializeVideo();
    }

    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  void _onSeek(double value) {
    setState(() {
      _isSeeking = true;
      _currentPosition = Duration(seconds: value.toInt());
    });
    _controller.seekTo(_currentPosition);
  }

  void _onSeekEnd() {
    setState(() {
      _isSeeking = false;
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _hideSeekbarAfterDelay() {
    _seekbarHideTimer?.cancel();
    setState(() {
      _showSeekbar = true;
    });

    _seekbarHideTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _showSeekbar = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showSeekbar = widget.showSeekbar || _showSeekbar;

    if (_errorMessage != null) {
      return Center(
        child: Container(
          width: 300,
          height: 200,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 24),
              const SizedBox(height: 16),
              Text(_errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.blueAccent)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                  });
                  _initializeVideo();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (!_isInitialized) {
      return GestureDetector(
        onTap: _togglePlay,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
          child: AspectRatio(
            aspectRatio: 16 / 9, // Default aspect ratio
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(widget.thumbnailPath, fit: BoxFit.cover),
                Icon(Icons.play_arrow, color: Colors.white, size: 50),
              ],
            ),
          ),
        ),
      );
    }

    return InkWell(
      onDoubleTap: _hideSeekbarAfterDelay,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.center,
            children: [
              VideoPlayer(_controller),
              Positioned(
                child: GestureDetector(
                  onTap: _togglePlay,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              if (showSeekbar)
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Slider(
                    value: _currentPosition.inSeconds.toDouble(),
                    min: 0,
                    max: _videoDuration.inSeconds.toDouble(),
                    onChanged: _onSeek,
                    onChangeEnd: (_) => _onSeekEnd(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              if (showSeekbar)
                Positioned(
                  bottom: 7,
                  left: 14,
                  right: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_currentPosition),
                          style: const TextStyle(color: Colors.white)),
                      Text(_formatDuration(_videoDuration),
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
