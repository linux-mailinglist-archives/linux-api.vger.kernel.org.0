Return-Path: <linux-api+bounces-3047-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA63A15428
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB9403A289E
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA3019CCFA;
	Fri, 17 Jan 2025 16:23:06 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCFF166F29;
	Fri, 17 Jan 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737130985; cv=none; b=KFuvePlkMIc4kQ6d7Aldw/abyYA/9aMcekWG8lxbLcXIrVdRBWajmkfztYnzEkFkAzqbqq6n0vpJdE+ErvgC/ON2pphvXW3EHdZGzRk7TQ3Fqi3V0oxiH0DjB+fEQPWYGHvHaToVyi/TcoRqBXv5JnW8SIlcL6miqUtTwyoqZ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737130985; c=relaxed/simple;
	bh=zTE/6J7ninxZKWEZPWMetV2ZOU7JALxIq6RZgI16hnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvqHrO+MGYYJZn9S/G1ehueHkTeyjj3ayle8j4F7FxvZkTSRVXKPIEwPfA8zbVWKQqW/RkRcIDf5r1pEd6Zq3agltUSKm+wD8lGZmOoFN/0qfNTxiX+KahAp/+2j9gLm5Aiz7QRNPXiCl/vSV2gXU2ckI202iAjR5u9155dtIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 130FA72C8CC;
	Fri, 17 Jan 2025 19:22:56 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 069517CCB3A; Fri, 17 Jan 2025 18:22:55 +0200 (IST)
Date: Fri, 17 Jan 2025 18:22:55 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250117162255.GA15597@strace.io>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
 <20250117150627.GA15109@strace.io>
 <20250117153258.GC21203@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117153258.GC21203@redhat.com>

On Fri, Jan 17, 2025 at 04:32:59PM +0100, Oleg Nesterov wrote:
> Dmitry,
> 
> You certainly understand the user-space needs much better than me.
> I am just trying to understand your point.
> 
> On 01/17, Dmitry V. Levin wrote:
> >
> > We should accept larger user_size from the very beginning, so that in case
> > the structure grows in the future, the userspace that sicks to the current
> > set of supported features would be still able to work with older kernels.
> 
> This is what I can't understand, perhaps I have a blind spot here ;)
> 
> Could you provide an example (even absolutely artificial) of possible extension
> which can help me to understand?

An absolutely artificial example: let's say we're adding an optional 
64-bit field "artificial" to ptrace_syscall_info.seccomp, this means
sizeof(ptrace_syscall_info) grows by 8 bytes.  When userspace wants
to set this optional field, it sets a bit in ptrace_syscall_info.flags,
this tells the kernel to look into this new "artificial" field.
When userspace is not interested in setting new optional fields,
it just keeps ptrace_syscall_info.flags == 0.  Remember, however, that
by adding the new optional field sizeof(ptrace_syscall_info) grew by 8 bytes.

What we need is to make sure that an older kernel that has no idea of this
new field would still accept the bigger size, so that userspace would be
able to continue doing its
	ptrace(PTRACE_SET_SYSCALL_INFO, pid, sizeof(info), &info)
despite of potential growth of sizeof(info) until it actually starts using
new optional fields.

> > We cannot just use sizeof(info) because it depends on the alignment of
> > __u64.
> 
> Hmm why? I thought that the kernel already depends on the "natural" alignment?
> And if we can't, then PTRACE_SYSCALL_INFO_SIZE_VER0 added by this patch makes
> no sense?

struct ptrace_syscall_info has members of type __u64, and it currently
ends with "__u32 ret_data".  So depending on the alignment, the structure
either has extra 4 trailing padding bytes, or it doesn't.

For example, on x86_64 sizeof(struct ptrace_syscall_info) is currently 88,
while on x86 it is 84.


-- 
ldv

