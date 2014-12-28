# Copyright (C) 2014 The SaberMod Project
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

# Force disable some modules that are not compatible with graphite flags
LOCAL_DISABLE_GRAPHITE := \
	libbusybox \
	libc \
	mdnsd \
	bluetooth.default \
	libhwui \
	libstagefright_amrnb_common \
	libunwind \
	dnsmasq \
	libFFTEm \
	libart-compiler \
	libicui18n \
	libskia \
	libvpx \
	libmedia_jni \
	libstagefright_mp3dec \
	libart \
	libstagefright_amrwbenc \
	libpdfium \
	libjavacrypto \
	libstagefright_amrnbenc \
	libstagefright_amrnbdec \
	libstagefright_amrwbdec \
	libstagefright_avcenc \
	libstagefright_m4vh263dec \
	libFraunhoferAAC \
	libcrypto_static \
	libicuuc \
	busybox \
	lsof \
	libstagefright_m4vh263enc \
	libpdfiumcore

ifneq (1,$(words $(filter $(LOCAL_DISABLE_GRAPHITE), $(LOCAL_MODULE))))
ifdef LOCAL_CONLYFLAGS
LOCAL_CONLYFLAGS += \
	$(GRAPHITE_FLAGS)
else
LOCAL_CONLYFLAGS := \
	$(GRAPHITE_FLAGS)
endif

ifdef LOCAL_CPPFLAGS
LOCAL_CPPFLAGS += \
	$(GRAPHITE_FLAGS)
else
LOCAL_CPPFLAGS := \
	$(GRAPHITE_FLAGS)
endif
endif

#####
