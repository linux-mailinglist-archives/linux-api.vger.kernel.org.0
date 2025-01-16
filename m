Return-Path: <linux-api+bounces-3023-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79E5A1356A
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 09:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9193418829FA
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2025 08:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCD21D63C6;
	Thu, 16 Jan 2025 08:33:32 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3071AAA10;
	Thu, 16 Jan 2025 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016412; cv=none; b=UkJtndXaC3aatbxNgMO8uKn0xtIFOY+daKnL6vELUXg/qmBr0IdH4Qj8k62m6HaL7hePAL/QPcH/w7b1/NrQnLnV4VrOS0VxsNz4aI+mdjIWiCb23xlLNpx4qStX14jgHDPWY+uL+N4MNRKtgW1RjTOiZLgmY8ZjvciLYCE4tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016412; c=relaxed/simple;
	bh=Q4OHIkrImLb+BwrSbPrgetIO0oidUZMyAaIJThugWiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsnBe8MTg/yvBqFgpZAuy0UEvENv3foByMh9T2ypBVgypMQXbwXCubR/qVRzP8JveVes7WgeaQlGdbSI4HqQWve1dWMDXDRwRYa8PtfN548EPH9ElqsharbBC6kZn6t30TAESGgDqG5f+4Ik5ZRG3s+IyLxcyH3WJ7SbaS5tXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 6C2C672C8CC;
	Thu, 16 Jan 2025 11:33:28 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 616B17CCB3A; Thu, 16 Jan 2025 10:33:28 +0200 (IST)
Date: Thu, 16 Jan 2025 10:33:28 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250116083328.GA32173@strace.io>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <Z4hnEzFUgN9N0pSF@ghost>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4hnEzFUgN9N0pSF@ghost>

On Wed, Jan 15, 2025 at 05:55:31PM -0800, Charlie Jenkins wrote:
> On Mon, Jan 13, 2025 at 07:12:08PM +0200, Dmitry V. Levin wrote:
[...]
> > +	/* Changing the type of the system call stop is not supported. */
> > +	if (ptrace_get_syscall_info_op(child) != info.op)
> 
> Since this isn't supported anyway, would it make sense to set the
> info.op to ptrace_get_syscall_info_op(child) like is done for
> get_syscall_info? The usecase I see for this is simplifying when the
> user doesn't call PTRACE_GET_SYSCALL_INFO before calling
> PTRACE_SET_SYSCALL_INFO.

struct ptrace_syscall_info.op is a field that specifies how to interpret
the union fields of the structure, so if "op" is ignored, then the
kernel would infer the meaning of the structure specified by the userspace
tracer from the kernel state of the tracee.  This looks a bit too
error-prone to allow.  For example, nothing good is expected to happen
if syscall entry information is applied in a syscall exit stop.

The tracer is not obliged to call PTRACE_GET_SYSCALL_INFO to set
struct ptrace_syscall_info.op.  If the tracer keeps track of ptrace stops
by other means, it can assign the right value by itself.

And, btw, the comment should say "is not currently supported",
I'll update it in the next iteration.

An idea mentioned in prior discussions was that it would make sense to
specify syscall return value along with skipping the syscall in seccomp stop,
and this would require a different value for "op" field, but
I decided not to introduce this extra complexity yet.


-- 
ldv

