Return-Path: <linux-api+bounces-3956-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CEEAE6952
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 16:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4562F1C2538B
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 14:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0B2E62B3;
	Tue, 24 Jun 2025 14:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dPEkM6YT"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C052E3363;
	Tue, 24 Jun 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775633; cv=none; b=MTbgZndquuiAvA2/+mE1wYBvWHLqUeJtisRrQkFzzE5g0IkSE4ogGQp78Cxj9JhC++llSJdlq/vUkL3YRfupcfw7NID7q7zjl+OUcQ4J2eOkEgf+cUoapWgVMsnLtTTzXaXnUwViOpO7nOhzpRiGNeZ+z8Ab08rE4UlIs1Fn0/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775633; c=relaxed/simple;
	bh=uCOWM58DfpNpIylnsONLhls5uM6mvCBOAPsjQuMH4nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TgrHBL7y1ev8VGp6Twnr0/8I/BcxxAo/T9WVxXuVbW8ITIW5TmMqRCiF8EvHEaLR2u4q9ydWNd5kCSTk3kJn+OE6hmE0R2V1qqUO9E0AXk1sDs4z02USoSnhDCwJPw1GLZixoZnMaPslbwCfR7NRtJE25hwcX++ELo89eOyzuNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dPEkM6YT; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B8E1A3F189;
	Tue, 24 Jun 2025 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750775628;
	bh=3muT/iMJ7UI6YOkx4LNS2+Wep3YKWoeTkaQsAdfM3Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=dPEkM6YTkLnhJgJsQ6xvnSJkXcG4T1jW5gnfcmvevvxTyo8Pg9honk//OcJtQAC3g
	 AjMw+7Bk8bmdQ+mMo5vZuDJAAta1mijJbed+jX1tIU1Ko+5XO/zUdPMF8DezOz7ahh
	 RSN+Y3fqlXJ157e39vHg5i92e2QRTUYkU7MZWtxBV/m+zYEev2xo+x46bFKYXUDNrJ
	 06+DLAi3zixkcaY5/BHWCRIbYNraePKdaOTwYb9SG56j6hqc1qpWXnvNfL02kYj0/1
	 8Xj6/Id+gI5Hc9vSw6gjRhhMMI7Hn+7Uxi8ljgdJyb8EKCBrpRGW5hd8DTKjUEOnLH
	 uiXYDzsAXuyOw==
From: =?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
To: linux-security-module@vger.kernel.org
Cc: john.johansen@canonical.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	mic@digikod.net,
	kees@kernel.org,
	stephen.smalley.work@gmail.com,
	casey@schaufler-ca.com,
	takedakn@nttdata.co.jp,
	penguin-kernel@I-love.SAKURA.ne.jp,
	song@kernel.org,
	rdunlap@infraread.org,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v3 0/3] lsm: introduce lsm_config_self_policy() and lsm_config_system_policy() syscalls
Date: Tue, 24 Jun 2025 16:30:39 +0200
Message-ID: <20250624143211.436045-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset introduces two new syscalls: lsm_config_self_policy(),
lsm_config_system_policy() and the associated Linux Security Module hooks
security_lsm_config_*_policy(), providing a unified interface for loading
and managing LSM policies. These syscalls complement the existing per‑LSM
pseudo‑filesystem mechanism and work even when those filesystems are not
mounted or available.

With these new syscalls, users and administrators may lock down access to
the pseudo‑filesystem yet still manage LSM policies. Two tightly-scoped
entry points then replace the many file operations exposed by those
filesystems, significantly reducing the attack surface. This is
particularly useful in containers or processes already confined by
Landlock, where these pseudo‑filesystems are typically unavailable.

Because they provide a logical and unified interface, these syscalls are
simpler to use than several heterogeneous pseudo‑filesystems and avoid
edge cases such as partially loaded policies. They also eliminates VFS
overhead, yielding performance gains notably when many policies are
loaded, for instance at boot time.

This initial implementation is intentionally minimal to limit the scope
of changes. Currently, only policy loading is supported, and only
AppArmor registers this LSM hook. However, any LSM can adopt this
interface, and future patches could extend this syscall to support more
operations, such as replacing, removing, or querying loaded policies.

Landlock already provides three Landlock‑specific syscalls (e.g.
landlock_add_rule()) to restrict ambient rights for sets of processes
without touching any pseudo-filesystem. lsm_config_*_policy() generalizes
that approach to the entire LSM layer, so any module can choose to
support either or both of these syscalls, and expose its policy
operations through a uniform interface and reap the advantages outlined
above.

This patchset is available at [1], a minimal user space example
showing how to use lsm_config_system_policy with AppArmor is at [2] and a
performance benchmark of both syscalls is available at [3].

[1] https://github.com/emixam16/linux/tree/lsm_syscall
[2] https://gitlab.com/emixam16/apparmor/tree/lsm_syscall
[3] https://gitlab.com/-/snippets/4864908

---
Changes in v3
 - Fix typos

Changes in v2
 - Split lsm_manage_policy() into two distinct syscalls:
   lsm_config_self_policy() and lsm_config_system_policy()
 - The LSM hook now calls only the appropriate LSM (and not all LSMs)
 - Add a configuration variable to limit the buffer size of these
   syscalls
 - AppArmor now allows stacking policies through lsm_config_self_policy()
   and loading policies in any namespace through
   lsm_config_system_policy()
---

Maxime Bélair (3):
  Wire up lsm_config_self_policy and lsm_config_system_policy syscalls
  lsm: introduce security_lsm_config_*_policy hooks
  AppArmor: add support for lsm_config_self_policy and
    lsm_config_system_policy

 arch/alpha/kernel/syscalls/syscall.tbl        |  2 +
 arch/arm/tools/syscall.tbl                    |  2 +
 arch/m68k/kernel/syscalls/syscall.tbl         |  2 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |  2 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |  2 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |  2 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |  2 +
 arch/parisc/kernel/syscalls/syscall.tbl       |  2 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |  2 +
 arch/s390/kernel/syscalls/syscall.tbl         |  2 +
 arch/sh/kernel/syscalls/syscall.tbl           |  2 +
 arch/sparc/kernel/syscalls/syscall.tbl        |  2 +
 arch/x86/entry/syscalls/syscall_32.tbl        |  2 +
 arch/x86/entry/syscalls/syscall_64.tbl        |  2 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |  2 +
 include/linux/lsm_hook_defs.h                 |  4 ++
 include/linux/security.h                      | 18 +++++
 include/linux/syscalls.h                      |  5 ++
 include/uapi/asm-generic/unistd.h             |  6 +-
 include/uapi/linux/lsm.h                      |  8 +++
 kernel/sys_ni.c                               |  2 +
 security/Kconfig                              | 22 ++++++
 security/apparmor/apparmorfs.c                | 31 ++++++++
 security/apparmor/include/apparmorfs.h        |  3 +
 security/apparmor/lsm.c                       | 71 +++++++++++++++++++
 security/lsm_syscalls.c                       | 25 +++++++
 security/security.c                           | 69 ++++++++++++++++++
 tools/include/uapi/asm-generic/unistd.h       |  6 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 29 files changed, 300 insertions(+), 2 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
-- 
2.48.1


