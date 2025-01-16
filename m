Return-Path: <linux-api+bounces-3029-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528AA13FA4
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 17:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76EB188C8F4
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF40D22D4D4;
	Thu, 16 Jan 2025 16:40:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F8226AE4;
	Thu, 16 Jan 2025 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737045626; cv=none; b=jRqxg+XPOn5XmMT40zdqeh1ixfFHUzBegXRn/LPysMgXQT1FjjAc2DNDuGJC769wLt3Vk6vnFJFTAFAorgUdn8XD0YVyWd9HodX/C+RwziNNBLSUN2EmtjUsCa+EbbdSuXQbulgkx/xJmkC2h+lvWPItnA1wWIAjne334DKyejg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737045626; c=relaxed/simple;
	bh=r0kXgIx10E5O+cD1K4uRtVtUiAIFRU1rn0yud7aFgjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIpTzb9bgG+/8KAH7kpaVno8+Y7mOIGPiIoC2PSMRCejFiau/w40Ouf5wNObpAi2LVIL7iCV1MzWXxhyRLcEmE4sUQyHtbtgpnHvQPhwk9DpkPSddnlGVrWSOH0mV6mvHQezMScZIZzAQNWTYvSIW1gNxxGnZFv408g1GDmQjfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 5D47272C8CC;
	Thu, 16 Jan 2025 19:40:22 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 4D1317CCB3A; Thu, 16 Jan 2025 18:40:22 +0200 (IST)
Date: Thu, 16 Jan 2025 18:40:22 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250116164022.GA4383@strace.io>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116160403.GA3554@strace.io>

On Thu, Jan 16, 2025 at 06:04:03PM +0200, Dmitry V. Levin wrote:
> On Thu, Jan 16, 2025 at 04:21:38PM +0100, Oleg Nesterov wrote:
> > On 01/13, Dmitry V. Levin wrote:
> > >
> > > +static int
> > > +ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
> > > +			void __user *datavp)
> > > +{
> > > +	struct pt_regs *regs = task_pt_regs(child);
> > > +	struct ptrace_syscall_info info;
> > > +	int error;
> > > +
> > > +	BUILD_BUG_ON(sizeof(struct ptrace_syscall_info) < PTRACE_SYSCALL_INFO_SIZE_VER0);
> > > +
> > > +	if (user_size < PTRACE_SYSCALL_INFO_SIZE_VER0 || user_size > PAGE_SIZE)
> > > +		return -EINVAL;
> > > +
> > > +	error = copy_struct_from_user(&info, sizeof(info), datavp, user_size);
> > 
> > OK, I certainly can't understand why copy_struct_from_user/check_zeroed_user
> > is useful, at least in this case. In particular, this won't allow to run the
> > new code (which uses the "extended" ptrace_syscall_info) on the older kernels?
> > 
> > Can't we just use user_size as a version number?
> > 
> > We can also turn info->reserved into info->version filled by
> > ptrace_get_syscall_info().
> > 
> > ptrace_set_syscall_info() can check that info->version matches user_size.
> 
> The idea is to use "op" to specify the operation, and "flags" to specify
> future extensions to the operation.  For example, we could later add
> PTRACE_SYSCALL_INFO_SECCOMP_SKIP operation to specify an exit-like
> data for seccomp stops, or some flag to set instruction_pointer or
> stack_pointer.  I don't think any of these would require a version field,
> though.
> 
> That is, the zero check implied by copy_struct_from_user() is not really
> needed here since the compatibility is tracked by "op" and "flags":
> if "op" and "flags" do not instruct the kernel to use these unknown
> extra bits, the kernel is not obliged to check them either.
> For the same reason I don't think the kernel is obliged to read more
> than sizeof(info) from userspace.
> 
> What would you recommend using instead of copy_struct_from_user in this
> case?

Something like this?

        if (user_size < PTRACE_SYSCALL_INFO_SIZE_VER0 || user_size > PAGE_SIZE)
                return -EINVAL;

        if (copy_from_user(&info, datavp, min(sizeof(info), user_size)))
                return -EFAULT;

        if (user_size < sizeof(info))
                memset((void *)&info + user_size, 0, sizeof(info) - user_size);

-- 
ldv

