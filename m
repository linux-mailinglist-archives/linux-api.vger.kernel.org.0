Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911D34B869
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbfFSMah (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:30:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37407 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731808AbfFSMad (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so1646581wme.2
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mkwu/3OEXZGqXJyUnO5ri3H818oiUy7gpX5xDSptxL0=;
        b=hm98CF6rbYKJJQOUnj+O5fB+GZ3i9F856bAQQ4TI9FIyvGrCXH9cy25b93bEb8y+TE
         VV1kmFUNCrPc9zdrLIaOmWeHG5cT05abL9Pa8s7aewSs6r9Er7uZZ5zrVXmJl+OYAxbP
         JpXqVGQXY6atE7vZOOXuWRv+/swXb74eyXzqKj26KbUcPyZkdNy1YC4Y4qnqG9RBDKa+
         tpl8wAzpjVxcz7rqoMOxHeMycX9Nl0xBqopKN8iBeaVE5IJbNa4yhqlOG62+8TeU+fIq
         OnoSY487MhBtXhcWUnXXiXxtdFjUot34m1Hrm1kEsT115NbajW+ygwRJ7mUwv/QMTmvL
         avqA==
X-Gm-Message-State: APjAAAUv/IkBrJGp+Ir/oHAx/Z+AYwD5yoTTrGtgUFJyAySnUYGItdMm
        t/lcsr4ArGVRND0xMxOtTb7yYA==
X-Google-Smtp-Source: APXvYqzhG/Ojq+ugu+NGlKLRr7Xa/HPx8OL4GK+QnjWlXZC3Xx84s21vw7gBF3qzuyD/LyRnzB0ihw==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr8459959wmc.77.1560947431788;
        Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:31 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] vfs: don't parse "silent" option
Date:   Wed, 19 Jun 2019 14:30:11 +0200
Message-Id: <20190619123019.30032-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
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
 fs/fs_context.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 49636e541293..c26b353aa858 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -51,7 +51,6 @@ static const struct constant_table common_clear_sb_flag[] = {
 	{ "nolazytime",	SB_LAZYTIME },
 	{ "nomand",	SB_MANDLOCK },
 	{ "rw",		SB_RDONLY },
-	{ "silent",	SB_SILENT },
 };
 
 /*
@@ -535,6 +534,9 @@ static int legacy_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	if (ret != -ENOPARAM)
 		return ret;
 
+	if (strcmp(param->key, "silent") == 0)
+		fc->sb_flags |= SB_SILENT;
+
 	if (strcmp(param->key, "source") == 0) {
 		if (param->type != fs_value_is_string)
 			return invalf(fc, "VFS: Legacy: Non-string source");
-- 
2.21.0

