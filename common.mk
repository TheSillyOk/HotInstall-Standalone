ROOT_DIR ?= .

VER_NAME ?= $(shell git tag -l | sort -V | tail -n 1 || echo "v1.0.2")
VER_CODE ?= $(shell git -C "$(ROOT_DIR)" rev-list HEAD --count 2>/dev/null || echo 1)
COMMIT_HASH ?= $(shell git -C "$(ROOT_DIR)" rev-parse --verify --short HEAD 2>/dev/null || echo unknown)

MODULE_ID ?= hot_install
MODULE_NAME ?= HotInstall-Standalone

BUILD_DIR ?= $(ROOT_DIR)/build
