#
# Copyright (C) 2014 VanirAOSP && The Android Open Source Project
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

#  This config sets up an interface for toggling various build configurations
#  that can be set and respected in device tree overlays.  All options should
#  default off if unset.  The vanir_config.mk is included in:
#    $(BUILD_SYSTEM)/config.mk

# current build configurations:
# BONE_STOCK := set true to override all vanir_config variables
# NO_DEBUG_FRAME_POINTERS := set true to add frame pointers
# NO_DEBUG_SYMBOL_FLAGS := true removes debugging code insertions from assert.h macros and GDB
# MAXIMUM_OVERDRIVE := true disables address sanitizer, in core/clang/config.mk
# USE_GRAPHITE := true adds graphite cflags to turn on graphite
# USE_FSTRICT_FLAGS := true builds with fstrict-aliasing (thumb and arm)
# USE_BINARY_FLAGS := true adds experimental binary flags that can be set here or in device trees
# USE_EXTRA_CLANG_FLAGS := true allows additional flags to be passed to the Clang compiler
# ADDITIONAL_TARGET_ARM_OPT := Additional flags may be appended here for GCC-specific modules, -O3 etc
# ADDITIONAL_TARGET_THUMB_OPT := Additional flags may be appended here for GCC-specific modules, -O3 etc
# FSTRICT_ALIASING_WARNING_LEVEL := 0-3 for what is considered an aliasing violation

# SET GLOBAL CONFIGURATION HERE:
MAXIMUM_OVERDRIVE              ?= true
NO_DEBUG_SYMBOL_FLAGS          ?= true
NO_DEBUG_FRAME_POINTERS        ?= true
USE_GRAPHITE                   ?= true
USE_FSTRICT_FLAGS              ?= true
USE_BINARY_FLAGS               ?=
USE_HOST_4_8                   ?= true
USE_MODULAR_O3                 ?= true
KRAIT_TUNINGS                  ?= true
ENABLE_GCCONLY                 ?= true
USE_O3_OPTIMIZATIONS           ?= true
USE_EXTRA_CLANG_FLAGS          ?= true
ADDITIONAL_TARGET_ARM_OPT      ?= true
ADDITIONAL_TARGET_THUMB_OPT    ?= true
ADDITIONAL_TARGET_GLOBAL_OPT   ?= true
ADDITIONAL_TARGET_RELEASE_OPT  ?= true
USE_EXTRA_GLOBAL_FLAGS         ?= true
FSTRICT_ALIASING_WARNING_LEVEL ?= 2

ifeq ($(FSTRICT_ALIASING_WARNING_LEVEL),)
  FSTRICT_ALIASING_WARNING_LEVEL := 2
endif

# Respect BONE_STOCK: strictly enforce AOSP defaults.
ifeq ($(BONE_STOCK),true)
  USE_MODULAR_O3                 :=
  USE_HOST_4_8                   :=
  USE_O3_OPTIMIZATIONS           :=
  KRAIT_TUNINGS                  :=
  ENABLE_GCCONLY                 :=
  MAXIUMUM_OVERDRIVE             :=
  NO_DEBUG_SYMBOL_FLAGS          :=
  USE_GRAPHITE                   :=
  USE_FSTRICT_FLAGS              :=
  USE_BINARY_FLAGS               :=
  USE_EXTRA_CLANG_FLAGS          :=
  ADDITIONAL_TARGET_ARM_OPT      :=
  ADDITIONAL_TARGET_THUMB_OPT    :=
  ADDITIONAL_TARGET_GLOBAL_OPT   :=
  ADDITIONAL_TARGET_RELEASE_OPT  :=
  USE_EXTRA_GLOBAL_FLAGS         :=
endif

# DEBUGGING OPTIONS
ifeq ($(NO_DEBUG_SYMBOL_FLAGS),true)
  DEBUG_SYMBOL_FLAGS := -g0 -DNDEBUG
endif
ifeq ($(NO_DEBUG_FRAME_POINTERS),true)
  DEBUG_FRAME_POINTER_FLAGS := -fomit-frame-pointer
endif

# GRAPHITE
ifeq ($(USE_GRAPHITE),true)
  GRAPHITE_FLAGS := \
          -fgraphite             \
          -floop-flatten         \
          -floop-parallelize-all \
          -ftree-loop-linear     \
          -floop-interchange     \
          -floop-strip-mine      \
          -floop-block
endif

# fstrict-aliasing. Thumb is defaulted off for AOSP.
ifeq ($(USE_FSTRICT_FLAGS),true)
  FSTRICT_FLAGS := \
          -fstrict-aliasing \
          -Wstrict-aliasing=$(FSTRICT_ALIASING_WARNING_LEVEL) \
          -Werror=strict-aliasing
endif

# Additional GCC-specific arm cflags
ifeq ($(ADDITIONAL_TARGET_ARM_OPT),true)
    VANIR_TARGET_ARM_FLAGS := -O3 -DNDEBUG -pipe -fno-tree-vectorize -fno-inline-functions -fivopts -ffunction-sections -fdata-sections -frename-registers -fomit-frame-pointer -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized
endif

# Additional GCC-specific thumb cflags
ifeq ($(ADDITIONAL_TARGET_THUMB_OPT),true)
    VANIR_TARGET_THUMB_FLAGS := -DNDEBUG -pipe -fno-tree-vectorize -fno-inline-functions -fno-unswitch-loops -fivopts -ffunction-sections -fdata-sections -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized -Wno-clobbered -Wno-strict-overflow
endif

# Additional GCC-specific arm cflags
ifeq ($(ADDITIONAL_TARGET_GLOBAL_OPT),true)
    VANIR_TARGET_GLOBAL_FLAGS := -fvisibility-inlines-hidden -O3 -DNDEBUG -pipe -fivopts -ffunction-sections -fdata-sections -funswitch-loops -fomit-frame-pointer -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized
endif

# Additional GCC-specific thumb cflags
ifeq ($(ADDITIONAL_TARGET_RELEASE_OPT),true)
    VANIR_TARGET_RELEASE_FLAGS := -O3 -DNDEBUG -pipe -g -frerun-cse-after-loop -frename-registers -fno-strict-aliasing -fivopts -ffunction-sections -fdata-sections -funswitch-loops -fomit-frame-pointer -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized
endif


# Additional clang-specific cflags
ifeq ($(USE_EXTRA_CLANG_FLAGS),true)
    VANIR_CLANG_CONFIG_EXTRA_ASFLAGS :=
    VANIR_CLANG_CONFIG_EXTRA_CFLAGS := -O3 -Qunused-arguments -Wno-unknown-warning-option
    VANIR_CLANG_CONFIG_EXTRA_CPPFLAGS := -O3 -Qunused-arguments -Wno-unknown-warning-option -D__compiler_offsetof=__builtin_offsetof
    VANIR_CLANG_CONFIG_EXTRA_LDFLAGS :=
endif

# Additional global flags
ifeq ($(USE_EXTRA_GLOBAL_FLAGS),true)
    VANIR_GLOBAL_CFLAGS := -O3 -DNDEBUG -pipe -fivopts -ffunction-sections -fdata-sections -funswitch-loops -fomit-frame-pointer -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized
    VANIR_RELEASE_CFLAGS := -O3 -DNDEBUG -pipe -fivopts -ffunction-sections -fdata-sections -funswitch-loops -fomit-frame-pointer -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized
    VANIR_GLOBAL_CPPFLAGS := -O3 -DNDEBUG -pipe -fivopts -ffunction-sections -fdata-sections -funswitch-loops -fomit-frame-pointer -ftracer -Wno-unused-parameter -Wno-unused-but-set-variable -Wno-maybe-uninitialized
    VANIR_GLOBAL_LDFLAGS := -Wl,-O1 -Wl,--as-needed -Wl,--relax -Wl,--sort-common -Wl,--gc-sections
endif

# variables as exported to other makefiles
VANIR_FSTRICT_OPTIONS := $(FSTRICT_FLAGS)

VANIR_GLOBAL_CFLAGS += $(DEBUG_SYMBOL_FLAGS) $(DEBUG_FRAME_POINTER_FLAGS)
VANIR_RELEASE_CFLAGS += $(DEBUG_SYMBOL_FLAGS) $(DEBUG_FRAME_POINTER_FLAGS)
VANIR_CLANG_TARGET_GLOBAL_CFLAGS += $(DEBUG_SYMBOL_FLAGS) $(DEBUG_FRAME_POINTER_FLAGS)

# set experimental/unsupported flags here for persistance and try to override local options that
# may be set after release flags.  This option should not be used to set flags globally that are
# intended for release but to test outcomes.  For example: setting -O3 here will have a higher
# likelyhood of overriding the stock and local flags.
ifdef ($(USE_BINARY_FLAGS),true)
VANIR_BINARY_CFLAG_OPTIONS := $(GRAPHITE_FLAGS)
VANIR_BINARY_CPP_OPTIONS := $(GRAPHITE_FLAGS)
VANIR_LINKER_OPTIONS :=
VANIR_ASSEMBLER_OPTIONS :=
endif
