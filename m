Return-Path: <linux-api+bounces-3033-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7266DA14434
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10923A6413
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 21:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2122CBF9;
	Thu, 16 Jan 2025 21:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fc2OAxKp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1119F120
	for <linux-api@vger.kernel.org>; Thu, 16 Jan 2025 21:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064035; cv=none; b=lmnA6uY5OWgwkVu2Jb2ZF+1WmWef9Yj42CXkFkL9eTh3OIveYoDK2LCh2Jsx/BLyfwVSdg8/gveXxI4jUf5iwHjRJcXBX3MNljpP2bE8pgW3Pr4ELauS+J0G72CESJXC5WA2Cc7SX+iNK8OulBnD19LG07NWS068j5qpuM8FnQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064035; c=relaxed/simple;
	bh=DbWdv2pgPh8ds9v9nhyPObQU2NpiBzVxcHxxNVg34oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWnhBCbcI6BkwMTOzFtN7evFNJrygXXNE5+HbGJuI8slFMFtGiJsfhtSurspFAR0qZL++5PgDeKubf1kKbVjVZI4RMGX2Fjyh3QBqDqvAg9p+eL5b4fwpx00CCvajx85AzdjWvCxaua3Y4ySDNftcFniXUYLSSLB0e4/SLsVjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fc2OAxKp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21680814d42so22989625ad.2
        for <linux-api@vger.kernel.org>; Thu, 16 Jan 2025 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1737064033; x=1737668833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUjGjdMfJB9QfNhG0/N12UqZ6Jr6QZ9KZ+1u+irK9iQ=;
        b=fc2OAxKpBHpnmpYn1SzcQaReDS4iAMCNzPJVP4V3jzPTT4IWgZD5W2cvKGtuAQ3DnG
         FcC5XGdJ9z/PrJ3hjRa/EmwArB/25d3UVN9lFfRjkHnznI9lLvyPJsspC2bfD+ciVO/Q
         qiDTIVbdZTZxzuZHcZb+pUo3vrGnTKkRqjkUghPjf9HAg0LVZOQnqicgwDufAvf06DxF
         KDY7rKq7c1Eyiln3RBwQPOR2HIjSWPGrqXb4QxXwMUdeW+gcyd9K1BjFRYweeBN00g7Q
         JZbkFfG3990XmzDzVm0OA9SF/L2SYpdU9y45cCWZiemXQfFswN+RSGrh1FxfOcaclguR
         ZTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737064033; x=1737668833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUjGjdMfJB9QfNhG0/N12UqZ6Jr6QZ9KZ+1u+irK9iQ=;
        b=rSnXXbmlBmR/g3LjbwrbNGb4z9Pbjl5KqJVHYpzQk5QfM/HMYFpayabMw3MCRKCH9M
         WSCqjjm7ql74tjzb51DMcuT9k+34CYvHz+XFrYuB0/rvrjPwitMcCQ7ungTFj83iiPPl
         RzpP/SVpx43XAG8TKg4VMWIKaN3CnWPOyYwQ2UQPXd0Hx9sk070uewi/+p7WED1/Q0Ae
         NSNJOUyGLfcLzq8VwM4t6vE5Kazbp2Djr4hzsaI6Do+ZvbAtoci3EaQxWp074wKqab/4
         llRj+3RPirmyh3pdG4HRaJwHOXqUcnMNHncpJhlGJTCzVCfwVLk46VGxLfSQ3AUS8dNi
         LHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWhtQBStXpj/1PLWJ07h6y72uI6ZosMwsZKTZ2+aMdJzGyQ/U9P0SVFzWmkbMPCtc7VmzmYhuIPVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnEhcmBmnuJDjpIj+QQvmGUVfq24c3vgenDzpJB4RxKt0zTT7j
	TaELVtglGf/nYHUf34sSgJbgjLFtqftOJ/qhDsmuJfpVvobCixRwvk1P+rioOUg=
X-Gm-Gg: ASbGnct3YluJEHvz16ZQShlRmwdM46163b+GlzplFryz72PYyfv1mp1O8XXqpJZzByl
	TOH2rIaUTYXOn+srvOY9+JF3QOK87yl3wDpPldr1Jxo9AsSDJY/vCZPd6nt10mbxj0K42WVNfyd
	NMNXqUMAkCgOBzjzOvOCSC49yhrMXg6DcW0xN09b+F2seag3XkE3gxH03+2RdQBZ5CCd1M/3Lgf
	GJ9vkyJOezW+op6VIQoTnxAeG0E28c3943bAqYwGmGvWJk=
X-Google-Smtp-Source: AGHT+IHtLEnbdesCbqY0qN5EM2QLUnnF86VdNxs05PScoQX0z/O6MEZlEHUv3uHkySsa7l26IPeeTg==
X-Received: by 2002:a17:90b:1f91:b0:2f1:4715:5987 with SMTP id 98e67ed59e1d1-2f782c92749mr257291a91.9.1737064032832;
        Thu, 16 Jan 2025 13:47:12 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f77616117bsm598578a91.20.2025.01.16.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 13:47:12 -0800 (PST)
Date: Thu, 16 Jan 2025 13:47:09 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	Celeste Liu <uwu@coelacanthus.name>, strace-devel@lists.strace.io,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <Z4l-XfC6dQmMzCFT@ghost>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <Z4hnEzFUgN9N0pSF@ghost>
 <20250116083328.GA32173@strace.io>
 <Z4l1L4OLoN7-lTkD@ghost>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4l1L4OLoN7-lTkD@ghost>

On Thu, Jan 16, 2025 at 01:07:59PM -0800, Charlie Jenkins wrote:
> On Thu, Jan 16, 2025 at 10:33:28AM +0200, Dmitry V. Levin wrote:
> > On Wed, Jan 15, 2025 at 05:55:31PM -0800, Charlie Jenkins wrote:
> > > On Mon, Jan 13, 2025 at 07:12:08PM +0200, Dmitry V. Levin wrote:
> > [...]
> > > > +	/* Changing the type of the system call stop is not supported. */
> > > > +	if (ptrace_get_syscall_info_op(child) != info.op)
> > > 
> > > Since this isn't supported anyway, would it make sense to set the
> > > info.op to ptrace_get_syscall_info_op(child) like is done for
> > > get_syscall_info? The usecase I see for this is simplifying when the
> > > user doesn't call PTRACE_GET_SYSCALL_INFO before calling
> > > PTRACE_SET_SYSCALL_INFO.
> > 
> > struct ptrace_syscall_info.op is a field that specifies how to interpret
> > the union fields of the structure, so if "op" is ignored, then the
> > kernel would infer the meaning of the structure specified by the userspace
> > tracer from the kernel state of the tracee.  This looks a bit too
> > error-prone to allow.  For example, nothing good is expected to happen
> > if syscall entry information is applied in a syscall exit stop.
> 
> Yes that's a good point. 
> 
> > 
> > The tracer is not obliged to call PTRACE_GET_SYSCALL_INFO to set
> > struct ptrace_syscall_info.op.  If the tracer keeps track of ptrace stops
> > by other means, it can assign the right value by itself.
> >
> > And, btw, the comment should say "is not currently supported",
> > I'll update it in the next iteration.
> > 
> > An idea mentioned in prior discussions was that it would make sense to
> > specify syscall return value along with skipping the syscall in seccomp stop,
> > and this would require a different value for "op" field, but
> > I decided not to introduce this extra complexity yet.
> 
> Makes sense, thank you!
> 
> - Charlie

I am no longer convinced that we need Celeste's patch that solves this
problem on riscv [1]. That patch is necessary without this change, but
PTRACE_SET_SYSCALL_INFO seems like a cleaner solution.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

- Charlie

[1] https://lore.kernel.org/lkml/20250115-13cc73c36c7bb3b9f046f614@orel/T/

> 
> > 
> > 
> > -- 
> > ldv

