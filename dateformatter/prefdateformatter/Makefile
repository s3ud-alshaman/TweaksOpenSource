TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PrefDateFormatter

PrefDateFormatter_FILES = S3RootListController.m
PrefDateFormatter_FRAMEWORKS = UIKit
PrefDateFormatter_PRIVATE_FRAMEWORKS = Preferences
PrefDateFormatter_INSTALL_PATH = /Library/PreferenceBundles
PrefDateFormatter_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
