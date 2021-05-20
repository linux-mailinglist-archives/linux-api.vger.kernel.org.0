Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9855389B2A
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 04:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhETCLj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 May 2021 22:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETCLj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 May 2021 22:11:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F10C061574
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:10:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f22so2866418pfn.0
        for <linux-api@vger.kernel.org>; Wed, 19 May 2021 19:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xULRjnWWDqsegSY4kRGGTEodocrGiVu00jzVeuMoXTQ=;
        b=SmqrkK3UEaVUWlrMDYrA22X2n+X5sYu8BmTgdATZvtLOcKEaF/ZEw/AiPSoDFb9oXV
         LOU/V+qcAJtOYA4JOsc66+5z2JqruDlQ/yKmS0Zhzpwy/91uoAsS5RTrkUHk/zeNCQdy
         5CxxNXQi6XuyRe76NtHA0kiCxhhgkUtgonWaiOJoNf8PZ74sWgd+G29Z+LxeDNx7xxGw
         e7uj3VO8Oiq07z5D+yDFrxEpTHds9GybvcBT7AtG8kiL76JUpfN8JR451vuWkEC8KBjB
         vJ+JpXWQaOXeqnoaAgk3wMwdBPSK1FuvxvDBFNN3FZB+gnt5YYQIXnwjgDYbVtmLrJJ2
         WmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xULRjnWWDqsegSY4kRGGTEodocrGiVu00jzVeuMoXTQ=;
        b=n5Wu4IqKPlQ3SJXidgjBZpC6fGpief2EuvJQ/7moq04lHXUbsL44/lVKt5ObQYDH31
         ANtF0jFqdxWzmGouXd0TQnO3FaRmko33LAY7Q7fLX9BoYBNezaU2+3ytmOcE5JNP2IwN
         WMqWtmi6ghPDLWvEkQv1h4yvn0XK0PRZIlZE7LIHefS0ElY1f71mOf5i00cDFBXtj80e
         WSKFU/hYnP8G4I/dBiQdL6u3RFNAnGHrxdO9iWRxml8z7D+yiO5I2gDtYPrffNJCdR4d
         Ym5e6s2Uwny9cd7Sl9Hy96rQgUp0SxnO2n+mubl7et7IQmVFyJLu0Ce+vMKRS4TuzvFQ
         1I8Q==
X-Gm-Message-State: AOAM533Zv1QrhljIQWdFeBU80kGLjj493YrUZlT12xvN5RuObV+6KtN2
        epn4L70M9GiLeQhYSa9BzOMRow==
X-Google-Smtp-Source: ABdhPJzq3RIf9QS+oglZKbDy/APEV4VXup541UNeEob4yeLVTW/UzV2Gj2DPJ1yHPLCEkDqgjQTVBA==
X-Received: by 2002:a63:b211:: with SMTP id x17mr2160504pge.106.1621476617986;
        Wed, 19 May 2021 19:10:17 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c035:b02d:975d:1161])
        by smtp.gmail.com with ESMTPSA id y17sm494012pfb.183.2021.05.19.19.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 19:10:17 -0700 (PDT)
Date:   Thu, 20 May 2021 12:10:04 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 1/5] kernel/pid.c: remove static qualifier from pidfd_create()
Message-ID: <d58484824a9d826c7fc5adf5488439d9bc23e932.1621473846.git.repnop@google.com>
References: <cover.1621473846.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1621473846.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

With the idea of returning pidfds from the fanotify API, there needs
to be mechanism exposed for creating pidfds. To do this, the static
qualifier is dropped from pidfd_create() and a declaration is added to
linux/pid.h so that this function can be called from other kernel
subsystems i.e. fanotify in this case.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 include/linux/pid.h | 1 +
 kernel/pid.c        | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb8d6a4..af308e15f174 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -78,6 +78,7 @@ struct file;
 
 extern struct pid *pidfd_pid(const struct file *file);
 struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
+int pidfd_create(struct pid *pid, unsigned int flags);
 
 static inline struct pid *get_pid(struct pid *pid)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index ebdf9c60cd0b..d3cd95b8b080 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -550,10 +550,12 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Note, that this function can only be called after the fd table has
  * been unshared to avoid leaking the pidfd to the new process.
  *
+ * This symbol should not be explicitly exported to loadable modules.
+ *
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid, unsigned int flags)
+int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
-- 
2.31.1.751.gd2f1c929bd-goog

/M
