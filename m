Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE314C7BA
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 09:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2I6r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 03:58:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33271 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgA2I6r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 03:58:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so6222260plb.0
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLcRmbaGlZdT/dpZlJUmvZno5pRafmsAvk974Kpo0hg=;
        b=mb8cBEpA3kSfsTu7exv1MCGJUeyN+lfxZAD3Efx9bUHCoXR5j1OU27+equvmQZ9rmt
         8N/lTHAPHbVQK/hAFvhEzXu/aJXwAoqlmsNpD9k3k7sb2ERFPLinACzP9tizVbQcAhvO
         WE/Yl0Va4oA8QYdm9rOz6VHRuai/8H8PVHvwVmmsSIxqy1d43j3j6+0CWH6sZbhB9J5l
         b8A44RQ5DHymlJTJrQxfFvydpsZbBvrU43SLfmzSG/hoUSiRZqy33mWqZ09DqZxmpcWD
         5O6tVbDMRhDI0c+Rm9dloMIVYBBk9qZfX9YehjEQm/z54Sn1WhQIFmn8JhbqQ6RSAAvj
         FGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLcRmbaGlZdT/dpZlJUmvZno5pRafmsAvk974Kpo0hg=;
        b=aMCE943U2CtI3g+FCVWy/rUc6J0IgII2gvbshZy/R+MJC1QiFAi0lGuEwuRU2JI8gx
         K2iD/QVZWHF858vLrbk+DW5hNGOwqWGQbsFrPvVVGy4DMgRiYt7RB0FBv+BQpRhUMGd7
         P4xdr4GkNhejHhsG2mX4AgoMP6plT2Sdtk4lczrO9SOiS2tD9ssKFS0o0cbKR2fbQNhB
         u7F0d/x2XA3CtCJk0XnqMiE5WyL2SiYga/zNA8BBI+2eM9DHGvW5V22JqYWiEoOSH4rA
         Nc5NC0es1iG8i1X+CbHfGQnaGo8qzN1C0KKgGHRsWspL3jNI94a+5lYGq8ZvNCTBVUqY
         T9wQ==
X-Gm-Message-State: APjAAAXQiK2PqgvEvDqDUj23pcnKyCxsvsnfpoMq0/qsv1umentbN46O
        F3HbuJ+kEmtURkeCPpGinekG1w==
X-Google-Smtp-Source: APXvYqx4RDyNcm34fCJVlHIU8RNGSRM4h3hd0We3221K6tQ+fvfAEkwzIsyZ0cETIXBDLKQPcLf8ww==
X-Received: by 2002:a17:902:a514:: with SMTP id s20mr26765805plq.300.1580288326418;
        Wed, 29 Jan 2020 00:58:46 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s131sm1935932pfs.135.2020.01.29.00.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:58:45 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH xfsprogs] xfs_io: add support for linkat() AT_LINK_REPLACE
Date:   Wed, 29 Jan 2020 00:58:29 -0800
Message-Id: <ff4b873f356ed8ff63ee582bc57c4babea947159.1580253398.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 io/link.c         | 24 ++++++++++++++++++++----
 man/man8/xfs_io.8 |  9 ++++++++-
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/io/link.c b/io/link.c
index f4f4b139..3fc3e24d 100644
--- a/io/link.c
+++ b/io/link.c
@@ -12,6 +12,9 @@
 #ifndef AT_EMPTY_PATH
 #define AT_EMPTY_PATH	0x1000
 #endif
+#ifndef AT_LINK_REPLACE
+#define AT_LINK_REPLACE	0x10000
+#endif
 
 static cmdinfo_t flink_cmd;
 
@@ -22,6 +25,7 @@ flink_help(void)
 "\n"
 "link the open file descriptor to the supplied filename\n"
 "\n"
+" -f -- overwrite the target filename if it exists (AT_LINK_REPLACE)\n"
 "\n"));
 }
 
@@ -30,10 +34,22 @@ flink_f(
 	int		argc,
 	char		**argv)
 {
-	if (argc != 2)
+	int		flags = AT_EMPTY_PATH;
+	int		c;
+
+	while ((c = getopt(argc, argv, "f")) != EOF) {
+		switch (c) {
+		case 'f':
+			flags |= AT_LINK_REPLACE;
+			break;
+		default:
+			return command_usage(&flink_cmd);
+		}
+	}
+	if (optind != argc - 1)
 		return command_usage(&flink_cmd);
 
-	if (linkat(file->fd, "", AT_FDCWD, argv[1], AT_EMPTY_PATH) < 0) {
+	if (linkat(file->fd, "", AT_FDCWD, argv[optind], flags) < 0) {
 		perror("flink");
 		return 0;
 	}
@@ -46,9 +62,9 @@ flink_init(void)
 	flink_cmd.name = "flink";
 	flink_cmd.cfunc = flink_f;
 	flink_cmd.argmin = 1;
-	flink_cmd.argmax = 1;
+	flink_cmd.argmax = -1;
 	flink_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK | CMD_FLAG_ONESHOT;
-	flink_cmd.args = _("filename");
+	flink_cmd.args = _("[-f] filename");
 	flink_cmd.oneline =
 		_("link the open file descriptor to the supplied filename");
 	flink_cmd.help = flink_help;
diff --git a/man/man8/xfs_io.8 b/man/man8/xfs_io.8
index c69b295d..f79b3a59 100644
--- a/man/man8/xfs_io.8
+++ b/man/man8/xfs_io.8
@@ -807,8 +807,15 @@ for the full list) is available via the
 .B help
 command.
 .TP
-.BI "flink " path
+.BI "flink [ \-f ]" " path"
 Link the currently open file descriptor into the filesystem namespace.
+.RS 1.0i
+.PD 0
+.TP 0.4i
+.B \-f
+overwrite the target path if it exists (AT_LINK_REPLACE).
+.PD
+.RE
 .TP
 .BR stat " [ " \-v "|" \-r " ]"
 Selected statistics from
-- 
2.25.0

