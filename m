Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38540893C
	for <lists+linux-api@lfdr.de>; Mon, 13 Sep 2021 12:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbhIMKm0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 13 Sep 2021 06:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20399 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238846AbhIMKmZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 06:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631529669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ryXldKXp5w2qrYfIRmnB0eY0iF5R48B4/QR1QYkEKSY=;
        b=X2h+lMHsHwCg3NMLXqSVSzG69JXaSUh7Zjgp5jlq5SBK5xOE1t+5tkTsS8OdOZ560L6prk
        jQuk0WUdVNlAxqYTuWKPw9ezyabNsDcOtmt7W99xLsJ72u7jshf9brj7l0jd5Ax6IQcycL
        g16b8E8Tn/1FEDCCY+99Rtxum9Fez0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-iyDlqZ8AMlGLjVZRSDBeBA-1; Mon, 13 Sep 2021 06:41:08 -0400
X-MC-Unique: iyDlqZ8AMlGLjVZRSDBeBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A43C480292A;
        Mon, 13 Sep 2021 10:41:06 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB9311036B24;
        Mon, 13 Sep 2021 10:41:04 +0000 (UTC)
Date:   Mon, 13 Sep 2021 12:41:01 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Dmitry V. Levin" <ldv@strace.io>, linux-api@vger.kernel.org
Subject: [PATCH v2] io-wq: expose IO_WQ_ACCT_* enumeration items to UAPI
Message-ID: <20210913104101.GA29616@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

These are used to index elements in the argument
of IORING_REGISTER_IOWQ_MAX_WORKERS io_uring_register command,
so they are to be exposed in UAPI.

Complements: 2e480058ddc21ec5 ("io-wq: provide a way to limit max number of workers")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
v2:
 - IO_WQ_ACCT_NR is no longer exposed directly in UAPI, per Jens Axboe's
   suggestion.

v1: https://lore.kernel.org/lkml/20210912122411.GA27679@asgard.redhat.com/
---
 fs/io-wq.c                    | 5 ++---
 include/uapi/linux/io_uring.h | 8 ++++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 6c55362..eb5162d 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -14,6 +14,7 @@
 #include <linux/rculist_nulls.h>
 #include <linux/cpu.h>
 #include <linux/tracehook.h>
+#include <uapi/linux/io_uring.h>
 
 #include "io-wq.h"
 
@@ -78,9 +79,7 @@ struct io_wqe_acct {
 };
 
 enum {
-	IO_WQ_ACCT_BOUND,
-	IO_WQ_ACCT_UNBOUND,
-	IO_WQ_ACCT_NR,
+	IO_WQ_ACCT_NR = __IO_WQ_ACCT_MAX
 };
 
 /*
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 59ef351..dae1841 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -324,6 +324,14 @@ enum {
 	IORING_REGISTER_LAST
 };
 
+/* io-wq worker limit categories */
+enum {
+	IO_WQ_ACCT_BOUND,
+	IO_WQ_ACCT_UNBOUND,
+
+	__IO_WQ_ACCT_MAX /* Non-UAPI */
+};
+
 /* deprecated, see struct io_uring_rsrc_update */
 struct io_uring_files_update {
 	__u32 offset;
-- 
2.1.4

