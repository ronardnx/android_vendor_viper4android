# ViPER4Android RE

V4A_PATH := vendor/viper4android

PRODUCT_PACKAGES += \
    ViPER4Android \
    libv4a_re

PRODUCT_COPY_FILES += \
    $(V4A_PATH)/proprietary/system/etc/permissions/privapp-permissions-viper4android.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-viper4android.xml

# The framework's global effect registry must also know about ViPER. The
# Magisk implementation patches this exact file at boot.
PRODUCT_COPY_FILES += \
    $(V4A_PATH)/configs/audio_effects_system.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/audio_effects.xml

# Register the legacy HIDL audio effect in every device audio SKU. Both the
# XML and legacy CONF are required because Qualcomm products may load either.
# Keep a device-independent default: product inheritance can evaluate this
# makefile without retaining variables assigned immediately before it.
ifeq ($(strip $(V4A_AUDIO_SKUS)),)
V4A_AUDIO_SKUS := pineapple cliffs
endif
ifneq ($(strip $(V4A_AUDIO_SKUS)),)
PRODUCT_COPY_FILES += \
$(foreach V4A_AUDIO_SKU, $(V4A_AUDIO_SKUS), \
    $(V4A_PATH)/configs/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_$(V4A_AUDIO_SKU)/audio_effects.conf \
    $(V4A_PATH)/configs/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_$(V4A_AUDIO_SKU)/audio_effects.xml)
endif

V4A_PATH :=
