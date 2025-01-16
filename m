Return-Path: <linux-api+bounces-3028-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEEA13EB4
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFEB41884802
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 16:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395B22BAC1;
	Thu, 16 Jan 2025 16:04:13 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00A24A7F6;
	Thu, 16 Jan 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043453; cv=none; b=LZR5GibwXrdiJyZWPi7DNZotGmKBNyuH1lDJnBYoRwNclM7E/I2uzUVtmfD00qoW+BPDLtQBQfUE1SLvrl+MUgbJrT59gesTCBN2sZt6sbw4QMnYV0HtYFJNvv4+3n6ega7kgprxuvrps5vUmb+BdzzNb9s3LJbGIBHXOrmPmN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043453; c=relaxed/simple;
	bh=X/N4/BXrk+bh43rgRGbrNL95bTuJNZzRxIK97gdDp1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmZhoVZmiNlRcSwxLXo41lmXinghpAae+9zyI2DRYSYhJunrDrbozbu+Rr99Gl7+4nJjBW0A0WF4YAwrXrI6cNy93EE6ZLhm7XM6HyDR4t84o5v0yQfH79RcpAwqgGvZN7M7PvdLVIqJr8QMPsvPCBq1Ll9OH8rHewBk2IinjYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 5967372C8CC;
	Thu, 16 Jan 2025 19:04:03 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 4E2EC7CCB3A; Thu, 16 Jan 2025 18:04:03 +0200 (IST)
Date: Thu, 16 Jan 2025 18:04:03 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250116160403.GA3554@strace.io>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116152137.GE21801@redhat.com>

On Thu, Jan 16, 2025 at 04:21:38PM +0100, Oleg Nesterov wrote:
> On 01/13, Dmitry V. Levin wrote:
> >
> > +static int
> > +ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
> > +			void __user *datavp)
> > +{
> > +	struct pt_regs *regs = task_pt_regs(child);
> > +	struct ptrace_syscall_info info;
> > +	int error;
> > +
> > +	BUILD_BUG_ON(sizeof(struct ptrace_syscall_info) < PTRACE_SYSCALL_INFO_SIZE_VER0);
> > +
> > +	if (user_size < PTRACE_SYSCALL_INFO_SIZE_VER0 || user_size > PAGE_SIZE)
> > +		return -EINVAL;
> > +
> > +	error = copy_struct_from_user(&info, sizeof(info), datavp, user_size);
> 
> OK, I certainly can't understand why copy_struct_from_user/check_zeroed_user
> is useful, at least in this case. In particular, this won't allow to run the
> new code (which uses the "extended" ptrace_syscall_info) on the older kernels?
> 
> Can't we just use user_size as a version number?
> 
> We can also turn info->reserved into info->version filled by
> ptrace_get_syscall_info().
> 
> ptrace_set_syscall_info() can check that info->version matches user_size.

The idea is to use "op" to specify the operation, and "flags" to specify
future extensions to the operation.  For example, we could later add
PTRACE_SYSCALL_INFO_SECCOMP_SKIP operation to specify an exit-like
data for seccomp stops, or some flag to set instruction_pointer or
stack_pointer.  I don't think any of these would require a version field,
though.

That is, the zero check implied by copy_struct_from_user() is not really
needed here since the compatibility is tracked by "op" and "flags":
if "op" and "flags" do not instruct the kernel to use these unknown
extra bits, the kernel is not obliged to check them either.
For the same reason I don't think the kernel is obliged to read more
than sizeof(info) from userspace.

What would you recommend using instead of copy_struct_from_user in this
case?


-- 
ldv

