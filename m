Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F56621A6EE
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 20:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGIS1d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 14:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGIS0x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 14:26:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA07C08E763
        for <linux-api@vger.kernel.org>; Thu,  9 Jul 2020 11:26:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so1337298pgh.3
        for <linux-api@vger.kernel.org>; Thu, 09 Jul 2020 11:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrMTIMXp8JCVs/UG6kwzV643qisCcMSwknnEo4LkN2s=;
        b=L8wvdwHte5JVfRo/XP6SiecvNSKuxO96e3Iw4DgEORXlBX29wHcKcTekzMu5ehRLxC
         PIZpkxQVThGY9I3o0Km+Zf3dqPVcYYFtmIF38pEP/OnDYBtw9U/C/nd8IeDdy4CeBbvR
         knaPAcSaS1ZiArDzFLG+JuglPL174w7ZWohI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrMTIMXp8JCVs/UG6kwzV643qisCcMSwknnEo4LkN2s=;
        b=jfGzXvudZ8Bu5qDZD8TVEo4ugMwykRpUDJx4RmOS9QW5V8bxei/SeCQyn+2eL9Irpd
         0/5hwI8DWygWbiNGKLDk1dZjoc1JWoDe+6H3hafUAnkws0BC5npRYnGPnEYT20B+MQZA
         R58Xf8x7KkloMx4vwhTJSTF9KBKcJQNGkcbrGNPsLkuDZncae5I7sNDFLgVU4iTh6zUQ
         zcW1zBEop7fGSJKO1MbQR4EjIo/M/DGWGZ1+2H/44vwWrEGyQyNC2OZTogQMngj1FiC1
         cwguarRIXy/hSz0KCgag1s2f/aC35RwyID+Ti5nU4Mg7AAxmznYE6UuCKRdC8DvAy1NA
         fIXw==
X-Gm-Message-State: AOAM533rMrN9doTWj/E4SzfyD1saLT+foFDivlun+qCVdbHe35GNGIJs
        9/KlIl+Jj/GOZgCHCcB1em4Vrg==
X-Google-Smtp-Source: ABdhPJx65UJ0x1t95RO9v7FuFc02woWGGDxWRTXPyPbUQ6AMj/WGTj8FXr741XZhs+0+z7kyxYCdSA==
X-Received: by 2002:a63:1f11:: with SMTP id f17mr53506078pgf.217.1594319213298;
        Thu, 09 Jul 2020 11:26:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l191sm3238744pfd.149.2020.07.09.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 11:26:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 6/9] pidfd: Replace open-coded receive_fd()
Date:   Thu,  9 Jul 2020 11:26:39 -0700
Message-Id: <20200709182642.1773477-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709182642.1773477-1-keescook@chromium.org>
References: <20200709182642.1773477-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Replace the open-coded version of receive_fd() with a call to the
new helper.

Thanks to Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com> for
catching a missed fput() in an earlier version of this patch.

Reviewed-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/pid.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 85ed00abdc7c..da5aea5f04fa 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -636,19 +636,8 @@ static int pidfd_getfd(struct pid *pid, int fd)
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
-	ret = security_file_receive(file);
-	if (ret) {
-		fput(file);
-		return ret;
-	}
-
-	ret = get_unused_fd_flags(O_CLOEXEC);
-	if (ret < 0) {
-		fput(file);
-	} else {
-		fd_install(ret, file);
-		__receive_sock(file);
-	}
+	ret = receive_fd(file, O_CLOEXEC);
+	fput(file);
 
 	return ret;
 }
-- 
2.25.1

