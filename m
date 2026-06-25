Return-Path: <linux-api+bounces-6664-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9UvHkvoPGrtuAgAu9opvQ
	(envelope-from <linux-api+bounces-6664-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:35:23 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E75F76C3DD2
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 10:35:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AhN20rf5;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6664-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6664-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89C2F3007F44
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9137F8D7;
	Thu, 25 Jun 2026 08:34:50 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDF374170
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 08:34:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376489; cv=none; b=M+2N7bCiHl0+fWe/Z5UUBb+wvGxrw5gvOWWwArsAF3SLbT6+/DBjDemP/9rPnrkO29rbUh0safVKJC4VOOjPzreYWu0ogCeuuqSLTwwTOVsSqvfbKLFdDttrlrw5iYqQzo/dCOU9K+HzgBSdtl6S6SagO6uxcyvVnKEr1y7DD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376489; c=relaxed/simple;
	bh=7BEwt6eYwfYFJfykt1yWvyBcAyXt9b2E6Fr7Bm2s5hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vg+zaQBiud6oAjNZbDNnEbQ3iiG2hXLpskoxHXUbWV5jYK8bl4DLVEoOmDmP0Mw+B1YP47T+VHcEJbQxO3Ze0jQYLaEGhDrq3E4ebBmScTOxBhrKaht8T2Dk6D1M6CavRYiY3B3QEcDkyb3/Vc/bqO2WqLO+Ti0cCr6jczp3RHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhN20rf5; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-463f1165e16so2241057f8f.0
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376487; x=1782981287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwuPvDSXXbiyOTdpO1yF6fW9CB9apWEc+I7V+XWMZf0=;
        b=AhN20rf5CJgZHlVu8rhuRPe2lvfLF0OcT28yLQ/pGxRJ2t4hwB9zSqto0j/OnuFEHt
         fhAAkhHuWrzsyCitxbVSTKCDu/gCzDfP4CWGJliLCAezpSODB4OwczwuOw/wkHvcIDCE
         gdYDbvMe3jxuNPve1Kn8CWeMq50B0dPAZzCmyJiLWORgWr7fWdwebh4GOzFYqzqvaAf6
         JwlaZS3CVPiMpo43J0Ihn7i8J2/jtpAD19c6egRqSFNl1GY/1EIxMyDNX3m7BXxfA4Uh
         bhC2Z2iL9eoBk3R+71HMx9BMIBZPMs7ZkchaoGxe4SpiBU7RJOyzuUqU23mnUiT3x7e4
         Ayjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376487; x=1782981287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwuPvDSXXbiyOTdpO1yF6fW9CB9apWEc+I7V+XWMZf0=;
        b=N7Yw6mNJCL/g7VgfkfMicBg+wkyDenPcwYLWkdX7JsWYSpmJLDhbsYliOYXBBrzqZo
         ANurDDhktVpgOi+78jLSUbwTAfMGBRt11Ki2Q1n0UCeAyY+88Z0dlcnGpZKlwHCey8aD
         wKyAi3/T/Em31xysCw72ITqEY9sa7LBPPdWVQapz5+ppF8rRuqrdW7PcDwfNQCihGinn
         Z516kx/HpHhXDa7wmI36nnfEuwq6q8By0126EueK5tEX4XPrwrP2YCvnAn5oB3Yt+VrY
         N+IUwR0MNqcXCrXgQh8rnPcX8kaNUgSVq1/F2mbYHiLZjx8C3ZDmYIIdYM4fryVzm4lh
         SMxQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfmTNEHXPO3uXgx1X2mGHJfOVIJgMa1rTk/zY3UFpUKJ1sfsWMRTcVOwExmZuVY3G49yFlCX6oV0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp5c+Yc/0dNwu4opHQOwxjtkhnig4LuEDDbCKEDu45G7s0RzBH
	s2Cfd8IundbvQF/YbS8Saoe6UFPgw+0j7ld/zoRwLG63X+y5hvat/Zi4
X-Gm-Gg: AfdE7clOU500b7Qnd3RzXMBKuioVNlGJ+WRzqPPfruVgBzYx+n/ivgz+axJ9d6xJNnO
	q6Z4+NS7k/PTP+K1kWT8eDZvoREErYrXwznwtejH11apc4z1icX+7cOnfFdzk9HQ6u873037vNm
	wXbbqyiZ2dlvikCWU9v0HMArmu+WIHIbu/NE8IPEgYT8xIh+H2N7IcAGgJcblfhI2gtrYJ8o5zz
	Rktx8szjICmKw3N7jyvfrVQiAjCFbEREBQFkZBu0u7VU9w5qCJYms6bSDJXvevNgKLFbf/JJ+Jn
	jQ4M10avx9xT9GeKdl5LYdWhNnMMczyB34x+ua3Qvf0046u7WQt4eTJulXElzO4p9Rl9sIywjth
	HphvBWg8C9VB5g0ebUukfepId10FUa35TI0YF5zSeZRJiZ7UtYUWtC8yGzexLZjDZrQi8Vy+xTg
	Wz65Wo33pO
X-Received: by 2002:a05:6000:2f8a:b0:46d:d6c1:8383 with SMTP id ffacd0b85a97d-46dd6c18494mr1746107f8f.44.1782376486646;
        Thu, 25 Jun 2026 01:34:46 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c221d998esm13183555f8f.24.2026.06.25.01.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:34:46 -0700 (PDT)
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
Subject: [PATCH v2 0/7] vmsplice: fix some problems in my previous vmsplice patchset
Date: Thu, 25 Jun 2026 08:34:02 +0000
Message-ID: <20260625083409.3769242-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6664-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E75F76C3DD2

This patchset is for VFS. Of course, it depends on my previous vmsplice
patchset ( https://lore.kernel.org/all/20260531010107.1953702-1-safinaskar@gmail.com/ ).

I fix some problems in my previous patchset.

1. Fix problem with CLASS(fd, f)(fd). See first patch in this patchset
for details. This is probably not so important, but I fix it anyway.

2. Change "unsigned long" back to "int". See second patch for details.
Again, this is probably not important, but I want to fix this anyway.

3. Fix that LTP vmsplice01 bug.

4. libfuse relies on sharing vmsplice behavior. So we detect particular
combination of flags to pipe2(2) and vmsplice(2) and return -EINVAL.
This forces libfuse to fail back to non-vmsplice code path.
I. e. we fix libfuse-related regression [1].
I did debian code search for regex "vmsplice.*SPLICE_F_NONBLOCK" and
I found no other packages with this particular combination of flags
except for fuse itself. (Okay, other packages are fio and stress-ng,
but these are merely testers.) So, I think this is okay to return
EINVAL here, breakage will be minimal.

5. Set FMODE_NOWAIT for named FIFOs. CRIU relies on ability to do
vmsplice(SPLICE_F_NONBLOCK) on named FIFOs. So, I fix this CRIU-related
regression [2]. But there is another CRIU-related regression, which I do not
fix [3]: CRIU behavior in splice mode becomes so slow that splice mode
becomes useless. I personally still believe that removing vmsplice is
right thing to do. Other option is doing nothing. Yet another option
is to implement some deprecation period [3]. Let other developers
decide.

See patches for details.

Please, run that LTP vmsplice01 test again.

Notes:

- I want to repeat: I change behavior around SPLICE_F_NONBLOCK.
Previously, vmsplice ignored whether pipe itself was opened as
non-blocking file. Now it is not ignored. And in my opinion
new behavior is better.
- vmsplice(2) now is in fs/read_write.c . It is very similar to
preadv2 and pwritev2 now, so I think it belongs to fs/read_write.c now.

Please, review this patchset carefully. I'm still new contributor.
In particular, please, review that do-while loop, I'm not sure I did
everything right.

Tested in Qemu.

[1] https://lore.kernel.org/all/CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com/
[2] https://lore.kernel.org/all/CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com/
[3] https://lore.kernel.org/all/CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com/

v1: https://lore.kernel.org/lkml/20260606061031.3744880-1-safinaskar@gmail.com/

Changes since v1: fix fuse-related and CRIU-related regressions (see above).

Askar Safin (7):
  vmsplice: open-code do_writev and do_readv
  vmsplice: change argument type back to "int"
  splice: turn wait_for_space flags argument into bool
  pipe: move wait_for_space to fs/pipe.c and rename it
  vmsplice: make sure we don't wait after writing some data
  vmsplice: return -EINVAL for particular combination of flags
  pipe: set FMODE_NOWAIT for named FIFOs

 fs/pipe.c                 | 23 +++++++++++++
 fs/read_write.c           | 71 +++++++++++++++++++++++++++++++++++----
 fs/splice.c               | 19 +----------
 include/linux/pipe_fs_i.h |  2 ++
 include/linux/syscalls.h  |  2 +-
 5 files changed, 91 insertions(+), 26 deletions(-)


base-commit: 8d86fcfc2857d64af85f5c87c193c25655c970af
-- 
2.47.3


