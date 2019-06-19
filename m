Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974654B92B
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSMzA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:55:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50511 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfFSMzA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:55:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so1680973wmf.0
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oUKHb/HhBZ0gnG9oANdx2Pjudz3ATWiOMMw4XgDgVpU=;
        b=ub0CCZLwkNECiRquNcO3IQSrye+ecGR7JH2oSo68+S/41/1TZFrmMJxZllqEhW7D0c
         U9uNww4MorYeHRHWu5pI5VV5PFGxk2qJixn10lriSpflugGVeqPbq0JvX+CMwLzVGfLx
         q9tvjHCA3oygYqPm0Gs9xpZ9/eNYRaxlMhabqg8QbxBPjP7cGCPabz4fHc42zBj3IXei
         kB92cvvGZbNkMbojSTHXlhqjKZG4wI/Rf2IDybsgryMGkKXZS60+tMHUzbWbtaSh38YD
         rDpqAsB4pXyzrqtklggUhX+Zuk/9RcZ3C6vy87TZRNY3t7CwRbO8B1mQbE1pVSjUNq0y
         Qlgw==
X-Gm-Message-State: APjAAAXENel6HbWYizKnIxfHKEIynzpZW3MJB3TLGDcVuLaUMnrjb3I1
        iRfTof5CmZGvBoI9FoWNFRZEeA==
X-Google-Smtp-Source: APXvYqw3i0VpSjIBS+93VI0Apn4ELLqPvHfMOQQF7nzI3bFhxPrXEygph6zjfl8uXvwK80wNW3qTeA==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr8147505wma.67.1560948898067;
        Wed, 19 Jun 2019 05:54:58 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id l12sm42800918wrb.81.2019.06.19.05.54.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:54:57 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] vfs: don't parse "silent" option
Date:   Wed, 19 Jun 2019 14:54:52 +0200
Message-Id: <20190619125452.28303-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

While this is a standard option as documented in mount(8), it is ignored by
most filesystems.  So reject, unless filesystem explicitly wants to handle
it.

The exception is unconverted filesystems, where it is unknown if the
filesystem handles this or not.

Any implementation, such as mount(8) that needs to parse this option
without failing should simply ignore the return value from fsconfig().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
Changes:
 - v1 didn't return on matching option in legacy_parse_param()
 
 fs/fs_context.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 49636e541293..bd8f8ab8358b 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
-	{ "silent",	SB_SILENT },
 };
 
 /*
@@ -535,6 +534,15 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
+	if (strcmp(param->key, "silent") == 0) {
+		if (param->type != fs_value_is_flag)
+			return invalf(fc, "%s: Unexpected value for '%s'",
+				      fc->fs_type->name, param->key);
+
+		fc->sb_flags |= SB_SILENT;
+		return 0;
+	}
+
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
 			return invalf(fc, "VFS: Legacy: Non-string source");
-- 
2.21.0

