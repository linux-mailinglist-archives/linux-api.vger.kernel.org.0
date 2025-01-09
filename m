Return-Path: <linux-api+bounces-2963-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFAA07BB0
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 16:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C093D16B4CD
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B792206B9;
	Thu,  9 Jan 2025 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNJPKL/y"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F9221D5A3
	for <linux-api@vger.kernel.org>; Thu,  9 Jan 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736435868; cv=none; b=lS3XnyOCh89+AqfbdBj9iMg8i3S8RbUFeyd/7Wv0yJ1Ywz+V4Z6nEuPqjpgU/ek+JtAIanjYw1IQs7kH9hq0Rn+fnWYMyUYpsN4T9qIQlX1juWQ+0n0DECrJdHMM87KoU0qC+FwZq/rS2R8D/r6HdVaKFi3i9onW6k+aZChis6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736435868; c=relaxed/simple;
	bh=05hMgRvn5o19L9ruodOsxrP9Aih9m45bk9m66vCgDkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OALwwcRBWv58MF1mfeg10eXevAkFsEFhNNUcOU6cLVcyo8E8913B8Z/gSYjGWWUn0SJxgIrWQ2AlnWQawNDSGAlKhHQO4o5JmU7wWx+4UPbTdmm1OCi5eagWdiKyQ7dX8mGnc+sfvmebY+wwNah0/QPFuZlpNM+xUA+LMr2iVVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hNJPKL/y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736435865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/YZYt1KJ7N++KjLwwGFp1BeprTvWVdaSdg67p9v5p0=;
	b=hNJPKL/yRDtOOyW3OgI6NFo35ctDvwTQ5VWQd7f1THR55EhqXJPB3wW7sIYM9dg9RApmp3
	5blxiJq3HSN82q56skrxRjHN3uJhvFuw5IbZcBU4Eqneto3zTnDwFhTPRcrYumJXM92AV0
	R0X7GFNJP67S4wBQj8Smi6/ObLNufOo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-EneLdpggPCaJlpFF9Yg1Ww-1; Thu,
 09 Jan 2025 10:17:42 -0500
X-MC-Unique: EneLdpggPCaJlpFF9Yg1Ww-1
X-Mimecast-MFC-AGG-ID: EneLdpggPCaJlpFF9Yg1Ww
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E0531953941;
	Thu,  9 Jan 2025 15:17:40 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.39.208.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B839530001BE;
	Thu,  9 Jan 2025 15:17:35 +0000 (UTC)
Date: Thu, 9 Jan 2025 16:17:31 +0100
From: Eugene Syromiatnikov <esyr@redhat.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250109151731.GA3997@asgard.redhat.com>
References: <20250107230153.GA30560@strace.io>
 <20250107230456.GE30633@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107230456.GE30633@strace.io>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Jan 08, 2025 at 01:04:56AM +0200, Dmitry V. Levin wrote:
> PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> system calls the tracee is blocked in.
> 
> This API allows ptracers to obtain and modify system call details
> in a straightforward and architecture-agnostic way.
> 
> Current implementation supports changing only those bits of system call
> information that are used by strace, namely, syscall number, syscall
> arguments, and syscall return value.
> 
> Support of changing additional details returned by PTRACE_GET_SYSCALL_INFO,
> such as instruction pointer and stack pointer, could be added later
> if needed, by re-using struct ptrace_syscall_info.reserved to specify
> the additional details that should be set.  Currently, the reserved
> field of struct ptrace_syscall_info must be initialized with zeroes;
> arch, instruction_pointer, and stack_pointer fields are ignored.
> 
> PTRACE_SET_SYSCALL_INFO currently supports only PTRACE_SYSCALL_INFO_ENTRY,
> PTRACE_SYSCALL_INFO_EXIT, and PTRACE_SYSCALL_INFO_SECCOMP operations.
> Other operations could be added later if needed.
> 
> Ideally, PTRACE_SET_SYSCALL_INFO should have been introduced along with
> PTRACE_GET_SYSCALL_INFO, but it didn't happen.  The last straw that
> convinced me to implement PTRACE_SET_SYSCALL_INFO was apparent failure
> to provide an API of changing the first system call argument on riscv
> architecture.

> index 72c038fc71d0..231b8bf7eeff 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -74,6 +74,7 @@ struct seccomp_metadata {
>  };
>  
>  #define PTRACE_GET_SYSCALL_INFO		0x420e
> +#define PTRACE_SET_SYSCALL_INFO		0x4212

It seems prudent to also add a comment about 0x4212 being taken right
after "#define PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG 0x4211", or the
usage of this ptrace request number may be overlooked on the next update.

>  struct ptrace_syscall_info {
>  	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> -	__u8 pad[3];
> +	__u8 reserved[3];
>  	__u32 arch;
>  	__u64 instruction_pointer;
>  	__u64 stack_pointer;

I would like to suggest adding flags for changing scno and args right
away;  while it is possibly of limited use and seems like an unnecessary
overcomplication, at least changing arguments only seems natural to me,
to avoid possible interaction with scno-related shenanigans that might
present/appear on some kernels and/or architectures.  Also, it makes
the aforementioned possible extensions of the interface (changing
of ip/sp) more natural (as in those cases users might definitely want
to avoid touching syscall number/arguments).


