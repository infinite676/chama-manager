# Chama Manager Proguard Rules
-keepattributes *Annotation*
-keepclassmembers class * {
    @androidx.room.* <methods>;
}
-keep class com.chamamanager.app.data.local.entity.** { *; }
-keep class com.chamamanager.app.domain.model.** { *; }
-keep class com.chamamanager.app.data.remote.mobilemoney.** { *; }
