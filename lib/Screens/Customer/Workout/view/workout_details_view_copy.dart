import 'dart:developer';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:url_launcher/url_launcher.dart';

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
import 'package:visibility_detector/visibility_detector.dart';
import '../../../../CommonWidgets/common_green_button.dart';
import '../../../../CommonWidgets/common_widget.dart';
import '../../../../Styles/my_colors.dart';
import '../../../../Styles/my_font.dart';
import '../../../../Styles/my_icons.dart';
import '../../../../Styles/my_strings.dart';
import '../../../../utils/internet_connection.dart';
import '../../../../utils/password_text_field.dart';
import '../controller/workout_controller.dart';
import 'AddWorkoutTrainingScreen.dart';
import 'AutoPlayVideoWidget.dart';

import 'VideoThumbnailWidget.dart';
import 'WorkoutVideoPlayer.dart';

// Add your imports for colors, fonts, and controller here
// import 'your_constants.dart';
// import 'your_controller.dart';

// ============================================================================
// WORKOUT DETAILS VIEW
// ============================================================================
// Add your imports here
// import 'your_constants.dart';
// import 'your_controller.dart';

// ============================================================================
// GLOBAL VIDEO MANAGER - PREVENTS MEMORY OVERLOAD
// ============================================================================
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Add your imports here
// import 'your_constants.dart';
// import 'your_controller.dart';

// ============================================================================
// VIDEO LIMIT TRACKER - PREVENTS TOO MANY VIDEOS
// ============================================================================
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Add your imports here
// import 'your_constants.dart';
// import 'your_controller.dart';

import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Add your imports here
// import 'your_constants.dart';
// import 'your_controller.dart';

// ============================================================================
// VIDEO CONTROLLER LIMITER - PREVENTS CRASHES
import 'dart:developer';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO: Add your imports here
// import 'your_constants.dart';  // For colors and fonts
// import 'your_controller.dart'; // For WorkoutController

import 'dart:developer';
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// TODO: Add your imports here
// import 'your_constants.dart';  // For colors and fonts
// import 'your_controller.dart'; // For WorkoutController

// ============================================================================
// VIDEO CONTROLLER LIMITER - PREVENTS CRASHES
// ============================================================================
class VideoControllerLimiter {
  static final VideoControllerLimiter _instance = VideoControllerLimiter._();
  factory VideoControllerLimiter() => _instance;
  VideoControllerLimiter._();

  int _activeCount = 0;
  static const int MAX_VIDEOS = 2;

  bool canCreate() => _activeCount < MAX_VIDEOS;

  void increment() {
    _activeCount++;
    print('📹 Active: $_activeCount/$MAX_VIDEOS');
  }

  void decrement() {
    if (_activeCount > 0) _activeCount--;
    print('📹 Active: $_activeCount/$MAX_VIDEOS');
  }

  void reset() {
    _activeCount = 0;
  }
}

// ============================================================================
// WORKOUT DETAILS VIEW
// ============================================================================
class WorkoutDetailsViewCopy extends StatefulWidget {
  const WorkoutDetailsViewCopy({Key? key}) : super(key: key);

  @override
  State<WorkoutDetailsViewCopy> createState() => _WorkoutDetailsViewCopyState();
}

class _WorkoutDetailsViewCopyState extends State<WorkoutDetailsViewCopy> {
  WorkoutController controller = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();
    log("WorkoutDetailsView InitState");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
    });
  }

  @override
  void dispose() {
    VideoControllerLimiter().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      statusBarColor: color_primary,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: color_primary,
          titleSpacing: 0,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Workout Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: fontInterMedium),
          ),
        ),
        body: Obx(() => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Code : ${controller.selectedWorkoutData.value.code ?? ""}",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 14,
                        fontFamily: fontInterSemiBold)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                        "From : ${getDateOnly((controller.selectedWorkoutData.value.workoutDate ?? DateTime(2023)).toString())}  To : ${getDateOnly((controller.selectedWorkoutData.value.dueDate ?? DateTime(2023)).toString())}",
                        style: TextStyle(
                            color: text_color,
                            fontSize: 14,
                            fontFamily: fontInterRegular)),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                    "Duration : ${controller.selectedWorkoutData.value.durationInDays ?? "0"}",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 14,
                        fontFamily: fontInterRegular)),
                SizedBox(height: 20),
                Text("WARM UP",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 16,
                        fontFamily: fontInterSemiBold)),
                SizedBox(height: 8),
                _buildTableHeader(),
                _buildWarmupList(),
                SizedBox(height: 16),
                Container(color: grey_f0f0f0, height: 2),
                SizedBox(height: 16),
                Text("EXERCISE ROUTINE",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 16,
                        fontFamily: fontInterSemiBold)),
                SizedBox(height: 4),
                _buildExerciseList(),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text("Training Schedule",
              style: TextStyle(
                  color: text_color,
                  fontSize: 13,
                  fontFamily: fontInterSemiBold)),
        ),
        Expanded(
          flex: 1,
          child: Text("SETS",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: text_color,
                  fontSize: 13,
                  fontFamily: fontInterSemiBold)),
        ),
        Expanded(
          flex: 1,
          child: Text("REP",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: text_color,
                  fontSize: 13,
                  fontFamily: fontInterSemiBold)),
        ),
        Expanded(
          flex: 1,
          child: Text("WEIGHT",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: text_color,
                  fontSize: 13,
                  fontFamily: fontInterSemiBold)),
        )
      ],
    );
  }

  Widget _buildWarmupList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: (controller.selectedWorkoutData.value.warmupList ?? []).length,
      itemBuilder: (context, index) {
        final warmup = controller.selectedWorkoutData.value.warmupList?[index];
        return Container(
          margin: EdgeInsets.only(top: 8),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(warmup?.masterWorkoutName ?? "",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 13,
                        fontFamily: fontInterRegular)),
              ),
              Expanded(
                flex: 1,
                child: Text(warmup?.sets ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: text_color,
                        fontSize: 13,
                        fontFamily: fontInterRegular)),
              ),
              Expanded(
                flex: 1,
                child: Text(warmup?.repeatNo ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: text_color,
                        fontSize: 13,
                        fontFamily: fontInterRegular)),
              ),
              Expanded(
                flex: 1,
                child: Text(warmup?.repeatTime ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: text_color,
                        fontSize: 13,
                        fontFamily: fontInterRegular)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildExerciseList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount:
      (controller.selectedWorkoutData.value.workoutTrainingList ?? [])
          .length,
      itemBuilder: (context, dayIndex) {
        final day = controller.selectedWorkoutData.value
            .workoutTrainingList?[dayIndex];
        return Container(
          margin: EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              if(dayIndex != 0)SizedBox(height: 20,),

              Container(
                width: double.infinity,
                color: color_primary,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: Text("Day ${day?.day ?? ""}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: fontInterSemiBold)),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (day?.workoutTrainingCategory ?? []).length,
                itemBuilder: (context, catIndex) {
                  final category = day?.workoutTrainingCategory?[catIndex];
                  return Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6),
                        Text(category?.workoutTrainingCategoryName ?? "",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                                fontFamily: fontInterSemiBold)),
                        SizedBox(height: 6),
                        _buildTableHeader(),
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                          (category?.workoutTrainingSubCategory ?? [])
                              .length,
                          itemBuilder: (context, subIndex) {
                            final exercise =
                            category?.workoutTrainingSubCategory?[subIndex];
                            final videos = exercise?.workoutDetailVideoList ?? [];
                            return Container(
                              margin: EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                            exercise?.workoutDetailName ?? "",
                                            style: TextStyle(
                                                color: text_color,
                                                fontSize: 13,
                                                fontFamily: fontInterRegular)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(exercise?.sets ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: text_color,
                                                fontSize: 13,
                                                fontFamily: fontInterRegular)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(exercise?.repeatNo ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: text_color,
                                                fontSize: 13,
                                                fontFamily: fontInterRegular)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(exercise?.repeatTime ?? "",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: text_color,
                                                fontSize: 13,
                                                fontFamily: fontInterRegular)),
                                      ),
                                    ],
                                  ),
                                  if (videos.isNotEmpty)
                                    _buildVideoSection(videos, exercise?.workoutDetailName ?? ""),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              Row(
                children: List.generate(
                    75,
                        (i) => Expanded(
                      child: Container(
                        color: i % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 1,
                      ),
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoSection(List videos, String exerciseName) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(Icons.video_library, size: 18, color: color_primary),
                SizedBox(width: 6),
                Text(
                  '${videos.length} ${videos.length == 1 ? 'Video' : 'Videos'}',
                  style: TextStyle(
                    color: color_primary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: fontInterSemiBold,
                  ),
                ),
                SizedBox(width: 8),
                if (videos.length > 1)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color_primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color_primary.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.swipe_left, size: 14, color: color_primary),
                        SizedBox(width: 4),
                        Text('Swipe',
                            style: TextStyle(
                              color: color_primary,
                              fontSize: 11,
                              fontFamily: fontInterMedium,
                            )),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: 280,
            child: Stack(
              children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  itemCount: videos.length,
                  itemBuilder: (context, videoIndex) {
                    final videoPath = videos[videoIndex].video ?? "";
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                SimpleAutoPlayVideo(
                                  videoUrl: videoPath,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoPlayerPage(
                                          videoPath: videoPath,
                                          exerciseName: exerciseName,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Positioned(
                                  top: 8,
                                  left: 8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${videoIndex + 1}/${videos.length}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text("Video ${videoIndex + 1}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    );
                  },
                ),
                if (videos.length > 1) _buildScrollArrow(true),
                if (videos.length > 1) _buildScrollArrow(false),
              ],
            ),
          ),
          if (videos.length > 1) _buildDotIndicators(videos.length),
        ],
      ),
    );
  }

  Widget _buildScrollArrow(bool isLeft) {
    return Positioned(
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      top: 0,
      bottom: 30,
      child: Container(
        width: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
            end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
            colors: [Colors.white, Colors.white.withOpacity(0.0)],
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
              ],
            ),
            child: Icon(
              isLeft ? Icons.chevron_left : Icons.chevron_right,
              color: color_primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDotIndicators(int count) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count > 5 ? 5 : count, (index) {
          if (count > 5 && index == 4) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 3),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color_primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('+${count - 4}',
                  style: TextStyle(
                      fontSize: 10,
                      color: color_primary,
                      fontWeight: FontWeight.bold)),
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color_primary.withOpacity(0.3),
            ),
          );
        }),
      ),
    );
  }
}

// ============================================================================
// AUTO-PLAY VIDEO WIDGET - OPTIMIZED FOR MOBILE DATA
// ============================================================================
class SimpleAutoPlayVideo extends StatefulWidget {
  final String videoUrl;
  final VoidCallback onTap;

  const SimpleAutoPlayVideo({
    Key? key,
    required this.videoUrl,
    required this.onTap,
  }) : super(key: key);

  @override
  State<SimpleAutoPlayVideo> createState() => _SimpleAutoPlayVideoState();
}

class _SimpleAutoPlayVideoState extends State<SimpleAutoPlayVideo> {
  VideoPlayerController? _controller;
  Uint8List? _thumbnail;
  bool _showVideo = false;
  bool _disposed = false;
  bool _hasController = false;

  @override
  void initState() {
    super.initState();
    _loadThumbnail();
  }

  Future<void> _loadThumbnail() async {
    try {
      final thumb = await VideoThumbnail.thumbnailData(
        video: widget.videoUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 150,
        quality: 100,
      );
      if (!_disposed && mounted) {
        setState(() => _thumbnail = thumb);
      }
    } catch (e) {
      print('Thumbnail error: $e');
    }
  }

  Future<void> _initVideo() async {
    if (_disposed || _hasController) return;

    if (!VideoControllerLimiter().canCreate()) {
      print('⚠️ Limit reached');
      return;
    }

    try {
      VideoControllerLimiter().increment();
      _hasController = true;

      final fileInfo = await DefaultCacheManager()
          .getFileFromCache(widget.videoUrl)
          .timeout(Duration(seconds: 3), onTimeout: () => null);

      if (_disposed) {
        await _cleanup();
        return;
      }

      if (fileInfo != null && fileInfo.file.existsSync()) {
        _controller = VideoPlayerController.file(fileInfo.file);
      } else {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
        DefaultCacheManager().downloadFile(widget.videoUrl).catchError((e) => null);
      }

      if (_disposed) {
        await _cleanup();
        return;
      }

      await _controller!.initialize().timeout(
        Duration(seconds: 10),
        onTimeout: () => throw TimeoutException('Init timeout'),
      );

      if (_disposed) {
        await _cleanup();
        return;
      }

      _controller!.setLooping(true);
      _controller!.setVolume(0);
      await Future.delayed(Duration(milliseconds: 50));

      if (_disposed) {
        await _cleanup();
        return;
      }

      _controller!.play();

      if (!_disposed && mounted) {
        setState(() => _showVideo = true);
      }
    } on TimeoutException {
      print('Video timeout');
      await _cleanup();
    } catch (e) {
      print('Video error: $e');
      await _cleanup();
    }
  }

  Future<void> _cleanup() async {
    if (_controller != null) {
      try {
        await _controller!.pause();
        await _controller!.dispose();
      } catch (e) {}
      _controller = null;
    }

    if (_hasController) {
      VideoControllerLimiter().decrement();
      _hasController = false;
    }

    if (mounted && _showVideo) {
      setState(() => _showVideo = false);
    }
  }

  void _onVisibilityChanged(double fraction) {
    if (_disposed) return;

    if (fraction > 0.7) {
      if (_controller == null && !_hasController) {
        _initVideo();
      } else if (_controller != null && !_showVideo) {
        try {
          _controller!.play();
          if (mounted) setState(() => _showVideo = true);
        } catch (e) {}
      }
    } else if (fraction < 0.2) {
      if (_hasController) {
        _cleanup();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_disposed) {
      return Container(width: 320, height: 220, color: Colors.grey[300]);
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: VisibilityDetector(
        key: Key('v_${widget.videoUrl}_$hashCode'),
        onVisibilityChanged: (i) => _onVisibilityChanged(i.visibleFraction),
        child: Container(
          width: 320,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (_thumbnail != null)
                  Image.memory(_thumbnail!, fit: BoxFit.cover)
                else
                  Container(
                    color: Colors.grey[800],
                    child: Center(
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    ),
                  ),
                if (_showVideo &&
                    !_disposed &&
                    _hasController &&
                    _controller != null &&
                    _controller!.value.isInitialized)
                  FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller!.value.size.width,
                      height: _controller!.value.size.height,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                if (_hasController && !_showVideo && _thumbnail != null)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    ),
                  ),
                if (!_showVideo && !_hasController && _thumbnail != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 32),
                    ),
                  ),
                if (_showVideo && !_disposed && _hasController)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.volume_off,
                          color: Colors.white, size: 14),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// FULLSCREEN VIDEO PLAYER
// ============================================================================
class VideoPlayerPage extends StatefulWidget {
  final String videoPath;
  final String exerciseName;

  const VideoPlayerPage({
    Key? key,
    required this.videoPath,
    required this.exerciseName,
  }) : super(key: key);

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final fileInfo =
      await DefaultCacheManager().getFileFromCache(widget.videoPath);

      if (fileInfo != null && fileInfo.file.existsSync()) {
        _controller = VideoPlayerController.file(fileInfo.file);
      } else {
        _controller =
            VideoPlayerController.networkUrl(Uri.parse(widget.videoPath));
        DefaultCacheManager().downloadFile(widget.videoPath);
      }

      await _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.setVolume(1.0);

      if (mounted) {
        setState(() => _isInitialized = true);
        _controller!.play();
      }
    } catch (e) {
      print('Video error: $e');
      if (mounted) {
        setState(() => _hasError = true);
      }
    }
  }

  void _toggleMute() {
    if (_controller == null) return;
    setState(() {
      _isMuted = !_isMuted;
      _controller!.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _togglePlayPause() {
    if (_controller == null) return;
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
    });
  }

  @override
  void dispose() {
    _controller?.pause();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.exerciseName,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
      ),
      body: Stack(
        children: [
          Center(child: _buildVideoContent()),
          if (_isInitialized && !_hasError)
            Positioned.fill(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: _controller!.value.isPlaying ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.play_arrow_rounded,
                            color: Colors.white, size: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_isInitialized && !_hasError)
            Positioned(
              bottom: 30,
              right: 20,
              child: GestureDetector(
                onTap: _toggleMute,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_hasError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 60),
          const SizedBox(height: 16),
          const Text('Failed to load video',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _initializeVideo,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: const Text('Retry'),
          ),
        ],
      );
    }

    if (!_isInitialized) {
      return const CircularProgressIndicator(color: Colors.white);
    }

    return AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );
  }
}