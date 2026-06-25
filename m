Return-Path: <linux-api+bounces-6668-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mwz0BNzoPGoxuQgAu9opvQ
	(envelope-from <linux-api+bounces-6668-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:37:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C65E6C3E64
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:37:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="JkDvh/3U";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6668-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6668-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D2203008466
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 08:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71694380FD3;
	Thu, 25 Jun 2026 08:36:27 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEBC380FFF
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 08:36:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376587; cv=none; b=Y3FwZF7U9v+h8fU4Nk9rqiOu1K4+n5U9CueoZ8ywe7J6v/lOmLQTEgawMQFtujs2LiG7uM7fNlm3kIFl2Bc4Cn6/BT5Ip3/6JRFAhmfn08+7MN+MhmxWdu7uJNv9bNDEAN8RK9KNF7N2JYtKBDZkBww/mafAR6r8K4NU57l5YOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376587; c=relaxed/simple;
	bh=qZiu7fS8kCZwF8htRjH//VRi7MyCn+kxzvosWiYjiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN1qMyXAfoL1gqHCw/i8Eo/fPHN1gFGiO+V8tvt6I3UAbagbYqjf5MgZ0IUNozCGZOLVPS8jJPMaOpESpovxB9wqnBiSi5fDeuR+T2fSZysDCcVTOTgoialmO3Nlileg7GbhUTUzeI+1KhyuBlI3+wzI5q4KWp/3vujhBBEHZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkDvh/3U; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49249707788so10115145e9.2
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376584; x=1782981384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=JkDvh/3UEJ/KKFD95OenoyJPpGWz0C30rNVG/xSx51ViDMBLykodCQP6LLextigjSb
         Y+jWkxDP+JbxE9m5wvysc5XRaMS04mdOgooXX+hmgcEA2mMzG1aGFJdXTf3wL8y5GG6y
         eeMUmObFy2ZxgNbr5ubK4MO+xgsTjL4fnnI/4wHvB+6nKCs+Xj7uWsF2rQyYvauxXFTd
         0103O0ryVXNJWWS10mzD3Ly7L5QqOadPrC8aLIwBBIDyNfRYmOdSi7j7Ffb9igpVBFYs
         kJhL7N1TAZSYiZRFKmz9r1cT++Bz7Rg2MVdnnbDt8fH8n+MIfC5SjvyzhyrVoa7PidLt
         icEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376584; x=1782981384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=HZk+O8s2q3jTwwrU6oHK4zS1ZjURx/Lg/dfRvwNDPtjg/GFnMsWM9Fjkxe2mmqffLF
         aeivdTBUWwOrUD5mrRmoUiTjOHXuuHCmJjbk+BFKEZwC1Vf6iOHbrVuqghm/QURlf+AB
         Wjfi7UcLCBcIvmpAV0ooBCevwihnIB7cWddGP38LwKsG8MxUplsYBI4iKRtGlGMWcugM
         82TmhlTmlA1gmCNe2RZs2rLrtoSsBq0JVTASSKwDMx8BtNd+KkVHeNu1uhhRoKbqsrCh
         aPDHqn7Jrp5xEMQ28JVZBB07PIYY4toh2ax0ombw7w8S83pPEaqDP85q/BSUE/cVc0tF
         lSpw==
X-Forwarded-Encrypted: i=1; AFNElJ+jd8BK37tR22xqFFVSBGrqI+nj5ENPtoxgpqZwYk1+Juighn+67ErYdsa822bNGDXnOVM+cA8YnWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZW5gv/AY/KMMWpo7CyNBzzLFCD2Msj4kz9e1rdUkvvl8pQIKX
	eIexblc+snpFA/r4hEdzdJiL+hne7SPwZ0WFCRViPEQKoZ2nFXou/Dx6
X-Gm-Gg: AfdE7clDmSX9K1C5igtk0UESgKrQAmb1jN8jGu2CC+CSqCpC5SehFxIGzXU04aBL/Up
	WXsRcrQq/o9ivPHgkpHJANEea5FGfy5NCgx2ctmNAfcP/FofpaK09IIOwbdvZJRUofkFKp7sN+J
	fPQaYT0/puiegGUXfiQSMFY0SzFtIgoaObsjrSzc2oIzx90oOXH4CRaMWDGjVIU8penY7LoJ/mJ
	0RiqW/SLWZXql5NrisWjVTFfJ/zWSpyPco38ic9AWHQr5YuIyluPTynOe0D8NlXCF+ZdrANbYXd
	Ztpwq5Lz0jkK+0QeDdE7XatWcaGwP78PbystohZryZs73gFBDk/WEqSOrkpgMMwJJLU1Udm2kD4
	xae5qv0eHemqHIMXYdS08wQ6n3k81uVFRW2y7qY1ptn9zaKKifhMbxIk+SO7wuNTsLOBesxO4rF
	q2oV7E1m5v
X-Received: by 2002:a05:600c:c4aa:b0:490:b189:212d with SMTP id 5b1f17b1804b1-492668a83dbmr17827635e9.33.1782376584308;
        Thu, 25 Jun 2026 01:36:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c2279b85csm13362284f8f.28.2026.06.25.01.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:36:23 -0700 (PDT)
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
Subject: [PATCH v2 4/7] pipe: move wait_for_space to fs/pipe.c and rename it
Date: Thu, 25 Jun 2026 08:34:06 +0000
Message-ID: <20260625083409.3769242-5-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6668-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C65E6C3E64

This is needed, because I plan to use it in fs/read_write.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/pipe.c                 | 17 +++++++++++++++++
 fs/splice.c               | 19 +------------------
 include/linux/pipe_fs_i.h |  2 ++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9..c0ccf21b9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1451,6 +1451,23 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	return ret;
 }
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block)
+{
+	for (;;) {
+		if (unlikely(!pipe->readers)) {
+			send_sig(SIGPIPE, current, 0);
+			return -EPIPE;
+		}
+		if (!pipe_is_full(pipe))
+			return 0;
+		if (non_block)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		pipe_wait_writable(pipe);
+	}
+}
+
 static const struct super_operations pipefs_ops = {
 	.destroy_inode = free_inode_nonrcu,
 	.statfs = simple_statfs,
diff --git a/fs/splice.c b/fs/splice.c
index 707db2c2c..d12243d19 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,23 +1239,6 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
-{
-	for (;;) {
-		if (unlikely(!pipe->readers)) {
-			send_sig(SIGPIPE, current, 0);
-			return -EPIPE;
-		}
-		if (!pipe_is_full(pipe))
-			return 0;
-		if (non_block)
-			return -EAGAIN;
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-		pipe_wait_writable(pipe);
-	}
-}
-
 static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
@@ -1268,7 +1251,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
+	ret = pipe_wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index a1eeed800..be653625d 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -335,4 +335,6 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 int create_pipe_files(struct file **, int);
 unsigned int round_pipe_size(unsigned int size);
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block);
+
 #endif
-- 
2.47.3


