LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	ipsec_dump_policy.c \
	ipsec_get_policylen.c \
	ipsec_strerror.c \
	key_debug.c \
	pfkey.c \
	pfkey_dump.c \
	policy_parse.c \
	policy_token.c \
	error.c

LOCAL_C_INCLUDES += \
	$(NDK_PROJECT_PATH) \
	$(NDK_PROJECT_PATH)/src/include-glibc \
	$(LOCAL_PATH)

LOCAL_SHARED_LIBRARIES += libclib

ifneq ($(TARGET_SIMULATOR),true)
        LOCAL_SHARED_LIBRARIES += libdl
endif

LOCAL_CFLAGS := -DANDROID_CHANGES -DHAVE_CONFIG_H

# Renames bison/flex symbols otherwise it will conflict with setkey
# XXX A cleaner alternative?
LOCAL_CFLAGS += \
	-Dyy_create_buffer=libipsec_yy_create_buffer \
	-Dyy_delete_buffer=libipsec_yy_delete_buffer \
	-Dyy_flex_debug=libipsec_yy_flex_debug \
	-Dyy_flush_buffer=libipsec_yy_flush_buffer \
	-Dyy_scan_buffer=libipsec_yy_scan_buffer \
	-Dyy_scan_bytes=libipsec_yy_scan_bytes \
	-Dyy_scan_string=libipsec_yy_scan_string \
	-Dyy_switch_to_buffer=libipsec_yy_switch_to_buffer \
	-Dyyalloc=libipsec_yyalloc \
	-Dyyerror=libipsec_yyerror \
	-Dyyfree=libipsec_yyfree \
	-Dyyget_debug=libipsec_yyget_debug \
	-Dyyget_in=libipsec_yyget_in \
	-Dyyget_leng=libipsec_yyget_leng \
	-Dyyget_lineno=libipsec_yyget_lineno \
	-Dyyget_out=libipsec_yyget_out \
	-Dyyget_text=libipsec_yyget_text \
	-Dyyin=libipsec_yyin \
	-Dyylex=libipsec_yylex \
	-Dyylex_destroy=libipsec_yylex_destroy \
	-Dyylineno=libipsec_yylineno \
	-Dyyout=libipsec_yyout \
	-Dyyparse=libipsec_yyparse \
	-Dyypop_buffer_state=libipsec_yypop_buffer_state \
	-Dyypush_buffer_state=libipsec_yypush_buffer_state \
	-Dyyrealloc=libipsec_yyrealloc \
	-Dyyrestart=libipsec_yyrestart \
	-Dyyset_debug=libipsec_yyset_debug \
	-Dyyset_in=libipsec_yyset_in \
	-Dyyset_lineno=libipsec_yyset_lineno \
	-Dyyset_out=libipsec_yyset_out

LOCAL_MODULE := libipsec

include $(BUILD_STATIC_LIBRARY)
