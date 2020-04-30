Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B851BF11A
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD3HRD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:17:03 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50530 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgD3HRC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wEu2MHGpZXHBHgWEZNtRrE0Tvpcfg9woRIfVH+4jvjA=; b=IGOdHg1B5M8gQzJ9Gc1ObdNvXq
        XraWODptMLddHowl7LclpbsprkWJLszY//F8eI8t+gHra5V/SRSRSz2Gvr9a0ybG+H94HvY0/4ktV
        67CbCpLA7GCzm5pMhusV23/aP8ofZEOVTEmFGuagb7M9bOfwLd1uDO1Tv9YREUCKuwkzWmzCM8xud
        uLkJR7lIpaQwF+s0fnZG+j51D1uIpVb81QyyWLOMg2sHXvE8ZM+DqAWCnpdLyc1Ep8kRwrJ905OJE
        tdCWThehDMtVtQmcdvr+jOX8zORvARqlsVvRIA8TQlQvvzxJglF0oWPMZ823RijLZb1Cn2kAdtIlb
        eVStw2Xw==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2uu-000B4I-K9; Thu, 30 Apr 2020 09:43:29 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:42:56 +0300
Message-Id: <20200430064301.1099452-3-ar@cs.msu.ru>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430064301.1099452-1-ar@cs.msu.ru>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: [PATCH v3 2/7] tty: termios: Reserve space for VSTATUS in .c_cc
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

There was no architecture we had to increase NCCS on,
so the size of struct termios did not change.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/alpha/include/asm/termios.h         | 4 ++--
 arch/alpha/include/uapi/asm/termbits.h   | 1 +
 arch/ia64/include/asm/termios.h          | 4 ++--
 arch/ia64/include/uapi/asm/termbits.h    | 1 +
 arch/mips/include/asm/termios.h          | 4 ++--
 arch/mips/include/uapi/asm/termbits.h    | 1 +
 arch/parisc/include/asm/termios.h        | 4 ++--
 arch/parisc/include/uapi/asm/termbits.h  | 1 +
 arch/powerpc/include/asm/termios.h       | 4 ++--
 arch/powerpc/include/uapi/asm/termbits.h | 1 +
 arch/s390/include/asm/termios.h          | 4 ++--
 arch/sparc/include/asm/termios.h         | 4 ++--
 arch/sparc/include/uapi/asm/termbits.h   | 1 +
 arch/xtensa/include/uapi/asm/termbits.h  | 1 +
 include/asm-generic/termios.h            | 4 ++--
 include/uapi/asm-generic/termbits.h      | 1 +
 16 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/alpha/include/asm/termios.h b/arch/alpha/include/asm/termios.h
index b7c77bb1b..0bf32d1af 100644
--- a/arch/alpha/include/asm/termios.h
+++ b/arch/alpha/include/asm/termios.h
@@ -8,9 +8,9 @@
 	werase=^W	kill=^U		reprint=^R	sxtc=\0
 	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
 	start=^Q	stop=^S		lnext=^V	discard=^U
-	vmin=\1		vtime=\0
+	vmin=\1		vtime=\0	status=^T
 */
-#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
+#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index 4575ba34a..bb895d467 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -70,6 +70,7 @@ struct ktermios {
 #define VDISCARD 15
 #define VMIN 16
 #define VTIME 17
+#define VSTATUS 18
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 589c02644..b262e010b 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -15,9 +15,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/ia64/include/uapi/asm/termbits.h b/arch/ia64/include/uapi/asm/termbits.h
index 000a1a297..86898e4c5 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -67,6 +67,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index bc29eeacc..9086e4f64 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -17,9 +17,9 @@
  *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
  *	start=^Q	stop=^S		susp=^Z		vdsusp=
  *	reprint=^R	discard=^U	werase=^W	lnext=^V
- *	eof=^D		eol=\0
+ *	eof=^D		eol=\0		status=^T
  */
-#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
+#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0\024"
 
 #include <linux/string.h>
 
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index dfeffba72..3dd60924f 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -78,6 +78,7 @@ struct ktermios {
 #define VLNEXT		15		/* Literal-next character [IEXTEN].  */
 #define VEOF		16		/* End-of-file character [ICANON].  */
 #define VEOL		17		/* End-of-line character [ICANON].  */
+#define VSTATUS		18		/* Status request character [ISIG]. */
 
 /* c_iflag bits */
 #define IGNBRK	0000001		/* Ignore break condition.  */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index cded9dc90..37828b15a 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -9,9 +9,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index 40e920f8d..ecca3b7d0 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 
 /* c_iflag bits */
diff --git a/arch/powerpc/include/asm/termios.h b/arch/powerpc/include/asm/termios.h
index 205de8f8a..263707fc3 100644
--- a/arch/powerpc/include/asm/termios.h
+++ b/arch/powerpc/include/asm/termios.h
@@ -10,8 +10,8 @@
 
 #include <uapi/asm/termios.h>
 
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
+/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  ^T  */
+#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025\024"
 
 #include <asm-generic/termios-base.h>
 
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index ed18bc61f..c85e98d75 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -62,6 +62,7 @@ struct ktermios {
 #define VSTOP		14
 #define VLNEXT		15
 #define VDISCARD	16
+#define VSTATUS		17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 46fa3020b..c84e49ed7 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -14,9 +14,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 #define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
 #define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
diff --git a/arch/sparc/include/asm/termios.h b/arch/sparc/include/asm/termios.h
index 4a558efdf..249c95cf2 100644
--- a/arch/sparc/include/asm/termios.h
+++ b/arch/sparc/include/asm/termios.h
@@ -20,9 +20,9 @@
 	eof=^D		eol=\0		eol2=\0		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		dsusp=^Y
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	vmin=\1         vtime=\0
+	vmin=\1		vtime=\0	status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
+#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001\000\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f..a1638c9cd 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -80,6 +80,7 @@ struct ktermios {
 #define VDISCARD 13
 #define VWERASE  14
 #define VLNEXT   15
+#define VSTATUS  16
 
 /* Kernel keeps vmin/vtime separated, user apps assume vmin/vtime is
  * shared with eof/eol
diff --git a/arch/xtensa/include/uapi/asm/termbits.h b/arch/xtensa/include/uapi/asm/termbits.h
index d4206a7c5..77969cb27 100644
--- a/arch/xtensa/include/uapi/asm/termbits.h
+++ b/arch/xtensa/include/uapi/asm/termbits.h
@@ -72,6 +72,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index b1398d0d4..06fbfb87c 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -10,9 +10,9 @@
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
+	eol2=\0		status=^T
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0\024"
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae8..11bb142ba 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -58,6 +58,7 @@ struct ktermios {
 #define VWERASE 14
 #define VLNEXT 15
 #define VEOL2 16
+#define VSTATUS 17
 
 /* c_iflag bits */
 #define IGNBRK	0000001
-- 
2.26.2

