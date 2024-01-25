Return-Path: <linux-api+bounces-633-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D696383B60B
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 01:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814792849F7
	for <lists+linux-api@lfdr.de>; Thu, 25 Jan 2024 00:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB41388;
	Thu, 25 Jan 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="nE2taNG2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D564B
	for <linux-api@vger.kernel.org>; Thu, 25 Jan 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142624; cv=none; b=HBR46naTqMD1RuLJCuAE3rYLou6PjuPjbGIcAmALVq/fMJW12zJ4CgB26rmqGa6S55tAT+WEDdAAWPeRSxyhX2Til/T629R/+PB/nsIXlnTGjeQrpRg+Sf/rZV8FxWM7Wm+6p0c9dCykcNZNMP5KTn08XWlmUTg9HloPkzlGb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142624; c=relaxed/simple;
	bh=6ed+3atdOO90Bcl6o4AJkfZDmJDPlpNG9qn2t/N6EdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XcmzA5wb43yzADd+ECJ4RoVoh6U8vP3ftN0l9+0udJpvSNCkO07WUvzSNdeQawLtHux1BOF45lEq/XiVLvbmoEpJododpnTJIo9n5EJH0yVDmIR+vH3zTuM7BrjKXdpA8GIQgj2ao25JBHQtuNhdC3CUj9tgvlpgfInCmO+syFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=nE2taNG2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dda0e3600aso821736b3a.2
        for <linux-api@vger.kernel.org>; Wed, 24 Jan 2024 16:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706142621; x=1706747421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJ/KhjXFYvr9irVvrcVntzkJlwaP0ByriXx5y0FiiYc=;
        b=nE2taNG2UQrC2NR1MGIWKEeY0JDaLOfD5jA2ZUpciZbYw/15cDZ2Cu7HaMigHVSRFg
         U7gKIe1cqxCWmW6CI+Rl4Xg5aluIRqxgO9tNrWTxt0aIYLKyGZ8acqEUHvaTtB9ZpC9L
         IVUVDyBAxyX0VYbKewFGEQC35R97TT0JbVGqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142621; x=1706747421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nJ/KhjXFYvr9irVvrcVntzkJlwaP0ByriXx5y0FiiYc=;
        b=L2m+E8QOZcpIk4qMrkQtOOkT/a9jK0d+gYPhM+bNKTdLGN9cIEY3c0KxlzU7vEAJyy
         fTliufBc5qQ5DyZ1V0AiRmmFgR125uRns7nueeiBG/3kxZVtnEyX1NqPstUWBiqtqwri
         DpZh/K3WLFrzboxZAtfM7PKOhJPUpp7thaurXqBIHjtloyV7el2XBCfyYHoDuJ/VN0pR
         ZGsC8hOX/hdzIv4RQopfDb4vH8b262Eo2ABTC8kE4iUV/7igAwZiRyOKDG7WmUUesD/R
         1oy7z8GTB4dgpf+Z/ZEQO1TICcAlTriE4mzPN60pF1x5LdXEsXARiJKwjDPK5qFTjf+B
         PaLQ==
X-Gm-Message-State: AOJu0YzGVfj8fQhK4lCr6PGvaEZxhTeqZhVGhP5JKaOuVOsTaiXeMVHo
	KsveYtmVdq/lHCBJQeFm9QU08+TQ3BgVPdZ9zxuUNjlDC6Nb36wAE00LsBAQshs=
X-Google-Smtp-Source: AGHT+IHdVXS6pNvjfF+4A/EF7XQhuNGhFbyY8RuLB7kiTQxOL8W7fgLJz1aoWc/mzDe0fl2C0mRcNQ==
X-Received: by 2002:a05:6a00:3ccf:b0:6dd:c542:afd7 with SMTP id ln15-20020a056a003ccf00b006ddc542afd7mr71418pfb.19.1706142621086;
        Wed, 24 Jan 2024 16:30:21 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd945c0399sm12550486pgi.80.2024.01.24.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:30:20 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 0/4] Per epoll context busy poll support
Date: Thu, 25 Jan 2024 00:30:10 +0000
Message-Id: <20240125003014.43103-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2. Cover letter updated from v1.

TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by allowing user applications to enable
epoll-based busy polling and set a busy poll packet budget on a per epoll
context basis.

To allow for this, two ioctls have been added for epoll contexts for
getting and setting a new struct, struct epoll_params.

This makes epoll-based busy polling much more usable for user
applications than the current system-wide sysctl and hardcoded budget.

Note: patch 1/4 uses an xor so that busy poll is only enabled if the
per-context busy poll usecs is set or the system-wide sysctl. If both are
enabled, busy polling does not happen. Calling this out specifically incase
there are strong feelings about this one; I felt one xor the other made
sense, but I am open to changing it.

Longer explanation:

Presently epoll has support for a very useful form of busy poll based on
the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).

This form of busy poll allows epoll_wait to drive NAPI packet processing
which allows for a few interesting user application designs which can
reduce latency and also potentially improve L2/L3 cache hit rates by
deferring NAPI until userland has finished its work.

The documentation available on this is, IMHO, a bit confusing so please
allow me to explain how one might use this:

1. Ensure each application thread has its own epoll instance mapping
1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
direct connections with specific dest ports to these queues.

2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
polling will occur. This can help avoid the userland app from being
pre-empted by a hard IRQ while userland is running. Note this means that
userland must take care to call epoll_wait and not take too long in
userland since it now drives NAPI via epoll_wait.

3. Optionally: Consider using napi_defer_hard_irqs and gro_flush_timeout to
further restrict IRQ generation form the NIC. These settings are
system-wide so their impact must be carefully weighed against the running
applications.

4. Ensure that all incoming connections added to an epoll instance
have the same NAPI ID. This can be done with a BPF filter when
SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
accept thread is used which dispatches incoming connections to threads.

5. Lastly, busy poll must be enabled via a sysctl
(/proc/sys/net/core/busy_poll).

Please see Eric Dumazet's paper about busy polling [2] and a recent
academic paper about measured performance improvements of busy polling [3]
(albeit with a modification that is not currently present in the kernel)
for additional context.

The unfortunate part about step 5 above is that this enables busy poll
system-wide which affects all user applications on the system,
including epoll-based network applications which were not intended to
be used this way or applications where increased CPU usage for lower
latency network processing is unnecessary or not desirable.

If the user wants to run one low latency epoll-based server application
with epoll-based busy poll, but would like to run the rest of the
applications on the system (which may also use epoll) without busy poll,
this system-wide sysctl presents a significant problem.

This change preserves the system-wide sysctl, but adds a mechanism (via
ioctl) to enable or disable busy poll for epoll contexts as needed by
individual applications, making epoll-based busy poll more usable. Note
that this change includes an xor allowing only the per-context busy poll or
the system wide sysctl, not both. If both are enabled, busy polling does
not happen. Calling this out specifically incase there are strong feelings
about this one; I felt one xor the other made sense, but I am open to
changing it.

Thanks,
Joe

v1 -> v2:
  - cover letter updated to make a mention of napi_defer_hard_irqs and
    gro_flush_timeout as an added step 3 and to cite both Eric Dumazet's
    busy polling paper and a paper from University of Waterloo for
    additional context. Specifically calling out the xor in patch 1/4
    incase it is missed by reviewers.

  - Patch 2/4 has its commit message updated, but no functional changes.
    Commit message now describes that allowing for a settable budget helps
    to improve throughput and is more consistent with other busy poll
    mechanisms that allow a settable budget via SO_BUSY_POLL_BUDGET.

  - Patch 3/4 was modified to check if the epoll_params.busy_poll_budget
    exceeds NAPI_POLL_WEIGHT. The larger value is allowed, but an error is
    printed. This was done for consistency with netif_napi_add_weight,
    which does the same.

  - Patch 3/4 the struct epoll_params was updated to fix the type of the
    data field; it was uint8_t and was changed to u8.

  - Patch 4/4 added to check if SO_BUSY_POLL_BUDGET exceeds
    NAPI_POLL_WEIGHT. The larger value is allowed, but an error is
    printed. This was done for consistency with netif_napi_add_weight,
    which does the same.

[1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/
[2]: https://netdevconf.info/2.1/papers/BusyPollingNextGen.pdf
[3]: https://dl.acm.org/doi/pdf/10.1145/3626780

Joe Damato (4):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add epoll ioctl for epoll_params
  net: print error if SO_BUSY_POLL_BUDGET is large

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 fs/eventpoll.c                                | 105 +++++++++++++++++-
 include/uapi/linux/eventpoll.h                |  12 ++
 net/core/sock.c                               |   3 +
 4 files changed, 116 insertions(+), 5 deletions(-)

-- 
2.25.1


