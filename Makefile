include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TinderPreview
ADDITIONAL_OBJCFLAGS = -fobjc-arc
TinderPreview_FILES = $(wildcard *.m *.mm *.x *.xm)

include $(THEOS_MAKE_PATH)/tweak.mk
