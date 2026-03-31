plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

dependencies {
  implementation(platform("com.google.firebase:firebase-bom:34.11.0"))
implementation("com.google.firebase:firebase-analytics")
}

android {
    namespace = "com.example.autovault"
    compileSdk = 36
    buildToolsVersion = "35.0.0"
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

defaultConfig {
    applicationId = "com.example.autovault"
    minSdk = flutter.minSdkVersion
    targetSdk = 36
    versionCode = flutter.versionCode
    versionName = flutter.versionName
    androidResources {
        localeFilters += "en"   // replaces deprecated resConfig
    }
}

buildTypes {
    release {
        signingConfig = signingConfigs.getByName("debug")
        isMinifyEnabled = true       // not minifyEnabled
        isShrinkResources = true     // not shrinkResources
    }
}
}

flutter {
    source = "../.."
}
