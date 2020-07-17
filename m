Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFFB2239A6
	for <lists+linux-api@lfdr.de>; Fri, 17 Jul 2020 12:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgGQKpb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Jul 2020 06:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQKpa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Jul 2020 06:45:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47178C061755
        for <linux-api@vger.kernel.org>; Fri, 17 Jul 2020 03:45:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b9so5287440plx.6
        for <linux-api@vger.kernel.org>; Fri, 17 Jul 2020 03:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IQS3+7tVa82GntLXDjGZyy3vSgsIExx3PjuBUx7YRNM=;
        b=R1v6iycfuan0KkKpAu+ZcuDemPbFfPC0nRwrn3/UnIb/iO6wDHoDrGNNNOat42KBSM
         dst1lbOHUCTdwjPqhlG9D0pXJDnQ2nftPrPm7X33+5pyd9Mhdwnzk2OPN3YHFUw3x4kR
         OUONtVbDwgcN6dGBQwAuJ8NNwEq9L6NQ7DX4asMab9kSUjlwEbiDmOyGPLPhZzZ8/y5s
         UHwvNt3M46vHZ2lgSIXfiGOYYmk243WE0VwuOaOGELRX8apKibJq1brk5rp8YESCHFFV
         zdP0c4KmvPDRl21Q8IrMBDw5MvxoVPnJ0mNwV1xFDlpMNOpm6wJNV+YPAElJp3/hG105
         B0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IQS3+7tVa82GntLXDjGZyy3vSgsIExx3PjuBUx7YRNM=;
        b=Nq07NUGjBJurasMN6XtB/DhbXwjUtlWDZOjS88E2Oyr6pWxMWrWIDC6yLMDZQrxzqD
         eBrT/VOwbYzRiT5XS5+vnEyf96moSHV40Oyk8JQQ5do87zzRZ6xAW1M/LE3bsdXlj1B4
         h/F4wQRpj2ApeTXA23uJe8vVaBxOn01oP1RN+3PqJbZ3rhXJQR/2T6IXlRQ+j7CqPlcr
         CSLz9Uva2mvT3Fi1GwkqoSoTFXhDkPVvoYBnMKuliW4JuuZgHrwdjyCbm1CVdKc7STfZ
         VnxmuWbEGNYRpu0SYTe/fhjgYfTo0GcVvrXCX2XKx5BYupxYilDvpeRBr6O7ovhUdh7u
         +CLw==
X-Gm-Message-State: AOAM532LsEv00isSH6Cw2TVuXq3vBZcnyHyXnhnA/4+TCjuqAw4fyeQo
        U4yJ08RIDRf5rdfsBz+J8Qo=
X-Google-Smtp-Source: ABdhPJwE75ry8ope1xHqVfP41wDD7OvNdd+C/TJJht8LSp2+iSZN1iAzw+rwvXMQjmUNL+3rII8+7Q==
X-Received: by 2002:a17:90a:ba86:: with SMTP id t6mr9670056pjr.10.1594982729806;
        Fri, 17 Jul 2020 03:45:29 -0700 (PDT)
Received: from linux-kernel-source.asia-southeast1-b.c.hardy-notch-265411.internal (3.136.240.35.bc.googleusercontent.com. [35.240.136.3])
        by smtp.gmail.com with ESMTPSA id h194sm7452970pfe.201.2020.07.17.03.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:45:29 -0700 (PDT)
From:   Bui Quang Minh <minhquangbui99@gmail.com>
To:     minhquangbui99@gmail.com, trivial@kernel.org
Cc:     linux-api@vger.kernel.org
Subject: [PATCH] syscall.h: fix comment
Date:   Fri, 17 Jul 2020 10:45:17 +0000
Message-Id: <20200717104517.2275-1-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The comment shows wrong file name that contains the syscalls' definition

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 include/linux/syscalls.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..a3d053f715e2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -741,7 +741,7 @@ asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
 asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
 asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
 
-/* kernel/timer.c */
+/* kernel/sys.c */
 asmlinkage long sys_getpid(void);
 asmlinkage long sys_getppid(void);
 asmlinkage long sys_getuid(void);
-- 
2.17.1

