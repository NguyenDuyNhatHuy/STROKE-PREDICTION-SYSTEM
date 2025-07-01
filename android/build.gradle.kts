// Dùng Kotlin DSL thuần – KHÔNG cần plugin Android hay Kotlin ở root
// (đã được định nghĩa "apply false" trong settings.gradle.kts)

import org.gradle.api.tasks.Delete
import org.gradle.api.provider.Provider
import org.gradle.api.file.Directory

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

/*──────────────────────────────
  Thu gọn thư mục build
──────────────────────────────*/
val newBuildDir: Directory = rootProject.layout
    .buildDirectory
    .dir("../../build")         // build nằm song song với thư mục android
    .get()

rootProject.layout.buildDirectory.value(newBuildDir)

/*──────────────────────────────
  Đồng bộ cho mọi sub-project
──────────────────────────────*/
subprojects {
    // build/<module-name>
    layout.buildDirectory.value(newBuildDir.dir(name))
    evaluationDependsOn(":app")   // bảo đảm cấu hình xong module :app trước
}

/*──────────────────────────────
  Task clean
──────────────────────────────*/
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
