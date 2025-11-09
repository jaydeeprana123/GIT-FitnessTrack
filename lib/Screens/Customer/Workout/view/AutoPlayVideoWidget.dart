import 'dart:developer';

import 'package:fitness_track/Screens/Customer/Measurements/view/measurement_details_view.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:fitness_track/Screens/Authentication/ForgotPassword/view/forgot_password_view.dart';
import 'package:fitness_track/Screens/Authentication/Profile/view/change_password_view.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../../../../utils/password_text_field.dart';
import '../controller/workout_controller.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AutoPlayVideoWidget extends StatefulWidget {
  final String videoUrl;
  const AutoPlayVideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<AutoPlayVideoWidget> createState() => _AutoPlayVideoWidgetState();
}

class _AutoPlayVideoWidgetState extends State<AutoPlayVideoWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..setLooping(true)
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _initialized = true);

          // Auto-play if visible after init
          if (_isVisible) {
            _controller.play();
          }
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleVisibility(double visibleFraction) async {
    if (!_initialized) {
      _isVisible = visibleFraction > 0.5;
      return;
    }

    // ✅ Autoplay logic (only if user didn’t manually pause)
    if (visibleFraction > 0.5 && !_controller.value.isPlaying) {
      _isVisible = true;
      await _controller.play();
    } else if (visibleFraction < 0.3 && _controller.value.isPlaying) {
      _isVisible = false;
      await _controller.pause();
    }
  }

  void _togglePlayPause() async {
    if (!_initialized) return;

    if (_controller.value.isPlaying) {
      await _controller.pause();
    } else {
      await _controller.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) => _handleVisibility(info.visibleFraction),
      child: Container(
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: _initialized
            ? Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),

            // ▶️ Play / ⏸ Pause Button
            GestureDetector(
              onTap: _togglePlayPause,
              child: AnimatedOpacity(
                opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),

            // Stop Button (bottom-right)
            Positioned(
              bottom: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.stop, color: Colors.white),
                onPressed: () async {
                  await _controller.pause();
                  await _controller.seekTo(Duration.zero);
                  setState(() {});
                },
              ),
            ),
          ],
        )
            : const SizedBox(
          height: 120,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}








