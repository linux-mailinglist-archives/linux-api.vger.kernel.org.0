Return-Path: <linux-api+bounces-2970-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC20A0A36D
	for <lists+linux-api@lfdr.de>; Sat, 11 Jan 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A13169FF5
	for <lists+linux-api@lfdr.de>; Sat, 11 Jan 2025 11:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575B17BB35;
	Sat, 11 Jan 2025 11:49:29 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE65634;
	Sat, 11 Jan 2025 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736596169; cv=none; b=Rsn58z1SPRQR0GSoio3tdiP7gz5aBurCpPYV/Gb+gxR9fxPpWpjMk5vISm1aGanH8An/9dDW9MGUsJOKFHmY/wpTpYoG/ajFfIdRytfmQ7sc7O6B3AOeLFIAWWmjm/S8P+HM6gfO0MbFyuSM6WaqnXwfj3C7F8ACR2/LcGgrJEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736596169; c=relaxed/simple;
	bh=ezBa8yZJmgUrHjcV/N/jFwu7/bYqlygy/EoSUUpgfYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0/j2UsC/kzvf6TYXS5xp4ymxUigeUVZftlbrzxi3zYBvet6rneyjuPkbG0TOevjExzxfw3C/mhN8VO/C92zSlvlUFxwE4tLn3llHvVFJ0EFa0pX7KAzu6qPVJ4IS9DVhjKq024lCLjXExqpL1AG5tz18KGNl9Uu7rwEPrmxHRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id A84D372C97D;
	Sat, 11 Jan 2025 14:49:25 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 98A667CCB3A; Sat, 11 Jan 2025 13:49:25 +0200 (IST)
Date: Sat, 11 Jan 2025 13:49:25 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250111114925.GA8306@strace.io>
References: <20250107230153.GA30560@strace.io>
 <20250107230456.GE30633@strace.io>
 <20250109152138.GE26424@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109152138.GE26424@redhat.com>

On Thu, Jan 09, 2025 at 04:21:39PM +0100, Oleg Nesterov wrote:
> On 01/08, Dmitry V. Levin wrote:
> >
> > +ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
> > +			      struct ptrace_syscall_info *info)
> > +{
> ...
> > +	syscall_set_nr(child, regs, nr);
> > +	syscall_set_arguments(child, regs, args);
> > +	if (nr == -1) {
> > +		/*
> > +		 * When the syscall number is set to -1, the syscall will be
> > +		 * skipped.  In this case also set the syscall return value to
> > +		 * -ENOSYS, otherwise on some architectures the corresponding
> > +		 * struct pt_regs field will remain unchanged.
> > +		 *
> > +		 * Note that on some architectures syscall_set_return_value()
> > +		 * modifies one of the struct pt_regs fields also modified by
> > +		 * syscall_set_arguments(), so the former should be called
> > +		 * after the latter.
> > +		 */
> > +		syscall_set_return_value(child, regs, -ENOSYS, 0);
> > +	}
> 
> This doesn't look nice to me...
> 
> We don't need this syscall_set_return_value(ENOSYS) on x86, right?

No, we don't need this on x86.

> So perhaps we should move this "if (nr == -1) code  into
> syscall_set_nr/syscall_set_arguments on those "some architectures" which
> actually need it ?

Thanks for the suggestion.  I think the best option is to skip
syscall_set_arguments() invocation in case of nr == -1.  It's not just
pointless, but also it would clobber the syscall return value on those
architectures like arm64 that share the same register both for the first
argument of syscall and its return value.

This is what I'm going to implement for the next iteration of the series:

	syscall_set_nr(child, regs, nr);
	/*
	 * If the syscall number is set to -1, setting syscall arguments is not
	 * just pointless, it would also clobber the syscall return value on
	 * those architectures that share the same register both for the first
	 * argument of syscall and its return value.
	 */
	if (nr != -1)
		syscall_set_arguments(child, regs, args);


-- 
ldv

