# Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.plugin.editing.** { *; }

# ✅ CRITICAL: Keep all Flutter plugin generated files
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.**

# ✅ Keep GeneratedPluginRegistrant
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }

# ✅ Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# ✅ SharedPreferences Plugin
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-keep class ** implements io.flutter.plugin.common.MethodCallHandler { *; }
-keep class ** implements io.flutter.plugin.common.StreamHandler { *; }

# ✅ All Flutter Plugins (CRITICAL)
-keep class * implements io.flutter.embedding.engine.plugins.FlutterPlugin { *; }
-keep class * implements io.flutter.plugin.common.PluginRegistry$Registrar { *; }

# ✅ Window Manager / AndroidX Window
-keep class androidx.window.** { *; }
-keep class androidx.window.extensions.** { *; }
-keep class androidx.window.sidecar.** { *; }
-dontwarn androidx.window.**

# Prevent stripping Flutter and BackEvent references
-keep class android.window.** { *; }
-dontwarn android.window.**
-keep class androidx.lifecycle.DefaultLifecycleObserver

# Video Player Plugin
-keep class io.flutter.plugins.videoplayer.** { *; }

# Image Picker Plugin
-keep class io.flutter.plugins.imagepicker.** { *; }

# Geolocator Plugin
-keep class com.baseflow.geolocator.** { *; }

# Permission Handler Plugin
-keep class com.baseflow.permissionhandler.** { *; }

# Local Notifications Plugin
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Package Info Plugin
-keep class io.flutter.plugins.packageinfo.** { *; }

# URL Launcher Plugin
-keep class io.flutter.plugins.urllauncher.** { *; }

# ✅ Keep all plugin communication channels
-keep class * implements io.flutter.plugin.common.MethodChannel$MethodCallHandler { *; }
-keep class * implements io.flutter.plugin.common.EventChannel$StreamHandler { *; }

# ✅ Keep Pigeon generated classes (CRITICAL for Firebase & SharedPreferences)
-keep class ** implements dev.flutter.pigeon.** { *; }
-keep interface dev.flutter.pigeon.** { *; }
-keep class **.Messages { *; }
-keep class **.Messages$* { *; }
-keep class **.*Messages { *; }
-keep class **.*Messages$* { *; }

# Razorpay
-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** { *; }
-optimizations !method/inlining/
-keepclasseswithmembers class * {
    public void onPayment*(...);
}

# Jackson
-keep class com.fasterxml.jackson.databind.ext.** { *; }
-dontwarn com.fasterxml.jackson.databind.ext.**
-dontwarn java.beans.**
-dontwarn org.w3c.dom.bootstrap.**
-keep class com.fasterxml.jackson.annotation.** { *; }

# Conscrypt
-dontwarn org.conscrypt.**

# General
-keepattributes Signature
-keepattributes *Annotation*

# ✅ Keep all native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# ✅ Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ✅ Keep Parcelables
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# ✅ Keep Serializable
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}