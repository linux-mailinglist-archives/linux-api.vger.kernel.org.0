Return-Path: <linux-api+bounces-6615-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nsp0CbKjMGonVwUAu9opvQ
	(envelope-from <linux-api+bounces-6615-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 03:15:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F33368B32D
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 03:15:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gY4GfdU+;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6615-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6615-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D01F3017FAD
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 01:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27051349CD6;
	Tue, 16 Jun 2026 01:15:27 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347734EF0E
	for <linux-api@vger.kernel.org>; Tue, 16 Jun 2026 01:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572527; cv=none; b=uI5wpmWxnmy8L4e4rDYoxsTOdpNdXeixr3xsOGhGfv5OdPAladyAmhwLA78xsQdTtxn1FU0tzXL/FOBDSQF/1mcSHsM5nYdNVqELuxvTsIvdWGk2tmT8ANL/xbdiYg/4Bz77OGzWFiqf+5HbqHs7lL8pbCRR2A41Su5FVzVJZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572527; c=relaxed/simple;
	bh=qSWoZgNw3PpVwHOk9/H/f2RnG3uRakwqaf1M/1PGtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G75odQ7rRWpw3CyKpgJKo0X8rqrI8oQnS3Mo6RvqSW+5WrJgn3rwC7Bu2LA2Iv/aURa4cwbm0FS1edjHV6Xaeha9VDgJDyhuicAauM6zvH2lRl7mPkg0QeDxviY/eUU9/D4MgckUXCREtlE3CogWApdnmw106bKVKuoUpM4h1P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY4GfdU+; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b9318997so28576935e9.2
        for <linux-api@vger.kernel.org>; Mon, 15 Jun 2026 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781572524; x=1782177324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53973eSawR2ZjjRuPt5kDFsVlZ1YHqdNePsF+6+pfeM=;
        b=gY4GfdU+fnf2fpkgHqn+YKSNu2S3tZpA4UYKriInFnsJ2ouxdKifTLZo+v2WRUVzVv
         l6ChYa8hy8b32sF5eihbKfCnq9ej6soPiI1VfrgCx+wpMYPIBffRw/IkkVHkATe3HfsF
         7biBiYvPB+QDdCV8fAVbNNMOmm/duLs125U/h8rlc6UfLQgKO7ZT2w/t3oj7W9TyGV8V
         vugqEIAZUEiatJwF+z+uscmYoEMGGTOvmbPQql1VT3ooCsni4RN3lUOxSjoOF1G0uWrJ
         44gD0UQ2SK5QUqE/od+j4iKtbzcAsww1GLqoTJT63nhUr97UfLH7pq8pzb8H0U3ls0bJ
         Cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781572524; x=1782177324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=53973eSawR2ZjjRuPt5kDFsVlZ1YHqdNePsF+6+pfeM=;
        b=iyvZQAPcpUwujx4j+uDESwEFlYWjfbmWxn383IwNuf36/w04UzCW+2aOiJAug/ufza
         5xib46Lg/v2PCM2Y08I9PqQKkCGWLkAhpKljlUHIHWgQfduak1ptFE2A9kv+GoLAn/b0
         /+ZZ/1e1lsnaYRz40YiYcnlG4u94ILUpBl5eUucI+phOhJdSuFlkDQfK59EtG7pEJ7kp
         49afPVyrTLWr8V6yrB5VWCncpk8teuJrEKyhs6eZpRujESGxx09OoVj7Kx8z+WzLN4FP
         IO+I3IUgmToxxmZEb/+1txO4l0ApeqAuh0Gw/odT6A/gx3dzNzm6iAPMewD7VOyU7SzC
         otvw==
X-Forwarded-Encrypted: i=1; AFNElJ/m8zHYdTKcC0hkwTYoPCDKd9gCZ62boSB/4OYoUqzni+EsQ1xhqTNXO1x2HXa7e546ec5TD5lX9gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYum/Du+VceXxku4dGbPXwn9IE77HfHtbt6sK0itkwRmfMQFH
	sTLYfJJd+zoZvXY3hJnWtvi70qXJGBgxh+7Hfs2ucNeTxfBUVtUwv3/p
X-Gm-Gg: Acq92OGx+QK4SFlMPvJbAjxcko/VDm2xuBMul3vuQE4mOpZIbgIMAL/lqYgZ9v5/9DW
	OHpvTa6Y2eOGTdpslYuMzN7dw1uFp+L9lM5Y4qqTCaRJ1+LNN3I76EODoJ2Xwfj1+UppjkSz7q6
	hV749WyY0O6FBvPqtE9x5hL9+FXn1v2DNTgSt/Zv1Vd6OWs4VHUbvXRceIuDyNOeIA9sjOyKLE6
	l5yS8lhouXWb4KtmFeDchG/OU3Rhun2muPaJXoO0b8Gof+kN2uvmEp3k806V0r7+uHyV/rkuj2G
	Lh8Rq52kgoBMEJGltIbOackduiwf2QOBLDh75C9swCVBF1fpnaglpa/7SCNQXpVC8v9VjoTxecW
	aqrhjEjWO1Ijw4VC87hAj7B0ZxSrshXMnoS0RP2cUasciLnzfEN+HJ7ZQRiGHxEeow2GHJ4/Ddb
	CfnE6Ps7G6aYE9xU3z2q4=
X-Received: by 2002:a7b:cd0b:0:b0:490:b2c9:e284 with SMTP id 5b1f17b1804b1-49220143bc6mr120782165e9.30.1781572523711;
        Mon, 15 Jun 2026 18:15:23 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4922fa47da9sm43123095e9.5.2026.06.15.18.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 18:15:21 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: joannelkoong@gmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bernd@bsbernd.com,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	val@packett.cool,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 16 Jun 2026 04:15:09 +0300
Message-ID: <20260616011516.4039110-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
References: <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6615-lists,linux-api=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS(0.00)[m:joannelkoong@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,bsbernd.com,kernel.org,redhat.com,lists.linux.dev,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,gmail.com,packett.cool,zeniv.linux.org.uk];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F33368B32D

Joanne Koong <joannelkoong@gmail.com>:
> > speaking of fuse_dev_splice……_write actually, this series has broken
> > xdg-document-portal!
> >
> > https://github.com/flatpak/xdg-desktop-portal/issues/2026
> >
> > Specifically what happens is that the EINVAL is returned due to oh.len
> > != nbytes:
> >
> > fuse_dev_do_write: oh.len 16400 != nbytes 15526
> >
> > (where 16400 == 16384 (read len) + 16, 15526 == 15510 (file len) + 16)
> >
> > After reverting the series, there is no error because oh.len
> > becomes 15526 too.
> 
> I think this is because of how libfuse handles eof / short reads. When
> it detects a short read, it fixes up the header length after the
> header was already vmspliced to the pipe because it assumes vmsplice
> mapped the header's page into the pipe by reference. It assumes that
> modifying the header length in place gets then reflected in what the
> pipe later splices out.
> 
> The logic for this happens in fuse_send_data_iov() [1]:
> a) sets out->len = headerlen (16) + len (16384) = 16400 in the
> stack-allocated fuse_out_header
> b) vmsplices the header to the pipe
> c) splices the backing file to the pipe. if this hits EOF, it'll get
> back 15510 instead of 16384
> d) detects the short read [2], fixes up the stack out->len = 16 + 15510 = 15526
> e) splices the pipe to /dev/fuse
> 
> After this patch, step b) is a straight copy which means step d)'s
> fixup doesn't modify what's in the pipe. This could be fixed up in
> libfuse to not depend on modify-after-vmsplice, but I don't think this
> helps for applications using already-released libfuse versions. I
> think this patch needs to be reverted.
> 
> Thanks,
> Joanne
> 
> [1] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L846
> [2] https://github.com/libfuse/libfuse/blob/master/lib/fuse_lowlevel.c#L956

Uh, this is very unfortunate. But I still want to remove vmsplice.
Maybe we can somehow save my patchsets? For example, let's return EINVAL
for this particular combination (writable pipe + SPLICE_F_NONBLOCK).

-- 
Askar Safin

