Return-Path: <linux-api+bounces-2652-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DE9B9529
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2024 17:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880C21F22F01
	for <lists+linux-api@lfdr.de>; Fri,  1 Nov 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAC31AA781;
	Fri,  1 Nov 2024 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K9xepvnw"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C911CACC4;
	Fri,  1 Nov 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478147; cv=none; b=C2+YgNux/y1WgzBrw744sOAKUua0UswA99kmwOnl0bWB2RP+aKd8Sitv36EY9dMlh/EQPkNxLxp0D1tRmMdUDguf2OhTkru2dV1/xYrsDb3saPQeHJZ/V7o0rMKk8WdMON5+uDfX713IYdmGyU1VcpSbkfoSaiYizGcVddoomOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478147; c=relaxed/simple;
	bh=+nDAAxalSuIG+p3KOUi0mR6ee0zev0MF6lIClan+yKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R1sgNMaxbcbIskDza2ncGzdCQeaeImX6GJ1nAxoM+FKPmLv22M4/J+5w+0++Qix2sSM2uN+hCyF2/qqWXXwjIDNlUiq705rIbtGX2+qs4bByCZcMVFTOtFLtPp+YAwt95t7R/lwdpRTdWH2IzWL6AqLs7Zo3cYadMBojcahMQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K9xepvnw; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0wUBukj4pH3ptXjHSn3clH3Pc98SrdScREXTosvlpns=; b=K9xepvnwxzJDwh0IFhD2cOzBot
	VNMidWQ8OqFHvIBTRWhcF2tBjOVVlMZM7ydvzjFXecRSGSIeSFmh8lkPcHeReeQjSglGYJmGq8gkg
	IXVzjOxlVnL6ypHn3a1VPCmV0qx5lFGxdJuVVFi5Patw3G39hiMRxkF6/CZZlE9DlSwYOyCJ/KZXG
	u7RP/ay4RCH/igF2iBXFP9oGptO1qqMCw0nDuiNXAG156paIiLGSpf1KgMmztD0W2fOAN/5B3yHLq
	TIfjm5rMBYkxPdcMY+u+T0YHWdO439+DZLbzqAoBF6Sb8fYfrvpZuwWDHpb7wdqqWOCXUC2ZM/pz6
	N+CtcUJg==;
Received: from [189.78.222.89] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uPM-000UVX-5s; Fri, 01 Nov 2024 17:21:56 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/3] futex: Create set_robust_list2
Date: Fri,  1 Nov 2024 13:21:44 -0300
Message-ID: <20241101162147.284993-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a new robust_list() syscall. The current syscall
can't be expanded to cover the following use case, so a new one is
needed. This new syscall allows users to set multiple robust lists per
process and to have either 32bit or 64bit pointers in the list.

* Use case

FEX-Emu[1] is an application that runs x86 and x86-64 binaries on an
AArch64 Linux host. One of the tasks of FEX-Emu is to translate syscalls
from one platform to another. Existing set_robust_list() can't be easily
translated because of two limitations:

1) x86 apps can have 32bit pointers robust lists. For a x86-64 kernel
   this is not a problem, because of the compat entry point. But there's
   no such compat entry point for AArch64, so the kernel would do the
   pointer arithmetic wrongly. Is also unviable to userspace to keep
   track every addition/removal to the robust list and keep a 64bit
   version of it somewhere else to feed the kernel. Thus, the new
   interface has an option of telling the kernel if the list is filled
   with 32bit or 64bit pointers.

2) Apps can set just one robust list (in theory, x86-64 can set two if
   they also use the compat entry point). That means that when a x86 app
   asks FEX-Emu to call set_robust_list(), FEX have two options: to
   overwrite their own robust list pointer and make the app robust, or
   to ignore the app robust list and keep the emulator robust. The new
   interface allows for multiple robust lists per application, solving
   this.

* Interface

This is the proposed interface:

	long set_robust_list2(void *head, int index, unsigned int flags)

`head` is the head of the userspace struct robust_list_head, just as old
set_robust_list(). It needs to be a void pointer since it can point to a normal
robust_list_head or a compat_robust_list_head.

`flags` can be used for defining the list type:

	enum robust_list_type {
	 	ROBUST_LIST_32BIT,
		ROBUST_LIST_64BIT,
	 };

`index` is the index in the internal robust_list's linked list (the naming
starts to get confusing, I reckon). If `index == -1`, that means that user wants
to set a new robust_list, and the kernel will append it in the end of the list,
assign a new index and return this index to the user. If `index >= 0`, that
means that user wants to re-set `*head` of an already existing list (similarly
to what happens when you call set_robust_list() twice with different `*head`).

If `index` is out of range, or it points to a non-existing robust_list, or if
the internal list is full, an error is returned.

* Implementation

The implementation re-uses most of the existing robust list interface as
possible. The new task_struct member `struct list_head robust_list2` is just a
linked list where new lists are appended as the user requests more lists, and by
futex_cleanup(), the kernel walks through the internal list feeding
exit_robust_list() with the robust_list's.

This implementation supports up to 10 lists (defined at ROBUST_LISTS_PER_TASK),
but it was an arbitrary number for this RFC. For the described use case above, 4
should be enough, I'm not sure which should be the limit.

It doesn't support list removal (should it support?). It doesn't have a proper
get_robust_list2() yet as well, but I can add it in a next revision. We could
also have a generic robust_list() syscall that can be used to set/get and be
controlled by flags.

The new interface has a `unsigned int flags` argument, making it
extensible for future use cases as well.

* Testing

I will provide a selftest similar to the one I proposed for the current
interface here:
https://lore.kernel.org/lkml/20241010011142.905297-1-andrealmeid@igalia.com/

Also, FEX-Emu added support for this interface to validate it:
https://github.com/FEX-Emu/FEX/pull/3966

Feedback is very welcomed!

Thanks,
	André

[1] https://github.com/FEX-Emu/FEX

Changelog:
- Added a patch to properly deal with exit_robust_list() in 64bit vs 32bit
- Wired-up syscall for all archs
- Added more of the cover letter to the commit message
v1: https://lore.kernel.org/lkml/20241024145735.162090-1-andrealmeid@igalia.com/

André Almeida (3):
  futex: Use explicit sizes for compat_exit_robust_list
  futex: Create set_robust_list2
  futex: Wire up set_robust_list2 syscall

 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +
 arch/arm/tools/syscall.tbl                  |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +
 include/linux/compat.h                      |  12 +-
 include/linux/futex.h                       |  12 ++
 include/linux/sched.h                       |   3 +-
 include/uapi/asm-generic/unistd.h           |   5 +-
 include/uapi/linux/futex.h                  |  24 ++++
 init/init_task.c                            |   3 +
 kernel/futex/core.c                         | 116 +++++++++++++++++---
 kernel/futex/futex.h                        |   3 +
 kernel/futex/syscalls.c                     |  40 ++++++-
 kernel/sys_ni.c                             |   1 +
 scripts/syscall.tbl                         |   1 +
 26 files changed, 203 insertions(+), 32 deletions(-)

-- 
2.47.0


