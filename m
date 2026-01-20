Return-Path: <linux-api+bounces-5658-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAoaGRCob2ndEgAAu9opvQ
	(envelope-from <linux-api+bounces-5658-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 17:06:40 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC753470EB
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 17:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7487942D9E
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 14:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354043DA46;
	Tue, 20 Jan 2026 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NoSWA8KH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NItJhtZf"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475F43CECD;
	Tue, 20 Jan 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768918243; cv=none; b=MwusQKw5SE9SR+3+ZsVAoKg+Ia196+uFLU7J5pfpT3J4IC46J/NFV4zKw9IB5/hLlokioiw0LrklwLazmDwE4fkz+yRtvkip7vVQoQcF+wSrvz/zfuSyyZirEQCA1Ze/SFFrzNdqZTlzVVV1EeN0tHCix2ihULUNmxeusynxRso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768918243; c=relaxed/simple;
	bh=Ahm6F+EOjc6R8Q0l33MFSfJ04zvpzbPYSaGnxm24BWE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R+FGMOZ6ZOdZbc5vZEcyCtGSTJXfJZYUsV7kj6obD/xY12mBSCN9QoKQwVtJtJ8RfPGhqb81aLjUkW/ll7AZjw16N1j13jUwsVf9CrBwb87B2EgILEMmGbF754tsaVfNbVH8vAPUuq6Rtji+iFlurI/csTj0qTW5ZCamYBu55Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NoSWA8KH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NItJhtZf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768918239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nw3GMmv6rsxzJhfQEt7gKqAEVYquIJkLViAuhkQckP0=;
	b=NoSWA8KHAOW34ej89I6r4P9qqfRGTSrpRdLYpSX2TU/YKte6uFQbzKvdinPA0lisvYESRi
	HYR3dbyIkym4yrwD6NuHSOFvoIRarqOstQ0TP56+/FTOn0uUTAZnuzzVzPi/0GoNDWQ88d
	GlGpOIj51tOdACdwx6SwPz+vAN3Pgg5Z+Wm/5Ly4DbiMrVsQfo/kZ8DQ3XH2ap2jNNODle
	ES+cM/ucSiFmYheJ92FprCtTYAW3fNxZv9iWB3FSG21peOu2k5+LOEXRiiGBNOKFoT6SFT
	fjRfM7aEWKIcHL7Nkspjl4yIVkCDKs85aMN92Q3Dl7GWp7BAFekFEzpwlwgi/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768918239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nw3GMmv6rsxzJhfQEt7gKqAEVYquIJkLViAuhkQckP0=;
	b=NItJhtZfv+tx5epeA2xKfozfbOxxbY0+Lwh+VC3Sf/nVsyjCAfZ/h/i5gbhoRCCWad3fkz
	//HYvaUB6h2f5DAg==
Subject: [PATCH net-next v2 0/4] net: uapi: Provide an UAPI definition of
 'struct sockaddr'
Date: Tue, 20 Jan 2026 15:10:30 +0100
Message-Id: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANaMb2kC/12NQQ6CMBBFr0Jm7Zh2tBBdeQ/DotBBJpqWtIVgC
 He3Yeny5eW/v0HiKJzgXm0QeZEkwRegUwX9aP2LUVxhIEVGExHOdhJMoX9b5yL2g1bc1HRt6AZ
 lM0UeZD16T/Cc0fOaoS1mlJRD/B5Hiz58adZKK/PXXDRq7JraXGxnNVnz+Iifcwxe1rNjaPd9/
 wFO2SCEuAAAAA==
X-Change-ID: 20251222-uapi-sockaddr-cf10e7624729
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 linux-kselftest@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
 libc-alpha@sourceware.org, Carlos O'Donell <carlos@redhat.com>, 
 Adhemerval Zanella <adhemerval.zanella@linaro.org>, 
 Rich Felker <dalias@libc.org>, klibc@zytor.com, 
 Florian Weimer <fweimer@redhat.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768918237; l=2292;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Ahm6F+EOjc6R8Q0l33MFSfJ04zvpzbPYSaGnxm24BWE=;
 b=5X22So3PfA/S7ayTw8eLh1EFtj1DE0Tv6sUsSL2/wnoVi2BXpK944Df4Iu5TWZmKG+GLpv7YI
 jzfIuR+GpMBDIJ9kfKmasfJ9A3NvmYTn3p3DyGhQAXO3d2FHCDLTleb
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5658-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,redhat.com,davemloft.net,kernel.org,digikod.net,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linutronix.de:email,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: BC753470EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Various UAPI headers reference 'struct sockaddr'. Currently the
definition of this struct is pulled in from the libc header
sys/socket.h. This is problematic as it introduces a dependency
on a full userspace toolchain.

Add a definition of 'struct sockaddr' to the UAPI headers.
Before that, reorder some problematic header inclusions in the selftests.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Fix compilation failures in BPF samples and selftests
- Link to v1: https://lore.kernel.org/r/20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de

---
Thomas Weißschuh (4):
      selftests: net: Move some UAPI header inclusions after libc ones
      selftests/landlock: Move some UAPI header inclusions after libc ones
      samples/bpf: Move some UAPI header inclusions after libc ones
      net: uapi: Provide an UAPI definition of 'struct sockaddr'

 include/linux/socket.h                             | 10 ----------
 include/uapi/linux/if.h                            |  4 ----
 include/uapi/linux/libc-compat.h                   | 12 ++++++++++++
 include/uapi/linux/socket.h                        | 14 ++++++++++++++
 samples/bpf/xdp_adjust_tail_user.c                 |  6 ++++--
 samples/bpf/xdp_fwd_user.c                         |  7 ++++---
 samples/bpf/xdp_router_ipv4_user.c                 |  6 +++---
 samples/bpf/xdp_sample_user.c                      | 15 ++++++++-------
 samples/bpf/xdp_tx_iptunnel_user.c                 |  4 ++--
 tools/testing/selftests/landlock/audit.h           |  7 ++++---
 tools/testing/selftests/net/af_unix/diag_uid.c     |  9 +++++----
 tools/testing/selftests/net/busy_poller.c          |  3 ++-
 tools/testing/selftests/net/mptcp/mptcp_diag.c     | 11 ++++++-----
 tools/testing/selftests/net/nettest.c              |  4 ++--
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |  6 +++---
 tools/testing/selftests/net/tcp_ao/lib/netlink.c   |  9 +++++----
 tools/testing/selftests/net/tun.c                  |  5 +++--
 17 files changed, 77 insertions(+), 55 deletions(-)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20251222-uapi-sockaddr-cf10e7624729

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


