import org.gradle.api.Plugin
import org.gradle.api.initialization.Settings

class SVUnitBuildInjectionPlugin implements Plugin<Settings> {
    public void apply(Settings settings) {
        settings.gradle.rootProject {
            apply plugin: 'com.verificationgentleman.gradle.hdvl.svunit-build'
        }
    }
}
