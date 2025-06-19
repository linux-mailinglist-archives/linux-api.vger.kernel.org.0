Return-Path: <linux-api+bounces-3944-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7E6AE0CDC
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 20:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7504A1B0F
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839B128DB62;
	Thu, 19 Jun 2025 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IFFbOB2A"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0432E28C871;
	Thu, 19 Jun 2025 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750357038; cv=none; b=uEBRTy3/QOgvwVToLoAGUXsqxJhJKzW+VUlTjc2tR7qYQVlHlsh1IdC9ZJfRa9q4Vs4rdzy3YahrxFNwqZ/lLVikbWFwzgAGPgCuP+xqG4DyUACMegwcpEy01twJZQPDTxUgsQrjIJ+Dg4Bj3DG061F6zhFbsnkfwKAkR4FANfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750357038; c=relaxed/simple;
	bh=kF8LGdv9oZMXauuQGxc0ySTOfmGH22ANIYdNFskaqCI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VkCN2GEGUztEm3mLuWmXsIcm4aS1K1bGRJhBUBPchmWOH60kxvvmH1J1RGzdtFRZ0ofraW3USkrKMv7i/suCzvbH5AM4g1JSolqPh1f+HJNYkRfE9DYsMutFUvRQe1Xr8CPN9kV/hidpk85zJ37wtMMx+AR8RJVrxHpTVX1CE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IFFbOB2A; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EE0393F9A9;
	Thu, 19 Jun 2025 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1750357026;
	bh=n1cKzBAzY7ed86xDm4Dx91HeM+mexgSBVVHDnuJhS5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=IFFbOB2AtpiBKdY83fvzjtcxmL9XiSCaVBfm2TXxY8zM2SUEWHvFd7A37x77KLkdt
	 zr/Ue1MpFarTfI+dm6j/DnfVLKtxnRcjj0ixpwpar9ZA5DNDPYW18qYoQ5g/4m+98W
	 alu9ulMAR7Ckn3zmC/QVxYfaaR83Szkw4GaEOQQCSPo4upoxiR82oTz0akNzJqMgNs
	 Q+q7Xrsj2HnzHYRPM6tOvOJGhLAgcr3x+VmKnwWkOBIgjzPP8VMM2ycDFjRx8LiOSd
	 AiOmq19hQipU9MkOpmgz8MhkFgXOwno1HD01Ion0+yC38cTX+pvxSOjbmegMW7J8Gh
	 kNfXpvaMp85Ig==
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
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH v2 0/3] lsm: introduce lsm_config_self_policy() and lsm_config_system_policy() syscalls
Date: Thu, 19 Jun 2025 20:15:30 +0200
Message-ID: <20250619181600.478038-1-maxime.belair@canonical.com>
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

-- 
Changes in v2
 - Split lsm_manage_policy() into two distinct syscalls:
   lsm_config_self_policy() and lsm_config_system_policy()
 - The LSM hook now calls only the appropriate LSM (and not all LSMs)
 - Add a configuration variable to limit the buffer size of these
   syscalls
 - AppArmor now allows stacking policies through lsm_config_self_policy()
   and loading policies in any namespace through
   lsm_config_system_policy()
--

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
 include/linux/security.h                      | 16 +++++
 include/linux/syscalls.h                      |  5 ++
 include/uapi/asm-generic/unistd.h             |  6 +-
 include/uapi/linux/lsm.h                      |  8 +++
 kernel/sys_ni.c                               |  2 +
 security/Kconfig                              | 22 ++++++
 security/apparmor/apparmorfs.c                | 31 +++++++++
 security/apparmor/include/apparmorfs.h        |  3 +
 security/apparmor/lsm.c                       | 63 +++++++++++++++++
 security/lsm_syscalls.c                       | 25 +++++++
 security/security.c                           | 69 +++++++++++++++++++
 tools/include/uapi/asm-generic/unistd.h       |  6 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 29 files changed, 290 insertions(+), 2 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
-- 
2.48.1


