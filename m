Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9B6158559
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 23:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgBJWQJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 17:16:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbgBJWQJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 17:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581372968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y3QmGs0AudfBgpKOomjJJYC+E6DRgewnTxmOMOi3mmk=;
        b=cOKMiE4tLbZM50ZksJ8D/URdItPHVrgQE8YPr2iCgFwuBx9VzZnX77NqMK6Q3pYLlFRUzD
        cty/kJ9lsgrTp/fO3+N+MvfglJsgvB0Qykij7SwmRjELuGPxneVG8SUZ0e3ZzODiRsg2G6
        16b9J2ZfocCWnt7GAQa9mRb7BUyjPeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-r0L2aM3UPOezctFIkJv-5A-1; Mon, 10 Feb 2020 17:16:04 -0500
X-MC-Unique: r0L2aM3UPOezctFIkJv-5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60D13800D41;
        Mon, 10 Feb 2020 22:16:02 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-145.rdu2.redhat.com [10.10.122.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 269235D9CA;
        Mon, 10 Feb 2020 22:16:01 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, christian.brauner@ubuntu.com,
        bvanassche@acm.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Date:   Mon, 10 Feb 2020 16:15:57 -0600
Message-Id: <20200210221557.8021-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
prctl commands added to the linux kernel for 5.6 in commit:

commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
Author: Mike Christie <mchristi@redhat.com>
Date:   Mon Nov 11 18:19:00 2019 -0600

    prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim

Signed-off-by: Mike Christie <mchristi@redhat.com>
---

V2:
- My initial patch for this was very bad. This version is almost 100%
taken word for word from Dave Chinner's review comments.


 man2/prctl.2 | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 720ec04e4..b481d186b 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1381,6 +1381,30 @@ system call on Tru64).
 for information on versions and architectures.)
 Return unaligned access control bits, in the location pointed to by
 .IR "(unsigned int\ *) arg2" .
+.TP
+.B PR_SET_IO_FLUSHER (Since Linux 5.6)
+An IO_FLUSHER is a user process that the kernel uses to issue IO
+that cleans dirty page cache data and/or filesystem metadata. The
+kernel may need to clean this memory when under memory pressure in
+order to free it. This means there is potential for a memory reclaim
+recursion deadlock if the user process attempts to allocate memory
+and the kernel then blocks waiting for it to clean memory before it
+can make reclaim progress.
+
+The kernel avoids these recursion problems internally via a special
+process state that prevents recursive reclaim from issuing new IO.
+If \fIarg2\fP is 1, the \fPPR_SET_IO_FLUSHER\fP control allows a userspa=
ce
+process to set up this same process state and hence avoid the memory
+reclaim recursion deadlocks in the same manner the kernel avoids them.
+If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and the
+default behavior will be used.
+
+Examples of IO_FLUSHER applications are FUSE daemons, zoned disk
+emulation daemons, etc."
+.TP
+.B PR_GET_IO_FLUSHER (Since Linux 5.6)
+Return as the function result 1 if the caller is in the IO_FLUSHER state=
 and
+0 if not.
 .SH RETURN VALUE
 On success,
 .BR PR_GET_DUMPABLE ,
@@ -1395,6 +1419,7 @@ On success,
 .BR PR_GET_SPECULATION_CTRL ,
 .BR PR_MCE_KILL_GET ,
 .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
+.BR PR_GET_IO_FLUSHER ,
 and (if it returns)
 .BR PR_GET_SECCOMP
 return the nonnegative values described above.
--=20
2.21.0

