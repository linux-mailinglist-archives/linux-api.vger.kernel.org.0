Return-Path: <linux-api+bounces-6469-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PneyA6SIG2rMDwkAu9opvQ
	(envelope-from <linux-api+bounces-6469-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:02:28 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C061412B
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14DCB3008FCF
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 01:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1116821CC5A;
	Sun, 31 May 2026 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAvMMyEJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81B816DEB1
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189342; cv=none; b=BBxfBRLeVu9W30UBZcO2RoA8cMEdOn0OeiBbaFOEnEqoep5ayg10+2NpTemsZxxI/R6HtRu43klKWMZwv85BiCrYM6xTIz7Haxdo5KJp6GnDmrYCl9sncedgG+j6enlSW0pFVNntunX6J3IUmKL/ODzmd+F9z7vb6EZC4Gkncdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189342; c=relaxed/simple;
	bh=vsb+QThfs2Jw6QSiFQtsk0PMTT4LF7TO2lj9pLcB1Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxKjMukZw0O23DOxmTz14c+GkXY5LoIV7WPcGR+7grV6v0+qOfEDN/4dvy+uWyFan3WF2w5qpte+sZTmOBw9e0uMJ/FEO2wXekWW53MLa+CN/HtVbwwdEHz7i1dtGgCFqzqfQrJA3iDbYH4jWq+XpC9zTFWd+hOyCJrhoxJKHYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAvMMyEJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so68627905e9.0
        for <linux-api@vger.kernel.org>; Sat, 30 May 2026 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189340; x=1780794140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcbBqWTkzkDxwNMdgJ7xVJp7N/TN/+GdHi920u4savY=;
        b=YAvMMyEJ51N9vhC53xnEEhMm64qQqG1nVXXeYsDkF8PoTdCjhLyZnmzfCSYThtdoy1
         xQsUDvOWfjZEmUxZMrd9oIqvRZNrBe6DS3VWZlDIMcgXjpn2cJcdJNnFBr/XqhB96PJU
         HBSmZ6TBf4E9VdaAhL/aQODtYVa6xsf9T38CbwVsI4S3+2yt0zjO8SndLk/jA/1OffH2
         ZaVds/eSQ4VuDx11SuHsFijcAuRxyQ4YsPRgmLwekBU/X7ylJBNUFqTSL0pxA7dPhDq3
         +oBnDHnZnJl5UV9B+7sXOzS0EcMnC8BefxAnlSrPj8VyAxLHQjRV3k3PD5oBoLo4cQgo
         GZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189340; x=1780794140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BcbBqWTkzkDxwNMdgJ7xVJp7N/TN/+GdHi920u4savY=;
        b=o+dKPGuR0320TqSuo/RoUsWUyFvrm2lWGONnpb4+iSHwXL9BT/c9obNep0lXRq2zK1
         VHKk9Rqid/ZZugqL66NFRqAZD+Sj6kv4udg6m85XetWQww8sKcJQPRJueOryHxVA1bim
         cVIioK3LggUPCNDoo/6LldHleIaaI3SloQBqdIVnoq1Y7lu6wcU1WzEZM/S/j3yM5urJ
         9Y8GxnZVRtqPrf91MVQUQeIRl4cx/0SX0Pj3cK31zNKKvruDqD7JTH4FDdzlyeX6QKcs
         ch3JwVNQfGT0zCfHzdeGjASsxUsq7O87o5N7rhHiEUkRBHaAm34AmT8F1smG4h/faYtL
         4AUA==
X-Forwarded-Encrypted: i=1; AFNElJ9pZSOUTb4MlVTUqEfD/NHRtMnBwqDl9FcQD65ZYr06/h8igUhIM0nbFJrQCNb5eToWStKcjoQfgUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+40u4w388ylzmxtsmZseKYVHdg4h2ABJg6G6ipQqRSDGMjRzS
	J3RKZVr5aSxs5jQu1pBkmgLXPFk5Yulv8RxpL+U21J8MpW9EIweydx6o
X-Gm-Gg: Acq92OGMkimHUySUzTcr42hmovloS69lvJBJxcrCSEervEPdnsI9AZBJpVHou2m1l8z
	8WkM0vhkABmKYtPZ7X3APUPjWY1j0WZBIlIABZ4p0Z7MYNbeO8OjlKjNxKRgLjnUSRRgu7pB5fJ
	uouvdqK0zI2KDoc1cRE4XGYxU5V2gsK7Johny+uVwfcJn4t9woabAIyTRnnO4V7u1b6VdGgX6Yk
	g8m9F7n0KdlgyoVOeeZmtMPbX22fIQR5TcLUTmhYazmmmaWEnVLIg/OXNdw4vTtW8Cx3GbRPvxp
	FgEOOGRKWw3odporltnvFc0cpZn1ZutpRwpEYVw7HjpnArMAlG/EG1HV61kwOhjjVZOHD2GRDeE
	DSkFXqRSytQ2yQ1NZGoFumxAw1twLYF8uK1Jrua0Dqj7+55k3AdwopTE7c20N58XGNqLY4yDMtK
	k8IjcAoMyPtAcYEKJindsY9GCTIQcfbQ==
X-Received: by 2002:a05:600d:8648:20b0:490:9d5c:a3e0 with SMTP id 5b1f17b1804b1-490a29215ebmr71216825e9.9.1780189339981;
        Sat, 30 May 2026 18:02:19 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c103908sm45297445e9.22.2026.05.30.18.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:02:19 -0700 (PDT)
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
Subject: [PATCH 1/3] tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
Date: Sun, 31 May 2026 01:01:05 +0000
Message-ID: <20260531010107.1953702-2-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6469-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 087C061412B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove unused parameter "flags" from "link_pipe".

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1a..59adbc2fa4d6 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1849,7 +1849,7 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
  */
 static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 			 struct pipe_inode_info *opipe,
-			 size_t len, unsigned int flags)
+			 size_t len)
 {
 	struct pipe_buffer *ibuf, *obuf;
 	unsigned int i_head, o_head;
@@ -1962,7 +1962,7 @@ ssize_t do_tee(struct file *in, struct file *out, size_t len,
 		if (!ret) {
 			ret = opipe_prep(opipe, flags);
 			if (!ret)
-				ret = link_pipe(ipipe, opipe, len, flags);
+				ret = link_pipe(ipipe, opipe, len);
 		}
 	}
 
-- 
2.47.3


