TARGET = iphone:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Instagram-hijack

Instagram-hijack_FILES = Tweak.x
Instagram-hijack_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
