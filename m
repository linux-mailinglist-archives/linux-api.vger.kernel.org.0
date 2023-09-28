Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420637B1D35
	for <lists+linux-api@lfdr.de>; Thu, 28 Sep 2023 15:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjI1NCq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Sep 2023 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjI1NCp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Sep 2023 09:02:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219411A5
        for <linux-api@vger.kernel.org>; Thu, 28 Sep 2023 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695906117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mK7muDvbuwqZAV3QEAYNGQadrKd1oX00byk/Uab1QWg=;
        b=B0FNnDGK2BA+HpRIjcjVcDLc2zyNZalCP4/ccUK68navoFF2n0wSoCgw22zloTdid13q1x
        LClVM5YnEGgFCxCMPLsfgxDyO2oEAuiYtcqDJIWj03ChruUb+xpEIQMMjxszAx6j98zwH5
        3xFMDPXODE4lHi9npJgBKKVjpOTEeRw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-Jyb7q5N5PK6x4c6Nht0DsQ-1; Thu, 28 Sep 2023 09:01:55 -0400
X-MC-Unique: Jyb7q5N5PK6x4c6Nht0DsQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so1139968666b.3
        for <linux-api@vger.kernel.org>; Thu, 28 Sep 2023 06:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695906114; x=1696510914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK7muDvbuwqZAV3QEAYNGQadrKd1oX00byk/Uab1QWg=;
        b=CejMa5f0GuLUsr6PRvrmlyI4vvpAI6ylOB0zq/FBJPq/rQLI6nrF+EAE2o1YaEnF4u
         uhwsQtuW0gmgJ8NuxE+TD70oxz/ZbvjtwFSgq6QO6uc4Atl8Rf5ueykhfCuPJ9es+q17
         VjIc0SJoQV7AHX8YtWIg+GCReO3nRECBNDvvJ5YXDd7uIu5ZDblXpxZ30KiRZ1t2R9VD
         Affswh/7ye6daCKizFYJL1f4RL9beimqwPyBbF41szX8oqkdvX9Yhs/DcAPROGDl9O1F
         qvgjb6BKZ4mUgO47h9nL7dL4w9zFP+Cdzzo7NXKB8DebiOqFlG+/yIdO4W3xkHncVNkH
         X7jA==
X-Gm-Message-State: AOJu0YwTWpB7US8Cf6t0rLM/ccu6qmgDEy3kb7WVOWYYFyHUsFQYWhrB
        acupxrq80CzW6DP9Cj/RLaDkIi2M8As+oym1l+VmzvihVbnNB3m95tzXdy+abVyVBPvTrXKLZKR
        au97S3nyVgrK28llLVUtuXDgJGSgK
X-Received: by 2002:a17:906:319a:b0:9ae:7943:b0ff with SMTP id 26-20020a170906319a00b009ae7943b0ffmr1409856ejy.27.1695906114324;
        Thu, 28 Sep 2023 06:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJjQiIjJVuDS3g32mRy//SH9vwKSEPCf6FjkZoTcZfx77rovjUrCRFJp0QcgV0Zb3CqzJbMg==
X-Received: by 2002:a17:906:319a:b0:9ae:7943:b0ff with SMTP id 26-20020a170906319a00b009ae7943b0ffmr1409778ejy.27.1695906113300;
        Thu, 28 Sep 2023 06:01:53 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-31.pool.digikabel.hu. [94.21.53.31])
        by smtp.gmail.com with ESMTPSA id v6-20020a170906380600b0099c53c4407dsm10784863ejc.78.2023.09.28.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 06:01:52 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 2/4] namespace: extract show_path() helper
Date:   Thu, 28 Sep 2023 15:01:44 +0200
Message-ID: <20230928130147.564503-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928130147.564503-1-mszeredi@redhat.com>
References: <20230928130147.564503-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To be used by the statmount(2) syscall as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/internal.h       |  2 ++
 fs/namespace.c      |  9 +++++++++
 fs/proc_namespace.c | 10 +++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..0c4f4cf2ff5a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -83,6 +83,8 @@ int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
+int show_path(struct seq_file *m, struct dentry *root);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index e02bc5f41c7b..c3a41200fe70 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4678,6 +4678,15 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+int show_path(struct seq_file *m, struct dentry *root)
+{
+	if (root->d_sb->s_op->show_path)
+		return root->d_sb->s_op->show_path(m, root);
+
+	seq_dentry(m, root, " \t\n\\");
+	return 0;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 250eb5bf7b52..5638ad419f52 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -142,13 +142,9 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
 		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
-	if (sb->s_op->show_path) {
-		err = sb->s_op->show_path(m, mnt->mnt_root);
-		if (err)
-			goto out;
-	} else {
-		seq_dentry(m, mnt->mnt_root, " \t\n\\");
-	}
+	err = show_path(m, mnt->mnt_root);
+	if (err)
+		goto out;
 	seq_putc(m, ' ');
 
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
-- 
2.41.0

