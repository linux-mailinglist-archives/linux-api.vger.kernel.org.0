Return-Path: <linux-api+bounces-2934-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 596239F5557
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 19:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B9F16FE36
	for <lists+linux-api@lfdr.de>; Tue, 17 Dec 2024 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130A1FA8EC;
	Tue, 17 Dec 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MxNCo9u1"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC411FA8E9;
	Tue, 17 Dec 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734457836; cv=none; b=FLTtELflDcmnfplBZt6sQzoahCWBFS327lK66xFWdW0yJy6Zj3+NQCHdYwQ/fmbt0/KbZ7/ug83Vnr7q3Lc0j3dNp2YkVmAiU6/qcygJ7em91dKfwm9DUbYZ9LOSsFbRk/YdkbPMq79M6MXx4o1zX0bTgAb1SiPrrAGFggkJAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734457836; c=relaxed/simple;
	bh=v9tlcHGujRssBFnt/PE7Z7DQNY9DB0I0CvCgckK/lVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E0RyYWjiMN2MvyHCB8j7D331UlI3cqqFsq7JfYoBb6hwTP1SGernO6m8+ASknwJDAE/Kzv1+Otwwrgzpr7IBP2KJL1yy6mD0MARfJ9y4NHjqB9nzOJLOxUc2/k+hHj7kEUxEuXUlWKQBcCrtAPGO0sdH5JOs/XSVDQOHO6MuO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MxNCo9u1; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XsJyRch4Bb0SUmmUdWVGZ+COqQ1Q+f9e8d470lSmFyo=; b=MxNCo9u1BgA64v6LCRR/PJqc4U
	N1To3paKzQ66TCR3oXXFrtc3TFDEKu98ak8g2AqSUctBggboDQy02TfN4NRtljm7zd8RGCdZ9LN9L
	sX7xuqSYN4uP+zCf8yOWca2ILc6b5R147PvsCt+kfUBEeXlI8wXcg3tBSvo3Ni8lIntb0kMH7xpqA
	yYYbyd8IkfL0+RN9ma49oMWQzrtvx3OC4MzPpMxiouoLHrLJoUjZysRdEYEC4lzPGUrJrTce6mS13
	dy0iuqm6lgTr4J9afN28eMqcvka4Y+3LDBoGw/EhcOyrvBkLxjmPl19jyQg4K26HJlpTMpzrs7Yoo
	I0RwPK2A==;
Received: from [179.193.1.214] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tNbhu-004TVV-TO; Tue, 17 Dec 2024 18:50:07 +0100
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
	Vinicius Peixoto <vpeixoto@lkcamp.dev>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v3 0/3] futex: Create set_robust_list2
Date: Tue, 17 Dec 2024 14:49:55 -0300
Message-ID: <20241217174958.477692-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.47.1
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
- Old syscall set_robust_list() adds new head to the internal linked list of
  robust lists pointers, instead of having a field just for them. Remove
  tsk->robust_list and use only tsk->robust_list2
v2: https://lore.kernel.org/lkml/20241101162147.284993-1-andrealmeid@igalia.com/

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
 include/linux/futex.h                       |  16 ++-
 include/linux/sched.h                       |   5 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 include/uapi/linux/futex.h                  |  24 ++++
 kernel/futex/core.c                         | 130 ++++++++++++++++----
 kernel/futex/futex.h                        |   5 +
 kernel/futex/syscalls.c                     |  82 +++++++++++-
 kernel/sys_ni.c                             |   1 +
 scripts/syscall.tbl                         |   1 +
 25 files changed, 249 insertions(+), 46 deletions(-)

-- 
2.47.1


