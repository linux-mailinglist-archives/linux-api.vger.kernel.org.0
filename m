Return-Path: <linux-api+bounces-6670-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QQwaDdLoPGotuQgAu9opvQ
	(envelope-from <linux-api+bounces-6670-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:37:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4F66C3E59
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:37:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SY8bp4vJ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6670-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6670-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA54330252BC
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 08:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817023815F1;
	Thu, 25 Jun 2026 08:37:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB637DAB3
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 08:37:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376635; cv=none; b=B7CIAR7XMjQuH/aVfp+Km9BDR662r5dWE1XC8dkn4iN7GVhwAZapc4iyJUoY2HJxNg3j/0QuyT3/vmNEDBzpB4dnDc6D17IkKr/xhmSHBbe94PA0aWUTiybBIkGlxQvzZ0AUnrI3+qI9MYN+NNfV8eNas5wPywgNBbJAlrxH61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376635; c=relaxed/simple;
	bh=vfuzqAAI4Z7JfbLKu/I0egbH5sPpHBKYRHIHNaxeamI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW0BLVptvVTvL4Ww8RzuD5ez4hFwcb97Yd4HQeha2n6mm9NuwaSO2ubJMC2pQdcn7nam9oO1XwGhtEQMjeF447v/3rQDY6AnNNUErpACp+MN2kNj+TLLUV34x1mZRYW6Y2lFKRkrcHT8ym0dpQHs6V2HBfQ1b5MP/gG0CHnHEsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SY8bp4vJ; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45fd461e4a5so1588960f8f.0
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376632; x=1782981432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vxs0grT+d4GM87KSfFWu+blunYqTUopWsPT4iLI/6Q=;
        b=SY8bp4vJ76cjT0gwKLLfSbNmYwKD0fXJ2UuZWI5dUi3h5u1WOMEJ4YDKo8cnZ6hGEJ
         cpQKdCndXE1AnzLlhE/8gKp7lenq/s9rx0RzLaVh2asZuPgWoVTZ1h6pAmLnhoYB9YDR
         Awtmr/mCJwudvY6e8qBjC390B4GH6a7K4UaUNaxu/gkzBGYlnJKYvL6f5LFhpxrcYx9W
         SasWkRH7b+KGkyy0Oc+3PGet2f2EzR3AasepQkvpKyMqFM3TTr9lihS+UhncODRCjpzd
         OhUARFvI4q+VmDPchhHBaNE1BkDcdJKC81n9QrRTZTVapEbzd/ffjeoqO32LOXnGojr/
         9K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376632; x=1782981432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Vxs0grT+d4GM87KSfFWu+blunYqTUopWsPT4iLI/6Q=;
        b=tD2TFblfiIi/AUlhxpq94v+jBR4nUSKrRlw1wOugPkSSlCFUHozhJkRepCROqNuTPu
         gy2gFEk0ZqHzqiYamUvMjKqCCx7PhrYTKhE7S6DGa1wET1lBTgPMJbHkfyIFugjWGA14
         LLlFagP97QQWvUABaFBhMI30+TCPNwr5yFueh9IkqtgaMUh2/bhPWtUcNAjz/jVbfols
         Sk3CpwrfnbY0B1yaXAlodQR4Xqn1k8EA8mQgsNsNRt6eo1dJsDXNlsajptB5ihkR9aY0
         Jck/bwLYQ/QYEbUbaOREsJUM1Df51PdPX7yJf5CLfSMFsqblxydPkDj47R2F5rT+2Ue4
         RhEg==
X-Forwarded-Encrypted: i=1; AHgh+RoMZqTtQVU3TTDAYxDVcgLFUqan6F+X7JP2n+kN/IvxDX8mDFyACZanXyJx3sAwvvhZL37pr8JwoMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSX5aio6ecd38gNuskohZjp8ghBI5xVwgnUIK6BJKkLm10WZ5o
	dt+ews5FF0JfkFiKp4aNaqBwSeKLarHo665WqSXZ6TUW0fUV06/JerlN
X-Gm-Gg: AfdE7cnqcDn80i+EkeVwzHlRrs1gyWa7pdk2SY7A0fiYeZXrqD0EljcetYsSmdN0EQz
	ieG+JBP2wfsP1IbMGi7Bwgc61Pnxycp9ubLnzt6lhSHoNNSjIdeZWb1LkCAWES86cawfTL4StHX
	+nv4kvVtXx0KyXWxdEwN8t42Gqanr0LV0oeLi3tkeTTMr4DjaETYaCvttQ2MKWFLpef4+NXjnX3
	ecmonS9UrjjlFCSrS9z904DbdSTlVfkAm9w+sPf0+Rte4xDa1rmX78UKdWmF+vlq9/Ud0vd5AZP
	HAYnBp042A/TK8ydtwYV5e1qrElu6dyoV7TytuOKP7S3KPQijsIWhXBHmOkkqrnyXuJiBGrq/b9
	pYo+cuWo+mz0RTIF6Kaqs0j6s4suvUPWxI2SeuqwvmsNp4DCVGbiFBfqpDcx+jK+OaPj4AZztUY
	OBcvKFF+tg
X-Received: by 2002:a5d:5e81:0:b0:468:4f81:5aa4 with SMTP id ffacd0b85a97d-46dc026de2bmr2181270f8f.10.1782376631864;
        Thu, 25 Jun 2026 01:37:11 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c221d93eesm13786367f8f.20.2026.06.25.01.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:37:11 -0700 (PDT)
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
Subject: [PATCH v2 6/7] vmsplice: return -EINVAL for particular combination of flags
Date: Thu, 25 Jun 2026 08:34:08 +0000
Message-ID: <20260625083409.3769242-7-safinaskar@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6670-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF4F66C3E59

See comment for details.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index dbd0debc2..b1f71b142 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1258,6 +1258,16 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
 		ssize_t ret;
 
+		/*
+		 * libfuse relies on sharing vmsplice behavior.
+		 * So we detect particular combination of flags to
+		 * pipe2(2) and vmsplice(2) and return -EINVAL.
+		 * This forces libfuse to fail back to non-vmsplice
+		 * code path.
+		 */
+		if ((flags == SPLICE_F_NONBLOCK) && (fd_file(f)->f_flags & O_NONBLOCK))
+			return -EINVAL;
+
 		do {
 			pipe_lock(pipe);
 			ret = pipe_wait_for_space(pipe, non_block);
-- 
2.47.3


