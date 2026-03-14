Return-Path: <linux-api+bounces-5967-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJo/H7fBtWkV4wAAu9opvQ
	(envelope-from <linux-api+bounces-5967-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:14:47 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741928EBAC
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 21:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EC273014610
	for <lists+linux-api@lfdr.de>; Sat, 14 Mar 2026 20:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F40384259;
	Sat, 14 Mar 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hro6Tiyy"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACB3368BB
	for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773519283; cv=none; b=tIbSwtsEqYpEzMQvffb1GODFS8yi2weWa2P7Ifo+697lgKmnZTG//2guig21n7mKXWUXSIvXV2tjVUWHMJcf8o64APPg8+19M877LTS6GrqOI6v/vq088IVOqEOeobXv7TsvJ52ARd9B2kR8yLVXApWw4hAJmf3cxcwO/2i2qns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773519283; c=relaxed/simple;
	bh=BynOgwAYPtb/KpshiEi9Ah5xEZa4UMFbs/5oRQMyRbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MbfXFsw/f0Q1q6PbehDWDn/jNIcADhK4UDXDYSCP0ux/h9BjwwGxc9kZsDlOZTP8OK9YhMsIqer4REQnBcDTah2YqOR+Ge/s9alFc2Ya8grAuqU0CcBkcD6glOSXpGcH7SyxgK+FtOetNXOKX8hWEBzofNQYqTRha6WGl5vA58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hro6Tiyy; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-41729dc7d7aso1272350fac.3
        for <linux-api@vger.kernel.org>; Sat, 14 Mar 2026 13:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773519280; x=1774124080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZQP7SyWGDwwAMOAnxSbi4O+tM8xtS6WH81TGDPwQ5w=;
        b=Hro6TiyyKbllqTwuYBm8ZLytugkPa7QgbTUsOycf61G5oWgwGxQ8mFa88taodDMlLV
         e2e5r6pIvC+SyxZ/w2RzZZnPfrjMOcdUGdFbAdMoHEULawFq5m8QanTVSw+6Oawc8M5B
         bJ9ZYk41i9HkS6xB0RIfyZDG55Z1Olr8qBjbxGVoO6vpHG/oA8zz1kZHopN/YrDuaQsd
         pNx8erJaKVb0RK+jca5AxZ1JFMntIX/bZDOA84Lofxk8/EGhD86e/X+JJ40XCq3wyQsG
         wS/XjtW4vvUbXL7IcaXpfeGh0KefJ4KtRApp/c/TFEEPmwyrHmf5UtgCB06ZSp6OZsGj
         3mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773519280; x=1774124080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZQP7SyWGDwwAMOAnxSbi4O+tM8xtS6WH81TGDPwQ5w=;
        b=Aqg4PobH9asntis77N16tlKXwd+nYf4J9qTQmG/+hZ56BQAyGy21B4CUcOffc9UqI1
         xU7Hoirq76z2iGEBsuGSag/dyxOAMtUdMgxcUsRjUAHql0BHPvn2DsT590zwDnXVzAWA
         lf7ptT3Q5tjvo6BBZeY6KCofCv85pV9+w0I7cucLmkgVqBBW2h/0hgEh8zALKauPiyvd
         0G4tQFQRsLvypx3EMTg5ttz+O24f7gdjW1YDS15p0YnYhgGhX8IccBYA7xQnHIzDBskq
         T/uUEMUByYpP1CnJBzUBdkZqwj78+0pjlm9bIe1wV28xswgf/ZFZaNgj/sG01k99onGf
         clLw==
X-Forwarded-Encrypted: i=1; AJvYcCVVjy/w6Q3AVGXAtqR1fHhokve7qCAhC4d8R50Px0uesZ57dYHv6WjpQwG+Skb0ppHkHTJGW3AZNIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLp8XhyWEHArULjhhdqT+xyzma0C92cAg+kQDtc+h1f9kcaBxI
	+nZQuENUDJKwkjjHaozAG0x1eB3M+q0C6XaNM1SgbG3KHiNSMkrFGxLL
X-Gm-Gg: ATEYQzzXxniun5cpsjz2JtQ0XHBMEV6rO3J0zK5AQ2iy6glpQHGSWLL/KZOb21zsspw
	NhMr4QYIKUi95sx54OxGLPE9V0N5BX2PIr31TT03Xo8RYOlCESu9O9roKYKfeZIlYtAJIjelfB6
	QUQ5u56PKodVrxcwziVDzp1DkUgNBURKctMsIT5MQI5DodOEVJloDxbch6E3afFwkFudSxg1bz/
	l8Kwr3TeHS3cuIZMMU+awufL8q21tOQ9K20NJ4wQHfBHMyWgjodlZ6vn5rMAhY978sO5h4oJ5MX
	Jlfimyw15pj/wpAme3uXCj532RgZYgU5PaHI6PWNJTQN6eNe38w705fkzCF9wNAtTxD9Alk8w9d
	Gw1jAAqqa9EcIx9/KgO9EXRGdO4zoJR/eZAllII878Oq8tcpKCfQCMkNElG4sXFVrEdFl3z0prL
	Fx7l/lEliEuzgvTcTfqm7kh9umHtsqIwfotoyL8oon2Fc5X9jBQKKeafqdLg3Za1pye5aLrPZ4H
	HTtR3zG8ine7BSUt67vj+Lh0rh3l6OG2owgfNCt
X-Received: by 2002:a05:6871:ca:b0:417:6237:cf82 with SMTP id 586e51a60fabf-417b923e031mr4502917fac.23.1773519280265;
        Sat, 14 Mar 2026 13:14:40 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e8185sm11914165fac.12.2026.03.14.13.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:14:39 -0700 (PDT)
From: atwellwea@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	ncardwell@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	dsahern@kernel.org,
	horms@kernel.org,
	kuniyu@google.com,
	andrew+netdev@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	skhan@linuxfoundation.org,
	corbet@lwn.net,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	0x7f454c46@gmail.com
Subject: [PATCH net-next v2 00/14] tcp: preserve receive-window accounting across ratio drift
Date: Sat, 14 Mar 2026 14:13:34 -0600
Message-ID: <20260314201348.1786972-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,google.com,lunn.ch,gmail.com,redhat.com,linuxfoundation.org,lwn.net,goodmis.org,efficios.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5967-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[atwellwea@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1741928EBAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wesley Atwell <atwellwea@gmail.com>

This series keeps sender-visible TCP receive-window accounting tied to the
scaling basis that was in force when the window was advertised, even if
later receive-side truesize inflation lowers scaling_ratio or the live
receive window retracts below the largest right edge already exposed to the
sender.

After the receive-window retraction changes, the receive path needs to keep
track of two related pieces of sender-visible state:

  1. the live advertised receive window
  2. the maximum advertised right edge and the basis it was exposed with

This repost snapshots both, uses them to repair receive-buffer backing when
ratio drift would otherwise strand sender-visible space, extends
TCP_REPAIR_WINDOW so repair/restore can round-trip the new state, and adds
truesize-drift coverage through TUN packetdrill tests and netdevsim-based
selftests.

v2:
- repost to net-next and use the [PATCH net-next v2] prefix
- rebase the receive-window accounting changes on top of the retraction
  model
- split the series more finely
- snapshot both the live rwnd basis and the max advertised-window basis
- extend TCP_REPAIR_WINDOW to preserve legacy, v1, and current layouts
- add TUN RX truesize injection and packetdrill coverage for ratio drift
- split the generic netdevsim PSP extension cleanup into its own final
  patch after the peer RX truesize support
- add the requested ABI/runtime comments at the non-obvious review points

Testing:

- full runtime selftest coverage for netdevsim, tcp_ao, mptcp, and
  packetdrill; all runtime suites completed successfully
- tcp_ao completed 24/24 top-level tests, covering 803 passing checks,
  6 expected failures, 36 skips, and 0 unexpected failures
- mptcp completed 588 passing checks in aggregate, with 28 skips and
  0 unexpected failures
- packetdrill completed 219/219 runtime cases with 0 failures,
  including the new tests
- netdevsim completed 18/18 top-level runtime tests with 0 failures,
  including the peer RX truesize and related netdevsim coverage used by
  this series

Wesley Atwell (14):
  tcp: factor receive-memory accounting helpers
  tcp: snapshot advertise-time scaling for rcv_wnd
  tcp: refresh rcv_wnd snapshots at TCP write sites
  tcp: snapshot the maximum advertised receive window
  tcp: grow rcvbuf to back scaled-window quantization slack
  tcp: regrow rcvbuf when scaling_ratio drops after advertisement
  tcp: honor the maximum advertised window after live retraction
  tcp: extend TCP_REPAIR_WINDOW for live and max-window snapshots
  mptcp: refresh TCP receive-window snapshots on subflows
  tcp: expose rmem and backlog in tcp and mptcp rcvbuf_grow tracepoints
  selftests: tcp_ao: cover legacy, v1, and retracted repair windows
  tun/selftests: add RX truesize injection for TCP window tests
  netdevsim: add peer RX truesize support for selftests
  netdevsim: release pinned PSP ext on drop paths

 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 drivers/net/netdevsim/netdev.c                | 156 ++++++-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 drivers/net/tun.c                             |  65 +++
 include/linux/tcp.h                           |   2 +
 include/net/tcp.h                             | 118 ++++-
 include/trace/events/mptcp.h                  |  11 +-
 include/trace/events/tcp.h                    |  12 +-
 include/uapi/linux/if_tun.h                   |   4 +
 include/uapi/linux/tcp.h                      |   8 +
 net/ipv4/tcp.c                                |  75 ++-
 net/ipv4/tcp_fastopen.c                       |   2 +-
 net/ipv4/tcp_input.c                          | 160 ++++++-
 net/ipv4/tcp_minisocks.c                      |   4 +-
 net/ipv4/tcp_output.c                         |  25 +-
 net/mptcp/options.c                           |  14 +-
 net/mptcp/protocol.h                          |  14 +-
 .../selftests/drivers/net/netdevsim/Makefile  |   1 +
 .../drivers/net/netdevsim/peer-rx-truesize.sh | 426 ++++++++++++++++++
 .../tcp_rcv_neg_window_truesize.pkt           | 143 ++++++
 .../net/packetdrill/tcp_rcv_toobig.pkt        |  35 ++
 .../packetdrill/tcp_rcv_toobig_default.pkt    |  97 ++++
 .../tcp_rcv_toobig_default_truesize.pkt       | 118 +++++
 .../tcp_rcv_wnd_shrink_allowed_truesize.pkt   |  49 ++
 .../testing/selftests/net/tcp_ao/lib/aolib.h  |  83 +++-
 .../testing/selftests/net/tcp_ao/lib/repair.c |  18 +-
 .../selftests/net/tcp_ao/self-connect.c       | 201 ++++++++-
 tools/testing/selftests/net/tun.c             | 140 +++++-
 28 files changed, 1911 insertions(+), 76 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer-rx-truesize.sh
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_neg_window_truesize.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_toobig_default_truesize.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rcv_wnd_shrink_allowed_truesize.pkt


base-commit: f807b5b9b89eb9220d034115c272c312251cbcac
-- 
2.43.0


