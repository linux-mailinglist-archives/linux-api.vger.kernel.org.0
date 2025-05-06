Return-Path: <linux-api+bounces-3703-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213DAAC855
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 16:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C47AA7BD129
	for <lists+linux-api@lfdr.de>; Tue,  6 May 2025 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E4B2836BF;
	Tue,  6 May 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FLDeS8VF"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A416283144;
	Tue,  6 May 2025 14:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542409; cv=none; b=keDvIBSzEJdep2II9oQ4F5qWnjm3McogNh2ylleZc+twpPw6DnaCAuGhSMhzXVBDpYdn2i1SdLq4BpvpgTAkAZqq79TzoWUALezulKhypdkU4BZhMTFzcldzAPsu8UzmNO8p6l8Icw+EJJA1N93OL4zkbi5SZTMyss01TJZPkM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542409; c=relaxed/simple;
	bh=1iXstPr7bOiUj3ykArYg0RbbEU7/aRPEt2AAD7QT3is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gtrXES623YLS+SgpFGoTCu11KyZW5SytCLtG8Z2leU8zXqOMDQHv0g9ynq6Cy9jQeEPD6Zf8SiqwdQthXVH9r64kdKaL9yknKnhk0+VNwZpR/JYBMIczMxzCzL3UZTHnNH6lKqG8f6ooGt1eEePL8YxtCORk6EeD9CtjOy/FjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FLDeS8VF; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from sec2-plucky-amd64.. (lau06-h06-176-136-128-80.dsl.sta.abo.bbox.fr [176.136.128.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0A1493F942;
	Tue,  6 May 2025 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746542030;
	bh=an5raNhgTgi9WJMXPfc6cBxG0uJN7smFK940ReUZLPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=FLDeS8VFZ41ndrtlEFVsHdrPIQ6TQtZdwGHAi2DPrlUhFH7oYF9po/v3tJk0L32WA
	 EOk91i5JRKqQAPNh8l7Z8d6b9xTfSZ7zVQbdhePp9mAuA1BhIZ7qMJh4IVb6OXckox
	 HMA8aboFP9Pjdwhe9c2bydNkb/cTE6LTcz/vSVaoQQo++bsI5wdyBTXAOeU5voiASr
	 zgo6YhGV4fT4Z+zG9GHh9NuNaizX3O5zDoEaF8ZmpR+UCvZC/Il+gMmYESV7SdcgpL
	 IEA4ke66R6Vh+qq6/5FLfM4fb5Q68/DCQbGojeqdPx4Wddr2QkR8Ds6/7nmBPKYyYG
	 AldNvaW3ruqKg==
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
	linux-api@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Maxime=20B=C3=A9lair?= <maxime.belair@canonical.com>
Subject: [PATCH 0/3] lsm: introduce lsm_manage_policy() syscall
Date: Tue,  6 May 2025 16:32:27 +0200
Message-ID: <20250506143254.718647-1-maxime.belair@canonical.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset introduces a new syscall, lsm_manage_policy(), and the
associated Linux Security Module hook security_lsm_manage_policy(),
providing a unified interface for loading and managing LSM policies.
This syscall complements the existing per‑LSM pseudo‑filesystem mechanism
and works even when those filesystems are not mounted or available.

With this new syscall, administrators may lock down access to the
pseudo‑filesystem yet still manage LSM policies. A single, tightly scoped
entry point then replaces the many file operations exposed by those
filesystems, significantly reducing the attack surface. This is
particularly useful in containers or processes already confined by
Landlock, where these pseudo‑filesystems are typically unavailable.

Because it provides a logical and unified interface, lsm_manage_policy()
is simpler to use than several heterogeneous pseudo‑filesystems and
avoids edge cases such as partially loaded policies. It also eliminates
VFS overhead, yielding performance gains notably when many policies are
loaded, for instance at boot time.

This initial implementation is intentionally minimal to limit the scope
of changes. Currently, only policy loading is supported, and only
AppArmor registers this LSM hook. However, any LSM can adopt this
interface, and future patches could extend this syscall to support more
operations, such as replacing, removing, or querying loaded policies.

Landlock already provides three Landlock‑specific syscalls (e.g.
landlock_add_rule()) to restrict ambient rights for sets of processes
without touching any pseudo-filesystem. lsm_manage_policy() generalizes
that approach to the entire LSM layer, so any module can expose its
policy operations through one uniform interface and reap the advantages
outlined above.

This patchset is available at [1] and a minimal user space example
showing how to use this syscall with AppArmor is at [2].

[1] https://github.com/emixam16/linux/tree/lsm_syscall
[2] https://gitlab.com/emixam16/apparmor/tree/lsm_syscall

Maxime Bélair (3):
  Wire up the lsm_manage_policy syscall
  lsm: introduce security_lsm_manage_policy hook
  AppArmor: add support for lsm_manage_policy

 arch/alpha/kernel/syscalls/syscall.tbl        |  1 +
 arch/arm/tools/syscall.tbl                    |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |  1 +
 include/linux/lsm_hook_defs.h                 |  2 ++
 include/linux/security.h                      |  7 +++++++
 include/linux/syscalls.h                      |  4 ++++
 include/uapi/asm-generic/unistd.h             |  4 +++-
 include/uapi/linux/lsm.h                      |  8 +++++++
 kernel/sys_ni.c                               |  1 +
 security/apparmor/apparmorfs.c                | 19 +++++++++++++++++
 security/apparmor/include/apparmorfs.h        |  3 +++
 security/apparmor/lsm.c                       | 16 ++++++++++++++
 security/lsm_syscalls.c                       | 11 ++++++++++
 security/security.c                           | 21 +++++++++++++++++++
 tools/include/uapi/asm-generic/unistd.h       |  4 +++-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
 17 files changed, 103 insertions(+), 2 deletions(-)


base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
-- 
2.48.1


