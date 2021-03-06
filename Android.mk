#
# Copyright (C) 2009 The Android Open Source Project
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

# Disable racoon as it is shipped by Android itself.
ifneq (1,1) # ($(TARGET_SIMULATOR),true)

LOCAL_PATH := $(call my-dir)

#
# libracoonlib.so
#
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/racoon/kmpstat.c \
	src/racoon/vmbuf.c \
	src/racoon/sockmisc.c \
	src/racoon/misc.c

LOCAL_C_INCLUDES += \
	$(NDK_PROJECT_PATH) \
	$(NDK_PROJECT_PATH)/src/include-glibc \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src/libipsec \
	$(OPENSSL_INC)

LOCAL_SHARED_LIBRARIES += libclib libipsec

ifneq ($(TARGET_SIMULATOR),true)
        LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_CFLAGS := -DANDROID_CHANGES -DHAVE_CONFIG_H -DNOUSE_PRIVSEP

LOCAL_MODULE := libracoonlib

include $(BUILD_SHARED_LIBRARY)


#
# racoon
#
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/racoon/isakmp.c \
	src/racoon/isakmp_agg.c \
	src/racoon/isakmp_base.c \
	src/racoon/isakmp_frag.c \
	src/racoon/isakmp_ident.c \
	src/racoon/isakmp_inf.c \
	src/racoon/isakmp_newg.c \
	src/racoon/isakmp_quick.c \
	src/racoon/handler.c \
	src/racoon/pfkey.c \
	src/racoon/ipsec_doi.c \
	src/racoon/oakley.c \
	src/racoon/vendorid.c \
	src/racoon/policy.c \
	src/racoon/crypto_openssl.c \
	src/racoon/algorithm.c \
	src/racoon/proposal.c \
	src/racoon/strnames.c \
	src/racoon/schedule.c \
	src/racoon/str2val.c \
	src/racoon/genlist.c \
	src/racoon/nattraversal.c \
	src/racoon/cfparse.c \
	src/racoon/cftoken.c \
	src/racoon/grabmyaddr.c \
	src/racoon/remoteconf.c \
	src/racoon/sainfo.c \
	src/racoon/rsalist.c \
	src/racoon/prsa_tok.c \
	src/racoon/prsa_par.c \
	src/racoon/plog.c \
	src/racoon/logger.c \
	src/racoon/main.c \
	src/racoon/backupsa.c \
	src/racoon/localconf.c \
	src/racoon/safefile.c \
	src/racoon/session.c \
	src/racoon/admin.c \
	src/racoon/evt.c \
	src/racoon/privsep.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src/include-glibc \
	$(LOCAL_PATH)/src/libipsec \
	$(LOCAL_PATH)/src/racoon \
	$(LOCAL_PATH)/src/racoon/missing \
	$(OPENSSL_INC)

LOCAL_SHARED_LIBRARIES := libcutils libcrypto libipsec libracoonlib

LOCAL_CFLAGS := -DANDROID_CHANGES -DHAVE_CONFIG_H -DSYSCONFDIR='"/tmp"' -DENABLE_ADMINPORT -DADMINPORTDIR='"/tmp"'

LOCAL_LDFLAGS := -L$(OPENSSL_LIB)/$(TARGET_ARCH_ABI)
LOCAL_LDLIBS := -lssl -lcrypto

LOCAL_MODULE := racoon

include $(BUILD_EXECUTABLE)

#
# racoonctl
#
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	src/racoon/racoonctl.c

LOCAL_C_INCLUDES += \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/src/include-glibc \
	$(LOCAL_PATH)/src/libipsec \
	$(OPENSSL_INC)


LOCAL_SHARED_LIBRARIES += libipsec libracoonlib

LOCAL_CFLAGS := -DANDROID_CHANGES -DHAVE_CONFIG_H -DENABLE_ADMINPORT -DADMINPORTDIR='"/tmp"'

LOCAL_MODULE := racoonctl

include $(BUILD_EXECUTABLE)

endif

include src/libipsec/Android.mk
include src/setkey/Android.mk
