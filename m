Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491204B863
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfFSMak (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:30:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33741 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731858AbfFSMaj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so4532702wme.0
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3XPGarDbNQvdg9HgXJCH37X+Od5kwHmLIcOjFshcWxM=;
        b=k2M5FqZIiOW3+MrTXXEn0Px1AxWZ/6yHxl7hwwS8HZmxneKS2o5D/afZGpM36thcdd
         qRZwLbt+O4Ltuc3EEOfFttk1Ckd6bj5yncUO71szoPQjguasjD/ci6t66NSaejxdyhsh
         86PtE6IUd1y9E0PfdkN1d4AWG8PlB4KdIxk5Jl/Z+pf6xL97CdZPIwNZON9gAgQ+SMc0
         M/MVH1uBbnxbMPT7INrbFPtKH81jw5KISjbeyKAUcaJF9GqT3Mt41MTAoeSGnx0jRfMQ
         PWqm3ltMdmhsVGvCFyzVvN7dqeJ5WHXZPplOCM4+FwhuzrG4LysFTcNOieXBR0+wYov9
         QgWg==
X-Gm-Message-State: APjAAAXxgxepece7GmfM/UTU2XX9nEwBUXLkcv5NFQYvjkqbGUbTx0A7
        bVJoTLcgyhgiCtXjE+muH5hCnw==
X-Google-Smtp-Source: APXvYqxRFzpttWVNpTPiQbdLpMWn0xb6IHJ5FyTailY17pShWafJilfmh1UScZ9oGl2gwVqFz8iRLA==
X-Received: by 2002:a05:600c:214e:: with SMTP id v14mr8496323wml.96.1560947437553;
        Wed, 19 Jun 2019 05:30:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:37 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] sysfs: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:14 +0200
Message-Id: <20190619123019.30032-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The options "sync", "async", "dirsync", "lazytime", "nolazytime", "mand"
and "nomand" make no sense for the sysfs filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/sysfs/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index ba576a976e8c..4797b7952fc5 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -49,7 +49,7 @@ static void sysfs_fs_context_free(struct fs_context *fc)
 
 static const struct fs_context_operations sysfs_fs_context_ops = {
 	.free		= sysfs_fs_context_free,
-	.parse_param	= vfs_parse_sb_flag,
+	.parse_param	= vfs_parse_ro_rw,
 	.get_tree	= sysfs_get_tree,
 };
 
-- 
2.21.0

