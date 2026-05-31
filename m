Return-Path: <linux-api+bounces-6468-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNxIEuuIG2rMDwkAu9opvQ
	(envelope-from <linux-api+bounces-6468-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:03:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2801614142
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 03:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00735301874A
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 01:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3265120D4E9;
	Sun, 31 May 2026 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONPBy+wq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578B42AA9
	for <linux-api@vger.kernel.org>; Sun, 31 May 2026 01:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189312; cv=none; b=E5k9uC2yKFf+eeV1p+sUfkpRSC5qNUtElyHrBuS/tCT5/+9rVV2yBz+NnW0H5gz/DcnblIxsDEW0Xxelx4GPczZwEhcEcwKXrjA6iAJu1W/fV6L1ZnkEwK21ZOv2+EL3xBWHL9W5hZkY7DvRIuH+mW4PlQy2lSkK7ePISMHzJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189312; c=relaxed/simple;
	bh=zDp1XhZh+e1pWOK/DsDnXaGWcjK6DLDDhCVbs2gw3ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRHaUVAwerdx7Zkt5vKyHukZ6klSzOCnvx5540xDzggpF8uvWp4+7gncQjSJW54KuIRrM5Kpf5Dbd4biHExTo2gut01mvt+E63pdRJ0zDeAkpF3TRy6dqDU2N5SPZFRHutwI85dyqdAy0/kza9ow/Njmy5iSm+fql20mUt7jnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONPBy+wq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49041e84237so72990175e9.1
        for <linux-api@vger.kernel.org>; Sat, 30 May 2026 18:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189309; x=1780794109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zPl6w3uFFVNTR71LIvI6Hm9g27LWiqb2gsEEN2QBH30=;
        b=ONPBy+wq4TbJvSn3LFGXIzPYyx8ZL8H0HYU72wPZVRyrKbZ3ulzc+EdYpWvPewy5+E
         HceHotkVzpTfwy5ttrDEQripSfGnKvGRaFhDHsXtc4xPtvryIUsW/n8cMtnKWqhWjVLr
         5PfktqQ0ALXzQVgwDDPr+8rAkWm76N+8vqNhRBIwZuny+k5LKYT/URzgaeAt9ij4cqwR
         5H33MKZqNPe3/+Dxieo1Mgg7UT2ujBWMZpgVi2MeIgWNbiM6X0ITgl05Jg7oUoq1J4lO
         3h3UAOnRQ3GVFDTMv+9NbMUeYedFTVX0GHUKUuxma6BOnmivDMq7ziff3UXnxYXACATl
         unmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189309; x=1780794109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPl6w3uFFVNTR71LIvI6Hm9g27LWiqb2gsEEN2QBH30=;
        b=np2kkzEmxGMop4lJYyTvgAdxwRUGfYZRVmYXzLm7XfehW5/y3LlTrYRRVrh84VONEZ
         9kuNgj5ZPxICE98bHm6/ued5VnIVMJbIrXLtDTBj7zlFtrpxNMmEw+XjEqFuYcLW5ZFn
         5o96v24KSQNWYj4plCMu6l0V2+R6sTnXgc738MToZd53YDN/Jd4FoHfDj8lB70CoVfkR
         XwHTA8PuS0QvhMJnIIKmpt96BG3Q2R9IpMCwv6MFHMHjZyQUh+drCI+hwMydvQOhE3lH
         NkyVDqtjsOsVIngBj9O3jP/Bn/aa3XUIdMuo8q7HJi2m/znQzFSx+X3doncIXC3E2sV1
         VihA==
X-Forwarded-Encrypted: i=1; AFNElJ8xiA/A0jTENFvjpHX82GLxIzda1Nx11WkTFztZL38nYD/TmsVvr8af2Gc8arwFmAQBlXJV66JF6KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnlrxnsP16mOQMinK1eJmCmttKMSCcj0AqPSnSC0/uhqoz0kK
	/7biWK+4w1u4vznmHDu22Uh1yidWnSbX/PEsw3oy3quUvAlwfcH0Kwla
X-Gm-Gg: Acq92OFOBhlflX3Pg9loVcqqqO0AarOCIOQEyEBv9WjZVbgeXiLhTRB2XwFNqgiBeSJ
	L70cQDVcNNCBxu5CsxfE0r+XxLdsRWmKSFVNNK3AoiFl8sQK55WKKaZ2irgJ0hT+Atu9T7/5ywa
	N3/mgRtD4coZD4J1n0l3DaRYNqYL0AKIlZ7N3xwzhkBKIqhAXpBHCFtklOU/qEj00t8Z6QG1e1q
	3rBrkeBy+iLdONps39BQ3Ech4dkRr2zj0FjFXqpc6X1zLFUNXKeiWz5Zo2HabxzCIw45+f11Bo6
	TQuuozOS06W8sJ6riMCy53ZeVwDd+rjM7t1i29XFB+enaaxrsRjDMkY9kv3iEJgsr12SD0HJ/ly
	VB7x+FRQJdnzbMQxXL7v8LKEDlhgPe2Q+c38IrtwUzo1e+2ND1pbhwV7xrZojxadmKYCqVs6zzG
	TTN8NBL1wu2xZ8FO+FE9Q9as45SiEjJ8uxhd8XOPJG
X-Received: by 2002:a05:600c:c168:b0:490:5000:917 with SMTP id 5b1f17b1804b1-490a2a02ad9mr75824695e9.1.1780189308943;
        Sat, 30 May 2026 18:01:48 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909cab0e79sm261799535e9.13.2026.05.30.18.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:01:48 -0700 (PDT)
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
Subject: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Sun, 31 May 2026 01:01:04 +0000
Message-ID: <20260531010107.1953702-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	TAGGED_FROM(0.00)[bounces-6468-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: A2801614142
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patchset is for VFS.

Recently we got a lot of vulnerabilities in splice/vmsplice.

Also vmsplice already was source of vulnerabilities in the past:
CVE-2020-29374 (see https://lwn.net/Articles/849638/ ).

Also vmsplice is problematic for other reasons. Here is what other
developers say:

Linus Torvalds in 2023:
> So I'd personally be perfectly ok with just making vmsplice() be
> exactly the same as write, and turn all of vmsplice() into just "it's
> a read() if the pipe is open for read, and a write if it's open for
> writing".
https://lore.kernel.org/all/CAHk-=wgG_2cmHgZwKjydi7=iimyHyN8aessnbM9XQ9ufbaUz9g@mail.gmail.com/

Christoph Hellwig in May 2026:
> vmsplice is the worst, as it is one of the few remaining places that
> can incorrectly dirty file backed pages without telling the file system
> and cause the other problems fixed by a FOLL_PIN conversion, but it is
> the only one where we do not have any idea yet how we could convert it
> to FOLL_PIN due to the unbounded pin time.
https://lore.kernel.org/all/agwFlBKvKytjURDO@infradead.org/

See recent discussion here:
https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u

For all these reasons I propose to make vmsplice a simple wrapper for
preadv2/pwritev2.

vmsplice(fd, vec, vlen, vmsplice_flags) will
be equivalent to preadv2(fd, vec, vlen, -1, rw_flags) if you have
readable pipe and to pwritev2(fd, vec, vlen, -1, rw_flags) if you have
writable pipe.

SPLICE_F_NONBLOCK is translated to RWF_NOWAIT, all other SPLICE_F_*
flags are ignored.

There is a small change to handling of NONBLOCK-related flags,
see commit messages for details.

I tested this patch in Qemu.

This patchset was written by me, not by LLMs.

Askar Safin (3):
  tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
  vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
  splice: remove PIPE_BUF_FLAG_GIFT

 fs/fuse/dev.c             |   1 -
 fs/read_write.c           |  23 +++++
 fs/splice.c               | 202 +-------------------------------------
 include/linux/pipe_fs_i.h |   1 -
 include/linux/skbuff.h    |   4 +-
 include/linux/splice.h    |   2 +-
 include/linux/syscalls.h  |   4 +-
 7 files changed, 33 insertions(+), 204 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d (7.1-rc5)
-- 
2.47.3


