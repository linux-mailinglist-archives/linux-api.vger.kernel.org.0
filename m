Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492153A214C
	for <lists+linux-api@lfdr.de>; Thu, 10 Jun 2021 02:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFJAYC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 20:24:02 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:46852 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhFJAYC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 20:24:02 -0400
Received: by mail-pj1-f43.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso2698952pjb.5
        for <linux-api@vger.kernel.org>; Wed, 09 Jun 2021 17:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dib1SF82d2ugxnX9e1Y9lh/2SdszKVIG2CAFliKU5MM=;
        b=KJlfT8PQWkTeqycqiUn8kd1tNCpgcGeuYlgow/0VmmneYFXWxRrBhSir49orAijMOT
         /G9fJ6zI1ARsc6St7PnLP4qFJfnYEmuVOdeQHqxZl7QU9gLknQL4xtXs94EV7kts8ghW
         amCq7YCBdTx+1WEPWr693HAifgFOmACDXoKa9rQ+1F4oX2UVmib9kT/eQFSzAFNICDbc
         80McYiCyN8nTRvnPKcY5tOD8H02xtqe3YFzYFMhrszw4YxEudcM4JfoWBbMIJM6uoTLR
         tNKqf1wK4Jj29JsQQpPpvke2Ptn283YrggdiFj/rlec0vIIVkD2SbXwOrP0+leO45na0
         mFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dib1SF82d2ugxnX9e1Y9lh/2SdszKVIG2CAFliKU5MM=;
        b=EWlO1751O45Wypq7SIrid1ASb41Ihow8yAEjwfnoit/6/9JZ5bYo9mFHHPHf63jSBk
         LC67qt8rTCE01ehF/Df1W2pLhw2P9zcnXWIhxPmDFR0rqLURryAWhgSYmMAqqkdL92Eu
         BqH5iU6kM8ms91o/vOw6IVEmHWC/O4qsg6uImIPmqHE8VdBh+NiT/ROaDqH7R8ILwivP
         94KK3hWFqDsxxcOYih/vBmF6juvsDtFZlyiVVvQDh/1s1Aap1St9r08QXpSXL3236afj
         HosPOfEQJkdhubeQY4vCmmcFQ3Xg1cEz0pO8BY1Sam5cnD1M2Ciy8jgL1fUL4S1Cl9ot
         F5Qw==
X-Gm-Message-State: AOAM533Qm6jgjJzSHTvxj2rcqdezB+BPxF7LJiI5hKNwaDDHjNH5TNKG
        kbdRFHfmIGzoezWlUPxdmTJuqg==
X-Google-Smtp-Source: ABdhPJy+XpQDOooMvyL/xgqDo1mZdu2EoNoDA90IowcQLZ3U70ELxS7iLYPfAQlrF3MFMsw8ag2hHw==
X-Received: by 2002:a17:90a:9a4:: with SMTP id 33mr350721pjo.180.1623284455371;
        Wed, 09 Jun 2021 17:20:55 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:6512:d64a:3615:dcbf])
        by smtp.gmail.com with ESMTPSA id a9sm565442pfo.69.2021.06.09.17.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 17:20:54 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:20:43 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v2 2/5] kernel/pid.c: implement additional checks upon
 pidfd_create() parameters
Message-ID: <3020418a466bc3f4e90413c3c98c29a1a93fd59f.1623282854.git.repnop@google.com>
References: <cover.1623282854.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623282854.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

By adding the pidfd_create() declaration to linux/pid.h, we
effectively expose this function to the rest of the kernel. In order
to avoid any unintended behaviour, or set false expectations upon this
function, ensure that constraints are forced upon each of the passed
parameters. This includes the checking of whether the passed struct
pid is a thread-group leader as pidfd creation is currently limited to
such pid types.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 kernel/pid.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index d3cd95b8b080..efe87db44683 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -559,6 +559,12 @@ int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
+	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
+		return -EINVAL;
+
+	if (flags & ~(O_NONBLOCK | O_RDWR | O_CLOEXEC))
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
2.30.2

/M
