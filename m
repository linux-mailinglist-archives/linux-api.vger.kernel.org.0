Return-Path: <linux-api+bounces-3021-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E149DA130F1
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 02:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EA41888F7C
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181D49652;
	Thu, 16 Jan 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JiTqEKCV"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089D517BD6
	for <linux-api@vger.kernel.org>; Thu, 16 Jan 2025 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992537; cv=none; b=UjdS/0InZXJ/ZCy9HIdmmpNZTxTW8FJs9Uo0XzQLYZXrz4ce6a6RVaV4Qw3WX8ey2i2y75faB+D7TQVoSHQ2UKr4RTGXrRnHmhX3OggMh1DosiwPDhz03BmT+XjyPJEg56OTQ3eZ0CVBCgUmvX26ZpMHNu/ezBWt8RI4T7U4f2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992537; c=relaxed/simple;
	bh=JrRkwbWGF5vPqOUVpIBvifGxAgG+naD1Ad3fxxX+IQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCl2xPNb/5QbCfj1Lls/urPeYg+uDTpJrprtmppOpP10FMWyE8Rwlk7T/bZazHn0SYdwVxwbDH0ZOTVMcEmP+csGOYsa2uA0hN61K+7PoFIrmxsHh3nwx7EW4ytaGpuxw+1p3DNFlQ/OdWr8gRLu8Y7RvydIGI15HpLZtgiGBDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JiTqEKCV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso638800a91.3
        for <linux-api@vger.kernel.org>; Wed, 15 Jan 2025 17:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736992534; x=1737597334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NI6OeEZYy8UVqHfC23q83UkmJHKFzT3h/7q64TwarY8=;
        b=JiTqEKCVgd7Vh/Oyg+j3+rIMGJxOH34MiliDGbdRHPaO5aXYm/EEnqseDCUGMy2AuW
         ynCD+CtcM0JQ6vWDe/46fx/d3aToxRkeoNftjz+tibL4XgrQVDdm2NYcCmikxhpl4Pnk
         r/RU0S/2kl0tWOsxA5AfqOktITnx71wKTwuTqUUfhvHoV3R6rjKYUGPd0WnG61UvrV0M
         ot5p8sSUuvpOn/yJzeC2MyYTzb8PhiF4xQxwUlTNrjudLM4rEE423aHWNf6yLV9y17YK
         y2pSEAAy3bz+59J2fJA3tdncgrnKv6QmcO3jM8PQxnppPMpeJ4vjLUur1kfSmozmefBu
         4FUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736992534; x=1737597334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NI6OeEZYy8UVqHfC23q83UkmJHKFzT3h/7q64TwarY8=;
        b=NgjBF9Arnd8x/06z29+jN63YfE8MF89GClqq6CZ+DVIasmEiFF8FVEUSo7ur95orOs
         e/PLtVKRR5xqqdWmERSjqTOQr2mW5VCd8+7oKD45VA4Q4/5XPtu/N6OB/Kd3YSIkSepK
         Az92VJnfIJ5ymI7LAVtBkVpBBQGUZhYbF1u0owJ9BYDcpwKY60RecnxRGFLcOr5HdWbE
         +fXFVs8t79UaQT0MLr1nUisI7iumV4d4NQ98BWZ/NfJzP7GyjfO75SKxk906FInNZxsf
         oGGQjaUHNxWYNt3QotQHUS0+ZoH+BEKqGGZphUWO8rv+RRTaq2PJgZShYo78SRbwrKmd
         h7VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcSC4iZoFnwnGtX3aEpYOwNgweqK42mwtkKkLOXfffas0E6oYEho3BK29a/6Tg9FwqN1ptFPBMsJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYdIw6c34byQmKvGmdke6mbnpZWqcG4f07PLKCJmMQV7E0VQFv
	YJFb0w73MnhPNrjiKi7xM1Zj9htjIhSraGkeMvNSEyTvklAn42DuJiv1HIaHt6YVePgp1DJmbW6
	q
X-Gm-Gg: ASbGnctn1IG0T3SS83em/Sk01N7wZqehO3KbjVd1J6RxrklETSEu/OziVFHePZVAT5I
	S9ETWTxdRSpeyXDAYGwODWVFNc5OU47yZ4yiMcO7By1+dFgF/AR0VhH+UIl/B6Ru5e7aAeISPna
	AciEm8EfLb1pPlNL6FAvvCHk4OZZv3Dq0Zt5aOktfkbpK+xnJvfd0GRP4njNbKeztNN966sJUuV
	6LX5W/EwHoEVkdDYkTERv15Aiuw+v2yPjuHJvwUBiLWBFg=
X-Google-Smtp-Source: AGHT+IEVstxG+CbZmk9gwt6dho9779HqyCG9kN/4pOcL/V+kh8v28I9/kW5DnUfAx+nStrie0yOR6Q==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:ab29:1a57 with SMTP id 98e67ed59e1d1-2f548e9a5b7mr46932662a91.2.1736992534290;
        Wed, 15 Jan 2025 17:55:34 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c15bf82sm2059398a91.7.2025.01.15.17.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 17:55:33 -0800 (PST)
Date: Wed, 15 Jan 2025 17:55:31 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <Z4hnEzFUgN9N0pSF@ghost>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113171208.GF589@strace.io>

On Mon, Jan 13, 2025 at 07:12:08PM +0200, Dmitry V. Levin wrote:
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
> if needed, by using struct ptrace_syscall_info.flags to specify
> the additional details that should be set.  Currently, flags and reserved
> fields of struct ptrace_syscall_info must be initialized with zeroes;
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
> 
> ptrace(2) man page:
> 
> long ptrace(enum __ptrace_request request, pid_t pid, void *addr, void *data);
> ...
> PTRACE_SET_SYSCALL_INFO
>        Modify information about the system call that caused the stop.
>        The "data" argument is a pointer to struct ptrace_syscall_info
>        that specifies the system call information to be set.
>        The "addr" argument should be set to sizeof(struct ptrace_syscall_info)).
> 
> Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>
> ---
>  include/linux/ptrace.h      |  3 ++
>  include/uapi/linux/ptrace.h |  4 +-
>  kernel/ptrace.c             | 95 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> index 90507d4afcd6..c8dbf1e498bf 100644
> --- a/include/linux/ptrace.h
> +++ b/include/linux/ptrace.h
> @@ -17,6 +17,9 @@ struct syscall_info {
>  	struct seccomp_data	data;
>  };
>  
> +/* sizeof() the first published struct ptrace_syscall_info */
> +#define PTRACE_SYSCALL_INFO_SIZE_VER0	84
> +
>  extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
>  			    void *buf, int len, unsigned int gup_flags);
>  
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 72c038fc71d0..ca75b3ab5d22 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -74,6 +74,7 @@ struct seccomp_metadata {
>  };
>  
>  #define PTRACE_GET_SYSCALL_INFO		0x420e
> +#define PTRACE_SET_SYSCALL_INFO		0x4212
>  #define PTRACE_SYSCALL_INFO_NONE	0
>  #define PTRACE_SYSCALL_INFO_ENTRY	1
>  #define PTRACE_SYSCALL_INFO_EXIT	2
> @@ -81,7 +82,8 @@ struct seccomp_metadata {
>  
>  struct ptrace_syscall_info {
>  	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
> -	__u8 pad[3];
> +	__u8 reserved;
> +	__u16 flags;
>  	__u32 arch;
>  	__u64 instruction_pointer;
>  	__u64 stack_pointer;
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 22e7d74cf4cd..41d37cb8f74a 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -1016,6 +1016,97 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
>  	write_size = min(actual_size, user_size);
>  	return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
>  }
> +
> +static unsigned long
> +ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
> +			      struct ptrace_syscall_info *info)
> +{
> +	unsigned long args[ARRAY_SIZE(info->entry.args)];
> +	int nr = info->entry.nr;
> +	int i;
> +
> +	if (nr != info->entry.nr)
> +		return -ERANGE;
> +
> +	for (i = 0; i < ARRAY_SIZE(args); i++) {
> +		args[i] = info->entry.args[i];
> +		if (args[i] != info->entry.args[i])
> +			return -ERANGE;
> +	}
> +
> +	syscall_set_nr(child, regs, nr);
> +	/*
> +	 * If the syscall number is set to -1, setting syscall arguments is not
> +	 * just pointless, it would also clobber the syscall return value on
> +	 * those architectures that share the same register both for the first
> +	 * argument of syscall and its return value.
> +	 */
> +	if (nr != -1)
> +		syscall_set_arguments(child, regs, args);
> +
> +	return 0;
> +}
> +
> +static unsigned long
> +ptrace_set_syscall_info_seccomp(struct task_struct *child, struct pt_regs *regs,
> +				struct ptrace_syscall_info *info)
> +{
> +	/*
> +	 * info->entry is currently a subset of info->seccomp,
> +	 * info->seccomp.ret_data is currently ignored.
> +	 */
> +	return ptrace_set_syscall_info_entry(child, regs, info);
> +}
> +
> +static unsigned long
> +ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
> +			     struct ptrace_syscall_info *info)
> +{
> +	if (info->exit.is_error)
> +		syscall_set_return_value(child, regs, info->exit.rval, 0);
> +	else
> +		syscall_set_return_value(child, regs, 0, info->exit.rval);
> +
> +	return 0;
> +}
> +
> +static int
> +ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
> +			void __user *datavp)
> +{
> +	struct pt_regs *regs = task_pt_regs(child);
> +	struct ptrace_syscall_info info;
> +	int error;
> +
> +	BUILD_BUG_ON(sizeof(struct ptrace_syscall_info) < PTRACE_SYSCALL_INFO_SIZE_VER0);
> +
> +	if (user_size < PTRACE_SYSCALL_INFO_SIZE_VER0 || user_size > PAGE_SIZE)
> +		return -EINVAL;
> +
> +	error = copy_struct_from_user(&info, sizeof(info), datavp, user_size);
> +	if (error)
> +		return error;
> +
> +	/* Reserved for future use. */
> +	if (info.flags || info.reserved)
> +		return -EINVAL;
> +
> +	/* Changing the type of the system call stop is not supported. */
> +	if (ptrace_get_syscall_info_op(child) != info.op)

Since this isn't supported anyway, would it make sense to set the
info.op to ptrace_get_syscall_info_op(child) like is done for
get_syscall_info? The usecase I see for this is simplifying when the
user doesn't call PTRACE_GET_SYSCALL_INFO before calling
PTRACE_SET_SYSCALL_INFO.

- Charlie

> +		return -EINVAL;
> +
> +	switch (info.op) {
> +	case PTRACE_SYSCALL_INFO_ENTRY:
> +		return ptrace_set_syscall_info_entry(child, regs, &info);
> +	case PTRACE_SYSCALL_INFO_EXIT:
> +		return ptrace_set_syscall_info_exit(child, regs, &info);
> +	case PTRACE_SYSCALL_INFO_SECCOMP:
> +		return ptrace_set_syscall_info_seccomp(child, regs, &info);
> +	default:
> +		/* Other types of system call stops are not supported. */
> +		return -EINVAL;
> +	}
> +}
>  #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
>  
>  int ptrace_request(struct task_struct *child, long request,
> @@ -1234,6 +1325,10 @@ int ptrace_request(struct task_struct *child, long request,
>  	case PTRACE_GET_SYSCALL_INFO:
>  		ret = ptrace_get_syscall_info(child, addr, datavp);
>  		break;
> +
> +	case PTRACE_SET_SYSCALL_INFO:
> +		ret = ptrace_set_syscall_info(child, addr, datavp);
> +		break;
>  #endif
>  
>  	case PTRACE_SECCOMP_GET_FILTER:
> -- 
> ldv

