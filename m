Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5FF389B2C
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 04:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhETCMA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 22:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhETCL7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 22:11:59 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB6C06175F
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:10:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so3265120pjb.4
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jXRaeMBwWGnMv7E5NAjMbGKZ+XEfdegT6fIJyXCOhXg=;
        b=OjnHC5PpLCGsPvBwE8rGr5Q9eeGxwXDB+9Q4PRO2FfYowjs4JMHIVls8o2W/o1k2/F
         okSEmjJnT/JLk3NbIv7sbjQU4/7XfrGn/3kaL2eztGNQn2zOYXIUe86oRYEJQyMLKuMo
         AoFWqeqks0I4ejxXwcCUqwT2DePvK5qZ6dJ1X1Rvvqpns33VXRX3oNoxRvVd1K0/RUhs
         c28JHHTTUZvOwryPkEEYDcvq8fPCr5Mr3v7uDNbFUFm/z+zgneqoHimLfSqHr+AdKJ4p
         bTuTc2jcI/DLIINcczIUdaIX9CG2MShHqvKzKwntWobm6cWLGXhfSAVfGQ/sFvqCcEzN
         4M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXRaeMBwWGnMv7E5NAjMbGKZ+XEfdegT6fIJyXCOhXg=;
        b=R59mXFI2UHrNF0eQTz8kIQH0f+g3eZTNLQyZUmCLWUGgOHkg1TVDziDoaFM8zkCgNL
         vDngyRAN/AVkzVdzRkhMdNF8BhdHctjSeQgbFzwmOcn2vh6IZ3EcB5orqWi+0AlOaqEO
         6N4XoTUWLYou8rbqFZg6LI/Rg6VkoS8rC1H1nv1MH21wM1W19KTjj9bddezppL2rW05v
         pU9hATL+iHnMszM827Xy3pUd6+xGna47QTRRnnEcCCzazzdAP6pQGwXs7q7wvbW9EK/F
         US1Kvg8hdqK0CF2Ko0DxDcdFwyy0mM+qy17zbH0ZH98Wmx5w5juZaijFVP8SGzubckwh
         LS0g==
X-Gm-Message-State: AOAM532SUwgQNS4zdqEaxV8vxtLWiA6MW2MAjXsnmiQ0fs7fuyzBgOCR
        Zkfi9zu2dOp3BJMPKzNH2dgomw==
X-Google-Smtp-Source: ABdhPJx5K8ScL845KbY/kaOoskE8q5+SlCKxICbTZKE1Wm3OnfZb6zcN3FgpvdBkXXPJ3fA0DPR4hQ==
X-Received: by 2002:a17:90a:1b09:: with SMTP id q9mr2553813pjq.108.1621476637780;
        Wed, 19 May 2021 19:10:37 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id 184sm509636pfv.38.2021.05.19.19.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:10:37 -0700 (PDT)
Date:   Thu, 20 May 2021 12:10:26 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 2/5] kernel/pid.c: implement checks on parameters passed to
 pidfd_create()
Message-ID: <13082e9b281e16445da413b23e720b99c8c74f2b.1621473846.git.repnop@google.com>
References: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621473846.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

By adding the pidfd_create() declaration to linux/pid.h, it
effectively exposes this function to the rest of the kernel. As the
function currently stands, any part of the kernel could call
pidfd_create() and the pidfd creation would not be subject to the same
parameter constraints/checks as calling pidfd_open() would force upon
a caller. This could lead to unintended behavior and/or misuse of the
pidfd API.

To mitigate this, the pid_has_task() check is rolled up into
pidfd_create() and flags that are passed as parameter are checked for
validity.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 kernel/pid.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index d3cd95b8b080..1805cb3d74b7 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -559,6 +559,12 @@ int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
+	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+		return -EINVAL;
+
+	if (flags & ~(O_NONBLOCK | O_CLOEXEC | O_RDWR))
+		return -EINVAL;
+
 	fd = anon_inode_getfd("[pidfd]", &pidfd_fops, get_pid(pid),
 			      flags | O_RDWR | O_CLOEXEC);
 	if (fd < 0)
@@ -598,10 +604,7 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	if (!p)
 		return -ESRCH;
 
-	if (pid_has_task(p, PIDTYPE_TGID))
-		fd = pidfd_create(p, flags);
-	else
-		fd = -EINVAL;
+	fd = pidfd_create(p, flags);
 
 	put_pid(p);
 	return fd;
-- 
2.31.1.751.gd2f1c929bd-goog

/M
