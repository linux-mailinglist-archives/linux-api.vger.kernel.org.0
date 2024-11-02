Return-Path: <linux-api+bounces-2663-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091319BA29F
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 22:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DBC1F22616
	for <lists+linux-api@lfdr.de>; Sat,  2 Nov 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75651ABEA0;
	Sat,  2 Nov 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgslIHnF"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F711149C42
	for <linux-api@vger.kernel.org>; Sat,  2 Nov 2024 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730584746; cv=none; b=rMIOh5iufrvfyTaeZS16Lc7SjUG5QOPucL6gTBhPGXaYYjkP54Mg0w36tIThTNOLp7jCxY+N1L3lZH3MlexbDgAYEQk0CljAC/7RA8IuLSw+WAJkYEi6289cNTuyw3ykA/vmeT2Zi4aAHOMU8JoUsZDOP71nb9XRbxc5o7airns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730584746; c=relaxed/simple;
	bh=iU/GFh5PxfwqsQ8XPruyq3jiA+Rzu6wWlnuHQDY2Z64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mDrj5Oi9Ggro9MBnDdDgZiHxGjO8oAEPDSsJUXzc3icnC4x/CgWueEcSYI6f6Z3owZNsKSB8KWycIP2KLrJUuKi19biePxTgpIdShtfMvmXWAO/fELKc1D3Ghr/tQadrxc7MIv4j1PScAWVb1NzEpYSUrKzWpyQMtEcGCADBQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VgslIHnF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730584743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ABp4GNt9hr2dQL86JdaUvGuLhtctNBvZysLpO4JDoJ8=;
	b=VgslIHnFpSJy2dQpr9z8kJv9yx4Ztd7Qr3YMd+hmUAvsnfNPIcAnBc/habLhyx+NAZYkbm
	bfXhDTRKIauw48/v6vb6TT3OnfzVXnSrTq7qchtuCa4k6P576fCp4ZWg8HK40Yb0Nw7uAl
	ChegBF0LyzcplArHE19zzL7dCnvnIHo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-CdByBlUuNH645wZNXiVUfg-1; Sat,
 02 Nov 2024 17:59:00 -0400
X-MC-Unique: CdByBlUuNH645wZNXiVUfg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8CE5019560B1;
	Sat,  2 Nov 2024 21:58:52 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.45.225.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66E919560A3;
	Sat,  2 Nov 2024 21:58:45 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,
  Peter Zijlstra <peterz@infradead.org>,  Darren Hart
 <dvhart@infradead.org>,  Davidlohr Bueso <dave@stgolabs.net>,  Arnd
 Bergmann <arnd@arndb.de>,  sonicadvance1@gmail.com,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com,
  linux-api@vger.kernel.org,  Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/3] futex: Create set_robust_list2
In-Reply-To: <20241101162147.284993-1-andrealmeid@igalia.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
	Almeida"'s message of "Fri, 1 Nov 2024 13:21:44 -0300")
References: <20241101162147.284993-1-andrealmeid@igalia.com>
Date: Sat, 02 Nov 2024 22:58:42 +0100
Message-ID: <87ldy170x9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Andr=C3=A9 Almeida:

> 1) x86 apps can have 32bit pointers robust lists. For a x86-64 kernel
>    this is not a problem, because of the compat entry point. But there's
>    no such compat entry point for AArch64, so the kernel would do the
>    pointer arithmetic wrongly. Is also unviable to userspace to keep
>    track every addition/removal to the robust list and keep a 64bit
>    version of it somewhere else to feed the kernel. Thus, the new
>    interface has an option of telling the kernel if the list is filled
>    with 32bit or 64bit pointers.

The size is typically different for 32-bit and 64-bit mode (12 vs 24
bytes).  Why isn't this enough to disambiguate?

> 2) Apps can set just one robust list (in theory, x86-64 can set two if
>    they also use the compat entry point). That means that when a x86 app
>    asks FEX-Emu to call set_robust_list(), FEX have two options: to
>    overwrite their own robust list pointer and make the app robust, or
>    to ignore the app robust list and keep the emulator robust. The new
>    interface allows for multiple robust lists per application, solving
>    this.

Can't you avoid mixing emulated and general userspace code on the same
thread?  On emulator threads, you have full control over the TCB.

QEMU hints towards further problems (in linux-user/syscall.c):

    case TARGET_NR_set_robust_list:
    case TARGET_NR_get_robust_list:
        /* The ABI for supporting robust futexes has userspace pass
         * the kernel a pointer to a linked list which is updated by
         * userspace after the syscall; the list is walked by the kernel
         * when the thread exits. Since the linked list in QEMU guest
         * memory isn't a valid linked list for the host and we have
         * no way to reliably intercept the thread-death event, we can't
         * support these. Silently return ENOSYS so that guest userspace
         * falls back to a non-robust futex implementation (which should
         * be OK except in the corner case of the guest crashing while
         * holding a mutex that is shared with another process via
         * shared memory).
         */
        return -TARGET_ENOSYS;

The glibc implementation is not really prepared for this
(__ASSUME_SET_ROBUST_LIST is defined for must architectures).  But a
couple of years ago, we had a bunch of kernels that regressed robust
list support on POWER, and I think we found out only when we tested an
unrelated glibc update and saw unexpected glibc test suite failures =E2=80=
=A6

Thanks,
Florian


