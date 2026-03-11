Return-Path: <linux-api+bounces-5922-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIISLuEgsWmOqwIAu9opvQ
	(envelope-from <linux-api+bounces-5922-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:59:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0625E4FB
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 08:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 093363004602
	for <lists+linux-api@lfdr.de>; Wed, 11 Mar 2026 07:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5823B6C1B;
	Wed, 11 Mar 2026 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ep5ux/fP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE7F3B27E4
	for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215791; cv=none; b=AqtuH6rR/f3xDB4nZXXoxadH0I9VNgKdMxozfuqj+yoO40sZrncAYcUjKHxoRuc0TPIwcEmYvEiFXoNN1Oofakz1IkSD4rR0JJJ/QqRMwmkIJZngnEIwiHTBhXrIwskcX7/TSlJ8ioPRRsiOimmxVeeIXnSjVOjhAcHv+6NkVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215791; c=relaxed/simple;
	bh=FDmpie23sScGP+OdflWzKGb+2xENXEuu2nCfUaQR7H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UqbF6pKK/9i19fYeKWgndQ7aOIhXqt9cG8hnQtr8+n85DmjIOtVES8xnndXJA1CPUVlTCc8HdXSgovTVjEWrQMoW2syZG6XZMoajq9+Ljot5SFLOp7/gB2HOEwvZaOmT1imj23F7guGGPGe8RvssXyd6hRryCgPaZjrUkZzwrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ep5ux/fP; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4171ff4cb2cso1991652fac.1
        for <linux-api@vger.kernel.org>; Wed, 11 Mar 2026 00:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773215787; x=1773820587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=Ep5ux/fPJChFYDWKlpLfuOO1GEiWepqX5YSftIEKjejsYgGZEgeFdk7VC2EWhb8sjw
         yZnAWSme2lhdMgJGZLPGlkWY87JyXHwKw4yrx4cKfk23r8vUdUGfRNsGcr3wepcvvpnX
         +ZBiNo36lnBHhItUD6h+wVdvz4jzLaBKAlOq1ct3IXYo96QCzlMTTcFLlSNkm0Gy/73m
         dbxk/35kkRGr+emMCJkLKVbfK+YxTXvDUZ1LCaE3Y2UvyHgKdd2b9BZSFfc8E3U8nK5s
         GoY5MNQo7LXXV+p5HCmzioTWpk5jhKPwayapprzlHQmD1/h79E7bvS/tQtw1ERPogvQg
         3hUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773215787; x=1773820587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRAOu3vndgNWWBgUC2jVEJ5hsRD9mDPq+B8T4vBDYFI=;
        b=u6xhAiS96Uy834q4/9A8CQ+TEKDdrGLfKmR4KZO/dIW6oUT0Lnt0XOtg9+h5N6Rm8Z
         e3hE4dRzxXtR1/ShPpLtc4hUAbwJQQPRifOMyvG4aCjD+Y2GJEWzVVuTcWO+rQvhwjKw
         d24ovrIfMg8EIqPFQRg0TkONYpCxv62AjbX0WcU/sVBMK9jhJHatVOIZGgKBbvPySZWE
         RrbtnT3i4vaoTjXO8CwB/hpL+ao8mLH3KnEC7TDSuSEHQGCeutY0SAagfzB6npK/EOc9
         bYBxmDjtL8Jp/D7oe7EJNZqrq/912CcPxXID4O5b2IoGFYld/liE/ZvX1SGKJIGwA3aP
         Ra0A==
X-Forwarded-Encrypted: i=1; AJvYcCUdvHyC9rrxkwsm8VNmcQnYtBKmPh5SyIVrf0W70kL8V2IHct6ZsecZ7AatqT6dXsnZlTsXh4Kd1mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrG9WP4rT/NE0U9v4lsLzDtzcv1B5/eccE4MfUtdrc4mNjHlab
	+YEyrKPk0z/XfYxqGJvGdP6dFlMLpfOk9wTYQWd5Nv25Ljx/Zb9iOKRD
X-Gm-Gg: ATEYQzyuL7us3nyODxwmOVkA0NIzMijvUu9jBwZEafmqBo7DScSk1/VazkKRhCIizW5
	xU6w5aNKrKAp28r0rp1DigASGkEon4eWrTUW/gq+1SdgE93jvsLJ1a1vDNLMIodKLUzGfZxs6VW
	Ur6iUMFRyOzTfEOsDB7LXE573hBjxMMUG3M7NbmUxwlIUnNKC25gfTeZE3HNNu2R+og88kirORF
	FoJb/0vsW9M98We0GdURcUEEeadq/FrLUX08l9HQIXphuHgoh+tSBYbN5zQEqVaPS6HBjFZfcu/
	7G15Twm6naJK0nzvDc8VtNkLkcWf8F7rpACIwgP3AEKo0cV7ZQkKIquyWFicrs3KQXE9F0hJJ7p
	EvcNK9K4JCI5fvrvsF2LGOKm44ZgzMVoVFc2fYRHnMzktZxg69rV7SDMqiCtCqbtPPzY04FsOZN
	9MbifKhmABCzXGE+MZc66uK1DR1NaBrwTgjaaffZ7+IK9vzohX7Gppxf9/M6WLXvpaX9gVEnYdF
	17RSychnVjL/mJCFcpK86iUhQjHY7TVJXC2b5U5XKod3bof
X-Received: by 2002:a05:6871:8a5:b0:409:6862:aba5 with SMTP id 586e51a60fabf-4177ca9e65dmr1127232fac.25.1773215786910;
        Wed, 11 Mar 2026 00:56:26 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6ae0e3sm1568938fac.16.2026.03.11.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:56:25 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: kuniyu@google.com,
	horms@kernel.org,
	geliang@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com,
	linux-doc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	atwellwea@gmail.com
Subject: [PATCH net 0/7] tcp: preserve advertised rwnd accounting across receive-memory decisions
Date: Wed, 11 Mar 2026 01:55:53 -0600
Message-Id: <20260311075600.948413-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BC0625E4FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5922-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,lwn.net,linuxfoundation.org,goodmis.org,efficios.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-api];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series keeps sender-visible TCP receive-window accounting tied to the
scaling basis that was in force when the window was advertised.

Problem
-------

`tp->rcv_wnd` is an advertised promise to the sender, but later
receive-memory admission and clamping could reconstruct that promise
through the mutable live `scaling_ratio`. After ratio drift, the stack
could retain or advertise a receive window that no longer matched the
local hard rmem budget.

Fix
---

- store the advertise-time scaling basis alongside `tp->rcv_wnd`
- refresh that pair at the TCP and MPTCP receive-window write sites
- consume the snapshot in receive-memory admission, clamping, and the
  scaled-window quantization path
- preserve the snapshot across `TCP_REPAIR_WINDOW` restore when userspace
  provides it, and fall back safely when legacy userspace cannot
- expose the accounting in tracepoints and cover the ABI/runtime contract
  in selftests

Series layout
-------------

1. track the receive-window snapshot state and helpers
2. refresh the snapshot when TCP advertises or initializes windows
3. use the snapshot in receive-memory admission and clamping
4. extend `TCP_REPAIR_WINDOW` for exact restore plus legacy compatibility
5. refresh the TCP shadow window snapshot in MPTCP
6. expose rmem/backlog state in `rcvbuf_grow` tracepoints
7. cover legacy and extended repair-window layouts in selftests

Testing
-------

- `git diff --check origin/main..HEAD`
- `scripts/checkpatch.pl --strict --show-types` on patches 1-7
- `make -j8 headers`
- `make -j8 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make -j8 C=1 CF='-D__CHECK_ENDIAN__' W=1 net/ipv4/tcp_input.o net/ipv4/tcp_output.o net/ipv4/tcp_minisocks.o net/ipv4/tcp.o`
- `make SPHINXDIRS='networking/net_cachelines' htmldocs`
- `make -j8 vmlinux bzImage modules`
- `make -C tools/testing/selftests/net/tcp_ao -j8`
- `make -C tools/testing/selftests/net/mptcp -j8`
- `packetdrill --dry_run` for `tcp_rcv_toobig.pkt` and
  `tcp_rcv_toobig_default.pkt`
- `virtme-run` guest pass for both packetdrill tests
- feature-enabled guest pass for `restore_ipv4`, `self-connect_ipv4`, and
  `mptcp_sockopt.sh`

Thanks,
Wesley

---
base-commit: 908c344d5cfa0ee6efb3226d22ea661e078ebfa0
-- 
2.43.0


