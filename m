Return-Path: <linux-api+bounces-3392-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF1A68143
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 01:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A96B189176A
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 00:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807B1B4F09;
	Wed, 19 Mar 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YMPzI8dC"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382671A9B34
	for <linux-api@vger.kernel.org>; Wed, 19 Mar 2025 00:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343348; cv=none; b=RJUIcEO4YrjgcmnFh8XsTytzVzUESBQyEbPP/hmzyN/rDN06Wbw4bpsUYaPJuhZ5UNKuvU24LFyEVBILw9kYmRerlw3wqr2YDwe+/3wn6aIYjuNpApRld+Xi1kKDq5Uc2zi1R4O2p+deaynVoTThtlCCU0ZHM7GfIli6OJCUgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343348; c=relaxed/simple;
	bh=5PCOzmacR5yYFup3o8g8dQwSPaboFM0aGB+HiTMI2DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmjqB5Ek4Z+kmnNt9EtWSQz2phCgxKjIEVcZZRDJv1fmQkqzlvRNwWfo3IbHmjBZU8vhjSo3Cl62yt51PrNDOBugQMbqHtriqBduya88DFJuBCoNmb+toZUc3jdsKmZSOOvjAL2kk/yXoDZLBk36AdCO5xDjwLhRooXaK9UNGMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YMPzI8dC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224341bbc1dso119939465ad.3
        for <linux-api@vger.kernel.org>; Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343346; x=1742948146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Q0E5apPluO3qX6mmuEZ2SRhcKnzs7kllQ/gSC8Vl0=;
        b=YMPzI8dCZhmG0Jgrf9/z4ds0YcgMu4ROkPE9Wwm8zEbNQbTxIZakULjVeXB/WrXl+f
         m9Xf2ZWsM5ytUURf3JCxWr8GSMeMG9JXni/Zod7xJ40W92K1dPyhWLXmUAmwmAjY5WoO
         rG7RgM+Qm5FLNMSZ3wgnazMpZRemKFcKlKPuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343346; x=1742948146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Q0E5apPluO3qX6mmuEZ2SRhcKnzs7kllQ/gSC8Vl0=;
        b=r1LulRU5TJ11+wjoZd1Ts+qfp10mXk95a4qnSSIEQ6wlZan/aqcarO8WVxAhOgT/Bw
         W+4JrABFQurE4TNukAsTkl9fEw/HDxX6ZugKBTu/O7a3SQlDcXSumIclszQqVCunbIDK
         RzqQH/VbFU7lfS3+B+sF1xwy8p6WcWExfKN1nGxaZntd6QDYtuKCSSNd8aaE35SNs5pV
         imbGiQkYPbCGvQTf54yod9aSq9mghQ/SG8oxIpyCmStLvZqGDxew3xAvHgRJVfL3Svxy
         eDdQszFWK06owHQ9vCF68X1+2kZ0ayKzHmIdE6Vu+B/VX5yuL1RIvSexROJ91VB1BD7B
         p84w==
X-Forwarded-Encrypted: i=1; AJvYcCUuYR2inGds11XlGam/Iru0LIteDdeko6tKTY2crZD/h20h+WDFc8vEqfw4CbpFrQattldIwEoQKwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXo1ceT+hEu4JtvBXEIHo2CnNr95gZ0ZvunYJF8V2M3rp3jg6b
	x/cTf3vnBMOXs4x1AWPq/+VewkKQ8Km4HsxavIu4y/My0Zn/uyQKshNMrm9IFjE=
X-Gm-Gg: ASbGnctIfXq71aL/zMiIrqzI2KHmT5Y5cifjArNrJfwV9BmbJqZ0PmzhJeW02yDZvw0
	8HJP9iNmF3KxgPE9nFJa5X7Ycyij1Pywhh+SWKnUDJYAGApLBm6yIJDN0i5Yg5KFiGNB7ejlwxB
	ltz4smms06DxD3x6l2pSBlMwgUOk8Pvv3YNKw+/iwd4GWPwSprPts6xXS647B4PBRyEnLNZEqEN
	/Zur41quWrJLQ8Ui0gutk/TzcI5QR1m1p99zefg3TgHVKxFt15c29xwv6v86mplxYmQGyCCB0i6
	QlDkUShvdow+cOHsb9m8SU8/dLzMi4HjhVRVaRS7b4CORlhxsdt9ZzynA/p+5+k=
X-Google-Smtp-Source: AGHT+IEOR8SkYAUNB17u62ljjwaf2hFD6D0NrcmHhlERldyKjuA2Rr70AEoQme8oc1Ybx9thwa9WTg==
X-Received: by 2002:a17:902:f646:b0:210:fce4:11ec with SMTP id d9443c01a7336-226497ffb08mr9977165ad.1.1742343346457;
        Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
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
Subject: [RFC -next 06/10] fs: Extend do_sendfile to take a flags argument
Date: Wed, 19 Mar 2025 00:15:17 +0000
Message-ID: <20250319001521.53249-7-jdamato@fastly.com>
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

Extend the internal do_sendfile to take a flags argument, which will be
used in future commits to signal that userland wants zerocopy
notifications.

This commit does not change anything about sendfile or sendfile64.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index a6133241dfb8..03d2a93c3d1b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1293,7 +1293,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 #endif /* CONFIG_COMPAT */
 
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
-			   size_t count, loff_t max)
+			   size_t count, loff_t max, int flags)
 {
 	struct inode *in_inode, *out_inode;
 	struct pipe_inode_info *opipe;
@@ -1398,13 +1398,13 @@ SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd, off_t __user *, offset, size_
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
 		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, size_t, count)
@@ -1415,13 +1415,13 @@ SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, si
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -1436,13 +1436,13 @@ COMPAT_SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd,
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
 		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
@@ -1454,13 +1454,13 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 #endif
 
-- 
2.43.0


