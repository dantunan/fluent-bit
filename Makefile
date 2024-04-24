ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

RTOSAPP_TOPDIR:=$(shell pwd)
BUILDDIR=build
PROJECT_DIR=$(realpath .)
OS=nto-qnx
CPU=x86_64

define target_build
	mkdir -p $(BUILDDIR)
	cmake -B $(BUILDDIR) \
	      -DFLB_CONFIG_YAML=Off \
	      -DCMAKE_CXX_STANDARD=14 \
	      -DCMAKE_BUILD_TYPE=Debug \
	      -DCMAKE_SYSTEM_PROCESSOR=$(CPU) \
	      -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
	      -DCMAKE_INSTALL_PREFIX=$(PROJECT_DIR)/$(BUILDDIR) \
	      -DOPENSSL_SSL_LIBRARY=$(QNX_TARGET)/x86_64/usr/lib/libssl.so \
	      -DLIBCARES_LIBRARY=$(QNX_TARGET)/x86_64/usr/lib/libcares.so \
	      -DLIBCARES_INCLUDE_DIR=$(QNX_TARGET)/usr/include \
	      -DZLIB_LIBRARY=$(QNX_TARGET)/x86_64/usr/lib/libz.so \
	      -DOPENSSL_ROOT_DIR=$(QNX_TARGET)/x86_64/usr/lib \
	      -DOPENSSL_INCLUDE_DIR=$(QNX_TARGET)/usr/include/openssl \
	      -DCURL_LIBRARY=$(QNX_TARGET)/x86_64/usr/lib/libcurl.so \
	      -DCURL_INCLUDE_DIR=$(QNX_TARGET)/usr/include/curl \
	      -DFFI_LIBRARIES=$(QNX_TARGET)/x86_64/usr/lib/libffi.so \
	      -DTerminfo_LIBRARIES=$(QNX_TARGET)/usr/lib/terminfo \
	      -DCMAKE_TOOLCHAIN_FILE=$(PROJECT_DIR)/tool_chain_script/CMake/Qnx.cmake			
	cmake --build $(BUILDDIR) -j16 
endef

all:
	@echo "build fluent-bit for QNX7.1 $(PROJECT_DIR) , $(INSTALLDIR)"
	$(call target_build)
	cp $(PROJECT_DIR)/$(BUILDDIR)/bin/fluent-bit $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/configure_files/* $(PROJECT_DIR)/bin
	cp $(PROJECT_DIR)/log/* $(PROJECT_DIR)/bin

.PHONY: clean
clean:
	rm -rf $(PROJECT_DIR)/bin/*
	rm -rf $(PROJECT_DIR)/$(BUILDDIR)/*
