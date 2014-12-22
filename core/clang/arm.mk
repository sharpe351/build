# Clang flags for arm arch, target or host.

CLANG_CONFIG_arm_EXTRA_ASFLAGS := \
  -no-integrated-as

CLANG_CONFIG_arm_EXTRA_CFLAGS := \
  -no-integrated-as

ifneq (,$(filter krait,$(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)))
  # Android's clang support's krait as a CPU whereas GCC doesn't. Specify
  # -mcpu here rather than the more normal core/combo/arch/arm/armv7-a-neon.mk.
  CLANG_CONFIG_arm_EXTRA_CFLAGS += $(call cc-option,-mcpu=swift,-mcpu=cortex-a15)
endif

CLANG_CONFIG_arm_EXTRA_CPPFLAGS := \
  -no-integrated-as

CLANG_CONFIG_arm_EXTRA_LDFLAGS := \
  -no-integrated-as

# Include common unknown flags
CLANG_CONFIG_arm_UNKNOWN_CFLAGS := \
  $(CLANG_CONFIG_UNKNOWN_CFLAGS) \
  -mthumb-interwork \
  -fgcse-after-reload \
  -frerun-cse-after-loop \
  -frename-registers \
  -fno-align-jumps \
  -fno-builtin-sin \
  -fno-caller-saves \
  -fno-early-inlining \
  -fno-move-loop-invariants \
  -fno-partial-inlining \
  -fno-strict-volatile-bitfields \
  -fno-tree-copy-prop \
  -fno-tree-loop-optimize \
  -funsafe-loop-optimizations \
  -fno-vect-cost-model \
  -fno-ipa-cp-clone \
  -fsection-anchors \
  -ftree-loop-im \
  -ftree-loop-ivcanon \
  -fgcse-sm \
  -fgcse-las \
  -fweb \
  -Wa,--noexecstack
  -Wno-unused-local-typedefs

ifeq ($(TARGET_CPU_VARIANT),krait)
  define subst-clang-incompatible-arm-flags
    $(subst -mcpu=cortex-a15,-mcpu=krait2,\
    $(1))
  endef
else
  define subst-clang-incompatible-arm-flags
    $(subst -march=armv5te,-march=armv5t,\
    $(subst -march=armv5e,-march=armv5,\
    $(1)))
  endef
endif
