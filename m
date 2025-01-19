Return-Path: <linux-api+bounces-3064-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3686A161AE
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 13:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48063A27EE
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0241DBB3A;
	Sun, 19 Jan 2025 12:44:39 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66E157A5C;
	Sun, 19 Jan 2025 12:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737290679; cv=none; b=VlarPRXNv85jEvO8NUXpgBhhGrBVXoETG/n3ssB5zHV8oM98Br/17ltmyDkpVP//ZzInBBSmJPFMb55H+lqaVAnstCNXw1WnfP+k8/9Dsl33q+kIkztxxxkET1lu1icC3nPwnjtbeu5zyCKAn2gDOqvAbhTKzl1kmRkJCeqYOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737290679; c=relaxed/simple;
	bh=Xk295TfmjQ1zxzAyE/4wDeeeaXErJq/oVzL0fYef/7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/5XuOUVQ2DUCvpymBRq+24DakIEU+3JcRzp1YQyVK723Wuy+XoNkb6tBiUeFF3qzNuNdb/eovNETLneH4z7I5/efqYumvCXVb40qC7z4FlgMG/mbQIc4XQKiXI9Wng+XvpnTfEkBEhA2MG/6uB3jIj6eTWXsrsMB3zEHWkLnHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id D778F72C8F5;
	Sun, 19 Jan 2025 15:44:27 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id B77977CCB3A; Sun, 19 Jan 2025 14:44:27 +0200 (IST)
Date: Sun, 19 Jan 2025 14:44:27 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250119124427.GA3487@strace.io>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
 <20250117150627.GA15109@strace.io>
 <20250117153258.GC21203@redhat.com>
 <20250117162255.GA15597@strace.io>
 <20250118141341.GA21464@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250118141341.GA21464@redhat.com>

On Sat, Jan 18, 2025 at 03:13:42PM +0100, Oleg Nesterov wrote:
> On 01/17, Dmitry V. Levin wrote:
[...]
> > For example, on x86_64 sizeof(struct ptrace_syscall_info) is currently 88,
> > while on x86 it is 84.
> 
> Not good, but too late to complain...

Actually, I don't think it's too late to add an extra __u32 padding
there since it wouldn't affect PTRACE_GET_SYSCALL_INFO.

I can add an explicit padding to the structure if you say
you like it better this way.

[...]
> Thats said... Can't resist,
> 
> > An absolutely artificial example: let's say we're adding an optional
> > 64-bit field "artificial" to ptrace_syscall_info.seccomp, this means
> > sizeof(ptrace_syscall_info) grows by 8 bytes.  When userspace wants
> > to set this optional field, it sets a bit in ptrace_syscall_info.flags,
> > this tells the kernel to look into this new "artificial" field.
> > When userspace is not interested in setting new optional fields,
> > it just keeps ptrace_syscall_info.flags == 0.  Remember, however, that
> > by adding the new optional field sizeof(ptrace_syscall_info) grew by 8 bytes.
> >
> > What we need is to make sure that an older kernel that has no idea of this
> > new field would still accept the bigger size, so that userspace would be
> > able to continue doing its
> > 	ptrace(PTRACE_SET_SYSCALL_INFO, pid, sizeof(info), &info)
> > despite of potential growth of sizeof(info) until it actually starts using
> > new optional fields.
> 
> This is clear, but personally I don't really like this pattern... Consider
> 
> 	void set_syscall_info(int unlikely_condition)
> 	{
> 		struct ptrace_syscall_info info;
> 
> 		fill_info(&info);
> 		if (unlikely_condition) {
> 			info.flags = USE_ARTIFICIAL;
> 			info.artificial = 1;
> 		}
> 
> 		assert(ptrace(PTRACE_SET_SYSCALL_INFO, sizeof(info), &info) == 0);
> 	}
> 
> Now this application (running on the older kernel) can fail or not, depending
> on "unlikely_condition". To me it would be better to always fail in this case.

In practice, user-space programs rarely have the luxury to assume that
some new kernel API is available.  For example, strace still performs a
runtime check for PTRACE_GET_SYSCALL_INFO (introduced more than 5 years
ago) and falls back to pre-PTRACE_GET_SYSCALL_INFO interfaces when the
kernel lacks support.  Consequently, user-space programs would have to
keep track of PTRACE_SET_SYSCALL_INFO interfaces supported by the kernel,
so ...

> That is why I tried to suggest to use "user_size" as a version number.
> Currently we have PTRACE_SYSCALL_INFO_SIZE_VER0, when we add the new
> "artificial" member we will have PTRACE_SYSCALL_INFO_SIZE_VER1. Granted,
> this way set_syscall_info() can't use sizeof(info), it should do
> 
> 	ptrace(PTRACE_SET_SYSCALL_INFO, PTRACE_SYSCALL_INFO_SIZE_VER1, info);
> 
> and the kernel needs more checks, but this is what I had in mind when I said
> that the 1st version can just require "user_size == PTRACE_SYSCALL_INFO_SIZE_VER0".

... it wouldn't be a big deal for user-space to specify also an
appropriate "user_size", e.g. PTRACE_SYSCALL_INFO_SIZE_VER1 when it starts
using the interface available since VER1, but it wouldn't help user-space
programs either as they would have to update "op" and/or "flags" anyway,
and "user_size" would become just yet another detail they have to care
about.

At the same time, "flags" is needed anyway because the most likely
extension of PTRACE_SET_SYSCALL_INFO would be support of setting some
fields that are present in the structure already, e.g.
instruction_pointer.


-- 
ldv

