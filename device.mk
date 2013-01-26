#
# This is the product configuration for a full maserati
#
$(call inherit-product, device/motorola/omap4-common/common.mk)

DEVICE_FOLDER := device/motorola/maserati

# Device overlay
    DEVICE_PACKAGE_OVERLAYS += $(DEVICE_FOLDER)/overlay

# Hardware HALs
PRODUCT_PACKAGES += \
    camera.maserati \
    lights.maserati

#    hwcomposer.maserati

# Modem
PRODUCT_PACKAGES += \
    nc \
    Stk \
    libreference-cdma-sms

# Prebuilts
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/prebuilt/etc/media_codecs.xml:system/etc/media_codecs.xml \
    $(DEVICE_FOLDER)/prebuilt/etc/media_profiles.xml:system/etc/media_profiles.xml \
    $(DEVICE_FOLDER)/prebuilt/etc/audio_policy.conf:system/etc/audio_policy.conf \
    $(DEVICE_FOLDER)/prebuilt/etc/vold.fstab:system/etc/vold.fstab \
    $(DEVICE_FOLDER)/prebuilt/usr/idc/omap4-keypad.idc:system/usr/idc/omap4-keypad.idc \
    $(DEVICE_FOLDER)/prebuilt/usr/keychars/omap4-keypad.kcm:system/usr/keychars/omap4-keypad.kcm \
    $(DEVICE_FOLDER)/prebuilt/usr/keylayout/omap4-keypad.kl:system/usr/keylayout/omap4-keypad.kl

# copy all kernel modules under the "modules" directory to system/lib/modules
ifneq ($(BOARD_USES_KEXEC),true)
PRODUCT_COPY_FILES += $(shell \
    find device/motorola/maserati/modules -name '*.ko' \
    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
    | tr '\n' ' ')
endif

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
$(call inherit-product-if-exists, vendor/motorola/omap4-common/proprietary/vzw/verizon.mk)
$(call inherit-product-if-exists, vendor/motorola/maserati/maserati-vendor.mk)
