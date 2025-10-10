Return-Path: <linux-api+bounces-5079-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97258BCD4AE
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319623A3F81
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44D2F49F1;
	Fri, 10 Oct 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="kcCDw7R/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECCB2F0C63;
	Fri, 10 Oct 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760103307; cv=none; b=niTCyVT74xdOTSi4pVOKQ5upFQD2/+wBOw6CRAeo/k2s/pUPRhgUDxtepfTjV5/ZLLkkBmCnkDH40/H5kxIuS5eVT2vfK74AosYRwzTa4FibvjFwgq2m+n71yPa9bSF6barS/c6nrScd3uzbxvWncpn20h8yKtUZhcjZG3NbY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760103307; c=relaxed/simple;
	bh=WpdwCHnR6YvPBMECAdpI2N8LvqL2Le3s5O9bkHz4KTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=reLUL4RO0Fd6QIcYyEgICiXBysKq8kPM5CK4k9jgIv51NARiBtExFP/oDhyJEXTRD75aFNu7Q6CITZ2VZgJOc6F99HvABA06sBFwDn/KIYS53/0xdYQ4w2WbxGGVta3Z9eaNXcA4WolOeNi41R3aKDHcjdggVwpWp99t0K9II/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=kcCDw7R/; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (176-136-128-80.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A6C2742AC3;
	Fri, 10 Oct 2025 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760102817;
	bh=1+R4NDJt4y0CKtRPec2MymO8YNfHu67NK0H5d5mZvbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=kcCDw7R/YD40px2rhTI7H5tdkB7mxvPPtoQsxmC9Wm3N0EDjCf/TApsgOxS6ncNez
	 rjR5LhHkTTuTz618y+bWNF0EgLo04GCdFI7DmBcHQ0o4MFEGoYB9oA7RdR6l+jfCA/
	 jCmMkukk9ZRKtOkkT9Kki0AA+/Tgl5sieOt6FyCMdZGw0LRQf+8Mb+tsvb2wtpuZGS
	 +tHzpuUmZVmY6Ip30fQpMb2SAjNzPyOU3GByjr58c0oJOMfWEx3H5flUOp0Lw48ij3
	 lV58FslnwUHsODMcHn1oI6YkuLm80btd4Wtsx5afyZU3UqBxnMlc/CWgo4wM58rX83
	 Cn8KGW59oEU6KqhXqAhF0oYpL7pKJm3BdkBTwaWlBGHf6lYdr5Rw4qK51XY0tWQDNM
	 XDVjdRqrRudBIJGIjVKtiq9wVlEJRUK227pegYDMGiRE29cbESDsrjb3bISmCKZnlb
	 YpWuOPtw+XvaleuM1Hw70nhy0YQGmZ6bWs/6aUFKorU0grlBczSH2gdq6Ak+IRSWRz
	 5VsVA9yPYxAADLt8527rJC10YxmKd16gg1IUaAzf91Tk5sRiBANksyJq10P5mBEFE5
	 ZJGKeerxqfVXhG74hLaquoZ+NYXt2OWBu7H2BmdxQSCGHY7BW5vAA32dJNo03VYBNI
	 EE9iBPQCmKh6N252QVNR1xVk=
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
Subject: [PATCH v6 0/5] lsm: introduce lsm_config_self_policy() and lsm_config_system_policy() syscalls
Date: Fri, 10 Oct 2025 15:25:27 +0200
Message-ID: <20251010132610.12001-1-maxime.belair@canonical.com>
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
of changes. Currently, only policy loading is supported. This new LSM
hook is currently registered by AppArmor, SELinux and Smack. However, any
LSM can adopt this interface, and future patches could extend this
syscall to support more operations, such as replacing, removing, or
querying loaded policies.

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

[1] https://github.com/emixam16/linux/tree/lsm_syscall_v6
[2] https://gitlab.com/emixam16/apparmor/tree/lsm_syscall_v6
[3] https://gitlab.com/-/snippets/4864908

---
Changes in v6
 - Add support for SELinux and Smack

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


Maxime Bélair (5):
  Wire up lsm_config_self_policy and lsm_config_system_policy syscalls
  lsm: introduce security_lsm_config_*_policy hooks
  AppArmor: add support for lsm_config_self_policy and
    lsm_config_system_policy
  SELinux: add support for lsm_config_system_policy
  Smack: add support for lsm_config_self_policy and
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
 security/lsm_syscalls.c                       | 21 +++++
 security/security.c                           | 60 +++++++++++++
 security/selinux/hooks.c                      | 27 ++++++
 security/selinux/include/security.h           |  7 ++
 security/selinux/selinuxfs.c                  | 16 +++-
 security/smack/smack.h                        |  8 ++
 security/smack/smack_lsm.c                    | 73 ++++++++++++++++
 security/smack/smackfs.c                      |  2 +-
 tools/include/uapi/asm-generic/unistd.h       |  6 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 35 files changed, 412 insertions(+), 7 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
-- 
2.48.1


