Return-Path: <linux-api+bounces-3344-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D7A44A98
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2025 19:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B3FE1885F47
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948041A38E1;
	Tue, 25 Feb 2025 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CzfeiXFc"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDBE14F9C4;
	Tue, 25 Feb 2025 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508573; cv=none; b=syRDSmsGIvaF1516YM5Hrm69XgkBeHZDVOw4Dz0B3zsNRh2xYNwfK99IcBlkH4oOUM4xa64DAA0H0BLuziN64wpeWU6j3XmrOxCfsKS1wZz6+dvdAxrETFUqCVpcmxVG+wlmzYKusw4KaXr4c4wl1boSC4oeB/xy8qcG2ufI6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508573; c=relaxed/simple;
	bh=VDjHXY7UAfm3OqARVr8+whmUDAKt7q8yiIBcPqR/KBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RZ43SK6dPCdY24p8jkAHrL6/CLjNcPMyxzAikSZ69sxWuWiwF/opQMCZbefPbUo5hqydnD7qt7ALMfFSwlW3c92GC0C8f2nbq/CyJYoKGINLEQ2Jbam/tRW0OPkRLpsociTnxoqPXw4GkDxr55TSlM1yrNZWX/unNicvgQq3YIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CzfeiXFc; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KeJQbvljd4XNcCRe+d6cHRdp4CkIaz6wNQGBG3xQq5w=; b=CzfeiXFcbk5gH63QJ9la65fivg
	8Cyjig/AKyDhA37/IiS15/ZPmOmNXdGVLD2iUR5290BIvejAEtN9B1xrxRF8HxR/L/5n8ov0FnXzH
	w86g4x9giWuPBgVi0RTzF3dQgV0+poZEDa/RarpSPErH8m4NB5TjdXuf/w/r7ER0OwGlx/gpPXvnW
	mRi3clQzDPwVaalBx1Zukem58PZhBrp+oPxDUjEBS+icpM593K9S1UwR+uOn/mm4hGakWThluAEq1
	zfg2qZTm4mqsKlBgEVeE9HOVtGPeLYmpnmu+gzpx1ZtFWX25nQTpOrN3GEh53XPdoikGnCxtCBezx
	7JEN6bRQ==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tmzmH-000WtH-7g; Tue, 25 Feb 2025 19:35:39 +0100
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
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v4 0/5] futex: Create set_robust_list2
Date: Tue, 25 Feb 2025 15:35:26 -0300
Message-ID: <20250225183531.682556-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
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

It refuses unaligned `head` addresses. It doesn't have a limit for elements in a
single list (like ROBUST_LIST_LIMIT), it destroys the list as it is parsed to be
safe against circular lists.

* Testing

This patcheset has a selftest patch that expands this one:
https://lore.kernel.org/lkml/20250212131123.37431-1-andrealmeid@igalia.com/

Also, FEX-Emu added support for this interface to validate it:
https://github.com/FEX-Emu/FEX/pull/3966

Feedback is very welcomed!

Thanks,
	André

[1] https://github.com/FEX-Emu/FEX

Changelog:
- Refuse unaligned head pointers
- Ignore ROBUST_LIST_LIMIT for lists created with this interface and make it
  robust against circular lists
- Fix a get_robust_list() syscall bug for getting the list from another thread
- Adapt selftest to use the new interface
v3: https://lore.kernel.org/lkml/20241217174958.477692-1-andrealmeid@igalia.com/

- Old syscall set_robust_list() adds new head to the internal linked list of
  robust lists pointers, instead of having a field just for them. Remove
  tsk->robust_list and use only tsk->robust_list2
v2: https://lore.kernel.org/lkml/20241101162147.284993-1-andrealmeid@igalia.com/

- Added a patch to properly deal with exit_robust_list() in 64bit vs 32bit
- Wired-up syscall for all archs
- Added more of the cover letter to the commit message
v1: https://lore.kernel.org/lkml/20241024145735.162090-1-andrealmeid@igalia.com/

André Almeida (5):
  futex: Use explicit sizes for compat_exit_robust_list
  futex: Create set_robust_list2
  futex: Wire up set_robust_list2 syscall
  futex: Remove the limit of elements for sys_set_robust_list2 lists
  selftests: futex: Expand robust list test for the new interface

 arch/alpha/kernel/syscalls/syscall.tbl        |   1 +
 arch/arm/tools/syscall.tbl                    |   1 +
 arch/m68k/kernel/syscalls/syscall.tbl         |   1 +
 arch/microblaze/kernel/syscalls/syscall.tbl   |   1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl     |   1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl     |   1 +
 arch/parisc/kernel/syscalls/syscall.tbl       |   1 +
 arch/powerpc/kernel/syscalls/syscall.tbl      |   1 +
 arch/s390/kernel/syscalls/syscall.tbl         |   1 +
 arch/sh/kernel/syscalls/syscall.tbl           |   1 +
 arch/sparc/kernel/syscalls/syscall.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/xtensa/kernel/syscalls/syscall.tbl       |   1 +
 include/linux/compat.h                        |  12 +-
 include/linux/futex.h                         |  16 +-
 include/linux/sched.h                         |   5 +-
 include/uapi/asm-generic/unistd.h             |   4 +-
 include/uapi/linux/futex.h                    |  24 +++
 kernel/futex/core.c                           | 165 ++++++++++++++----
 kernel/futex/futex.h                          |   5 +
 kernel/futex/syscalls.c                       |  85 ++++++++-
 kernel/sys_ni.c                               |   1 +
 scripts/syscall.tbl                           |   1 +
 .../selftests/futex/functional/robust_list.c  | 160 ++++++++++++++++-
 26 files changed, 436 insertions(+), 57 deletions(-)

-- 
2.48.1


