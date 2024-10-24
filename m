Return-Path: <linux-api+bounces-2556-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB09AEA2F
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 17:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4431C227AB
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 15:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4851F1DD0E6;
	Thu, 24 Oct 2024 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WnBCP6NR"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729ED15884A;
	Thu, 24 Oct 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783106; cv=none; b=bCk+R/BhVSYyU8hdZiZDF4Nk+AnQdlppiq72ABeNBEUznJdWuRIvcxGmHIG5JH+NeX/F4zzrSOtOmmi5FPeu511Ak2xdIdwspeTOtFvjAN3bwjHDavsZILRJRUiXwoGfV8Ysu7yPxzuVKejKXFBGdk4YedDev2+R6o72NU9CRsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783106; c=relaxed/simple;
	bh=8TORefZgTSpEJeiOCBWdj+qC9hOeHTf5lUQ/hDBy9MA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NI5M2ES1Y2wakIu1NskbG7JcX1VgztiEcwHH9maa0v5YqW2w2sTG51YKhLA4L0ZZp8hemCh3u5RBsCslJMinzAh5gq0sYNXJ/f3SWI+kR44qlud6qrdQwFryTEkAv820T9j9BvHLZfsJR8DnZ+VWNL/HEG6CUFjDYyQZ0y3CoxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WnBCP6NR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=hklWwJuJAP4UGgX7NEh6jnRaJ2z2hO4fw2dC/KmpMwQ=; b=WnBCP6NRIRZeBh2lDcGcz++koH
	3tOm0y61oTMCUxD93D+TS9/g+JKH3qDqAjm8iLQ00tWfE5l2jPhSikwrkAUy9UJLJCDOW8+XMnKMe
	ru1zPtqnsPp/a7XOQNNowFlqu+9peLaIrHALvSb7EE2zKyPo0DUIZSywVBH4IQEX9MNrjm4Z4n75y
	TXHKkexplv9EheaJKTFUpHGHCLlkVKeZ4rmBv+z7jEEnkXu9S+ZUy9sjrAToRPpt6h0PLLQJcIHZY
	WMu+L8DAT2lKgs128hDvMUy6m7BGWbp76IYdLMVAm0waLao0ugBQjrcZ6M/QRMsaCFR1nWoi6BCVI
	hLzM7jVw==;
Received: from [177.172.124.83] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t3zHX-00EXrz-E1; Thu, 24 Oct 2024 16:57:47 +0200
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
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RFC 0/1] futex: Add a new robust list syscall
Date: Thu, 24 Oct 2024 11:57:34 -0300
Message-ID: <20241024145735.162090-1-andrealmeid@igalia.com>
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

André Almeida (1):
  futex: Create set_robust_list2

 arch/arm/tools/syscall.tbl             |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/futex.h                  |  1 +
 include/linux/sched.h                  |  1 +
 include/uapi/asm-generic/unistd.h      |  5 +-
 include/uapi/linux/futex.h             | 24 +++++++++
 init/init_task.c                       |  3 ++
 kernel/futex/core.c                    | 34 +++++++++---
 kernel/futex/syscalls.c                | 71 ++++++++++++++++++++++++++
 scripts/syscall.tbl                    |  1 +
 10 files changed, 133 insertions(+), 9 deletions(-)

--
2.47.0


