Return-Path: <linux-api+bounces-554-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4968331E6
	for <lists+linux-api@lfdr.de>; Sat, 20 Jan 2024 01:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA21284F92
	for <lists+linux-api@lfdr.de>; Sat, 20 Jan 2024 00:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90827A3C;
	Sat, 20 Jan 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PyAacvR1"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F6339C
	for <linux-api@vger.kernel.org>; Sat, 20 Jan 2024 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711431; cv=none; b=dndFV/CngtmOL0fZux4IPoIqbH6tb+hy+UoXDvNeFHLhAICD+mhJqIbaFzCBnBEG4l5lxAgbKEf8NIN0q1ti8pyy+r1UHD0Rdy9YKOjhqPq9coLXYuTmj7KtqNeuaP0WZlAvt+l8xjlE9Is2KDGVN8Jcz8cvNy4qDtTcpc3j9EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711431; c=relaxed/simple;
	bh=5HG+b53C84Ypx7OXyBN4VTdPWHJvm6dijnFWhd1WFrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O34GvN7gVQtr5QabSU6QnTItUl7GkQNHTTNn4/TOGt3GVk9bSw9N+rdVB5jGWKDzbq1HE774a9F0TLZ1JsTuQe4I89Y8P/NHKA02dt/VX6C7A46qG683n1k7/uY1I6cDD7iSTpgnEfbtFcASqoWxz8RRH3YUdAMib04J8tNg4QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PyAacvR1; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-361a38dd171so4690135ab.0
        for <linux-api@vger.kernel.org>; Fri, 19 Jan 2024 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1705711428; x=1706316228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xv/LIsX6DuyDvwhk5hVzMgJVITeYTPHNZOG4F7N98kE=;
        b=PyAacvR10VPLnWGHhxp2x4+/1ssQGWgrkLUnRV6ENvii5KhjvVIuN9jCHjLWc01lc9
         D7AL1vpVIDH/r7TEFCgP72YV9L3LrazZmtxFfAfePwmoDg0/Omk+9DJDMlV1+25e1XYC
         7Iz4TaDJLrM2AOiC1bg6sd+SEMt3wPFKJhm8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705711428; x=1706316228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv/LIsX6DuyDvwhk5hVzMgJVITeYTPHNZOG4F7N98kE=;
        b=K7JKTsolieeO+sS5IEDWak2hPDKwtKOm3wLeInJsC1O475hpT3Vb+InBBOJcviW5/U
         Kk/1AjpcUblQFNzig8n8aSZ/DMswZlZMDadBKT27Z+Gd3hzAlrHFyh8QXIpC+33ykms6
         DSeag3UUJmQZkHQeVay6B/5qgBeCTlRJ2nTdTT23qSDbOP7J+crOSmSPIZJ2IN+0YzG0
         0F8nQVXlXgkrNbSOIXd8bp9MgCNG9MSyRTMCv/L5KNspEQhDKeNXPXlo7SvZIqlQrvuR
         Y12i6fz4KTYJ6YSzAQDP+7F/VvPinShqtre/ek/rWAehC3lQjZiTvSef/6zP87f0r+6f
         g65A==
X-Gm-Message-State: AOJu0YwqMEIyj5uRMFjtidky8MY9UoM//w1Xihif2k2mQt+SboMADosW
	lrSoFuFcsNeR4VvpRdaJ8oTsc3nt5RLbSO5dH35vrRyQ4yHYfxtKuFhvSZ6jYRs=
X-Google-Smtp-Source: AGHT+IEp6bm3kMMWG7JMnNa3IQl4FOHtl850x8XfQbXEPegYhoQX6NR2wf1qyz5d5x1ffoQr00MQcQ==
X-Received: by 2002:a92:d1c7:0:b0:35f:e8a1:2b24 with SMTP id u7-20020a92d1c7000000b0035fe8a12b24mr757662ilg.61.1705711428053;
        Fri, 19 Jan 2024 16:43:48 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p7-20020a170903248700b001cf6783fd41sm3563800plw.17.2024.01.19.16.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 16:43:47 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC 0/1] RFC: Allow busy poll to be set per epoll instance
Date: Sat, 20 Jan 2024 00:42:46 +0000
Message-Id: <20240120004247.42036-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

TL;DR This RFC builds on bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by adding two fcntl knobs for enabling
epoll-based busy poll on a per epoll basis instead of the current
system-wide sysctl. This change makes epoll-based busy poll much more
usable.

I have another implementation which uses epoll_ctl and adds a new
EPOLL_CTL_BUSY_POLL_TIMEOUT knob instead of using fcntl, but fcntl
seemed to be slightly cleaner.

I am happy to use whatever interface is desired by the kernel community
in order to allow for per-epoll instance busy poll to be supported.

Longer explanation:

Presently epoll has support for a very useful form of busy poll based on
the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).

This form of busy poll allows epoll_wait to drive NAPI packet processing
which can allow for user applications to decide when it is appropriate
to process network data vs being pre-empted during less optimal times.

For example, a network application might process an entire datagram and
get better use of L2/L3 cache by deferring packet processing until all
events are processed and epoll_wait is called.

The documentation available on this is, IMHO, a bit confusing so please
allow me to explain how to use this kernel feature.

In order to use this feature, user applications must do three things:

1. Ensure each application thread has its own epoll instance mapping
1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
direct connections with specific dest ports to these queues.

2. Ensure that all incoming connections added to an epoll instance
have the same NAPI ID. This can be done with a BPF filter when
SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
accept thread is used which dispatches incoming connections to threads.

3. Lastly, busy poll must be enabled via a sysctl
(/proc/sys/net/core/busy_poll).

The unfortunate part about step 3 above is that this enables busy poll
system-wide which affects all user applications on the system.

It is worth noting that setting /proc/sys/net/core/busy_poll has
different effects on different system calls:

- poll and select based applications would not be affected as busy
  polling is only enabled when this sysctl is set *and* sockets have
  SO_BUSY_POLL set.
- All epoll based applications on the system, however, will busy poll
  when this sysctl is set.

If the user wants to run one low latency epoll-based server application with
epoll-based busy poll, but would like to run the rest of the applications on
the system (which may also use epoll) without busy poll, this
system-wide sysctl presents a significant problem.

This change preserves the system-wide sysctl, but adds a mechanism (via
fcntl) to enable or disable busy poll for epoll instances as needed.

This change is extremely useful for low latency network applications
that need to run side-by-side with other network applications where
latency is not a major concern.

As mentioned above, the epoll_ctl approach I have (which works) seemed
less clean than the fcntl approach in this RFC. I would be happy to use
whatever interface the kernel maintainers prefer to make epoll based busy
poll more convenient for user applications to use.

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/

Joe Damato (1):
  eventpoll: support busy poll per epoll instance

 fs/eventpoll.c                   | 71 ++++++++++++++++++++++++++++++--
 fs/fcntl.c                       |  5 +++
 include/linux/eventpoll.h        |  2 +
 include/uapi/linux/fcntl.h       |  6 +++
 tools/include/uapi/linux/fcntl.h |  6 +++
 tools/perf/trace/beauty/fcntl.c  |  3 +-
 6 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.25.1


