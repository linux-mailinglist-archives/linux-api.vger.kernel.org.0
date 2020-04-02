Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE0219BA2A
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 04:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgDBCI6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Apr 2020 22:08:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34067 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732664AbgDBCI5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Apr 2020 22:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585793336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NGxb4KbOdVnje8SH5r05o0FovpXNfX4tJUxf9c8+z8A=;
        b=STSuDa5kW2Mr2UMyuwiSTvB3bY0az6yl4/0u2cJEqKb89ZL+bC2iwxovEw+RcVyLaJco8y
        9eCCb8yLIDkMVppkjoX2p+zStIdAnZ7r8FPcl/D1LecPQWFhUVY3qo2U1/v340RFVYIxpo
        IYHw67HYbbmTBAzhJ3b9uEl0JD4nsNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-5-PlgDZeOnGpLK-prH8K6g-1; Wed, 01 Apr 2020 22:08:54 -0400
X-MC-Unique: 5-PlgDZeOnGpLK-prH8K6g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34AF31416;
        Thu,  2 Apr 2020 02:08:53 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-112-7.rdu2.redhat.com [10.10.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAE966106C;
        Thu,  2 Apr 2020 02:08:51 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     linux-api@vger.kernel.org, david@fromorbit.com, mhocko@suse.com,
        masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
Date:   Wed,  1 Apr 2020 21:08:50 -0500
Message-Id: <20200402020850.7218-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

V4:
- Remove internal details.
- Add CAP_SYS_RESOURCE requirement info.

V3:
- Replace emulation device example.

V2:
- My initial patch for this was very bad. This version is almost 100%
taken word for word from Dave Chinner's review comments.

Signed-off-by: Mike Christie <mchristi@redhat.com>

 man2/prctl.2 | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/man2/prctl.2 b/man2/prctl.2
index 720ec04e4..3c3355439 100644
--- a/man2/prctl.2
+++ b/man2/prctl.2
@@ -1381,6 +1381,31 @@ system call on Tru64).
 for information on versions and architectures.)
 Return unaligned access control bits, in the location pointed to by
 .IR "(unsigned int\ *) arg2" .
+.TP
+.B PR_SET_IO_FLUSHER (Since Linux 5.6)
+If a user process is involved in the block layer or file system IO path,
+and can allocate memory while processing IO requests it must set
+\fIarg2\fP to 1. This will put the process in the IO_FLUSHER state which
+allows it special treatment to make progress when allocating memory.
+If \fIarg2\fP is 0, the process will clear the IO_FLUSHER state, and
+the default behavior will be used.
+
+The calling process must have the
+.BR CAP_SYS_RESOURCE
+capability.
+
+Examples of IO_FLUSHER applications are FUSE daemons, SCSI device
+emulation daemons, and daemons that perform error handling like multipat=
h
+path recovery applications.
+
+.TP
+.B PR_GET_IO_FLUSHER (Since Linux 5.6)
+Return as the function result 1 if the caller is in the IO_FLUSHER state=
 and
+0 if not.
+
+The calling process must have the
+.BR CAP_SYS_RESOURCE
+capability.
 .SH RETURN VALUE
 On success,
 .BR PR_GET_DUMPABLE ,
@@ -1395,6 +1420,7 @@ On success,
 .BR PR_GET_SPECULATION_CTRL ,
 .BR PR_MCE_KILL_GET ,
 .BR PR_CAP_AMBIENT + PR_CAP_AMBIENT_IS_SET ,
+.BR PR_GET_IO_FLUSHER ,
 and (if it returns)
 .BR PR_GET_SECCOMP
 return the nonnegative values described above.
--=20
2.21.0

