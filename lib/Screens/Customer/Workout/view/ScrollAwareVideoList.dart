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

class ScrollAwareVideoList extends StatefulWidget {
  final List<String> videoUrls;
  const ScrollAwareVideoList({Key? key, required this.videoUrls}) : super(key: key);

  @override
  State<ScrollAwareVideoList> createState() => _ScrollAwareVideoListState();
}

class _ScrollAwareVideoListState extends State<ScrollAwareVideoList> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = [];
  final List<VideoPlayerController> _controllers = [];

  int _currentVisibleIndex = -1;

  @override
  void initState() {
    super.initState();

    for (final url in widget.videoUrls) {
      _controllers.add(VideoPlayerController.networkUrl(Uri.parse(url))
        ..setLooping(true)
        ..initialize());
      _keys.add(GlobalKey());
    }

    _scrollController.addListener(_checkVisibleVideo);
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _checkVisibleVideo() {
    double minDiff = double.infinity;
    int newVisibleIndex = -1;

    for (int i = 0; i < _keys.length; i++) {
      final key = _keys[i];
      final context = key.currentContext;
      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;

      final position = box.localToGlobal(Offset.zero);
      final centerY = position.dy + box.size.height / 2;

      // Find the video closest to screen center
      final diff = (MediaQuery.of(context).size.height / 2 - centerY).abs();
      if (diff < minDiff) {
        minDiff = diff;
        newVisibleIndex = i;
      }
    }

    if (newVisibleIndex != _currentVisibleIndex) {
      _setActiveVideo(newVisibleIndex);
    }
  }

  void _setActiveVideo(int index) async {
    if (_currentVisibleIndex != -1 && _controllers[_currentVisibleIndex].value.isPlaying) {
      await _controllers[_currentVisibleIndex].pause();
    }

    if (index != -1 && _controllers[index].value.isInitialized) {
      await _controllers[index].play();
    }

    _currentVisibleIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.videoUrls.length,
        itemBuilder: (context, index) {
          final controller = _controllers[index];

          return Container(
            key: _keys[index],
            width: 160,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: controller.value.isInitialized
                ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            )
                : const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}







