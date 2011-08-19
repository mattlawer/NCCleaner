SDKVERSION = 5.0
include theos/makefiles/common.mk

TWEAK_NAME = NCCleaner
NCCleaner_FILES = Tweak.xm
NCCleaner_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
