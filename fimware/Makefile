
# Project settings
PROJECT_NAME = firmware
PROJECT_VERSION = 0.1
ESPIDF_DIR = /frameworks/esp-idf
IDF_PATH = $(ESPIDF_DIR)

MICROPYTHON_DIR = /micropython
MICROPYTHON_PORT = esp32

# ESP build settings
#
BOARD=ESP32_GENERIC_S3
BOARD_VARIANT=FLASH_4M
FLASH_SIZE=4MB

FROZEN_MANIFEST = $(CURDIR)/frozenmanifest.py
PROJECT_DIR = $(CURDIR)


FIRMWARE_DIR = $(MICROPYTHON_DIR)/ports/$(MICROPYTHON_PORT)
BUILD_DIR = $(FIRMWARE_DIR)/build-$(BOARD)-$(BOARD_VARIANT)



.PHONY: info clean deepclean checkSizes
.ONESHELL:



test:
	export IDF_PATH=$(IDF_PATH)
	. /frameworks/esp-idf/export.sh
	cd $(FIRMWARE_DIR)
	make BOARD=$(BOARD) BOARD_VARIANT=$(BOARD_VARIANT) FROZEN_MANIFEST=$(FROZEN_MANIFEST) -j all


info:
	@echo "----------------------------------------"
	@echo "Project: MicroPython Firmware"
	@echo "Author: Stefan Marx (stefan@marx-merten.de)"
	@echo "Date: $(shell date)"
	@echo "Working Directory: $(shell pwd)"
	@echo "ESP $(BOARD) $(BOARD_VARIANT)"
	@echo "----------------------------------------"


build: dist/firmware.bin dist/application.bin dist/partition.table
	@echo "Building firmware for $(BOARD) $(BOARD_VARIANT)"
	@echo "----------------------------------------"
	@echo "Firmware: $(BUILD_DIR)/firmware.bin"
	@echo "----------------------------------------"
	make checkSizes

checkSizes: dist/application.bin dist/partition.table
	@echo "Checking sizes"
	@echo "----------------------------------------"

	appSize=$$(stat -c %s dist/application.bin) ;\
	otaHex=$$(grep app dist/partition.table | head -n 1 | awk -F , '{print $$5}' | awk -F K '{ print $$1}') ;\
	otaSize=$$(($$otaHex * 1024)) ;\
	echo "Application Size: $$appSize" ;\
	echo "OTA Partition Size: $$otaSize" ;\
	if [ $$appSize -gt $$otaSize ]; then \
		echo "Application size exceeds OTA partition size" ;\
		exit 1 ;\
	fi ;\
	percentages=$$(($$appSize * 100 / $$otaSize)) ;\
	echo "Application size is $$percentages% of OTA partition size" ;\
	if [ $$percentages -gt 90 ]; then \
		echo "Application size is more than 90% of OTA partition size" ;\
		exit 1 ;\
	fi
	@echo "----------------------------------------"


clean:
	rm -rf $(BUILD_DIR)
	rm -rf dist



dist/firmware.bin: $(BUILD_DIR)/firmware.bin
	mkdir -p dist
	cp $(BUILD_DIR)/firmware.bin dist/firmware.bin

dist/application.bin: $(BUILD_DIR)/firmware.bin
	mkdir -p dist
	cp $(BUILD_DIR)/micropython.bin dist/application.bin

dist/partition.table: $(BUILD_DIR)/firmware.bin
	mkdir -p dist
	python3 $(ESPIDF_DIR)/components/partition_table/gen_esp32part.py $(BUILD_DIR)/partition_table/partition-table.bin dist/partition.table


$(BUILD_DIR)/firmware.bin:  frozenmanifest.py pysrc/device/*
	export IDF_PATH=$(IDF_PATH)
	. /frameworks/esp-idf/export.sh
	cd $(FIRMWARE_DIR)
	make BOARD=$(BOARD) BOARD_VARIANT=$(BOARD_VARIANT) FROZEN_MANIFEST=$(FROZEN_MANIFEST) -j all