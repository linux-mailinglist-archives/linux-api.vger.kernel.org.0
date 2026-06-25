Return-Path: <linux-api+bounces-6667-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 99XHHMfoPGomuQgAu9opvQ
	(envelope-from <linux-api+bounces-6667-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:37:27 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0F6C3E3C
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ubondpu6;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6667-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6667-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81B603019C94
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063893812C7;
	Thu, 25 Jun 2026 08:36:04 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD851344D92
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 08:36:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376563; cv=none; b=uiJBZ0mphXbwdmoeRtJH43lg7HDVjpYaxvWYTzDxAtEFg5wtFWMs9BhPu0UNxCU50H23ubnwD+mutJbheuFjR+xkrQjaJkFgSf69Oq8khTTb8okJOEqyK+0zW3B1ekepMiR9pkjsHrX1f+zZTUc4GXB/+6faEWJu//OxbDnj3ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376563; c=relaxed/simple;
	bh=cFehA3I9prjpPS9MpvxHw5vuJaTELUrjhx5IPWyT2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgzPnKCRdWtpKBE7zoz85x8+TB/hIKRHFESO3BTD7agHjRT22nbDZsdwelAmVb8KdfPBAxbg4wgMobk/fp5ZudXU2clDERIKX9chelBPC2YMjQBvemae9CPXLJfOQx8U2OmDKf8A28qGXdOj/zlA8VEkLaCsVt/ntudxtgl1bKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ubondpu6; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso19661315e9.3
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376561; x=1782981361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=Ubondpu6xJgw/p84wAy8wNH/JR5wUCsCd/5xeQSpoNrfjzYHLUwW8PBbPetdv0J4jl
         O94zcjadi65puUvpau74wT5BgSn//VHTqqIGGsONw3MI/n/FrxOrqCrhL7VyTXvLWGnE
         HPDOMUBZB9AYgKkkkyyVAxnQTkdR/cRFmGfInKWLNmBYNAThciWyKzYzkDFCSrEg4WzM
         WZavq5gQo95nHZcd7d8LuTkVUcPnP9kN0A7XjFPa2MgBiW2JiQ9CZBp+Jxw54vN4GFV7
         IG/oHhjwJVK88hdwkyQdESlXyM1I/7dDyaEQ0s6mkM9fLog6IlI//dvhOP/fAoQLTnJt
         3+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376561; x=1782981361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=e3T3kpXxGPuFpGJhxa98h4yUAPhfNeI58hI+9CPIO4rBUKebYOlU5Fkz2kbzBCkwoh
         OfA9JA+eL/bXtUb8SEQx7IQGD502sriLDQQbi5Cwtoa7D20GpO9UuXRp8rHsia4G6Vv4
         lWr2rzJVIiuf7IgHhqynels7e1AHuqgTMvOgl9qYmcCszFLqvYU5Gxgcn6Eb/z49qF8b
         qDvjvMmY2AO1UsjCka+Lm3DRvXCCO3ZAarwPG0omMgVdbkLy1W9ePCD/gAIQ693tF0q0
         4xX5jTA1NjsWTrAP5z+vkDsu9/krK4zhFZgXCBpRqCW2BEUS3HCAYzs+MG0PGDzuujyb
         IhHQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DhzNJOdDiLFGkvdIKzaRFzVIGVx4zVnsEKpW0qPOWxyO90TMfvp78tl1AXmld2Hr9Ah7xWRIKvr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rS/1za0nZCYIqz3k9jPi5dLNeHLMCy2cSotEKszRgf35n0JN
	ukZkR9LtpHxgS5rpj+MFiBNUrOVIvLf9A/Bvzfuqefd0/sEJPH1obKGS
X-Gm-Gg: AfdE7cmU9VXpU/X93K11KMYufIe3i7Urnyma+vYV5YhL6DtkYROIsUILGmjRz7iBQb5
	4IiD3dAL5ypnHFv6msT5RJaquNdarLlq2yJ0HDXG/HK1OjeS6+3ih9OLoemcug5QMAJCdNVy2hE
	eXRbH5lXZ9bg7hWkQCij79IkwjEJmdaMTkPPV2pl84/VtNbifKhS74jdr0vWwzoMcfb5dC5ZVrZ
	DGXBJmy6Jyg1xdw33lLBy9WhG2bNX+9LAdWa2ueHwrj2plNW+pIKZlTAclgVg2l/U8v51X+gy0k
	VsgZ51W2GRWAJsP29DCX0J1LthGoPHazVskxTKfp+Wsp0LZsDfKa0x0VCszGp3V1XvmOmrXmBAh
	ui0ofJqnHZsWRcptK0FGn4GVaum73BGrdWLoJVTCah0po63ceHO/V9AmE5wLXesFESPAe+ytjYl
	V5It0xPOk1
X-Received: by 2002:a05:600c:c0d2:20b0:492:41c9:886b with SMTP id 5b1f17b1804b1-4926684c948mr14881805e9.14.1782376560755;
        Thu, 25 Jun 2026 01:36:00 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4926401a2e7sm80070205e9.3.2026.06.25.01.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:36:00 -0700 (PDT)
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
Subject: [PATCH v2 3/7] splice: turn wait_for_space flags argument into bool
Date: Thu, 25 Jun 2026 08:34:05 +0000
Message-ID: <20260625083409.3769242-4-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6667-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6F0F6C3E3C

I want to do this, because I will move this function to fs/pipe.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6ddf7dd72..707db2c2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
+static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
 {
 	for (;;) {
 		if (unlikely(!pipe->readers)) {
@@ -1248,7 +1248,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 		}
 		if (!pipe_is_full(pipe))
 			return 0;
-		if (flags & SPLICE_F_NONBLOCK)
+		if (non_block)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -1268,7 +1268,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags);
+	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
-- 
2.47.3


