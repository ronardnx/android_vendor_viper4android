# ViPER4Android RE vendor

Standalone Android product package extracted from `aospa_gapps`.

Include it from the device product makefile:

```make
$(call inherit-product, vendor/viper4android/viper4android.mk)
```

This installs the privileged app, its permission allowlist, and both 32-bit and
64-bit `libv4a_re.so` sound-effect libraries.

The source package does not contain an audio-effects configuration entry. If
the device's active `audio_effects.xml` does not already register ViPER, add:

```xml
<library name="v4a_re" path="libv4a_re.so"/>
```

inside `<libraries>`, and:

```xml
<effect name="v4a_standard_re" library="v4a_re"
        uuid="90380da3-8536-4744-a6a3-5731970e640f"/>
```

inside `<effects>`.
