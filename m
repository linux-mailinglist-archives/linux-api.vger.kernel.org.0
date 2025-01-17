Return-Path: <linux-api+bounces-3045-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B674A15262
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 16:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6AE3A5B13
	for <lists+linux-api@lfdr.de>; Fri, 17 Jan 2025 15:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE22188713;
	Fri, 17 Jan 2025 15:06:31 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231AE156C71;
	Fri, 17 Jan 2025 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126391; cv=none; b=lxmwhzfIPvF4aW4oyDm3+XFRSfMye2VMqDRvhSYPKEvVIOrJY+EA6n+qJwdWiiZqAD7VCNzBUz8EShVp48mGg4rKRhemhUDHQ/xH1z7NSlXgY3YQIGZsyEzIGBdOfH5AfAM5BkK2aYl9nszqYGY7ha95U7RPs14VIPL99PVNHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126391; c=relaxed/simple;
	bh=IR3iSA6tKvu4wPyww3CCGODodcjxr+DYqLfEeRa4KkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEX8duXK1QnGbSmo2xbdilS0bUtZQuNMeQbXO/co7QfOymlchd4gT9z947iQBafEIdneo8AeUi2cbC9XUwpHj/Adn1CUbpiCEMv6S0QNm9RMDNTVbDxEVRBpY4RnLPmymUS1XCjcXVWKWX9YNGroFiCUaFK2ErrOLmoXD1CtmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id A6A3872C8CC;
	Fri, 17 Jan 2025 18:06:27 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 94EFF7CCB3A; Fri, 17 Jan 2025 17:06:27 +0200 (IST)
Date: Fri, 17 Jan 2025 17:06:27 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250117150627.GA15109@strace.io>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117144556.GB21203@redhat.com>

On Fri, Jan 17, 2025 at 03:45:57PM +0100, Oleg Nesterov wrote:
> On 01/16, Dmitry V. Levin wrote:
> >
> > The idea is to use "op" to specify the operation, and "flags" to specify
> > future extensions to the operation.
> 
> OK,
> 
> > That is, the zero check implied by copy_struct_from_user() is not really
> > needed here since the compatibility is tracked by "op" and "flags":
> 
> OK, but then why this patch uses copy_struct_from_user() ?
> 
> Why can't we simply do
> 
> 	if (user_size != PTRACE_SYSCALL_INFO_SIZE_VER0)
> 		return -EINVAL;
> 
> 	if (copy_from_user(..., user_size))
> 		return EFAULT;
> 
> now, until we add the extensions ?

We should accept larger user_size from the very beginning, so that in case
the structure grows in the future, the userspace that sicks to the current
set of supported features would be still able to work with older kernels.

I think we can do the following:

        /*
         * ptrace_syscall_info.seccomp is the largest member in the union,
         * and ret_data is the last field there.
         * min_size can be less than sizeof(info) due to alignment.
         */
        size_t min_size = offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
        size_t copy_size = min(sizeof(info), user_size);

        if (copy_size < min_size)
                return -EINVAL;

        if (copy_from_user(&info, datavp, copy_size))
                return -EFAULT;

We cannot just use sizeof(info) because it depends on the alignment of
__u64.  Also, I don't think we need to fill with zeroes the trailing
padding bytes of the structure as we are not going to use them in any way.


-- 
ldv

