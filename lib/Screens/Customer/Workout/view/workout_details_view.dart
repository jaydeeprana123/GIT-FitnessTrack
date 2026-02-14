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
class VideoLimitTracker {
  static final VideoLimitTracker instance = VideoLimitTracker._();
  VideoLimitTracker._();

  final Set<String> _activeVideos = {};
  static const int MAX_ACTIVE = 2;

  bool canActivate(String id) {
    return _activeVideos.length < MAX_ACTIVE || _activeVideos.contains(id);
  }

  void activate(String id) {
    _activeVideos.add(id);
  }

  void deactivate(String id) {
    _activeVideos.remove(id);
  }

  void clear() {
    _activeVideos.clear();
  }

  int get activeCount => _activeVideos.length;
}

// ============================================================================
// WORKOUT DETAILS VIEW
// ============================================================================
class WorkoutDetailsView extends StatefulWidget {
  const WorkoutDetailsView({Key? key}) : super(key: key);

  @override
  State<WorkoutDetailsView> createState() => _WorkoutDetailsViewState();
}

class _WorkoutDetailsViewState extends State<WorkoutDetailsView> {
  WorkoutController controller = Get.find<WorkoutController>();

  @override
  void initState() {
    super.initState();
    log(":::::::::::::::WorkoutDetailsView InitState::::::::::");

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await controller.getUserInfo();
    });
  }

  @override
  void dispose() {
    VideoLimitTracker.instance.clear();
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
                        "From : " +
                            (getDateOnly((controller.selectedWorkoutData
                                .value.workoutDate ??
                                DateTime(2023))
                                .toString())) +
                            "  To : " +
                            (getDateOnly((controller.selectedWorkoutData
                                .value.dueDate ??
                                DateTime(2023))
                                .toString())),
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

                // WARM UP SECTION
                Text("WARM UP",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 16,
                        fontFamily: fontInterSemiBold)),
                SizedBox(height: 8),

                Row(
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
                ),

                ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount:
                  (controller.selectedWorkoutData.value.warmupList ?? [])
                      .length,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                              controller.selectedWorkoutData.value
                                  .warmupList?[index].masterWorkoutName ??
                                  "",
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              controller.selectedWorkoutData.value
                                  .warmupList?[index].sets ??
                                  "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              controller.selectedWorkoutData.value
                                  .warmupList?[index].repeatNo ??
                                  "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              controller.selectedWorkoutData.value
                                  .warmupList?[index].repeatTime ??
                                  "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: text_color,
                                  fontSize: 13,
                                  fontFamily: fontInterRegular)),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16),
                Container(color: grey_f0f0f0, height: 2),
                SizedBox(height: 16),

                // EXERCISE ROUTINE SECTION
                Text("EXERCISE ROUTINE",
                    style: TextStyle(
                        color: text_color,
                        fontSize: 16,
                        fontFamily: fontInterSemiBold)),
                SizedBox(height: 4),

                ListView.builder(
                  scrollDirection: Axis.vertical,
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (controller.selectedWorkoutData.value
                      .workoutTrainingList ?? [])
                      .length,
                  itemBuilder: (context, index) => _buildDaySection(index),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildDaySection(int index) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Day " +
                  (controller.selectedWorkoutData.value
                      .workoutTrainingList?[index].day ??
                      ""),
              style: TextStyle(
                  color: text_color,
                  fontSize: 14,
                  fontFamily: fontInterSemiBold)),
          ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (controller.selectedWorkoutData.value
                .workoutTrainingList?[index].workoutTrainingCategory ??
                [])
                .length,
            itemBuilder: (context, j) => _buildCategorySection(index, j),
          ),
          SizedBox(height: 12),
          Row(
            children: List.generate(
                150 ~/ 2,
                    (i) => Expanded(
                  child: Container(
                    color: i % 2 == 0 ? Colors.transparent : Colors.grey,
                    height: 1,
                  ),
                )),
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildCategorySection(int dayIndex, int catIndex) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6),
          Text(
              controller.selectedWorkoutData.value
                  .workoutTrainingList?[dayIndex]
                  .workoutTrainingCategory?[catIndex]
                  .workoutTrainingCategoryName ??
                  "",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontFamily: fontInterSemiBold)),
          SizedBox(height: 6),
          Row(
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
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            primary: false,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: (controller.selectedWorkoutData.value
                .workoutTrainingList?[dayIndex]
                .workoutTrainingCategory?[catIndex]
                .workoutTrainingSubCategory ??
                [])
                .length,
            itemBuilder: (context, subIndex) =>
                _buildExerciseRow(dayIndex, catIndex, subIndex),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseRow(int dayIndex, int catIndex, int subIndex) {
    final exercise = controller.selectedWorkoutData.value
        .workoutTrainingList?[dayIndex]
        .workoutTrainingCategory?[catIndex]
        .workoutTrainingSubCategory?[subIndex];

    final videoList = exercise?.workoutDetailVideoList ?? [];

    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(exercise?.workoutDetailName ?? "",
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

          // VIDEO SECTION - EACH WIDGET OWNS ITS CONTROLLER
          // ADD THIS TO YOUR EXISTING CODE
// Replace the video section in _buildExerciseRow method

// VIDEO SECTION - WITH SCROLL INDICATORS
          if (videoList.isNotEmpty)
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video count indicator
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(Icons.video_library, size: 18, color: color_primary),
                        SizedBox(width: 6),
                        Text(
                          '${videoList.length} ${videoList.length == 1 ? 'Video' : 'Videos'}',
                          style: TextStyle(
                            color: color_primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: fontInterSemiBold,
                          ),
                        ),
                        SizedBox(width: 8),
                        if (videoList.length > 1)
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
                                Text(
                                  'Swipe',
                                  style: TextStyle(
                                    color: color_primary,
                                    fontSize: 11,
                                    fontFamily: fontInterMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Video horizontal scroll with indicators
                  Container(
                    height: 240,
                    child: Stack(
                      children: [
                        // Video ListView
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          itemCount: videoList.length,
                          itemBuilder: (context, videoIndex) {
                            final videoPath = videoList[videoIndex].video ?? "";
                            final exerciseName = exercise?.workoutDetailName ?? "";

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  // Video card with shadow and border
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
                                        InstagramVideoWidget(
                                          videoUrl: videoPath,
                                          uniqueId: 'video_${dayIndex}_${catIndex}_${subIndex}_$videoIndex',
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

                                        // Video number badge
                                        Positioned(
                                          top: 8,
                                          left: 8,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(0.7),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              '${videoIndex + 1}/${videoList.length}',
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
                                  Text(
                                    "Video ${videoIndex + 1}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        // Left scroll indicator (if not at start)
                        if (videoList.length > 1)
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 30,
                            child: Container(
                              width: 40,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.0),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_left,
                                    color: color_primary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Right scroll indicator (if more videos)
                        if (videoList.length > 1)
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 30,
                            child: Container(
                              width: 40,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.0),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_right,
                                    color: color_primary,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Dot indicators (like Instagram stories)
                  if (videoList.length > 1)
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          videoList.length > 5 ? 5 : videoList.length,
                              (index) {
                            if (videoList.length > 5 && index == 4) {
                              // Show "+X more" indicator
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: color_primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '+${videoList.length - 4}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: color_primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ============================================================================
// INSTAGRAM VIDEO WIDGET - OWNS ITS OWN CONTROLLER
// ============================================================================
class InstagramVideoWidget extends StatefulWidget {
  final String videoUrl;
  final String uniqueId;
  final VoidCallback onTap;

  const InstagramVideoWidget({
    Key? key,
    required this.videoUrl,
    required this.uniqueId,
    required this.onTap,
  }) : super(key: key);

  @override
  State<InstagramVideoWidget> createState() => _InstagramVideoWidgetState();
}

class _InstagramVideoWidgetState extends State<InstagramVideoWidget> {
  VideoPlayerController? _controller;
  Uint8List? _thumbnail;
  bool _showVideo = false;
  bool _disposed = false;
  bool _isActive = false;

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
        maxWidth: 250,
        quality: 70,
      );
      if (!_disposed && mounted) {
        setState(() => _thumbnail = thumb);
      }
    } catch (e) {
      print('Thumbnail error: $e');
    }
  }

  Future<void> _activateVideo() async {
    if (_disposed || _controller != null) return;

    // Check if we can activate
    if (!VideoLimitTracker.instance.canActivate(widget.uniqueId)) {
      print('Video limit reached, cannot activate ${widget.uniqueId}');
      return;
    }

    try {
      VideoLimitTracker.instance.activate(widget.uniqueId);
      _isActive = true;

      final fileInfo = await DefaultCacheManager().getFileFromCache(widget.videoUrl);

      if (_disposed) {
        VideoLimitTracker.instance.deactivate(widget.uniqueId);
        _isActive = false;
        return;
      }

      if (fileInfo != null && fileInfo.file.existsSync()) {
        _controller = VideoPlayerController.file(fileInfo.file);
      } else {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
        DefaultCacheManager().downloadFile(widget.videoUrl).catchError((e) => null);
      }

      if (_disposed) {
        await _cleanupController();
        return;
      }

      await _controller!.initialize();

      if (_disposed) {
        await _cleanupController();
        return;
      }

      _controller!.setLooping(true);
      _controller!.setVolume(0);
      _controller!.play();

      if (!_disposed && mounted) {
        setState(() => _showVideo = true);
      }
    } catch (e) {
      print('Video activation error: $e');
      await _cleanupController();
    }
  }

  Future<void> _deactivateVideo() async {
    if (!_isActive) return;

    VideoLimitTracker.instance.deactivate(widget.uniqueId);
    _isActive = false;

    if (_showVideo && mounted) {
      setState(() => _showVideo = false);
    }

    await _cleanupController();
  }

  Future<void> _cleanupController() async {
    if (_controller != null) {
      try {
        await _controller!.pause();
        await _controller!.dispose();
      } catch (e) {
        print('Cleanup error: $e');
      }
      _controller = null;
    }

    if (_isActive) {
      VideoLimitTracker.instance.deactivate(widget.uniqueId);
      _isActive = false;
    }
  }

  void _onVisibilityChanged(double fraction) {
    if (_disposed) return;

    if (fraction > 0.7) {
      // Visible - activate
      if (!_isActive) {
        _activateVideo();
      } else if (_controller != null && !_showVideo) {
        try {
          _controller!.play();
          if (mounted) setState(() => _showVideo = true);
        } catch (e) {
          print('Play error: $e');
        }
      }
    } else if (fraction < 0.3) {
      // Not visible - deactivate to free slot
      if (_isActive) {
        _deactivateVideo();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _showVideo = false;
    _cleanupController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_disposed) {
      return const SizedBox(width: 280, height: 180);
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: VisibilityDetector(
        key: Key(widget.uniqueId),
        onVisibilityChanged: (info) => _onVisibilityChanged(info.visibleFraction),
        child: Container(
          width: 280,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Thumbnail
                if (_thumbnail != null)
                  Image.memory(_thumbnail!, fit: BoxFit.cover),

                // Video - ONLY if controller is valid and not disposed
                if (_showVideo &&
                    !_disposed &&
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

                // Play icon
                if (!_showVideo && _thumbnail != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                // Mute indicator
                if (_showVideo && !_disposed)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.volume_off,
                        color: Colors.white,
                        size: 14,
                      ),
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
// VIDEO PLAYER FULLSCREEN PAGE
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
        title: Text(
          widget.exerciseName,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
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
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
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