Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0D2E1AF7
	for <lists+linux-api@lfdr.de>; Wed, 23 Dec 2020 11:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgLWK07 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Dec 2020 05:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgLWK07 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Dec 2020 05:26:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49936C0613D3
        for <linux-api@vger.kernel.org>; Wed, 23 Dec 2020 02:26:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j13so2974387pjz.3
        for <linux-api@vger.kernel.org>; Wed, 23 Dec 2020 02:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5jqskOuKzDG8SRqMboCrMrWUZsVKNfBPbJ28eE9Fn0=;
        b=qwsz6HxjF6QqaY/mZwFATQ1JfZkgbwdUOd6MnqhSodjp2H8Zr/sAk9kPRRrv3IcVqc
         QrKT5beOU/aNeNh+og6A7O9C2NnZDceygJmBe2dPRo9zXHRlqMAO4XkUXuotrKLfT/ft
         BObVCFkE5IYFEylSKOp+O7h7AYB9ccfGIO7Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l5jqskOuKzDG8SRqMboCrMrWUZsVKNfBPbJ28eE9Fn0=;
        b=st5T5uQVzeN0uI9Rjx0SK3wsKCzdydWUQ6Ej9gIY8zPeww+V5BTCELsbXDxhE+c8Rl
         iY2CVmOxSsl8Ry8ZNYIBE+zgUn06Ulu0Ud7U7fxbN+iN8K0RJFD0wK80hjWUGVLfmqcs
         1lD0P2E6UV4p728i/uAOu03oX5pwhkkZo+kd2VKbkkS61qF9e3+3eBGfceM3CQUD353B
         neoPJr1hApW+ObhsGPap1SC7t4pnAJCfhK8l3dqjUn/Yh51JNNlJVUtkYTjg4fjp6cX5
         hPGNpsC1cR3MStV1xlOlSK/PG6kudiq46fxBeUjmsfjQlG+WHkvBGp6zGx1hILdePUf9
         QgTg==
X-Gm-Message-State: AOAM531GbvMSmO93msCvG0Px+4fRcSp1qIDhrKEmKK4oQG2qtkYqwENG
        H9c9uhbu5KQtugQWf5eifJtceA==
X-Google-Smtp-Source: ABdhPJzj5MLX/NW5oeAawY3dToBvE+bqjcU3DuHLllM/NC2lYSuXBUiPdmFuxEeoT4PgESsv1LptDg==
X-Received: by 2002:a17:90a:f694:: with SMTP id cl20mr26579419pjb.179.1608719172757;
        Wed, 23 Dec 2020 02:26:12 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id k25sm23514995pfi.10.2020.12.23.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 02:26:12 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>
Subject: [PATCH] fs: Validate flags and capabilities before looking up path in ksys_umount
Date:   Wed, 23 Dec 2020 02:26:04 -0800
Message-Id: <20201223102604.2078-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

ksys_umount was refactored to into split into another function
(path_umount) to enable sharing code. This changed the order that flags and
permissions are validated in, and made it so that user_path_at was called
before validating flags and capabilities.

Unfortunately, libfuse2[1] and libmount[2] rely on the old flag validation
behaviour to determine whether or not the kernel supports UMOUNT_NOFOLLOW.
The other path that this validation is being checked on is
init_umount->path_umount->can_umount. That's all internal to the kernel.

[1]: https://github.com/libfuse/libfuse/blob/9bfbeb576c5901b62a171d35510f0d1a922020b7/util/fusermount.c#L403
[2]: https://github.com/karelzak/util-linux/blob/7ed579523b556b1270f28dbdb7ee07dee310f157/libmount/src/context_umount.c#L813

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Christoph Hellwig <hch@lst.de>
Fixes: 41525f56e256 ("fs: refactor ksys_umount")
---
 fs/namespace.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index cebaa3e81794..dc76f1cb89f4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1710,10 +1710,6 @@ static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
 
-	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
-		return -EINVAL;
-	if (!may_mount())
-		return -EPERM;
 	if (path->dentry != path->mnt->mnt_root)
 		return -EINVAL;
 	if (!check_mnt(mnt))
@@ -1746,6 +1742,12 @@ static int ksys_umount(char __user *name, int flags)
 	struct path path;
 	int ret;
 
+	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
+		return -EINVAL;
+
+	if (!may_mount())
+		return -EPERM;
+
 	if (!(flags & UMOUNT_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 	ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
-- 
2.25.1

