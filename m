Return-Path: <linux-api+bounces-3510-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7BAA948FA
	for <lists+linux-api@lfdr.de>; Sun, 20 Apr 2025 21:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058AC3AB8F9
	for <lists+linux-api@lfdr.de>; Sun, 20 Apr 2025 19:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D331BCA0F;
	Sun, 20 Apr 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVWROH4M"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33F19B5B8;
	Sun, 20 Apr 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745176617; cv=none; b=S1/5NrLGYQgUSkSz7pfr90wGlUw5UwP0KROeJvb+bNFYCUrzeEo3PmINnaZUqYzWS2Yp3QQUGX9jmJsPP3ezHoEiHADOtuUclyY6tP09cxWYW60RBIQIwiVgozkq4GzOUYGYmDTWPKyYcTOE2zQ9R1M3pq4/wRCXljJ+ZTfLbak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745176617; c=relaxed/simple;
	bh=bhJ3YWrCT+v6YJ1pnpPZRiRNVL+HYKAjRaKngCmTWVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWjN0YOX38ZvXIR/W7R92MrWJnjZ2F6Qtk4VwLG1ASw6CLtONTFJZBuzUUY5a/65acyBVB6jYiiYEcGuLkVnI82dBB6PV2WT/7bXwjUfGO30TMtocUXM2ZGDIC2p6X5dNO3yr8oJIELaBjG4qpT0rde6DVeQkJlSqQF5i8Q9NXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVWROH4M; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-af548cb1f83so3293566a12.3;
        Sun, 20 Apr 2025 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745176614; x=1745781414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPV63PL8/TxpXvMaz1I5ZEE6LMusimG3NpoJZlCfiyg=;
        b=OVWROH4MEweKcttDOBz5SBtJsoIF21+CfXQTxyhKe6K86OD4EYoAyuCKzT9j+5GGb0
         lzwl4ltgdoGaAi8fqPaT+TTF8xyyOtBK3AR+byo7+WxubCXMvyMsfyLCOZ9ucJHIuYxE
         /eTpUf9ZhdO9UQPqQz+egDTFVc1K4koinOiiGNOQpopeH0MLR2Ay4LBoW0gRt8+6MGne
         +DWq6l3TEP8pL7MfPdCeOv3GVRmK6CUF5sQViU3UOxw080RQL35u3RHsZMsn/i175Tk/
         XIEECCpbjL6S3fLzUpd5PGTQciVRvFwOxZwe7nafTpGjLamsYwlOaiaVxkFnj91jsdnf
         5vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745176614; x=1745781414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPV63PL8/TxpXvMaz1I5ZEE6LMusimG3NpoJZlCfiyg=;
        b=xSzEyDGWCAjyXwJb8uI/diMcsfZPwnsTyqIXXzcWBWgSh4vkLwDSON+OzZ31mBk7px
         PNbEOv3FnFKQfUBKVnIZbBayn2pHNUgWUXmCZaYoo+JzAV3u3TyimbAiaNo0ZpWDJ6eP
         eXaos4CN3IW0nwmIysxACdKMZEagIV3qdazbwGRTrmil9petfivkC+2nv6981kbb54qw
         d0wfp06PHy6tuYYQrUm1ETMQK5P917nxnEB1TlKt9S82a2Hpccm5uTZYE8bHLf7/m9qo
         s31uMhogY1NdfrWaKy/BBoAOs5HtjwdW+hfvsA+FLJKWTAddepjJrWaEOmJF8Yen7iog
         xq0w==
X-Forwarded-Encrypted: i=1; AJvYcCVynUxyPecZXCISaqLUg3BL0G9Rf8SGBzH+coDjKlDpLLuAYGNHmToDdZ3uN2lp4tMd+0v84gOJ5lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwD3OQMicSN1kgyX9zAVUNm6Pehab5xefFwG1ICIEKZPNutGh
	ztM0K3X79XQNsD79NalOpXtj/b4PWlIuKPpKRvDrHSNXhj3o9BAY
X-Gm-Gg: ASbGnctT0tnafHmRmUsz5veAtMBPFwU8DjIawhmH7eeXGNzts8oobeUUkdazPtCM2V2
	PrqxZV9tWTulwCTF9OV7uUWDS6c2CHBfYZEDYwdRrFk0GDCFGLjtrmUVYY57hEhNP4nVpoSP4Ph
	FGg/kc84NNRjczIgBzNNSGXMSDjP+8zSSPmSaYYHMTW1fOAyDIj6mS/u283Y9lSksrZA/QoVSbK
	IJujU1fawxtk0N2XpxcfIY95aKNafF9KtgnplOXT9jpwGz6dPBe2tG+XtcGaBG+hyOvckWyKpVm
	3mrQpMu8/6t4bnVgHDtdCt9CpyF6H3U4calpqS9m8PylQRBD8d9jGkE=
X-Google-Smtp-Source: AGHT+IGnR7hgaghygtJs6vKtnNOpzDkaKShg7ztYy8QA3/llrsiMnapfAu1K779wyAELBd5PlVLOhw==
X-Received: by 2002:a17:902:d545:b0:22c:33b2:e420 with SMTP id d9443c01a7336-22c53285a12mr121863515ad.7.1745176613899;
        Sun, 20 Apr 2025 12:16:53 -0700 (PDT)
Received: from localhost.localdomain ([121.171.113.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb48ebsm50944015ad.122.2025.04.20.12.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 12:16:53 -0700 (PDT)
From: devhoodit <devhoodit@gmail.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org,
	linux-api@vger.kernel.org,
	devhoodit <devhoodit@gmail.com>,
	Carlos O'Donell <carlos@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] man/man2/clone.2: Document CLONE_NEWPID and CLONE_NEWUSER flag
Date: Mon, 21 Apr 2025 04:16:03 +0900
Message-ID: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

CLONE_NEWPID and CLONE_PARENT can be used together, but not CLONE_THREAD.  Similarly, CLONE_NEWUSER and CLONE_PARENT can be used together, but not CLONE_THREAD.
This was discussed here: <https://lore.kernel.org/linux-man/06febfb3-e2e2-4363-bc34-83a07692144f@redhat.com/T/>
Relevant code: <https://github.com/torvalds/linux/blob/219d54332a09e8d8741c1e1982f5eae56099de85/kernel/fork.c#L1815>

Cc: Carlos O'Donell <carlos@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: devhoodit <devhoodit@gmail.com>
---
 man/man2/clone.2 | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/man/man2/clone.2 b/man/man2/clone.2
index 1b74e4c92..b9561125a 100644
--- a/man/man2/clone.2
+++ b/man/man2/clone.2
@@ -776,9 +776,7 @@ .SS The flags mask
 no privileges are needed to create a user namespace.
 .IP
 This flag can't be specified in conjunction with
-.B CLONE_THREAD
-or
-.BR CLONE_PARENT .
+.BR CLONE_THREAD .
 For security reasons,
 .\" commit e66eded8309ebf679d3d3c1f5820d1f2ca332c71
 .\" https://lwn.net/Articles/543273/
@@ -1319,11 +1317,10 @@ .SH ERRORS
 mask.
 .TP
 .B EINVAL
+Both
 .B CLONE_NEWPID
-and one (or both) of
+and
 .B CLONE_THREAD
-or
-.B CLONE_PARENT
 were specified in the
 .I flags
 mask.
-- 
2.49.0


