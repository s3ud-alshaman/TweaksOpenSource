TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = Twitter

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TwitDate

TwitDate_FILES = Tweak.x
TwitDate_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
