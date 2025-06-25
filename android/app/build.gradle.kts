plugins {
    id("com.android.application")          // plugin Android
    id("org.jetbrains.kotlin.android")     // Kotlin (không ghi version)
    id("dev.flutter.flutter-gradle-plugin")// Flutter plugin (phải sau Android/Kotlin)
    id("com.google.gms.google-services")   // Google-services (Firebase)
}

android {
    namespace = "com.amphenol.strokepredictor"

    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.amphenol.strokepredictor"
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        // Enable desugaring for java.time.* etc.
        isCoreLibraryDesugaringEnabled = true
    }
    kotlinOptions { jvmTarget = "11" }

    buildTypes {
        release {
            // dùng keystore debug tạm (đổi khi phát hành)
            signingConfig = signingConfigs.getByName("debug")
            // bật shrinkResources / minify nếu cần
        }
    }
}

flutter { source = "../.." }

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")

    // Firebase BoM giữ tất cả libs đồng bộ phiên bản
    implementation(platform("com.google.firebase:firebase-bom:33.15.0"))
    implementation("com.google.firebase:firebase-analytics-ktx")
    // thêm Auth / Firestore / Functions nếu cần
    // implementation("com.google.firebase:firebase-auth-ktx")
    // implementation("com.google.firebase:firebase-firestore-ktx")
}
