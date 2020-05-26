Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B961C5B3B
	for <lists+linux-api@lfdr.de>; Tue,  5 May 2020 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgEEPcY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 May 2020 11:32:24 -0400
Received: from smtp-42a9.mail.infomaniak.ch ([84.16.66.169]:56689 "EHLO
        smtp-42a9.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729774AbgEEPcX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 May 2020 11:32:23 -0400
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49GkHT2wK6zlhjXL;
        Tue,  5 May 2020 17:32:21 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 49GkHS4fpxzlsV54;
        Tue,  5 May 2020 17:32:20 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 2/6] fs: Add a MAY_EXECMOUNT flag to infer the noexec mount property
Date:   Tue,  5 May 2020 17:31:52 +0200
Message-Id: <20200505153156.925111-3-mic@digikod.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200505153156.925111-1-mic@digikod.net>
References: <20200505153156.925111-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This new MAY_EXECMOUNT flag enables to check if the underlying mount
point of an inode is marked as executable.  This is useful to implement
a security policy taking advantage of the noexec mount option.

This flag is set according to path_noexec(), which checks if a mount
point is mounted with MNT_NOEXEC or if the underlying superblock is
SB_I_NOEXEC.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
---
 fs/namei.c         | 2 ++
 include/linux/fs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..33b6d372e74a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2849,6 +2849,8 @@ static int may_open(const struct path *path, int acc_mode, int flag)
 		break;
 	}
 
+	/* Pass the mount point executability. */
+	acc_mode |= path_noexec(path) ? 0 : MAY_EXECMOUNT;
 	error = inode_permission(inode, MAY_OPEN | acc_mode);
 	if (error)
 		return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 313c934de9ee..79435fca6c3e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -103,6 +103,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define MAY_NOT_BLOCK		0x00000080
 /* the inode is opened with O_MAYEXEC */
 #define MAY_OPENEXEC		0x00000100
+/* the mount point is marked as executable */
+#define MAY_EXECMOUNT		0x00000200
 
 /*
  * flags in file.f_mode.  Note that FMODE_READ and FMODE_WRITE must correspond
-- 
2.26.2

