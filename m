Return-Path: <linux-api+bounces-6572-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fUa7Aje7I2oaxgEAu9opvQ
	(envelope-from <linux-api+bounces-6572-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 06 Jun 2026 08:16:23 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DB664CB15
	for <lists+linux-api@lfdr.de>; Sat, 06 Jun 2026 08:16:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=L4s7ECxT;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6572-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6572-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A534305F58B
	for <lists+linux-api@lfdr.de>; Sat,  6 Jun 2026 06:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EC030C629;
	Sat,  6 Jun 2026 06:12:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470162FD1B6
	for <linux-api@vger.kernel.org>; Sat,  6 Jun 2026 06:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726361; cv=none; b=aQZ/DNfTAqQQ3s4/9h9S+3T1KVVX5djA9pxZyJy6ondky96H2tvkpbJGQpa4rZSRFN03/sOpT+/nQr9gUQx4d0+ujLfkLtGwsCoxI3UlwXKWGxF6za7rikIdzXK0RbSfIT2FLKdoRjPP6kRFYaLucs+gKHtGb2YYtSUzBMPKAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726361; c=relaxed/simple;
	bh=qZiu7fS8kCZwF8htRjH//VRi7MyCn+kxzvosWiYjiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8cLnAMAxk9NRhQSU92FO31wknV+4cagKiTMGyz38fIgZq+a7FWBnDWE/QFCjQwgpC/YYiNxeBafanJbfjRrQRLMNgR1H/IQIAkMIBfQNLQE4zRXkPeDUMo9lQyYVqSqF8S5rTXW8cuGlMBTQ3atlzqDEbdBEKDfIIZrbG1MzGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4s7ECxT; arc=none smtp.client-ip=209.85.221.54
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-46015dc517aso2156080f8f.2
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726357; x=1781331157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=L4s7ECxTUjG0RDR3WRK3BqiiobD46Pe2PuXxbGIjV7aQ7oZjPFdSWw9K+z8QGFl9vd
         ooopF3muoWuT8/+JvGAAQly7+qEYOjvnyirFepJ1O+L2ozkOox3jTYsaWlX59Cm6Jr+b
         uF69w7fjnJcEPFFSves52eqvnSji2yx1Pq034qcRi8pn0wMhVyR/EhwYyNfkK3pBxhTt
         xfLpYL4v01Nd/smdKvYZalHR7hMy9sYdamMYZWsRDyep9SNVzk8zm6qofTd4BYKWOD4c
         EifQHVjNsQG69TrCjxXzvUjJv6LIP5jJTtEfOki8rmwwFw3R1r9qpLpFePMbdgy3P4Uq
         KEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726357; x=1781331157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=O7ML6E1p0ACCdJu+AkZ8GYQH81qzZJR2zCH1sN47/J9tn/2W3TWfH2h3lFFMW+KaV7
         /0SAlr/L3Hh4m3kYed7BFLQZr77VoA0zX/pm+4vKlvLZU7VmbTTPTTInp7Aoezeu4e+U
         GO5hJL1Kcn5kANm6VU+uleA11zOMPfAl+vzRuo5lzIywa/Npr7QSZ5kR0ccoVfVHe0Bq
         aR3uPmCsC3rhkBExVTcmdGnEcNZQ98pzkQis9yEMx4/2sDdEl/AAmhuMdZc9k1Xxjx+p
         h0Yf9vQKlc/tmMmnqAM/4n5weylpIegaBtN5gHjxKpulLyZYMa4QtniKC+xM+kxkWwuc
         kysQ==
X-Forwarded-Encrypted: i=1; AFNElJ8THPDpCaw/w+gxgfw0bC8KvO0PLnHY+95CfTekPCvFWkKDhJZUUnK8eJywY4pLw+DIZTTzkwFK3ss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpty2iKAWWvQCJ73aXvqmtV3oW/Iiad7kxtgcjmvhPeWop4k3r
	ywEdP5qtI0SIWcFwykNNOmbNmsctN+hq7zDPgTXSRidV6lTWw63MeXL2
X-Gm-Gg: Acq92OHobmd85oNdIQaD96sXT6+xvQ627a9pei10NAq2qBrrAf7ucVLnOi0KDSh/UnG
	in7R5Y7VHnesXvtpqiYhP8EcYSdRtevsWIuLw/Ya56rPKf5UYcugI+lbrFHYKvXLBwx5BGqGb5x
	c9ods09/6l3SjPRkrawo5CZ1+pVcgbauvt3vV6u2ScATSOgJ3f5IokBuix1b+cUPkeC6Kf1ckc6
	DWJPwwbbasX80vejpcnnFwXkwx25mJADpXHas4yA/4bvxQtJpGTdrvALY4DC4bJgNQprcmpO1fZ
	pOcCCmzLdOC42ixfn3OTLPYE4dnzZO3kJSpOGGF5hMFrfOya08l+Lz8nHqX3NM+wa1cxzs4MDf5
	d6+k+mmnLgppFGDyF0Cy8wweAkzmohiR2xAgV956xTkqY974VSXbMr/G4dz8Y5DcbCjg/6iBjoJ
	/oYHt0WGpoOnxmCcYiDUviTM94GSkbaw==
X-Received: by 2002:adf:e545:0:b0:45e:e44b:3136 with SMTP id ffacd0b85a97d-4603063a715mr8180799f8f.19.1780726356710;
        Fri, 05 Jun 2026 23:12:36 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f344541sm29667978f8f.22.2026.06.05.23.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:12:36 -0700 (PDT)
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
	ltp@lists.linux.it,
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
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 4/5] pipe: move wait_for_space to fs/pipe.c and rename it
Date: Sat,  6 Jun 2026 06:10:30 +0000
Message-ID: <20260606061031.3744880-5-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6572-lists,linux-api=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:ltp@lists.linux.it,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:luto@amacapital.net,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:metze@samba.org,m:rostedt@goodmis.org,m:kernel@infinite-source.de,m:w@1wt.eu,m:joannelkoong@gmail.com,m:patches@lists.linux.dev,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,lists.linux.it,linux-foundation.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,amacapital.net,gmail.com,samba.org,goodmis.org,infinite-source.de,1wt.eu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50DB664CB15

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


