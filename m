Return-Path: <linux-api+bounces-6665-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lk88FmXoPGrzuAgAu9opvQ
	(envelope-from <linux-api+bounces-6665-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:35:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE26C3DE2
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:35:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IvVtfjAn;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6665-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6665-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56C083018C06
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 08:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08E380FDB;
	Thu, 25 Jun 2026 08:35:16 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B6037B41E
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 08:35:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376516; cv=none; b=ex+WdjpM0REOytT2z+YclYe53Y0PjjwDkKNrPgFBWAbkt3R++nC6MjDauZecUlyu5J+ZbfOpeIroZPj12DoC7DEd0J1Rron4jD/XgawzstZymb9kR4UYmAy3iUhqp7pnHaYk7r6G+5vRijiE+csj9jwESGNr9w+YBzauQdLzLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376516; c=relaxed/simple;
	bh=QtIkhOcb4XuSPNMSHsQTam2xRok/IOw4SC1HUoDCl24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gljhm2Z+xYM+M56ZoQyoJcOmGqgc/eeDiepK14NKg3cnGOb2CFpOslG68xjHexOGRqqKBq+VXefzqt0+xC2kOtQb/whxpPLSu7eQcOTQ+KmFTSe6Qzr1+yKFskudBC6v++/iZ0OupFggwjViodK5Zi/aa33zmS7VvBnvF/vHc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvVtfjAn; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-46cacc39191so253576f8f.0
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376513; x=1782981313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
        b=IvVtfjAnKaBK/0oQMtnLDiuV4uWEGKXPXAe+AlxRHG6MnbRdOnwIUfAKJjX57utGZS
         RA93kED8fJa9O5rFjZ+0xpmGWVHSGJekcF4QjLRE+9tIfLia59YTnsl5uCFNeaniCHYM
         5ZzmM6WJ/eA/ZQgbCsLgjOKHc5QpvB8SEkaetLP6sDVxwCT9Xbf79YBfNv/qFqmFb1eR
         GqdtIomwz2L9o19YnNZzwc8yfe+1sOCd2S9kf+44M9mXX/WaaS9HEOsL1d9bD/AsSE7U
         LxGhViFq3CN1cDSLLxRgrgwei7VAOJ71DV4FvcjrUCQB/zwz2D3jyNKU/qsz7in7C5lc
         AwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376513; x=1782981313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
        b=Z0VuYLUmUtjJ4S3mDarcrMtU+ZMjlbZVaRbERKUvxZol9j6xk9Kmhe90hFi5Q6ruds
         0hgnWquhhFetnij/vlAL3gZfkXS4jN5GZn7PxMqpKfwpWtluG9H+I/oOpf/e1KnW5WjT
         v8FpIfgwkwtfqceaFaqoVvYF27tKcJD06dKUziplgLjIctr6ffYbhvr/dUdDTMiw1eK1
         iLjZ0KxekxzRUI4+OJgLWK+6EyvyDYpKwDY5a+qGlFq9sMgW3Bjk5V8XiCWv1y6flx3k
         BLWC8PqYLo81hfri/kxwuPmxt/EE065KPZgxFrmXzMbGRefCC9rlh1nrDvQEuhFC3gey
         NEYg==
X-Forwarded-Encrypted: i=1; AHgh+RrkxBrQp5r2AOX2X75EgBZ60LYk7URjRPAsWhv+hagxbOjw9LjOCXFh9bjZFbc3aNRSOJX0dKaOREg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5perEifMqJWqfGAHIzES4CQAbOKYm9jqtK0nsVkNg2pq59uVL
	2HyHoA3nsYzRQgPdKgZaj77AfsA5is4rmi3NntdCV3DdtTqaxx9Vcjcb
X-Gm-Gg: AfdE7cmvXQI/AbS7r+WQDKBKVCkavpArmH2vSGQ1vWmJFqu7gI/u9GFJqozMsDexCY8
	TemP6y+oZkUkX54cYTrXjCl5Hb6gblJldu5Kdnw8bWOgIQwp7h5gOKDqywMsvI6ZrO+g1ufHtne
	VD96LhRvbHi64J27YjYVjieeIibVQVi/B5BfkXG0gPaoE42zR28Nk98sS4EAyi25plz++FlehNg
	ljHBTkiBWL0khBFqmEe60BTWKOEcDlqCJBxn9fkIikqn2duoVlm50DHqLJsp/TXVkKsbUC3vCnR
	60ejV63YdipBC0yBUlxTRC4wkrO5X9vV4O+Zb0Yba1i/4a91UH7TQwy1JmnCkOM5F3E00QchGsq
	AiSveVEg1buWSyuVQLZMuGrs3iYUyyFN3mXC8MTy/1dRjzKm5KUkiraROet1iITlsBiwiYTB/NJ
	KR/QI6hR+F
X-Received: by 2002:a05:6000:4603:b0:460:602f:85a6 with SMTP id ffacd0b85a97d-46da34965dbmr2376831f8f.0.1782376512951;
        Thu, 25 Jun 2026 01:35:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c9ed7491esm9926887f8f.37.2026.06.25.01.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:35:11 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 1/7] vmsplice: open-code do_writev and do_readv
Date: Thu, 25 Jun 2026 08:34:03 +0000
Message-ID: <20260625083409.3769242-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6665-lists,linux-api=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:luto@amacapital.net,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:metze@samba.org,m:kernel@infinite-source.de,m:w@1wt.eu,m:joannelkoong@gmail.com,m:val@packett.cool,m:avagin@gmail.com,m:patches@lists.linux.dev,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,linux-foundation.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,amacapital.net,gmail.com,samba.org,infinite-source.de,1wt.eu,packett.cool];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDFE26C3DE2

My previous vmsplice patch did the following mistake: I did
"CLASS(fd, f)(fd)", then did some checks on resulting "struct file",
then passed numeric (!) file descriptor to a function.

This is somewhat okay in this particular case, but I still think
this is code smell, so I fix this by open-coding do_writev and do_readv.

Also I insert a comment to warn other developers to keep
do_writev and do_readv in sync with vmsplice(2).

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1e5444f4d..e224e7cb8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1070,6 +1070,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 			unsigned long vlen, rwf_t flags)
 {
+	/* All future changes to this function should be kept in sync with vmsplice(2). */
 	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
@@ -1093,6 +1094,7 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 			 unsigned long vlen, rwf_t flags)
 {
+	/* All future changes to this function should be kept in sync with vmsplice(2). */
 	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
@@ -1226,14 +1228,24 @@ SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
 	if (fd_empty(f))
 		return -EBADF;
 
-	/* We do do_writev/do_readv, so it is okay to pass "false" here */
+	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
 	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
 		return -EBADF;
 
-	if (fd_file(f)->f_mode & FMODE_WRITE)
-		return do_writev(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
-	else
-		return do_readv(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+	if (fd_file(f)->f_mode & FMODE_WRITE) {
+		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		if (ret > 0)
+			add_wchar(current, ret);
+		inc_syscw(current);
+		return ret;
+	} else {
+		ssize_t ret = vfs_readv(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+
+		if (ret > 0)
+			add_rchar(current, ret);
+		inc_syscr(current);
+		return ret;
+	}
 }
 
 /*
-- 
2.47.3


