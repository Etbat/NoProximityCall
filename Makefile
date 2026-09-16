ARCHS = arm64 arm64e

TARGET = iphone:clang:latest:15.0

THEOS_PACKAGE_SCHEME = roothide

INSTALL_TARGET_PROCESSES = MobilePhone WeChat

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoProximityCall

NoProximityCall_FILES = Tweak.x

NoProximityCall_CFLAGS = -fobjc-arc

NoProximityCall_FRAMEWORKS = UIKit

NoProximityCall_PLIST = NoProximityCall.plist

include $(THEOS_MAKE_PATH)/tweak.mk
