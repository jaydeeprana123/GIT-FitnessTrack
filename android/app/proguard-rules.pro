# Prevent stripping Flutter and BackEvent references
-keep class android.window.** { *; }
-dontwarn android.window.**
