Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6C51BABEE
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgD0SEx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:04:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:54722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgD0SEx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 14:04:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A6F9AAD5D;
        Mon, 27 Apr 2020 18:04:48 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot parameter
Date:   Mon, 27 Apr 2020 20:04:33 +0200
Message-Id: <20200427180433.7029-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200427180433.7029-1-vbabka@suse.cz>
References: <20200427180433.7029-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Testing is done by a new parameter debug.test_sysctl.boot_int which defaults to
0 and it's expected that the tester passes a boot parameter that sets it to 1.
The test checks if it's set to 1. To distinguish true failure from parameter
not being set, the test checks /proc/cmdline for the expected parameter, and
whether test_sysctl is built-in and not a module.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/test_sysctl.c                        | 13 +++++++++
 tools/testing/selftests/sysctl/sysctl.sh | 36 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 566dad3f4196..84eaae22d3a6 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -44,6 +44,8 @@ struct test_sysctl_data {
 	int int_0002;
 	int int_0003[4];
 
+	int boot_int;
+
 	unsigned int uint_0001;
 
 	char string_0001[65];
@@ -61,6 +63,8 @@ static struct test_sysctl_data test_data = {
 	.int_0003[2] = 2,
 	.int_0003[3] = 3,
 
+	.boot_int = 0,
+
 	.uint_0001 = 314,
 
 	.string_0001 = "(none)",
@@ -91,6 +95,15 @@ static struct ctl_table test_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "boot_int",
+		.data		= &test_data.boot_int,
+		.maxlen		= sizeof(test_data.boot_int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+		.extra1		= SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
 	{
 		.procname	= "uint_0001",
 		.data		= &test_data.uint_0001,
diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index ce1eeea6f769..ef6417b8067b 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -39,6 +39,7 @@ ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
 ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
 ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
 ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
+ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int"
 
 test_modprobe()
 {
@@ -752,6 +753,40 @@ sysctl_test_0006()
 	run_bitmaptest
 }
 
+sysctl_test_0007()
+{
+	TARGET="${SYSCTL}/boot_int"
+	if [ -d $DIR ]; then
+		echo "Boot param test only possible sysctl_test is built-in, not module:"
+		cat $TEST_DIR/config >&2
+		return 0
+	fi
+
+	echo -n "Testing if $TARGET is set to 1 ..."
+	ORIG=$(cat "${TARGET}")
+
+	if [ x$ORIG = "x1" ]; then
+		echo "ok"
+		return 0
+	fi
+	echo "FAIL"
+	echo "Checking if /proc/cmdline contains setting of the expected parameter ..."
+	if [ ! -f /proc/cmdline ]; then
+		echo "/proc/cmdline does not exist, test inconclusive"
+		return 0
+	fi
+
+	FOUND=$(grep -c "sysctl[./]debug[./]test_sysctl[./]boot_int=1" /proc/cmdline)
+	if [ $FOUND = "1" ]; then
+		echo "Kernel param found but $TARGET is not 1, TEST FAILED"
+		rc=1
+		test_rc
+	fi
+
+	echo "Skipping test, expected kernel parameter missing."
+	echo "To perform this test, make sure kernel is booted with parameter: sysctl.debug.test_sysctl.boot_int=1"
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -766,6 +801,7 @@ list_tests()
 	echo "0004 x $(get_test_count 0004) - tests proc_douintvec()"
 	echo "0005 x $(get_test_count 0005) - tests proc_douintvec() array"
 	echo "0006 x $(get_test_count 0006) - tests proc_do_large_bitmap()"
+	echo "0007 x $(get_test_count 0007) - tests setting sysctl from kernel boot param"
 }
 
 usage()
-- 
2.26.0

