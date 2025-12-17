# Prevent stripping Flutter and BackEvent references
-keep class android.window.** { *; }
-dontwarn android.window.**

# Firebase (expanded rules)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Flutter plugins
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Pigeon (Firebase communication bridge)
-keep class dev.flutter.pigeon.** { *; }
-dontwarn dev.flutter.pigeon.**

# Play Core (suppress warnings)
-dontwarn com.google.android.play.core.**
-keep class com.google.android.play.core.** { *; }

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Don't warn about missing classes
-ignorewarnings