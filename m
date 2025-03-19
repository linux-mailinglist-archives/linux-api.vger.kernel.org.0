Return-Path: <linux-api+bounces-3388-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32EBA6812B
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 01:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D5A17859E
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 00:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486A514A4E7;
	Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gMn0Gk81"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E43595B
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343342; cv=none; b=p6XlAZwAkXN8VMSOyCAplMADByWxrO9+u/Y3P/Lf1iwbZ5jHD7/acyRND3fYmv89K4rehwUx9KzFYUZkn/SUjhhs7Na8wn6qrVyYtblE9+npDLusa1rTU43xeBqki7cCovB1z8tGHISMLfXFljXwIPpiVfGRQotAaffiEUpwQoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343342; c=relaxed/simple;
	bh=zDwqRePv1ZFUDi9FjMPQDVKfJ1n1RRe7hhmBOVzyCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzcWg8nyIcqtQDUlAH43sHg7WMEpNHXYSA3as7yVV+V18OLR3E9p2hd7OoQ5jRIii3rbORFJrnggcyJRzJb9gd+HlB9vG/RY+X34CJRKujUv6r1w2QHIGmASe5XAEQXNUt2C2VscbWKf8QDIgjsNTTYqRORT9AtiQ5JVus/nPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gMn0Gk81; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso7213673a91.1
        for <linux-api@vger.kernel.org>; Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343339; x=1742948139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=gMn0Gk81p6q/vZ4LGycCtV8PrWqmKL2X2+1X7JUYuAk7MxmnWIJuOfblGJYKzH1qHS
         NHGtmlgyX/4nIO0x+NDViqz93DL2F52q8hztCpCwajF3yIzTdhN8LJJc8uSXOkRRSbyx
         r8JDzvsMP8tNb3e/DiHLdTjOx59RF5ciEg/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343339; x=1742948139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=VN9ZxW3LOIdpkb5SgER8fOO2SBIjIIlHapOn4XZoHglaeM+8AKFwBP8E6z2C79gIwk
         h6wKJyUUWLfUwLibXfVwI5FS/FnM6/97+/FX1TUkr+8ksYS5LyAbpHFiUcxjZLwpEtDW
         ihLmBdrzU9CaM/2uUXdepI6FdF7rOKog8twfgp2zvlSrbGpZcv/v/vyP3hLs9gUHkR1Z
         QyLOKbi5mO1tjEV9HVDfvY1ZL9dpDxgn8dHqmUhqf8CHZAOnRVrI7joZMzFk0PsB4F30
         jzkECfsF/WpgwjPuQ6fnwT/rlePxa+btw4BPsRiWDY91jecU4RaJO/0I/4bTEQU1df9W
         qgVw==
X-Forwarded-Encrypted: i=1; AJvYcCW4KPhzD8GUQkcJ422m2ZgXYWGcGpm40eA/O9EOetWIBVOgtJ7DKhVjjzw8mZ6+CFpKaMZyaOoEF6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vrtC4o28krg1/de+nkMu/pO8+tI4rCuminSbua69h28d7CfZ
	6l/1pUGd8Z5dSEXPn2KGbqixJ8t3033xhQfSgv5c43IJ2fNi33nukjDByNCoNdU=
X-Gm-Gg: ASbGnct88FAwEFqM68gFTO5+otqDLuEt7tjwYxSFTUzPzvfDJzZz2fE0cba9FYKLnXj
	qDVPQigOWn12VPgQSQjDryQ/vT0zJfNT7Fbg+B+Axm8X77SVjcsYAevhQLWoisYRW5DlEkjihST
	N/nLz9hjX9FqZpRqkVlL2sH4YwApGMsYFYcixXavraM5iJ05Gkokx8PGhOGHqB/DLIQMyHFtSwU
	MMRxB6pimZO3bRem1yQmiXu3l8ApNJAgHhQjJWSFqGYEoAjYcdiwBQZ1Hl4+G4XzBL/KHxZTIY+
	9QOEUYe9GAl/l9cNsu85/eYElfd7k+8MtCsT7sfBb/BMaJJCOe4aH/BXEhdJG8s=
X-Google-Smtp-Source: AGHT+IEnc6PYsekT6MewbYE2xz5zbksEbwPRypdKB1fVzKJg+O8NyDF3d1M1ZZ7rEg687HtSnDkx0Q==
X-Received: by 2002:a17:90b:2f44:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-301be204e8dmr956493a91.30.1742343339529;
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 02/10] splice: Add helper that passes through splice_desc
Date: Wed, 19 Mar 2025 00:15:13 +0000
Message-ID: <20250319001521.53249-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add do_splice_from_sd which takes splice_desc as an argument. This
helper is just a wrapper around splice_write but will be extended. Use
the helper from existing splice code.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..9575074a1296 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -941,6 +941,15 @@ static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
+static ssize_t do_splice_from_sd(struct pipe_inode_info *pipe, struct file *out,
+				 struct splice_desc *sd)
+{
+	if (unlikely(!out->f_op->splice_write))
+		return warn_unsupported(out, "write");
+	return out->f_op->splice_write(pipe, out, sd->opos, sd->total_len,
+				       sd->flags);
+}
+
 /*
  * Indicate to the caller that there was a premature EOF when reading from the
  * source and the caller didn't indicate they would be sending more data after
@@ -1161,7 +1170,7 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 	long ret;
 
 	file_start_write(file);
-	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	ret = do_splice_from_sd(pipe, file, sd);
 	file_end_write(file);
 	return ret;
 }
@@ -1171,7 +1180,7 @@ static int splice_file_range_actor(struct pipe_inode_info *pipe,
 {
 	struct file *file = sd->u.file;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	return do_splice_from_sd(pipe, file, sd);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
-- 
2.43.0


