ARCHS = arm64 arm64e

TARGET = iphone:clang:16.5:15.0

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoProximityCall

NoProximityCall_FILES = Tweak.x
NoProximityCall_CFLAGS = -fobjc-arc
NoProximityCall_FRAMEWORKS = Foundation

include $(THEOS_MAKE_PATH)/tweak.mk
