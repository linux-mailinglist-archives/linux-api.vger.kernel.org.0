Return-Path: <linux-api+bounces-3102-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCAEA20DC8
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2025 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7623E165B74
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48171D63FD;
	Tue, 28 Jan 2025 15:58:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513691B4223;
	Tue, 28 Jan 2025 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079895; cv=none; b=WKF5nRs1fROb5cpx/0cz89PDQncI7WxeU8Wz52obonLaa2EBK96zuTkWZxzY8VthMOXXhgztqEygyCErIjzARQCjvx4AyVV48xQ7o2xH+xtM5wabkLHqfkQXvaongjvngIcXL6wpD2pRjm5yz6H3BDKotw8fjC9y00yOaquzcrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079895; c=relaxed/simple;
	bh=8UJ5OktHCn/A20NVQtgzSGOQ8m9GvBV5VaL/oKPCRYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c5twAmEf7hcnUmGhc+X0qMXr8hriAku4Zx3xvdao7vzrXV7qr0uTzo7H9ZytiAZ8RKcCs0vlOReBZkGAwRRr7QfudjX3w49cpMPbUnfLRkZLhhs848C/TYf+OCZ2GaBpMHKirmunAnTFVe1DbEwuOI2i1Y57iJ5PXvsxCnmaNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2DDE372C8CC;
	Tue, 28 Jan 2025 18:58:13 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 15A227CCB3A; Tue, 28 Jan 2025 17:58:12 +0200 (IST)
Date: Tue, 28 Jan 2025 17:58:12 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <legion@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v3 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250128155812.GB11869@strace.io>
References: <20250128091650.GE8601@strace.io>
 <3ee13371-0c7c-4264-b561-eceb4a7d7976@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ee13371-0c7c-4264-b561-eceb4a7d7976@csgroup.eu>

On Tue, Jan 28, 2025 at 04:21:13PM +0100, Christophe Leroy wrote:
> Le 28/01/2025 à 10:16, Dmitry V. Levin a écrit :
> > PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
> > PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
> > system calls the tracee is blocked in.
> > 
> > This API allows ptracers to obtain and modify system call details
> > in a straightforward and architecture-agnostic way.
> > 
> > Current implementation supports changing only those bits of system call
> > information that are used by strace, namely, syscall number, syscall
> > arguments, and syscall return value.
> 
> How do you handle changes related to syscalls that call 
> force_successful_syscall_return() ?

I don't see why these syscalls would need any special treatment.
If a tracer wants to set an error status for a syscall that cannot return
an error, it's up to the tracer to face the consequences.
Tracers can do it now via PTRACE_SETREGS* anyway.


-- 
ldv

