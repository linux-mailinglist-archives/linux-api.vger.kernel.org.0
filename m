Return-Path: <linux-api+bounces-4082-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F725AEF363
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 11:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB671BC5FDA
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 09:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1011B27055F;
	Tue,  1 Jul 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="krs4LUJP"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4458269CF1;
	Tue,  1 Jul 2025 09:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362206; cv=none; b=tUFNrdZq5w39Z2dVd6nVB+56ZUYyFJGaDM0lmwOli+C4MMU0uAvKNjRVQIA+PnsZqeMwfV7ruybD6dnn3MHOX89t6IbJJLoqOo+V9/2o+qwPueVj9AIiIJmqNqknoyGVV3U3QplBwjxG77DIo86765Yksp3Vshhel5aRvkIMrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362206; c=relaxed/simple;
	bh=mI2bcxeSQWVmBisEdmPAetbjZIHjM16PxkzKdX7lrPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RxPlGYeopQTjv1yVU7/0R175gm3I6npB3lkFkzzYIukAV/ozRzMuJDxYyueEBfH7CTGHfXUMHSdAwhXMiKvF3DsEoBwAm9y37XntkjEO3BTmSTvIpSRhBIwGkGtA7VmayzNbRyhlakaFZsyqy4IJcP7gBW+KNCPtWwk8X3xvEOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=krs4LUJP; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (176-136-128-80.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4DC083F702;
	Tue,  1 Jul 2025 09:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751361610;
	bh=sbEax+u9FyP8XVplruAPXD54M5bPhhX1zb7JgpbL7to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=krs4LUJPF/uvFU3VSj3erJ8kQfzUOQxqUYoe7supNqCgC6lghZdNHEGCBnJGUCey6
	 NnLnW/twUo+vKH7YI+k9v4AdBnpXAK60lK3pbfSM+A8HND/Oi7DVzgDzlEW/8oWPve
	 K/9HUNhgM3cn8Jzn9BiSy7Ioa5kbhVDC4CzyyNZo6/ja8Bo8bOpEEfNKMYGNg6e7c1
	 J+CbW/ovcQQQp3xjSTrf30DLymrWqnqIe/gOQS1R0uutHAbCn5DtoPxeD+2OAg4vo3
	 dACor5fINPL51E5oHxy93mn2asniashQOKpIP3f1OjL9R8ULT5O2vGS7Xngmo/pNAW
	 Ho3WaeiQMc3Ug==
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
Subject: [PATCH v4 0/3] lsm: introduce lsm_config_self_policy() and lsm_config_system_policy() syscalls
Date: Tue,  1 Jul 2025 11:17:38 +0200
Message-ID: <20250701091904.395837-1-maxime.belair@canonical.com>
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
 security/apparmor/apparmorfs.c                | 31 ++++++++
 security/apparmor/include/apparmor.h          |  4 +
 security/apparmor/include/apparmorfs.h        |  3 +
 security/apparmor/lsm.c                       | 79 +++++++++++++++++++
 security/lsm_syscalls.c                       | 25 ++++++
 security/security.c                           | 63 +++++++++++++++
 tools/include/uapi/asm-generic/unistd.h       |  6 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  2 +
 29 files changed, 286 insertions(+), 2 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
-- 
2.48.1


