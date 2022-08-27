TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e


TWEAK_NAME = DateFormatter

DateFormatter_FILES = Tweak.x
DateFormatter_EXTRA_FRAMEWORKS += Cephei

DateFormatter_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += prefdateformatter
include $(THEOS_MAKE_PATH)/aggregate.mk
