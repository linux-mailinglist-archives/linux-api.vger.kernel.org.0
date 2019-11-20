Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D51037D5
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 11:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfKTKpQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 05:45:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36945 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfKTKpQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Nov 2019 05:45:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so27531385wrv.4
        for <linux-api@vger.kernel.org>; Wed, 20 Nov 2019 02:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDfQIdvNmwNiawulM29v9GlY4a3OII8q9LRcAw1Twyw=;
        b=Yr645Hr2e9dLJx6WDTQ+pAr3Hu5YSHBdrHa9GMLiiqFgfeumBWNXKz1iUR0CGzSi3M
         vAkqeIv+CY7eyroHhBTzYoCHzUTMFNdDmEMIu85cWFOCmQWCmYN/pqwUIj4ZC+BN5rnE
         sYD6osVOAIMOiE2fNUZcKpdo743ydqqqihUfNXql/7ge+cCfiHGdBXiHCMCoS3qo4JUN
         wCXowLORgwjg3tQkL5BxEkQLEYMftoQr8fLbyQ+mNBlpRLysETHu/S57D0kYqREcseoD
         XFHAMRJQKSuap76nF60ZJ3hywrVRTgRUb5nCy1uErPtqiAqg2M0/ZRM+1YlJ1ztGEK+5
         6iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FDfQIdvNmwNiawulM29v9GlY4a3OII8q9LRcAw1Twyw=;
        b=cCX5Mpn4QgxLWVVsa+MycmXPFpH9YSH1njbkcVNyGyEIqjoDRhvlySfMPCu9g7oAPN
         TeULeps7HFfwxfNcxKbGxW3sRd99KA7/l9dQvlTMGgU/5IOrkrAwE0V0LHqdVh+zK/GI
         h6uSWU5CFs1ksobWav/3GSCFoI/Af1OkjC8A8x5gCb3LQoPeomQhlOD49FyAHAilOp+r
         bxIL29eMT4eQ7UAU/KsZ2Yvg080dJMLwt8Gvub4u431n9UkBJyDL4juakGSXTten/jwh
         FDZo8fANougUenjwNsKr2tIxgRPQxZNFJoIca3Nnk0V07gklm8WAcKgHQ/kF35GR/bVX
         RP8Q==
X-Gm-Message-State: APjAAAWzKK3x65y4hAn4Su0NtW6enT9pDKgTkm7WRO8IrER1yc6cu01s
        WZJ8TdA9+MuBK3+sKUdFJRaQtQ==
X-Google-Smtp-Source: APXvYqzpuucxLTZ3L0mTgG5umNKwQQhw8dteIFiGk38O+PRYxtirZZYJyaRNyI0FoadP9dQ8TZr66A==
X-Received: by 2002:adf:fe8d:: with SMTP id l13mr2478867wrr.287.1574246713926;
        Wed, 20 Nov 2019 02:45:13 -0800 (PST)
Received: from localhost.localdomain ([79.140.122.151])
        by smtp.gmail.com with ESMTPSA id w10sm5973002wmd.26.2019.11.20.02.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 02:45:12 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     mtk.manpages@gmail.com
Cc:     adrian@lisas.de, akpm@linux-foundation.org, arnd@arndb.de,
        avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: [PATCH] clone.2: Mention that CLONE_PARENT is off-limits for inits
Date:   Wed, 20 Nov 2019 11:45:04 +0100
Message-Id: <20191120104504.22411-1-christian@brauner.io>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The CLONE_PARENT flag cannot but used by init processes. Let's mention
this in the manpages to prevent suprises.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 man2/clone.2 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/man2/clone.2 b/man2/clone.2
index f0f29d6f1..aa98ab79b 100644
--- a/man2/clone.2
+++ b/man2/clone.2
@@ -646,6 +646,13 @@ if
 .B CLONE_PARENT
 is set, then the parent of the calling process, rather than the
 calling process itself, will be signaled.
+.IP
+The kernel will not allow global init and init processes in pid
+namespaces to use the
+.B CLONE_PARENT
+flag. This is done to prevent the creation of multi-rooted process
+trees. It also avoids unreapable zombies in the initial pid
+namespace.
 .TP
 .BR CLONE_PARENT_SETTID " (since Linux 2.5.49)"
 Store the child thread ID at the location pointed to by
-- 
2.24.0

