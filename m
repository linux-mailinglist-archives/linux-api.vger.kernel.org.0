Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0581BF125
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD3HRU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:17:20 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:50607 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgD3HRU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d5gsmze9MSy69rmeD3h6am3lK1ZyfWmkdrDf0f9ThVY=; b=RsSfrtXSh/jhZorGhaXLXMdS2S
        kAjOh63+iiwV2M+qldTeiI3Sux3siUcTrljExL7Y/YpNP0CQovbehRr7EwMxDgaoJpbXlfZhhMhoH
        12bHIUUJOm439OtujyDUwY2386CDZTLjOS0Jjur7WYL3XUecAYMuxJY+J0doEPRwKIvmJEebfSq/z
        Cr+cygi7i8iZuQ1CS1lXXU/1fIn3o4CrCfwE2yCQz8pJiU8tKtOj9IzoR+TsYd89yClDaiaQVeFeR
        2GvdX9SRct3fZKjVkg/Uga/hIich7NVZ4RhTnS+YoL8dFvJyixbaHA81RAbIdFfB0l3wnAR1D0hpl
        bkdBWBOw==;
Received: from [37.204.119.143] (port=42272 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU2uv-000B4I-MX; Thu, 30 Apr 2020 09:43:29 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Date:   Thu, 30 Apr 2020 09:42:59 +0300
Message-Id: <20200430064301.1099452-6-ar@cs.msu.ru>
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
Subject: [PATCH v3 5/7] tty: Add NOKERNINFO lflag to termios
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The termios lflag is off by default.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/alpha/include/uapi/asm/termbits.h   | 1 +
 arch/ia64/include/uapi/asm/termbits.h    | 1 +
 arch/mips/include/uapi/asm/termbits.h    | 1 +
 arch/parisc/include/uapi/asm/termbits.h  | 1 +
 arch/powerpc/include/uapi/asm/termbits.h | 1 +
 arch/sparc/include/uapi/asm/termbits.h   | 1 +
 arch/xtensa/include/uapi/asm/termbits.h  | 1 +
 include/linux/tty.h                      | 1 +
 include/uapi/asm-generic/termbits.h      | 1 +
 9 files changed, 9 insertions(+)

diff --git a/arch/alpha/include/uapi/asm/termbits.h b/arch/alpha/include/uapi/asm/termbits.h
index bb895d467..850dd8dc4 100644
--- a/arch/alpha/include/uapi/asm/termbits.h
+++ b/arch/alpha/include/uapi/asm/termbits.h
@@ -204,6 +204,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO	0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/ia64/include/uapi/asm/termbits.h b/arch/ia64/include/uapi/asm/termbits.h
index 86898e4c5..f777b99bc 100644
--- a/arch/ia64/include/uapi/asm/termbits.h
+++ b/arch/ia64/include/uapi/asm/termbits.h
@@ -190,6 +190,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/mips/include/uapi/asm/termbits.h b/arch/mips/include/uapi/asm/termbits.h
index 3dd60924f..2755cfd14 100644
--- a/arch/mips/include/uapi/asm/termbits.h
+++ b/arch/mips/include/uapi/asm/termbits.h
@@ -206,6 +206,7 @@ struct ktermios {
 #define TOSTOP	0100000		/* Send SIGTTOU for background output.	*/
 #define ITOSTOP TOSTOP
 #define EXTPROC 0200000		/* External processing on pty */
+#define NOKERNINFO 0400000		/* Disable kernel output from VSTATUS. */
 
 /* ioctl (fd, TIOCSERGETLSR, &result) where result may be as below */
 #define TIOCSER_TEMT	0x01	/* Transmitter physically empty */
diff --git a/arch/parisc/include/uapi/asm/termbits.h b/arch/parisc/include/uapi/asm/termbits.h
index ecca3b7d0..c7ba145ad 100644
--- a/arch/parisc/include/uapi/asm/termbits.h
+++ b/arch/parisc/include/uapi/asm/termbits.h
@@ -183,6 +183,7 @@ struct ktermios {
 #define PENDIN  0040000
 #define IEXTEN  0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
diff --git a/arch/powerpc/include/uapi/asm/termbits.h b/arch/powerpc/include/uapi/asm/termbits.h
index c85e98d75..79dbcc546 100644
--- a/arch/powerpc/include/uapi/asm/termbits.h
+++ b/arch/powerpc/include/uapi/asm/termbits.h
@@ -192,6 +192,7 @@ struct ktermios {
 #define PENDIN	0x20000000
 #define IEXTEN	0x00000400
 #define EXTPROC	0x10000000
+#define NOKERNINFO	0x40000000
 
 /* Values for the ACTION argument to `tcflow'.  */
 #define	TCOOFF		0
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index a1638c9cd..108c039dd 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -225,6 +225,7 @@ struct ktermios {
 #define PENDIN	0x00004000
 #define IEXTEN	0x00008000
 #define EXTPROC	0x00010000
+#define NOKERNINFO	0x00020000
 
 /* modem lines */
 #define TIOCM_LE	0x001
diff --git a/arch/xtensa/include/uapi/asm/termbits.h b/arch/xtensa/include/uapi/asm/termbits.h
index 77969cb27..6155e1c81 100644
--- a/arch/xtensa/include/uapi/asm/termbits.h
+++ b/arch/xtensa/include/uapi/asm/termbits.h
@@ -199,6 +199,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO	0400000
 
 /* tcflow() and TCXONC use these */
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 8411fd18d..cafb9b7f7 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -186,6 +186,7 @@ struct tty_bufhead {
 #define L_PENDIN(tty)	_L_FLAG((tty), PENDIN)
 #define L_IEXTEN(tty)	_L_FLAG((tty), IEXTEN)
 #define L_EXTPROC(tty)	_L_FLAG((tty), EXTPROC)
+#define L_NOKERNINFO(tty)	_L_FLAG((tty), NOKERNINFO)
 
 struct device;
 struct signal_struct;
diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 11bb142ba..6219803d6 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -181,6 +181,7 @@ struct ktermios {
 #define PENDIN	0040000
 #define IEXTEN	0100000
 #define EXTPROC	0200000
+#define NOKERNINFO 0400000
 
 /* tcflow() and TCXONC use these */
 #define	TCOOFF		0
-- 
2.26.2

