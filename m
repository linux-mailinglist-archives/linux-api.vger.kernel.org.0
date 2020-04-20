Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF381B1304
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 19:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTRac (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 13:30:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTRab (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 Apr 2020 13:30:31 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573C520782;
        Mon, 20 Apr 2020 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587403831;
        bh=WJI0iLfDsytzXcwanqGsflVdhW1CScnnDHgpeUZuVRc=;
        h=From:To:Cc:Subject:Date:From;
        b=eMzXdyGJCECydOrsTRmLVZPCtkcGTNjT3cKOddec8xU0idn1+l802im22eRVe3KkN
         6TyKXjzeT3OIURok6NEh/XQqrpqG4Jj52euu5GiicrNYo78HqFOTh3lZO0vMRjM2Xi
         XtJfs6xiBSrMymwsRHycyZ37qTi/6N6M+9XC37UE=
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, andres@anarazel.de, dhowells@redhat.com,
        willy@infradead.org, hch@infradead.org, jack@suse.cz,
        david@fromorbit.com, linux-kernel@vger.kernel.org
Subject: [RFC man-pages PATCH] sync.2: add details about new syncfs() behavior
Date:   Mon, 20 Apr 2020 13:30:29 -0400
Message-Id: <20200420173029.31627-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

syncfs() now also returns errors if writeback fails.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/sync.2 | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

This patch shouldn't be merged until the relevant kernel patch series
has been merge. I'm hoping to get this into v5.8:

    [PATCH v6 0/2] vfs: have syncfs() return error when there are writeback errors

diff --git a/man2/sync.2 b/man2/sync.2
index 7198f3311b05..a025080713ed 100644
--- a/man2/sync.2
+++ b/man2/sync.2
@@ -86,11 +86,26 @@ to indicate the error.
 is always successful.
 .PP
 .BR syncfs ()
-can fail for at least the following reason:
+can fail for at least the following reasons:
 .TP
 .B EBADF
 .I fd
 is not a valid file descriptor.
+.TP
+.B EIO
+An error occurred during synchronization.
+This error may relate to data written to any file on the filesystem, or on
+metadata related to the filesytem itself.
+.TP
+.B ENOSPC
+Disk space was exhausted while synchronizing.
+.TP
+.BR ENOSPC ", " EDQUOT
+Data was written to a files on NFS or another filesystem which does not
+allocate space at the time of a
+.BR write (2)
+system call, and some previous write failed due to insufficient
+storage space.
 .SH VERSIONS
 .BR syncfs ()
 first appeared in Linux 2.6.39;
@@ -121,6 +136,13 @@ or
 .BR syncfs ()
 provide the same guarantees as fsync called on every file in
 the system or filesystem respectively.
+.PP
+In mainline kernel versions prior to 5.8,
+.\" commit <<< TBD >>>
+.BR syncfs ()
+will only fail with EBADF when passed a bad file descriptor. In 5.8
+and later kernels, it will also report an error if one or more inodes failed
+to be written back since the last syncfs call.
 .SH BUGS
 Before version 1.3.20 Linux did not wait for I/O to complete
 before returning.
-- 
2.25.3

