Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45059361613
	for <lists+linux-api@lfdr.de>; Fri, 16 Apr 2021 01:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbhDOXWq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Apr 2021 19:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhDOXWq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Apr 2021 19:22:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66609C061574
        for <linux-api@vger.kernel.org>; Thu, 15 Apr 2021 16:22:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so15267130pji.5
        for <linux-api@vger.kernel.org>; Thu, 15 Apr 2021 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hZqD6ltCvrJgsL2u8AfIw1rh2NQf1pSi6cfmsTeRz+I=;
        b=gS6CFi1ja7RLx5Fem8T6NecDqP2E1wbyFfkdlcMNgv8RtD7AYbUi8QIQ1PQqdRfPl7
         SWxzZEN0aTZjCVHLrlqt3QOe5FwApUj/Rqaxpo0hJTlXlBjx8Aznaq8OYrA6Fenmqy6W
         EGq1xkRM0YRRBBVpMFRlyQlrHDlsw7sUVs/3Ij/tgtQQN7Bjh/jLh3SvTnOKlp44JEv2
         7KFG7Xprpg59vsychKsWzfiyWZAzAqc6LDsF90wNDAmMy5oMh/tYwmmCTsF9SAuaCftk
         B5Gjkm5mgpdkRfNXGx57UxBYLiB9Iv6gXpL+UDf1TfnHfCCz6uEJbmUI85XBtJp5to5h
         qmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hZqD6ltCvrJgsL2u8AfIw1rh2NQf1pSi6cfmsTeRz+I=;
        b=OnyUC37raKw04e9q0tXQkVh6X6Rm8a3op6cj24jruXiwstNTO7acHaPXtsyX3bHHEP
         xLI1RsuThiE62DkUAuj8Q0moz94gdKFh23Qw1Vs+R2FklApCyTbqsiVSx3cSn/2iFptO
         Yj5eT8TdLlB880eFWCGk8IbOC/gO2XIiELGc0CESafmdQ24zCc9FCxmJjzDfrfHQrDp0
         DqgP9XN6hMRF+Cc+Ptw09iK+dgMwmA2VWLhVxNaXG2j60r4ZuIfDKmzjQ2DAWSarCYBq
         bwIeHtS6NquDQejaI6NEqKXHF+zTP113Wv42gb53U1YV5aLFlqzTUrYn6SKOwc4JLSmW
         m9fg==
X-Gm-Message-State: AOAM530E/FfU+dnyd/ooBnF8L3/tDQhlio+oIMWX6+BwAqOfxEVnwaRx
        ngALbdGIsG/ze0DZIZwP6Vd/vIQxEkf6r1Vw
X-Google-Smtp-Source: ABdhPJyDumUoYyNQGOsslWciEvA79i8Ns71fv9PWfMVnV2vlXgqm+butPtawu6LVUfnpxBaNnryLxQ==
X-Received: by 2002:a17:90a:e296:: with SMTP id d22mr6233078pjz.31.1618528941855;
        Thu, 15 Apr 2021 16:22:21 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3d18:8baf:8ab:7dd5])
        by smtp.gmail.com with ESMTPSA id v6sm2959810pfb.130.2021.04.15.16.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:22:21 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:22:09 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] pidfd_create(): remove static qualifier and declare
 pidfd_create() in linux/pid.h
Message-ID: <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
References: <cover.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618527437.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

With the idea to have fanotify(7) return pidfds within a `struct
fanotify_event_metadata`, pidfd_create()'s scope is to increased so
that it can be called from other subsystems within the Linux
kernel. The current `static` qualifier from its definition is to be
removed and a new function declaration for pidfd_create() is to be
added to the linux/pid.h header file.

Signed-off-by: Matthew Bobrowski <repnop@google.com>
---
 include/linux/pid.h | 1 +
 kernel/pid.c        | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

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
index ebdf9c60cd0b..91c4b6891c15 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -553,7 +553,7 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  * Return: On success, a cloexec pidfd is returned.
  *         On error, a negative errno number will be returned.
  */
-static int pidfd_create(struct pid *pid, unsigned int flags)
+int pidfd_create(struct pid *pid, unsigned int flags)
 {
 	int fd;
 
-- 
2.31.1.368.gbe11c130af-goog

/M
