Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F82E6BA0
	for <lists+linux-api@lfdr.de>; Tue, 29 Dec 2020 00:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgL1Wzy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Dec 2020 17:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgL1Up2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Dec 2020 15:45:28 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F38C061796
        for <linux-api@vger.kernel.org>; Mon, 28 Dec 2020 12:44:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1so257615pjr.2
        for <linux-api@vger.kernel.org>; Mon, 28 Dec 2020 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46zWNq1MQMAllPErESq+P0d3wb/+jK7l73bBEn1MKsw=;
        b=ULQrG5MLVRY0Vzr34XFrkm3y61mmJ5AIS4J3bNrtIG1AIchd+p7ay3R7CbXRclN8uZ
         M6UeZQrH5oUiOCriZCg/UIiQDgd2JN5KLqd9nEs81cSqo5rI+PVH6kv0v+k6Yl5MCUjV
         09OOnYx+vrVOj+ICiXMmKDiBDca8BE0gsq5OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=46zWNq1MQMAllPErESq+P0d3wb/+jK7l73bBEn1MKsw=;
        b=QGKLPpYJzCuMMkJXhx3/Mjtu6CAp5aSy1QGb480xq9ahd2E2NJwefwIK0Ys7CkAzAV
         CH+nju1bXhlJjp58wyc2F/M57up50p8wQjqDQ/IaL4ErLudK1dHQ1FWB6OjcXGgFvfTZ
         uz02lObBrQcD0lZRI94B8GZeyRiBsj7Ce+hz/dyCiHm9fYhymmW3fdjizvYgpPpXAmJa
         OwMsAKakCbicu9Lxtu2X+0uugdniBXj+VHm4lWgrC4IofXkKSNEeEd4H24GijD5OrX52
         j2mDBPQCCpqEbyfaI4HE7/jkRnswALMKColPj/z5vuOUU4gkNfNeEC2knnRlpiZXAd6M
         /Law==
X-Gm-Message-State: AOAM532WszzhMqvMRKuTRkypcy7C+/RihMCN5FrvTDNWra+iGCv1cCSc
        n7cWyRDIiys1OrkVdUaLsxmauA==
X-Google-Smtp-Source: ABdhPJxzW5BNpGbiIkly/rGtsowvBDABW0hzn/xoLQGi8JxAkFaLtLng/NVzkkuRgLFRoydQzclBJQ==
X-Received: by 2002:a17:90b:24c:: with SMTP id fz12mr668157pjb.138.1609188287184;
        Mon, 28 Dec 2020 12:44:47 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b129sm37843077pgc.52.2020.12.28.12.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:44:46 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Rob Gulewich <rgulewich@netflix.com>,
        Zoran Simic <zsimic@netflix.com>, stable@vger.kernel.org
Subject: [RESEND PATCH] fs: Validate flags and capabilities before looking up path in ksys_umount
Date:   Mon, 28 Dec 2020 12:44:38 -0800
Message-Id: <20201228204438.1726-1-sargun@sargun.me>
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
Cc: stable@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
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

