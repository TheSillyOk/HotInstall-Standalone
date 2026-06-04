include common.mk

VERSION ?= $(VER_CODE)-$(COMMIT_HASH)
MODULE_ZIP ?= $(MODULE_NAME)-$(VER_NAME)-$(VERSION).zip
OUT_DIR ?= out
ZIP_OUT ?= $(OUT_DIR)/$(MODULE_ZIP)

ifeq ($(TERMUX_VERSION),)
	ADB_PUSH := adb push $(ZIP_OUT) /data/local/tmp
	ADB_SHELL := adb shell 
	INSTALL_PATH := /data/local/tmp/$(MODULE_ZIP)
else
	INSTALL_PATH := $(ZIP_OUT)
endif

.PHONY: build

all: build

clean:
	@echo Cleaning the build and output directories...
	@rm -rf $(BUILD_DIR)
	@rm -rf $(OUT_DIR)

build:
	@echo Creating build directory...
	@mkdir -p $(BUILD_DIR)
	@cp -r module/* $(BUILD_DIR)/

	@sed -e 's/versionName/$(VER_NAME) ($(VERSION))/g' \
             -e 's/versionNumber/$(VER_CODE)/g' \
             module/module.prop > $(BUILD_DIR)/module.prop

	@echo Creating module zip...
	@mkdir -p $(OUT_DIR)
	@cd $(BUILD_DIR) && zip -qr9 ../$(ZIP_OUT) .

installModule: build
	$(ADB_PUSH)
	@$(ADB_SHELL)su -M -c "magisk --install-module $(INSTALL_PATH) 2&>/dev/null"|| \
	$(ADB_SHELL)su -c "ksud module install $(INSTALL_PATH) 2&>/dev/null"||        \
	$(ADB_SHELL)su -c "apd module install $(INSTALL_PATH) 2&>/dev/null"           \
	|| echo "[X] Could not find valid CLI to install the module"

installModuleAndReboot: installModule
	$(ADB_SHELL)su -c reboot
