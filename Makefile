ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

RTOSAPP_TOPDIR:=$(shell pwd)
BUILDDIR=build
PROJECT_DIR=$(realpath .)

define target_build
	mkdir -p $(BUILDDIR)
	cmake -B $(BUILDDIR) \
	      -DFLB_CONFIG_YAML=Off \
	      -DCMAKE_CXX_STANDARD=14 \
	      -DCMAKE_BUILD_TYPE=Release \
	      -DCMAKE_SYSTEM_PROCESSOR=${1} \
	      -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	      -DCMAKE_INSTALL_PREFIX=$(PROJECT_DIR)/$(BUILDDIR) \
	      -DOPENSSL_SSL_LIBRARY=$(QNX_TARGET)/${1}/usr/lib/libssl.so \
	      -DLIBCARES_LIBRARY=$(QNX_TARGET)/${1}/usr/lib/libcares.so \
	      -DLIBCARES_INCLUDE_DIR=$(QNX_TARGET)/usr/include \
	      -DZLIB_LIBRARY=$(QNX_TARGET)/${1}/usr/lib/libz.so \
	      -DOPENSSL_ROOT_DIR=$(QNX_TARGET)/${1}/usr/lib \
	      -DOPENSSL_INCLUDE_DIR=$(QNX_TARGET)/usr/include/openssl \
	      -DCURL_LIBRARY=$(QNX_TARGET)/${1}/usr/lib/libcurl.so \
	      -DCURL_INCLUDE_DIR=$(QNX_TARGET)/usr/include/curl \
	      -DFFI_LIBRARIES=$(QNX_TARGET)/${1}/usr/lib/libffi.so \
	      -DTerminfo_LIBRARIES=$(QNX_TARGET)/usr/lib/terminfo \
	      -DCMAKE_TOOLCHAIN_FILE=$(PROJECT_DIR)/tool_chain_script/CMake/${2}		
	cmake --build $(BUILDDIR) -j16 
endef

all: qnx710-x86_64

qnx710-x86_64:
	@echo "build fluent-bit for QNX7 in $(PROJECT_DIR)"
	$(call target_build,x86_64,Qnx.cmake.x86_64.qnx710)
	cp $(PROJECT_DIR)/$(BUILDDIR)/bin/fluent-bit $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/configure_files/* $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/log/* $(PROJECT_DIR)/bin

qnx710-aarch64:
	@echo "build fluent-bit for QNX7 in $(PROJECT_DIR)"
	$(call target_build,aarch64le,Qnx.cmake.aarch64.qnx710)
	cp $(PROJECT_DIR)/$(BUILDDIR)/bin/fluent-bit $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/configure_files/* $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/log/* $(PROJECT_DIR)/bin

qnx710-armle_v7:
	@echo "build fluent-bit for QNX7 in $(PROJECT_DIR)"
	$(call target_build,armle-v7,Qnx.cmake.armv7.qnx710)
	cp $(PROJECT_DIR)/$(BUILDDIR)/bin/fluent-bit $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/configure_files/* $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/log/* $(PROJECT_DIR)/bin

qnx700-aarch64:
	@echo "build fluent-bit for QNX7 in $(PROJECT_DIR)"
	$(call target_build,aarch64le,Qnx.cmake.aarch64.qnx700)
	cp $(PROJECT_DIR)/$(BUILDDIR)/bin/fluent-bit $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/configure_files/* $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/log/* $(PROJECT_DIR)/bin

.PHONY: clean
clean:
	rm -rf $(PROJECT_DIR)/bin/*
	rm -rf $(PROJECT_DIR)/$(BUILDDIR)/*
