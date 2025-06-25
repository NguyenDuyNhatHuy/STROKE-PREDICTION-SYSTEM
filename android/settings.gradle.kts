

/*─────────────────────────*
 *   settings.gradle.kts   *
 *─────────────────────────*/

pluginManagement {
    /* Lấy đường dẫn Flutter SDK từ local.properties */
    val flutterSdkPath = run {
        val props = java.util.Properties()
        file("local.properties").inputStream().use { props.load(it) }
        props.getProperty("flutter.sdk")
            ?: error("flutter.sdk not set in local.properties")
    }

    /* Kết hợp build logic của Flutter */
    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    /* Kho plugin */
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

/* Khai báo plugin _một lần_ với phiên bản; apply false → sẽ được áp dụng
   trong module cần thiết (app) để tránh xung đột */
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"

    id("com.android.application")          version "8.7.3"   apply false
    id("org.jetbrains.kotlin.android")     version "2.1.21"  apply false
    id("com.google.gms.google-services")   version "4.4.2"   apply false
}

/* Module duy nhất của dự án Android */
include(":app")