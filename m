Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 187474B868
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfFSMbN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:31:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbfFSMai (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id s3so1583709wms.2
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zH+k6ndWzHXcUGt/1dQWHzCs9DtuO0deMfiOOMoKDp4=;
        b=jpUOtxTvrVg6ksewCYv2Qm2S6MDTw3fUtiNVgixW52VDVedEOJVflCntZ+XLa2e4X7
         YkwZj98zikQZPakR7aq+8SI9FryXB80ZwnRMz+MbnLH2vGnqAYso5OdFBPu0MScuFBcF
         52weoS1slUDB+Hx5sOrMJldb/X3NxIkz0pdUamIk2TDZJk09PFkQBNfY5lCY0PvNjHGO
         SwbBSG8eGtzIt52OnnvQ7RKtTQegDrvmXo4vIV15Y7baDSvGmNyq7mpzpwP5Rf8gduFz
         Q0S7oiP4hk98L3MjgUe/IGo8ilSlFkujC/5tOlnf+9qGqT/KFHUeVJe9f+03c1SLwSTx
         QvIg==
X-Gm-Message-State: APjAAAV105nP5VnbdOAksJw+dE7D57S+Yt/yLk6VIvMQCCY+Zr64Ff6L
        fF+pyMScaa3BKHrHp6YuA+yUNA==
X-Google-Smtp-Source: APXvYqzuyPwUZiu30WPoQqiKG/EAE+hhjNevOIChGgYRXYTK/dXvHdqIoIpAjRdiAlQh9pVuex6Smw==
X-Received: by 2002:a1c:6585:: with SMTP id z127mr8881330wmb.25.1560947436334;
        Wed, 19 Jun 2019 05:30:36 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:35 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] proc: don't ignore options
Date:   Wed, 19 Jun 2019 14:30:13 +0200
Message-Id: <20190619123019.30032-7-mszeredi@redhat.com>
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
and "nomand" make no sense for the proc filesystem.  If these options are
supplied to fsconfig(FSCONFIG_SET_FLAG), then return -EINVAL instead of
silently ignoring the option.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/proc/root.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 6ef1527ad975..70127eaba04d 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -58,7 +58,7 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	int ret, opt;
 
-	ret = vfs_parse_sb_flag(fc, param);
+	ret = vfs_parse_ro_rw(fc, param);
 	if (ret != -ENOPARAM)
 		return ret;
 
-- 
2.21.0

