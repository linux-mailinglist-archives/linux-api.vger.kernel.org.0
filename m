Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B864B853
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbfFSMal (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:30:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41298 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731868AbfFSMak (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so3186384wrm.8
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdQVoNmmq/tpICs94VWnUfb4xhH0uHVfAUpoN+yDuN4=;
        b=OuQYqtUNrkqur9PyKU31ni1tT835vB9QxCGrdnk74gZDeqQSaC/mNWJCkzrLy2c2N4
         RAcAaeASTzuVt1oqm/rVYt9zcbfW2ayYwu+WUy3UsgnslvhY6p1NNCp0Sp/K8EMxupwM
         25dWEp64THnhFsbcdBb37YDYpkKNB0Ep1/NQ4S5wvha50KZdiTr26lLn2+wa+Ldkc/Xh
         wWdOwsnn8QabDCQH0tLqcAbZC9QUThUV5x8rMFm5C0ZIHVWQQRD7uqXu2k05eLx1G6KL
         yYoHAlVa5GJ60vrkT0N7DltdlQbhtdo0pYOlbpzaC2mfcg36QVdVT0MVG+mjiXAPqWr+
         uiqw==
X-Gm-Message-State: APjAAAVP66zZ2YA2cAFtMUBV5dqwz9ZAZ/zmIuF+SjOhwdeQkzBiGDpi
        l/ntpSoSCmRiO8ux9THvOzBrqw==
X-Google-Smtp-Source: APXvYqzgc/pTXrx3oLCjioNyxDtYbyoBKOJfXCsDmaWxhuRtivEE9x9bE9zw/wRPVqXoUt4DZF9cvQ==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr37772543wrp.188.1560947438884;
        Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] mqueue: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:15 +0200
Message-Id: <20190619123019.30032-9-mszeredi@redhat.com>
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
and "nomand" make no sense for the mqueue filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 557aa887996a..1e8567c20d6a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1577,7 +1577,7 @@ static const struct super_operations mqueue_super_ops = {
 
 static const struct fs_context_operations mqueue_fs_context_ops = {
 	.free		= mqueue_fs_context_free,
-	.parse_param	= vfs_parse_sb_flag,
+	.parse_param	= vfs_parse_ro_rw,
 	.get_tree	= mqueue_get_tree,
 };
 
-- 
2.21.0

