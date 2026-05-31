Return-Path: <linux-api+bounces-6471-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOjHCZ6JG2rMDwkAu9opvQ
	(envelope-from <linux-api+bounces-6471-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:06:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FBD614184
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8994307ED96
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 01:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3202571A9;
	Sun, 31 May 2026 01:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCfvO7qB"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71C1A683E
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189388; cv=none; b=scHR9yJD3wsIhQr0X96mRAq9ai3SMlVKvRZFj0I47rXST1YZ4p4tqLTkYcUpeTgAngDJHpkXTXrEi4CAGAK48Odzl6yv9o+i4igJHc9CDCwH6bd8z9GTcRxj94G305fJ+mvOwWSmpncBDg/VOzLGBLNEnVtWAfZqPJnfPPctWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189388; c=relaxed/simple;
	bh=APiFWZXTnRfbG+HwF1DJ9n4FtfK50FyeJSRq8kImSmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw1rLOboOHFCMxiQbSu65WmXwC14YAdLLF3MyQbqq4jbG69ZvEXV9mvOQ07QJKLZPvWuFvZLDg1j19B8DQGofKDXZMZp0etNUpRjXAdhg0fPAmdLupHb+OZ9jk6/G7lEY+x+q8vPm9w/je4tkqGrqOuJJbbPAHStG/XyI0vwzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCfvO7qB; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45efa0326fdso545306f8f.1
        for <linux-api@vger.kernel.org>; Sat, 30 May 2026 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189385; x=1780794185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xcR4llDLZ21dX5aGAHoZFyM5vQ6lE/uFW6fHX8pUaI=;
        b=jCfvO7qBVVXKTcOlfUa6tSZO8/gjbdh1BF6NE9G3o80DPXyDhMitwi1hSC20yG73Zr
         Di/I9DSUSzgUkdD/Xnhme2MNWHgw679ZK6z8dT+WEPR/B6Mxgfsnu20MZpLqQjLgDz20
         lzbSB6VVmc/BvsDeK7tPSK90BaGVhabvFMQNyQtoWPVYdbeqUoU6o27XN/xwFNFEwywD
         dSshlovJ0vlIZaUjuAlnMnrkeUlMmj29U0pB/x3rI0wtn83yzuIWa/d8O8Vwt8IkYmq6
         jSgQ4EJ+MK+Ie+hCNmf32BtZmbr3w+6rszUuUOCGPtkXRAhjEx+ggatc0Wwe6X+pu3x0
         U3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189385; x=1780794185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+xcR4llDLZ21dX5aGAHoZFyM5vQ6lE/uFW6fHX8pUaI=;
        b=nmA2ag9TtEHX1pDTwCWI36Ds79pcQ4QugOKSD/FH0NC+nd7pgJ/KNl8IkGy7tA5tIo
         DC/LVGzF1lsqOAuJPheyFgIHQlcmkYvC+gp7ydBKXNw6980lv9HJLxbZNcJ/9a/TWG3q
         6z8NurzEO7Gea5kSf9krHBlxqAffjD8ZQM0Qw5Prjg2gC1kwtyMiWqhrtYqk2AyVSnvL
         Mq6DzPGZgZSmNmh9RpifjU5bYu17az4rFFR5oRpmgHTANHslxdsJOxrx9HpQFo+lacIv
         oLauhRb1RBFVXqXZeuVONqQ2XdNexy30vVyqWD3oWqCzLPa2mVSun9W5ToIRvL//kXoL
         /rKg==
X-Forwarded-Encrypted: i=1; AFNElJ+I7BjB7lbE5z2okHv+yDouyS3e3rrhfzNQWcsw7nCslv32mmzqdJi/o/KVX9Ug6r4V/AGCpsUJyvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgGRStd7PWB+28kW0ntCT+Y4SldCp6np6plrPJbbq/HBq9w3c
	vr1bqQb/qtX39qgcsclw0O8kTh9PALoxIzZ2a8oH7ctBSqVWI19ynhqn
X-Gm-Gg: Acq92OH4XXrf4+FxyTCUK5egnx7+xJzo5KoqvLQjyUOPClkuU2+/tfxSjvWVTv8CLzc
	ozqkvaPc0mGjAB8eiUBMJ4HsJCN1hypHORytAgGD2Lt0lHyh7VsNis3IwyBo91QGMBah+opU5RJ
	yrbbSRgutOOZ66kyqZU3K2R1UgyyXhQ2VWoce76oVBYjBLuXbcGhwqgAPnjQIfRqIuE8F0eM9O2
	TVxhv2Rc+ym+E13iVCN8SqxDNwWYOVdpA4TqUFlJHH7rs9PXHIUfjCvaqz2eiS8PwBGGsYpR8t1
	JeTVqIGEdQnqiKSctSOtHInR8ViWDOhQ2ugxuJjeXhI7XsMrV4wavYWpvGlgNB66TCZO5sWaHpN
	bsyyeCOg/AWW6kxon1SRaP9ENBnSO1gOYdYzK8Us2eOGtGVxSidGba1GR1irBLE+XC+Xn1oJEtn
	l8F2kvBrtLl5lGVndZdmyP7eZUXTxMzg==
X-Received: by 2002:a05:600c:e489:20b0:490:467e:a3d7 with SMTP id 5b1f17b1804b1-490a2952798mr65855195e9.30.1780189385274;
        Sat, 30 May 2026 18:03:05 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909ca6575csm218111405e9.4.2026.05.30.18.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:03:04 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: [PATCH 3/3] splice: remove PIPE_BUF_FLAG_GIFT
Date: Sun, 31 May 2026 01:01:07 +0000
Message-ID: <20260531010107.1953702-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6471-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6FBD614184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It is unused now.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/fuse/dev.c             | 1 -
 fs/splice.c               | 6 ++----
 include/linux/pipe_fs_i.h | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..fb8fe0c96692 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2352,7 +2352,6 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				goto out_free;
 
 			*obuf = *ibuf;
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->len = rem;
 			ibuf->offset += obuf->len;
 			ibuf->len -= obuf->len;
diff --git a/fs/splice.c b/fs/splice.c
index b1a4e3713bd6..6ddf7dd72f7b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1622,10 +1622,9 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			*obuf = *ibuf;
 
 			/*
-			 * Don't inherit the gift and merge flags, we need to
+			 * Don't inherit the merge flag, we need to
 			 * prevent multiple steals of this page.
 			 */
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->flags &= ~PIPE_BUF_FLAG_CAN_MERGE;
 
 			obuf->len = len;
@@ -1711,10 +1710,9 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 		*obuf = *ibuf;
 
 		/*
-		 * Don't inherit the gift and merge flag, we need to prevent
+		 * Don't inherit the merge flag, we need to prevent
 		 * multiple steals of this page.
 		 */
-		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 		obuf->flags &= ~PIPE_BUF_FLAG_CAN_MERGE;
 
 		if (obuf->len > len)
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 7f6a92ac9704..a1eeed800669 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -6,7 +6,6 @@
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
-#define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
 #define PIPE_BUF_FLAG_CAN_MERGE	0x10	/* can merge buffers */
 #define PIPE_BUF_FLAG_WHOLE	0x20	/* read() must return entire buffer or error */
-- 
2.47.3


