# Copyright (C) 2015 The SaberMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#Vanir Config
include $(BUILD_SYSTEM)/vanir_config.mk

# Force disable some modules that are not compatible with strict flags
LOCAL_DISABLE_STRICT := \
	camera.msm8084 \
	libc_bionic \
	libc_dns \
	libc_tzcode \
	libziparchive \
	libdiskconfig \
	libcrypto_static \
	libtwrpmtp \
	libfusetwrp \
	libguitwrp \
	busybox \
	libuclibcrpc \
	libziparchive-host \
	libpdfiumcore \
	libandroid_runtime \
	libmedia \
	libpdfiumcore \
	libpdfium \
	bluetooth.default \
	logd \
	llvm-tblgen \
	mdnsd \
	net_net_gyp \
	libstagefright_webm \
	libaudioflinger \
	libmediaplayerservice \
	libcompiler_rt \
	libstagefright \
	ping \
	ping6 \
	libdiskconfig \
	libjavacore \
	libfdlibm \
	libfuse \
	libbusybox \
	libvariablespeed \
	librtp_jni \
	libwilhelm \
	libdownmix \
	libldnhncr \
	libqcomvisualizer \
	libvisualizer \
	libstlport \
	libutils \
	libandroidfw \
	libOmxVenc \
	dnsmasq \
	gatt_testtool \
	static_busybox \
	libwebviewchromium \
	libwebviewchromium_loader \
	libwebviewchromium_plat_support \
	content_content_renderer_gyp \
	third_party_WebKit_Source_modules_modules_gyp \
	third_party_WebKit_Source_platform_blink_platform_gyp \
	third_party_WebKit_Source_core_webcore_remaining_gyp \
	third_party_angle_src_translator_lib_gyp \
	camera.msm8084 \
	lsof \
	third_party_WebKit_Source_core_webcore_generated_gyp

ifneq (1,$(words $(filter $(LOCAL_DISABLE_STRICT), $(LOCAL_MODULE))))
ifndef LOCAL_CONLYFLAGS
LOCAL_CONLYFLAGS += \
    $(VANIR_FSTRICT_OPTIONS)
else
LOCAL_CONLYFLAGS := \
    $(VANIR_FSTRICT_OPTIONS)
endif

ifdef LOCAL_CPPFLAGS
LOCAL_CPPFLAGS += \
    $(VANIR_FSTRICT_OPTIONS)
else
LOCAL_CPPFLAGS := \
    $(VANIR_FSTRICT_OPTIONS)
endif
endif
#####
