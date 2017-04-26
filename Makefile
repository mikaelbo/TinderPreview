include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TinderPreview
ADDITIONAL_OBJCFLAGS = -fobjc-arc
TinderPreview_FILES = $(wildcard Source/*.m Source/*.mm Source/*.x Source/*.xm)

include $(THEOS_MAKE_PATH)/tweak.mk
