Return-Path: <linux-api+bounces-4064-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14585AEE456
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 18:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD73B6FE2
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7BE292B5E;
	Mon, 30 Jun 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzcNb/rV"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B9291C1C
	for <linux-api@vger.kernel.org>; Mon, 30 Jun 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300440; cv=none; b=a5Wnxl49KS0SDruJhdXbeHH9uj26niohTE8KCMKjqZBeQpd/+si6MJXpo37WdNrrNNniji4oRq6vpen+YmCa8iAyv9bCxIrKHlfKXZx8DAz8aH/xwwimUa/PesEdu3vmwdDCmjXItW71D9VlkuLXBnAipq6zC8E7P0lg8yfiGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300440; c=relaxed/simple;
	bh=1fmnKQClA+Eq4TXGJEAAeuvdJ0gw1NSpnjK1+MgJX8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWOujm2WYd0UfdLHnclQv5fHLl/LdurP8tsx/lEpqTfG5xIoi2nFIyL9FouUu906ucRAeGBt+aC14Fp/vQ6nXSFjR7unCmxNazKF/XTuPm/gGw6W0i/Msjbw/50sRpHYSPnh3J2FOeaoAAlzd7eTEaOBZGNOX+T1+EIZMo+1sh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzcNb/rV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300437;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=retAznaHagyZVmXo9T/cqkc6BvJhqtSJTEOEchYRx98=;
	b=gzcNb/rVLruQias5SRzx7tBsEVVBBgrv54jT/226ObQhU6ynbCRGWYuxPsCW+o5XNpNF8B
	Q9OTTekF8XGdBncE3CWXW/8PVZjrC6nsaluc7kjDSMqvarrLml8piz7TI9/1JM5DPOJ6CU
	zL315jEPdYTK9+WZedVyTlQqH5mkHmo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-ZAH8HbufPTCP0Q4OJZZfdw-1; Mon, 30 Jun 2025 12:20:36 -0400
X-MC-Unique: ZAH8HbufPTCP0Q4OJZZfdw-1
X-Mimecast-MFC-AGG-ID: ZAH8HbufPTCP0Q4OJZZfdw_1751300435
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a6da94a532so1498922f8f.2
        for <linux-api@vger.kernel.org>; Mon, 30 Jun 2025 09:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300434; x=1751905234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=retAznaHagyZVmXo9T/cqkc6BvJhqtSJTEOEchYRx98=;
        b=FGzakT6T1yEUL3BOkMmj/JDgo67cHjhqaDGeSCrKvaJl/CIls6F2fZBYdV46GRQj+e
         0em+R8xKQboTOEcSM6IgJP9nGI/YRQhHDf++17//ZrNAxrs3Byli/KNmcV47syL876xU
         BVO/86E3kfdOCNK69sL5UNBbTUa+Ba+NxkndeEndGBJCVpJKUfMp861xfSglqXNB8FXX
         8R4v2UqXKZFpzWaO8eHnn1WRpVh/3tjX9gsc37LIugt7v+Wd6ezNkmREA2qH0VwbSe/z
         o02Nv82SV54aKEWt1D0caICn03CZB81Qexa+prWRfJXuNG3WGLOeY9PWuMrVa2YwCjkk
         5quA==
X-Gm-Message-State: AOJu0YxEdorBWRzaIfAdJHxSpsSGNrujCXLlyEXDVfBHJCiY0peO0pdV
	vD4/CmpItQJAx+N9ECgl4D3D52O1EFvWxciaBEZzguMUO1y9fgWkz+cQTmrLCBgD2G7lUrNiODA
	WJkyF5JSnlqH3dwo4lwLo2TG5PaIZQIRuVMz3+cbv9Gh6G/FoGgPVca3hC9Pznix8J43HNx4GnD
	4mawgqf+dILtKU7ntOf9R8ZXi3L/OVwuoHS8ZH/HbWif3q
X-Gm-Gg: ASbGncsdfpFNjz/hjqeVsTnhUoJR55bbtAztPROoOCxidnpDOE1DUjhhpT3WsfgnD/+
	30sAW+vjmh6urjvMpTMs2nbFqti5GVLR+BoUDpkerWV4egCrVRbJqQ+DP4frYzDDYpuoN/YPu+E
	1zfuuzzckY+jTtWXacfzeVaBeNyecZhqaNVFz1NZerKJD/6Rm9rpDr2I3wEbEmuLfSR356C36N2
	9C+Gg8nmfKiPZrn61aSPA+VrJ5RdpuMcGI5GsDpPyW/qAlSlBOvAxFvYwDo82cQL7Nls+yky5Es
	h2NFR0fGWREpfuV9dD2Ulx0Vz/IU
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id 5b1f17b1804b1-4538edf9e08mr161397405e9.0.1751300434023;
        Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGWz29iLt9Ec8/QxCebaTYhDNjHorIH/1Bz8WoGZW+4+aLu8ceqioBoXyyLjXlnzKczI0zmg==
X-Received: by 2002:a05:600c:4706:b0:453:8bc7:5e53 with SMTP id 5b1f17b1804b1-4538edf9e08mr161396915e9.0.1751300433504;
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:13 +0200
Subject: [PATCH v6 3/6] selinux: implement inode_file_[g|s]etattr hooks
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-3-c4e3bc35227b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=1fmnKQClA+Eq4TXGJEAAeuvdJ0gw1NSpnjK1+MgJX8U=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2enPFVZ/teivMYHN62xWL+csXzExLCz/utC+5a
 qlnSu+es2IdpSwMYlwMsmKKLOuktaYmFUnlHzGokYeZw8oEMoSBi1MAJtLpxfA/JuEJW8yuCy1M
 T8/dSOzS2vKR9eSE8LZb6+3t7Q8UKSrYMzIsni+mekNPS2F99OTy5xf2ZfnlXYgJXX4lZxPf5md
 lmZX8AEY/R7U=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These hooks are called on inode extended attribute retrieval/change.

Cc: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>

Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 security/selinux/hooks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..be7aca2269fa 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3480,6 +3480,18 @@ static int selinux_inode_removexattr(struct mnt_idmap *idmap,
 	return -EACCES;
 }
 
+static int selinux_inode_file_setattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__SETATTR);
+}
+
+static int selinux_inode_file_getattr(struct dentry *dentry,
+				      struct fileattr *fa)
+{
+	return dentry_has_perm(current_cred(), dentry, FILE__GETATTR);
+}
+
 static int selinux_path_notify(const struct path *path, u64 mask,
 						unsigned int obj_type)
 {
@@ -7350,6 +7362,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(inode_getxattr, selinux_inode_getxattr),
 	LSM_HOOK_INIT(inode_listxattr, selinux_inode_listxattr),
 	LSM_HOOK_INIT(inode_removexattr, selinux_inode_removexattr),
+	LSM_HOOK_INIT(inode_file_getattr, selinux_inode_file_getattr),
+	LSM_HOOK_INIT(inode_file_setattr, selinux_inode_file_setattr),
 	LSM_HOOK_INIT(inode_set_acl, selinux_inode_set_acl),
 	LSM_HOOK_INIT(inode_get_acl, selinux_inode_get_acl),
 	LSM_HOOK_INIT(inode_remove_acl, selinux_inode_remove_acl),

-- 
2.47.2


