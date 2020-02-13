Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A275215CA46
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 19:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBMSXs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Feb 2020 13:23:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52834 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727794AbgBMSXr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Feb 2020 13:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581618226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sL+DW+Qou8gFBnFUuqeHRjFrg1OvX1TRw9IHCYgSbn8=;
        b=Jwwx6tzTlDXdfwG+QkiYsVKYAqTfXDAdVmfBCyHywVxks7404ZRXNl3AcRMV1ZVLFTULkv
        LgHXm/x11Mu8L6XKE97qjMclVFkQRLc/eZc7VVMF+F1u2C7D0J35F5kMKMvomwXgrg03iI
        1Ly80P0wIrpuSGl4uQhtrL412/BuKFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-V232OndTO-2filxhqalAug-1; Thu, 13 Feb 2020 13:23:42 -0500
X-MC-Unique: V232OndTO-2filxhqalAug-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BF0E13E4;
        Thu, 13 Feb 2020 18:23:40 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-76.rdu2.redhat.com [10.10.125.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3614910027A9;
        Thu, 13 Feb 2020 18:23:39 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
Date:   Thu, 13 Feb 2020 12:23:36 -0600
Message-Id: <20200213182336.6663-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
---

V3:
- Replace emulation device example.

V2:
- My initial patch for this was very bad. This version is almost 100%
taken word for word from Dave Chinner's review comments.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---
 man2/prctl.2 | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 720ec04e4..58d77bf2e 100644
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
+Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
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

