Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2104B850
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbfFSMah (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 08:30:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35638 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731842AbfFSMah (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 08:30:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so3222972wrv.2
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 05:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEJZvAaP0gZ3BGwiRkcb3jZB35A1QSUJKdWyF6hsB/4=;
        b=jf27NsSANNnxmqUuEayhMwEs5ZkX6tR7ckVsS9JbZmsqQFK4WK1Sdn74VIEqrICkiY
         SavhSzmZeynwlOKH6XHCsiLkP3zibhay8URfRnStwbeer5pa8tKEdcJDZPro2bqa+RxG
         ps9K9NhZfnq/BYMy4hKL/+YOZ1pxOP+ae5UpsaHGFDWztxOmc/2h7E0Ld3vYbxIqXa7p
         LGNv06rJX5XMMflmu8cWvMinEENwzrhaBYjoO9fsxvDAwZDzy2bfUebLGlEANyJZWZLt
         Tic0EwqEHp8odOwgtGO7N9WFid2C6hV40ks7oWcDZkg35xO5qpDUfEmfPuQNwuZJlcqR
         PC+w==
X-Gm-Message-State: APjAAAVb3xKbfLNKtjsDobM9135f577+HltWXjkzYHU3Ie+ZH6DstHc4
        /qaA5LjJr9zmY9IRnk3bxOhpOg==
X-Google-Smtp-Source: APXvYqx+pORYHinPI1RPJLOFGKWiPjDYT7ZAsQ/FYO/zLto8APQKogtIGI+TjNYrCayP0MLlUNfRAg==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr86528327wrr.324.1560947435212;
        Wed, 19 Jun 2019 05:30:35 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 11sm1837513wmd.23.2019.06.19.05.30.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 05:30:33 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] vfs: new helper: vfs_parse_ro_rw()
Date:   Wed, 19 Jun 2019 14:30:12 +0200
Message-Id: <20190619123019.30032-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619123019.30032-1-mszeredi@redhat.com>
References: <20190619123019.30032-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This just parses the "ro" and "rw" options and sets sb_flags accordingly.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fs_context.c            | 18 ++++++++++++++++++
 include/linux/fs_context.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index c26b353aa858..5012ab7650ec 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -77,6 +77,24 @@ int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param)
 }
 EXPORT_SYMBOL(vfs_parse_sb_flag);
 
+int vfs_parse_ro_rw(struct fs_context *fc, struct fs_parameter *param)
+{
+	if (strcmp(param->key, "ro") == 0)
+		fc->sb_flags |= SB_RDONLY;
+	else if (strcmp(param->key, "rw") == 0)
+		fc->sb_flags &= ~SB_RDONLY;
+	else
+		return -ENOPARAM;
+
+	if (param->type != fs_value_is_flag)
+		return invalf(fc, "%s: Unexpected value for '%s'",
+			      fc->fs_type->name, param->key);
+
+	fc->sb_flags_mask |= SB_RDONLY;
+	return 0;
+}
+EXPORT_SYMBOL(vfs_parse_ro_rw);
+
 /**
  * vfs_parse_fs_param - Add a single parameter to a superblock config
  * @fc: The filesystem context to modify
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 39f4d8b0a390..bff6796a89ef 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -128,6 +128,7 @@ extern struct fs_context *fs_context_for_submount(struct file_system_type *fs_ty
 
 extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_sb_flag(struct fs_context *fc, struct fs_parameter *param);
+extern int vfs_parse_ro_rw(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
-- 
2.21.0

