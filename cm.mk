$(call inherit-product, device/samsung/d2spr/full_d2spr.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/cdma.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=d2uc TARGET_DEVICE=d2spr BUILD_FINGERPRINT="d2uc-user 4.0.4 IMM76D I747UCALEM release-keys" PRIVATE_BUILD_DESC="samsung/d2uc/d2spr:4.0.4/IMM76D/I747UCALEM:user/release-keys"

TARGET_BOOTANIMATION_NAME := vertical-720x1280

PRODUCT_NAME := cm_d2spr
PRODUCT_DEVICE := d2spr

