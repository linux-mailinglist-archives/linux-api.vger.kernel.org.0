Return-Path: <linux-api+bounces-5025-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B58BC4EC6
	for <lists+linux-api@lfdr.de>; Wed, 08 Oct 2025 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD0F40053C
	for <lists+linux-api@lfdr.de>; Wed,  8 Oct 2025 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21526B2DA;
	Wed,  8 Oct 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbyYiD6P"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35E26657B
	for <linux-api@vger.kernel.org>; Wed,  8 Oct 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927475; cv=none; b=tLTDeLxgPVd6RGd1h9wXyhBbHh4kfhO7VDzCgFsOWfbwN1p57zx90xOn+EPctkVb3I1e5BBNaVFAE3IeBHllXuvAVk//O3RtyVP91mguZj+l76DMz2Z/rh1xbxrh2NTkcNwJtr+C/1TwJCE+dwVLgcrLPaY3ihJRShcKcnRH6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927475; c=relaxed/simple;
	bh=0FQzczq+XvPIcLSgmN3fW8/Mf+a99S5LM/p3VLvLUUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1aamA2HjwvB7LDN2Opn7V79T+kQ+SSCGp4OgImVn0JIHuB7C2M8gxVMDKGInGcMyC8F3Z+m5ksOQyWCSJ8LQmyUmnxIK05qc1UEB7ZhOdWalz4w8msrCriQBY6joPIIJrNmg71QbRu7XJrKhNvkq4+CnYb40rVNkexRs9zk7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbyYiD6P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759927472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTuvQMGGyHVj/GABY47oNzO2RJy8snMcE51C98ebSFA=;
	b=PbyYiD6Pkr067iVXsDS37Pe+cvMqywdQxzeHk1L+FcjBeh7jmYMCD9pd+eVVHkF6M1qBtV
	lHXRZ6pVo1iKxYXP6zFSymg0SCPRZ52pgvW+dpyClLFDE3JjitJxw4qBXVVtAxqev+2Vh0
	gLFYb6ddj1C+SHFmuGyNTQ+bPBKF9qo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-WtAYiJoDOX22Oy8OFohKxA-1; Wed, 08 Oct 2025 08:44:28 -0400
X-MC-Unique: WtAYiJoDOX22Oy8OFohKxA-1
X-Mimecast-MFC-AGG-ID: WtAYiJoDOX22Oy8OFohKxA_1759927467
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so38218415e9.3
        for <linux-api@vger.kernel.org>; Wed, 08 Oct 2025 05:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759927467; x=1760532267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTuvQMGGyHVj/GABY47oNzO2RJy8snMcE51C98ebSFA=;
        b=E0auQK+nvtiWcH5IIVZ+sw/NKHbUoVXMyEpAg+7ZuHG6QqC0+S9qL2eO9msj/lgucc
         //pBhPO/ms7fAQEuGe2LpJQG0s9VW46z2QWW7T6TneIGBsJ3oMjeNZhA9dmlzKVfoB8I
         Ws84Vcp38MMooINjHHnAQ6X/7b+qOtvedy2pSx/Kk+ehRyPC+DIVGKWD4r333V3QXhc7
         WN6aiWRy/qrXtZDOtW8iI68hMPe2ZFyzzDWaEqYHTmk011NW3DVkVNG9wKlNTKslIL38
         Wz47UeiTWzUnqk5bIc6ZOV5yxd488OM/ORtmvLiBufXg+j73W7Ioc82D7X/IQd+Lq4N+
         tCQg==
X-Gm-Message-State: AOJu0YxaVB9AxndoAbiPcymvaq5JRe7qRDcesryIO4GjXmzUGzrZ7iqe
	d/YJb89IjVWrIljZBDelC2/EDIfATj1Fagc1SLyLPeWoiAp8H/uymKoeSGCRJ0Qsqj3k4fyp0d7
	rGuOqPc++dyE/Sl5dXWs6SMxoyKuGx2CtWrykfcNyqy6Fu7YQ//d/0Su4RBEF
X-Gm-Gg: ASbGncsvx7bWTgS3QLhulOUi3z5UuJrklvwkDZaimLqfroNLjd8iOGBQYLMAUp9aunJ
	qLVnTbbJFfTLqikOzNKlqwyS2f0ymttpS2fyYE0iVBpCSpEOWTB281nuH3wZMdqFTNDFft+Qe/B
	fEAP9l9YDLq98xhcDJj0nciz13iso/57SoPyPXU/2tBr8EDyp5ZKf9xX0SSdBV3SthjUeUof648
	ZehHa4XfjS5tPO6qi5qqxy+KVdlDeOY409pHZapSvN5mKNvOqIGAHyFZhBbfI+cwMsRqd4C++rH
	tIBgZTtw7M99jXNjMISDT3Twgzn22JE3bO0b70k4zAI8/zl8fFuiiIn2ABME+0ZozS1RkuIz
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id 5b1f17b1804b1-46fa9af0621mr20360675e9.19.1759927467225;
        Wed, 08 Oct 2025 05:44:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUOOWjGZbNdj8gMQY80gtaJEpiEmEfUTkvwjILGRLj8xEez7HmT/bGwpHIikuJuXE2VGR3WQ==
X-Received: by 2002:a05:600c:4753:b0:46e:1d8d:cfb6 with SMTP id 5b1f17b1804b1-46fa9af0621mr20360455e9.19.1759927466628;
        Wed, 08 Oct 2025 05:44:26 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d438fsm13918765e9.2.2025.10.08.05.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 05:44:23 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 08 Oct 2025 14:44:18 +0200
Subject: [PATCH 2/2] fs: return EOPNOTSUPP from file_setattr/file_getattr
 syscalls
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-eopnosupp-fix-v1-2-5990de009c9f@kernel.org>
References: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
In-Reply-To: <20251008-eopnosupp-fix-v1-0-5990de009c9f@kernel.org>
To: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1018; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=0FQzczq+XvPIcLSgmN3fW8/Mf+a99S5LM/p3VLvLUUI=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMp7FLGXrP8A6vbUxj0FJYk7QpN39id7xEkWd89QkI
 zpFkg//d+woZWEQ42KQFVNkWSetNTWpSCr/iEGNPMwcViaQIQxcnAIwkdJChv81zi23ZYUvSooz
 rV8jnbo2JlSBw+6ARlfjho/CMi9lDOQZ/unft+y8uohbU15J7LPhvrUve3LPuzVyGeXnnAn6cq/
 9HjcAeUxC6A==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

These syscalls call to vfs_fileattr_get/set functions which return
ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
inode. For syscalls EOPNOTSUPP would be more appropriate return error.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/file_attr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 460b2dd21a85..5e3e2aba97b5 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	}
 
 	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error == -ENOIOCTLCMD)
+		error = -EOPNOTSUPP;
 	if (error)
 		return error;
 
@@ -483,6 +485,8 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	if (!error) {
 		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
 					 filepath.dentry, &fa);
+		if (error == -ENOIOCTLCMD)
+			error = -EOPNOTSUPP;
 		mnt_drop_write(filepath.mnt);
 	}
 

-- 
2.51.0


