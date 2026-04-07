Return-Path: <linux-api+bounces-6069-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOv0N9Ei1WnK1AcAu9opvQ
	(envelope-from <linux-api+bounces-6069-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 17:29:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB8D3B0FAA
	for <lists+linux-api@lfdr.de>; Tue, 07 Apr 2026 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FFEC3057D64
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2026 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801B3C0623;
	Tue,  7 Apr 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aefdV1zd"
X-Original-To: linux-api@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E93F36F43A;
	Tue,  7 Apr 2026 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575424; cv=none; b=I+9qwHnwGOQtnY+qPE2Cv3qC4k3z5AmCDMpmV8W4NBYuZzBLFDm08qMncg1EpV8c5kEfMDkc8gjkQWu3qFxn2uQoY6KbXSWHSzduUVn6GwcW4ne82cK+BGTsgZYBa4Zwi2/mBs8EeSxJpLOLC/1qtsQPWC+TZKY69ZrzC43rgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575424; c=relaxed/simple;
	bh=S0KhfM4isL6DUfK/OM+IpENXf/XOYoUfgu5TX4otGBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pERR4CBKHpsHlnCBeIBPEcPxMdrkX74rBwkoJgq4dHr3OqkwpRT3XZSgCZr1nC19Hnd5Bnx0PfKNxdBSuoBxHcmAr5QLdAx2Xez/OkbFa2cDt4KQ2eqYBbB6mtPkYdhZ04s+GMP7zSzWG5oXbBHJLunHPaN8su1ekD0PfZoSQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aefdV1zd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C09181BB2;
	Tue,  7 Apr 2026 08:23:29 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3BC63F7D8;
	Tue,  7 Apr 2026 08:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775575415; bh=S0KhfM4isL6DUfK/OM+IpENXf/XOYoUfgu5TX4otGBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aefdV1zd4eTc7MvgGtSzxJ6u6nyn6CMFJ8DD0XRkLGfrY33iY2FOoNFww6iazNtBn
	 wAhikLlDca2j5pDfe4SJfzH1oEwvG3WfHMJS7FKe4QHJTXCAI4y0AQpcswcWdV1YHG
	 NydN8l/eOnj3UHguIO+FYOOEcR/l3ipZzrQCTm5g=
Date: Tue, 7 Apr 2026 16:23:26 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Andrei Vagin <avagin@google.com>
Cc: Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, criu@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Chen Ridong <chenridong@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Koutny <mkoutny@suse.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
	Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
Message-ID: <adUhbk0sKT0ucWhJ@J2N7QTR9R3>
References: <20260323175340.3361311-1-avagin@google.com>
 <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com>
 <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
 <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com>
 <CAEWA0a7AZiuy1F+0LDxtEtJpdu=zA-RKhPb1wcDMpy2tSMFO5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEWA0a7AZiuy1F+0LDxtEtJpdu=zA-RKhPb1wcDMpy2tSMFO5g@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6069-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,samsung.com,gmail.com,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,arm.com,lists.infradead.org,huawei.com,xmission.com,oracle.com,suse.com,futurfusion.io];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DKIM_TRACE(0.00)[arm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CB8D3B0FAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 05:21:26PM -0700, Andrei Vagin wrote:
> Hi Mark,
> 
> I understand all these points and they are valid. However, as I
> mentioned, we are not trying to introduce a mechanism that will strictly
> enforce feature sets for every container. While we would like to have
> that functionality, as you and will mentioned, it would require
> substantially more complexity to address, and maintainers would unlikely
> to pick up that complexity. 

The crux of my complaint here is that unless you do that (to some
degree), this is not going to work reliably, even with the constraints
you outline.

Further, I disagree with your proposed solution of pushing more
constraints onto userspace (to also consider HWCAPs as overriding other
mechainsms, etc).

I think that as-is, the approach is flawed.

> Even masking ID registers on a per-container basis would introduce
> extra complexity that could make architecture maintainers unhappy.
> There were a few attempts to introduce container CPUID masking on
> x86_64 in the past.

> In CRIU, we are not aiming to handle every possible workload. Our goal
> is to target workloads where developers are ready to cooperate and
> willing to make adjustments to be C/R compatible. The goal here is to
> provide developers with clear instructions on what they can do to ensure
> their applications are C/R compatible. When I say "workloads", I mean
> this in a broad sense. A container might pack a set of tools with
> different runtimes (Go, Java, libc-based). All these runtimes should
> detect only allowed features.

I do not think that arbitrary applications (and libraries!) should have
to pick up additional constraints that are unnecessary without CRIU,
especially where that goes against deliberate design decisions (e.g.
features in arm64's HINT instruction space, which are designed to be
usable in fast paths WITHOUT needing explicit checks of things like
HWCAPs). Note that those typically *do* have kernel controls.

I think there's a much larger problem space than you anticipate, and
adding an incomplete solution now is just going to introduce a
maintenance burden.

> Returning to the subject of this patchset: this series extends the role
> of hwcaps. With this change, we would establish that hwcaps is the
> "source of truth" for which features an application can safely use. Any
> other features available on the current CPU would not be guaranteed to
> remain available after migration to another machine.
> 
> After this discussion, I found that the current version missed one major
> thing: there should be a signal indicating that hwcaps must be used for
> feature detection. Since we will need to integrate this interface into
> libc, Go, and other runtimes, they definitely should not rely just on
> hwcaps by default, especially in the early stages. This can be solved
> via the prctl command.  Libraries like libc would call
> prctl(PR_USER_HWCAP_ENABLED). If this returns true, the runtime knows
> that only the features explicitly listed in hwcaps should be used.

I do not think we should be pushing that shape of constraint onto
userspace.

> You are right, the controlled feature set will be limited to features
> the kernel knows about. And yes, we would need to report CPU features in
> hwcaps even if the kernel isn't directly involved in handling them.

To be clear, that is not what I am arguing.

As I mentioned before, the way this works on arm64 is that the kernel
only exposes what it is aware of, even in the ID regs accessible to
userspace. We usually *can* hide features, and do that for cases of
mismatched big.LITTLE, virtual machines, etc.

> Honestly, I am not certain if this is the "right" interface for that,
> and I would be happy to consider other ideas. I understand that these
> hwcaps will not work right out of the box, but we need a way to solve
> this problem. Having a centralized API for CPU/kernel feature detection
> seems like the right direction.

I think that for better or worse the approach you are tkaing here simply
does not solve enough of the problem to actually be worthwhile.

> As for signal frame size and extended states like SVE/SME, we aware
> about this problem.  However, it is partly mitigated by the fact that if
> an application does not use some features, those states are not placed
> in the signal frame.

That is not true. The kernel can and will create signal frames for
architectural state that a task might never have touched.

Generally arm64 creates signal frames for features when the feature
*exists*, regardless of whether the task has actively manipulated the
relevant state. For example, on systems with SVE a trivial SVE signal
frame gets created even if a task only uses the FPSIMD registers, and on
systms with SME a TPIDR2 signal frame gets created even if the task has
never read/written TPIDR2.

When restoring, an unrecognised signal frame is treated as invalid, and
we can require that certain signal frames are present.

> In the future, when we construct/reload a signal frame, we could look
> at a process feature set for a process and generate a frame according
> to those features...

When you say 'we' here, are you talking about within the kernel, or
within the userspace C/R mechanism?

Mark.

