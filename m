Return-Path: <linux-api+bounces-4143-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D99AFE1D3
	for <lists+linux-api@lfdr.de>; Wed,  9 Jul 2025 10:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8792C1BC5A89
	for <lists+linux-api@lfdr.de>; Wed,  9 Jul 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA0235BE1;
	Wed,  9 Jul 2025 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IilcMi/v"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7E22539E;
	Wed,  9 Jul 2025 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048199; cv=none; b=d7FbPTl7klVDnDcmr3MNf6OZdBqtlom4LuHCd3F/QmhuVVStMYQnMJuZV3umJPcuFBr0aB7FSFDwA4zB1cohIUIwR3ldF96dcdehMBOtNAQIRxdtoxIQa01A9P2L8RX29qQWHUyGHrQgGefHBZc2FIFGoC/UAuWwYxdR61+6tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048199; c=relaxed/simple;
	bh=spCwiESFX+5apWoOtPJqIiucwT8h3Bsj1plAMzmlSqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jos70NVH4FE/C6mdhTxwkcfimQ2UDNXgFAoFvNTaCEyYN9bkc+iO3CcntYUA3ksT8nyfT/UbJYwyfa5IHJ+EjdozM/tGfhJDVnu1L5s+elcgzjNKvU5mUWCEzMYKZTYYUq402lkbz96XOuVW+uNlDgZay+M6wbxhibovi63YBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IilcMi/v; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A7DCC3F784;
	Wed,  9 Jul 2025 08:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1752048186;
	bh=MdZFOOAxxlhICgD522nsYR/hdSej8sTawvepD/fEmSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=IilcMi/v4ZaEkgx5sqzHP09W/V5mRgBQnl2RR1dqCfrZW+kLVHmKz0JHfUvbDhy87
	 uN4dHnNcu88T+Bz0+yeWiiaqSG6fEh86ZaIf1fc+MA1bENf7jliIAMWBRZXoi40m20
	 9KWytF3givwuiLMPdzt2XLs5RFdDXddOt+JOdTZCAn0c5UV1GLCHV68Ruc61ZdCelP
	 5i8l6RQVtKYPItmszSPjHjJJv7GnXrM5xRm3VsIe86lzY7mn9okEwAIImTTiqm9Hax
	 QeNT6S7dL+amd9kvm7yGckd+vjQj0EMUmEbe+za5fEPFJVqigYge2j6eC5ZYAEVdf1
	 31KNtScwUDCbA==
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
	rdunlap@infradead.org,
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v5 0/3] lsm: introduce lsm_config_self_policy() and lsm_config_system_policy() syscalls
Date: Wed,  9 Jul 2025 10:00:53 +0200
Message-ID: <20250709080220.110947-1-maxime.belair@canonical.com>
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
Changes in v5
 - Improve syscall input verification
 - Do not export security_lsm_config_*_policy symbols

Changes in v4
 - Make the syscall's maximum buffer size defined per module
 - Fix a memory leak

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
 include/linux/lsm_hook_defs.h                 |  4 +
 include/linux/security.h                      | 20 +++++
 include/linux/syscalls.h                      |  5 ++
 include/uapi/asm-generic/unistd.h             |  6 +-
 include/uapi/linux/lsm.h                      |  8 ++
 kernel/sys_ni.c                               |  2 +
 security/apparmor/apparmorfs.c                | 31 +++++++
 security/apparmor/include/apparmor.h          |  4 +
 security/apparmor/include/apparmorfs.h        |  3 +
 security/apparmor/lsm.c                       | 84 +++++++++++++++++++
 security/lsm_syscalls.c                       | 25 ++++++
 security/security.c                           | 60 +++++++++++++
 tools/include/uapi/asm-generic/unistd.h       |  6 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 29 files changed, 288 insertions(+), 2 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
-- 
2.48.1


