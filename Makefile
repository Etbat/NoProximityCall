ARCHS = arm64 arm64e
TARGET = iphone:clang:16.0:16.0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoProximityCall

NoProximityCall_FILES = Tweak.x
NoProximityCall_CFLAGS = -fobjc-arc
NoProximityCall_FRAMEWORKS = UIKit
NoProximityCall_PLIST = NoProximityCall.plist

include $(THEOS_MAKE_PATH)/tweak.mk
