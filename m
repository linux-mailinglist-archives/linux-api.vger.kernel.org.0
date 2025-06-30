Return-Path: <linux-api+bounces-4063-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8DFAEE431
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 18:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54A67AD69E
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85380292B4C;
	Mon, 30 Jun 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akhtyO8W"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EFC29187E
	for <linux-api@vger.kernel.org>; Mon, 30 Jun 2025 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300440; cv=none; b=WAGiMvQrTgftHFHvVZTRbw+fvL8PExf7opQWNw0UuUl8kSkoUfHYJrq7myETJNIlRY+FrA31G8jqd6flW2L6NIb3xjOuBKZIFHkmbTkUKTMih2c8H1F1haKzgx11aiEMWSUvWPTQZ6sIOv2cw1txSxuBxgX5IZNp19a5ZFlbOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300440; c=relaxed/simple;
	bh=bO/jpswV1LWNhjalyWMDjdR/z42wKAwo8hIHFNHoxHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPsnGITY4HWJEMNzcv7wWIVmKKMkIA28BFfhoSdCw+GlvQ9c62p0gzjdXoRYV8g20X2Tt08Ga5NgD4JoYYYWXPa+bclC+niTlv/Sj0zwOsAYmmiEy8EL5zOgUvqH7FD8oPcpuln054RNHnpmOIyMPEXJvRzzbGH5CXCsQcNpdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akhtyO8W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/ldgdzsRv8e0UT+Jrv0yb/WEFGbntMvFcer/+29UGk=;
	b=akhtyO8W8eJh95mVJRmw1qCnZk8YiWMA+jtsSy+1FXGfod6g1SR6ZhD5iZJxvwXLC/x0Lc
	hINNG/203+ZV/UnVBD/yi3Bc/HRJo/5Vy++LUndZbpSZ0Kvr5nWf2iTHUf3w8YrZie92ym
	OiiCsooZL5LLtbiFjxwV3yivC6bQnWc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-etUA8QFsO2u9jE2pwLi66Q-1; Mon, 30 Jun 2025 12:20:34 -0400
X-MC-Unique: etUA8QFsO2u9jE2pwLi66Q-1
X-Mimecast-MFC-AGG-ID: etUA8QFsO2u9jE2pwLi66Q_1751300434
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-453817323afso27987975e9.1
        for <linux-api@vger.kernel.org>; Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300433; x=1751905233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/ldgdzsRv8e0UT+Jrv0yb/WEFGbntMvFcer/+29UGk=;
        b=GnC+No0OrJNKR39sWa958r6ptgLP7tOq++JMJfJ5bBHKhRt+5MpoAw69HRsdnOyGOz
         4d4EkFopQ2vhmoV+3SdCXarXFAgVbjYzv7lcqVhTySYLr0so/7pc8HeERRTIrhi7F4Ky
         rJAOfp6BcoGMR3MCvD6iHIAQbOd4LXm9wHw+7/aLRGKRhjcNh2eRiXBSxtEJRZzovr3t
         qN5J0egUbVkehjwYKFJLaYFl6dghFvDiP3/sbZ893jxakLykWo4QbNTD5lQpRilRufyC
         Gp5ww0nD8Fc8CcDvWUF38wTs78XJDMIIFtjblNzJ9lqOPBEH+rT0LbRoh1/J4+9SKH8n
         60Kg==
X-Gm-Message-State: AOJu0Yw+QTPe+2n9Bp/ZMfN36MaJV5XTyQ77sq1OyNTbFIOaSehZkAct
	ldqQ9w8cKWCvnZhqda15ijjyFywTMdMHQblTj6scREpVa8gqMwM8g+0ia42Glyy7/znbpLgvban
	rY8b2BamdRsZbDekHW/ZSvULJgLyV8tFQSZ2CbuDNQz1g/srepth6t27FyH97M5r3iqYISj3cvh
	JM+2aDyQw9mv/mUotvUemQdzB66aH3OEo0yRSgdHgyABc0
X-Gm-Gg: ASbGncuBrA7ncU+g1MT3wiKcFPhqCF5sW81lXW2X0SPUn8rOES38cNbiW7yzmjGqbyM
	a1GYb6d6hteTdF7n/oPtT+PLnYi4ptjdAOfuEEvdzIBleSuVAjbsgrnQdpPB+zI4IcixOPH7mt9
	UiV7MOixwEbDUc/ENfm6mzJTSkRiWoMgfAKNOiW0ELH/y+P5aDwCqBovbyBMKweSbTNYJaTNTZm
	UAT2llYiO/pMYK33FDrjOfjHumug61GPGUlj+yvi4sL5u5NXEtDDLk5M0y5/fypTgcl4mtmpB+l
	qG7k7q/Mh1qI65D70qO99ONZZIyZ
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr112684525e9.11.1751300433197;
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFduavveB4cdYSeQ2qocLMKSrImBMaC6aj6NuX+uihLHHyN/rjbOwaD5qNXSxUq7WLZl2/mug==
X-Received: by 2002:a05:600c:458b:b0:450:b9c0:c7d2 with SMTP id 5b1f17b1804b1-45391b6b96dmr112684075e9.11.1751300432717;
        Mon, 30 Jun 2025 09:20:32 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:29 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:12 +0200
Subject: [PATCH v6 2/6] lsm: introduce new hooks for setting/getting inode
 fsxattr
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-2-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5238; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=bO/jpswV1LWNhjalyWMDjdR/z42wKAwo8hIHFNHoxHc=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2ev2XWlBSZ1NT29LbkmzeYMpctqZpt8v5pdwnD
 coswzK/b+ooZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkX2zGP5wFThm6IgLsXdV
 /tpyS4eJUcfv1pbw5zrMD884LNDjf2LJyNAdtarms/SlmIr7p/6vnKwRF9nfmmrtkis1Y3v8UtZ
 duqwAYNREEw==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Introduce new hooks for setting and getting filesystem extended
attributes on inode (FS_IOC_FSGETXATTR).

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c                | 19 ++++++++++++++++---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 16 ++++++++++++++++
 security/security.c           | 30 ++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 2910b7047721..be62d97cc444 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -76,10 +76,15 @@ EXPORT_SYMBOL(fileattr_fill_flags);
 int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
+	int error;
 
 	if (!inode->i_op->fileattr_get)
 		return -ENOIOCTLCMD;
 
+	error = security_inode_file_getattr(dentry, fa);
+	if (error)
+		return error;
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
@@ -242,12 +247,20 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 		} else {
 			fa->flags |= old_ma.flags & ~FS_COMMON_FL;
 		}
+
 		err = fileattr_set_prepare(inode, &old_ma, fa);
-		if (!err)
-			err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
+		err = security_inode_file_setattr(dentry, fa);
+		if (err)
+			goto out;
+		err = inode->i_op->fileattr_set(idmap, dentry, fa);
+		if (err)
+			goto out;
 	}
+
+out:
 	inode_unlock(inode);
-
 	return err;
 }
 EXPORT_SYMBOL(vfs_fileattr_set);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..9600a4350e79 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -157,6 +157,8 @@ LSM_HOOK(int, 0, inode_removexattr, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *name)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_removexattr, struct dentry *dentry,
 	 const char *name)
+LSM_HOOK(int, 0, inode_file_setattr, struct dentry *dentry, struct fileattr *fa)
+LSM_HOOK(int, 0, inode_file_getattr, struct dentry *dentry, struct fileattr *fa)
 LSM_HOOK(int, 0, inode_set_acl, struct mnt_idmap *idmap,
 	 struct dentry *dentry, const char *acl_name, struct posix_acl *kacl)
 LSM_HOOK(void, LSM_RET_VOID, inode_post_set_acl, struct dentry *dentry,
diff --git a/include/linux/security.h b/include/linux/security.h
index dba349629229..9ed0d0e0c81f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -451,6 +451,10 @@ int security_inode_listxattr(struct dentry *dentry);
 int security_inode_removexattr(struct mnt_idmap *idmap,
 			       struct dentry *dentry, const char *name);
 void security_inode_post_removexattr(struct dentry *dentry, const char *name);
+int security_inode_file_setattr(struct dentry *dentry,
+			      struct fileattr *fa);
+int security_inode_file_getattr(struct dentry *dentry,
+			      struct fileattr *fa);
 int security_inode_need_killpriv(struct dentry *dentry);
 int security_inode_killpriv(struct mnt_idmap *idmap, struct dentry *dentry);
 int security_inode_getsecurity(struct mnt_idmap *idmap,
@@ -1052,6 +1056,18 @@ static inline void security_inode_post_removexattr(struct dentry *dentry,
 						   const char *name)
 { }
 
+static inline int security_inode_file_setattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
+static inline int security_inode_file_getattr(struct dentry *dentry,
+					      struct fileattr *fa)
+{
+	return 0;
+}
+
 static inline int security_inode_need_killpriv(struct dentry *dentry)
 {
 	return cap_inode_need_killpriv(dentry);
diff --git a/security/security.c b/security/security.c
index 596d41818577..711b4de40b8d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,6 +2622,36 @@ void security_inode_post_removexattr(struct dentry *dentry, const char *name)
 	call_void_hook(inode_post_removexattr, dentry, name);
 }
 
+/**
+ * security_inode_file_setattr() - check if setting fsxattr is allowed
+ * @dentry: file to set filesystem extended attributes on
+ * @fa: extended attributes to set on the inode
+ *
+ * Called when file_setattr() syscall or FS_IOC_FSSETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_setattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_setattr, dentry, fa);
+}
+
+/**
+ * security_inode_file_getattr() - check if retrieving fsxattr is allowed
+ * @dentry: file to retrieve filesystem extended attributes from
+ * @fa: extended attributes to get
+ *
+ * Called when file_getattr() syscall or FS_IOC_FSGETXATTR ioctl() is called on
+ * inode
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_inode_file_getattr(struct dentry *dentry, struct fileattr *fa)
+{
+	return call_int_hook(inode_file_getattr, dentry, fa);
+}
+
 /**
  * security_inode_need_killpriv() - Check if security_inode_killpriv() required
  * @dentry: associated dentry

-- 
2.47.2


