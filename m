Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A23C1BABEB
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD0SEv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:04:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:54566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbgD0SEu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 14:04:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE33AAD4F;
        Mon, 27 Apr 2020 18:04:47 +0000 (UTC)
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
Subject: [PATCH v3 4/5] tools/testing/selftests/sysctl/sysctl.sh: support CONFIG_TEST_SYSCTL=y
Date:   Mon, 27 Apr 2020 20:04:32 +0200
Message-Id: <20200427180433.7029-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200427180433.7029-1-vbabka@suse.cz>
References: <20200427180433.7029-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The testing script recommends CONFIG_TEST_SYSCTL=y, but actually only works
with CONFIG_TEST_SYSCTL=m. Testing of sysctl setting via boot param however
requires the test to be built-in, so make sure the test script supports it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 6a970b127c9b..ce1eeea6f769 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -42,7 +42,7 @@ ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
 
 test_modprobe()
 {
-       if [ ! -d $DIR ]; then
+       if [ ! -d $SYSCTL ]; then
                echo "$0: $DIR not present" >&2
                echo "You must have the following enabled in your kernel:" >&2
                cat $TEST_DIR/config >&2
@@ -122,9 +122,9 @@ test_reqs()
 
 function load_req_mod()
 {
-	if [ ! -d $DIR ]; then
+	if [ ! -d $DIR -a ! -d $SYSCTL ]; then
 		if ! modprobe -q -n $TEST_DRIVER; then
-			echo "$0: module $TEST_DRIVER not found [SKIP]"
+			echo "$0: module $TEST_DRIVER not found and not built-in [SKIP]"
 			exit $ksft_skip
 		fi
 		modprobe $TEST_DRIVER
-- 
2.26.0

