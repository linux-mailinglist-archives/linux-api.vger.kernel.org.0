Return-Path: <linux-api+bounces-6091-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAXGAqvm32m4aAAAu9opvQ
	(envelope-from <linux-api+bounces-6091-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 21:27:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD38407607
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 21:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3741B307E821
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C1386571;
	Wed, 15 Apr 2026 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/amLioS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7C43859DD
	for <linux-api@vger.kernel.org>; Wed, 15 Apr 2026 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281237; cv=pass; b=APZNpFRwU80M4vPsF0rV1ycrEUDTOWFVE1kQBr6dFnh9QarlW0QNBnG6g5HJGUWTkZiHoqjzP/MCC4RodAuaRE/g3Y8bMEMPibI4IvNIKBhbfG5soq1oOutKui61D1GyRf7wku8Y6Z0RTd+m6wrb9mrKpeN0TjNBSEnu3dn6wxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281237; c=relaxed/simple;
	bh=4v+Eko4xmqaU82b1NDdR0TLMvuLm6cFirxeTfWhHtMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i28CWLz67Vw+e5SqHBUPQUc5wDSrZDK2fEM3j8klAdxO1A2h8fxcaOvuUjdKLJwYSzj+8nw3tE3BiSMJUS6HK5ownAOq7QRm+eNkWuF47VK/yX4ez1sPDF+11lWB/NMHDs/bGPfgRgBcEhwsQxRLB433Xq2CqdiQoxHbR60SMvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/amLioS; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so3563738a34.0
        for <linux-api@vger.kernel.org>; Wed, 15 Apr 2026 12:27:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776281235; cv=none;
        d=google.com; s=arc-20240605;
        b=W3AAt64j5TN0rTsWx3tUp0B/vfylZZ0xtOAPsNGiysoWC9gE2xNlI67mpoR3IVvXNK
         n8/ljHbL1Eh2xauSqZmf8t9MFzo5zjzhT9XMsiCnF0nQCdzbhGpX/qC+OOsbKaEl0Kaj
         2w2w5qG1431Nz/AHMR0LnedpJdGkuUxi21H12a2KLKVUr5nkFrqWzd3fOfBu8hYM9H+T
         3aWkV6z2/Hr+/6Le6S7woLak54MNOsk/jNEUUBUSPj6OpK4QqsYUa295DtFzkSqzA5PP
         6M+CIqPxUxkiClUAkyBMpHcq1YqPfkePhiMnIFBhFZq7QdYXueM2IbUSvKIPhM0ID2Cj
         TInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WQ7kho8nNPiCZN6dDdK/LtHsVWQC24olPeq9GPw1YEU=;
        fh=TGkHdPyEIRc1szB9JNuOwKnSP0na6SQhlZNcOaMXW08=;
        b=bHIVIyh4uuBu7MgwekYjKs9WHa8+Gh21KQYoco/HnR9JAG0eppvVcfKgW95KNP4dbS
         +HU52n/xLZDcbYfyZad0kZKyZpYxg9o5/T0P/mlcuvQyp19Xbhs4ehSkWd4AjHhsfkGB
         AKiDOD+S3m2mMGFE8Y52z8l6kuaQK1yHb0Z+mhumyc/bTuQiRXPxeP3Ib0ZiLuWNtJ/7
         D98Ho5DD66Bb2kekU5aFXK84qK5o3dgLSak/iR1G3ioRA2QVSCjwhzwNdmbUmScLWUci
         OoEpM7q2sQmjVcuq7mkv06su9OSK0Uh6dgRjDVD7aikcKOmNDkPWKbl398/IBdQsR7XS
         FqqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281235; x=1776886035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQ7kho8nNPiCZN6dDdK/LtHsVWQC24olPeq9GPw1YEU=;
        b=s/amLioSoVGpC7OWVVQQZ8PyUrIMSk2hpeib9QuB06ogOU56MRGKDBOCy2SQE5FdZQ
         18wTQ5zfSIP8STV/b6vvKsKCwaYxv1fd04eILFYITlwEv05vFzl2tPN86hTi8W53D39P
         oeXw445TC97MMew19fP4cCxTYse3Ytiqr0YxW96+gAxPSssqTNW9JWRd/wHoX1q5qdi+
         8/FCkbm5M/QORwfK2Z8dk6dzO+DnRPJi4mhhdeCpkSjm32vyzugiZwPHyQjhKIee3o/L
         vD9FoADpejObFdkLSmt3r4Gm3vBm4BguaDoLSq1/cIWi6pQ/LP/4rZR9O8ZEbOBRbACf
         C+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281235; x=1776886035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WQ7kho8nNPiCZN6dDdK/LtHsVWQC24olPeq9GPw1YEU=;
        b=IEtkOjko5Wsh8SY3fL66/dKWVju8THQ8U777Z7LX7NEOb+YbRqbRh8zqV2Y60C9IjI
         1btUdiEEonyOPBo37pmhVUi7lA0qdbzr+CtOiEeLfrURVKgcYJwY7RhWUpd81KPeOOOt
         HpgZG9gKDSiMbKqUQLCkbZ7hW1hUAlzJYrzd4oFoj2ZwJuBMa5mrj0+PDmWYmkOFADJk
         x3jBp4RByC5E6YOCuWIP4QdwjZJPUEufUDdoSJkvgnTGabRnU1UmQdIyfGb28OnUSnfv
         ddzKULSG5DEYMOIFjU/i1rDc2RKE+4MOIO2VyksvQo1pYigDUrtvZkozDrXodF6ChSi3
         pxEg==
X-Forwarded-Encrypted: i=1; AFNElJ8v5fjL+hH+W8PJczjkFCzNYOnetenSVV4okVY24jHDL3c49akjDIkpcLzY2KWOW45MiGNyEwiZQDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylPoDHKsGuVhtbZlVBYvQzgvThhk6nB8SWneajrxSJAAxnvov/
	WXQuejUt8WOKCWzxiRnOpUQGqTbMyq58yC1tKgoZmk0xoVkYrmJgVo4+WDWixGku31IGF2Sj63D
	25+y11EdPd5fFJBctou64GLimFWPNmgQ=
X-Gm-Gg: AeBDietmlfVDrQBa1+V2yqyGqAcgM9GEZgDZUvYvDJy9NQ5hJdxIxsjrN/4pRftp06O
	Xj1NTFWWay8ZCNb9qRp0z9crhvsN9uCDtjzx84nYisfFS2zruB73B2z7F8EsxShjn4eDGGU1Fo2
	8Wkv++7YHjtujYuzPy2UhT9zHZIkB/5KRWy3Qb8s8ayUOScCQswBuE3/jRBxbn2JwWzRQfxlmkl
	u4/VF1OXZm0x5OI9CTP60izfyvO7TO7scadsu//owkZ7rh6ozsC3rVgxJtNOsXv8Z6pmVTRTCg3
	6icJkA6D+mIlSiy4hw==
X-Received: by 2002:a05:6830:25c5:b0:7d9:f50f:968a with SMTP id
 46e09a7af769-7dc27c66377mr13072583a34.5.1776281234901; Wed, 15 Apr 2026
 12:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com> <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com> <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com>
 <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com> <CAEWA0a7AZiuy1F+0LDxtEtJpdu=zA-RKhPb1wcDMpy2tSMFO5g@mail.gmail.com>
 <adUhbk0sKT0ucWhJ@J2N7QTR9R3>
In-Reply-To: <adUhbk0sKT0ucWhJ@J2N7QTR9R3>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 15 Apr 2026 12:27:03 -0700
X-Gm-Features: AQROBzBNtO31xd0yW9r81lEqB1GfFyuOQPPb5LE8m1aTt5Q8NnQOvyvucUSdcQk
Message-ID: <CANaxB-xitpwsU9SmQ1D7q0Jn0Ng1b4WYxzAWF3L-pE+EYzbObg@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andrei Vagin <avagin@google.com>, Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>, 
	Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6091-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linux-foundation.org,samsung.com,gmail.com,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,arm.com,lists.infradead.org,huawei.com,xmission.com,oracle.com,suse.com,futurfusion.io];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CD38407607
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mark,

Thanks for the feedback and sorry for the delay, was on vacation.
Please see my comments inline.

On Tue, Apr 7, 2026 at 8:29=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Fri, Mar 27, 2026 at 05:21:26PM -0700, Andrei Vagin wrote:
> > Hi Mark,
> >
> > I understand all these points and they are valid. However, as I
> > mentioned, we are not trying to introduce a mechanism that will strictl=
y
> > enforce feature sets for every container. While we would like to have
> > that functionality, as you and will mentioned, it would require
> > substantially more complexity to address, and maintainers would unlikel=
y
> > to pick up that complexity.
>
> The crux of my complaint here is that unless you do that (to some
> degree), this is not going to work reliably, even with the constraints
> you outline.
>
> Further, I disagree with your proposed solution of pushing more
> constraints onto userspace (to also consider HWCAPs as overriding other
> mechainsms, etc).
>
> I think that as-is, the approach is flawed.

I would really appreciate it if we could move this conversation toward
how we can make it work.

>
> > Even masking ID registers on a per-container basis would introduce
> > extra complexity that could make architecture maintainers unhappy.
> > There were a few attempts to introduce container CPUID masking on
> > x86_64 in the past.
>
> > In CRIU, we are not aiming to handle every possible workload. Our goal
> > is to target workloads where developers are ready to cooperate and
> > willing to make adjustments to be C/R compatible. The goal here is to
> > provide developers with clear instructions on what they can do to ensur=
e
> > their applications are C/R compatible. When I say "workloads", I mean
> > this in a broad sense. A container might pack a set of tools with
> > different runtimes (Go, Java, libc-based). All these runtimes should
> > detect only allowed features.
>
> I do not think that arbitrary applications (and libraries!) should have
> to pick up additional constraints that are unnecessary without CRIU,
> especially where that goes against deliberate design decisions (e.g.
> features in arm64's HINT instruction space, which are designed to be
> usable in fast paths WITHOUT needing explicit checks of things like
> HWCAPs). Note that those typically *do* have kernel controls.
>
> I think there's a much larger problem space than you anticipate, and
> adding an incomplete solution now is just going to introduce a
> maintenance burden.

I am not adding arbitrary constraints for standard non-CRIU use cases.
Previously, I suggested that standard libraries would need to call prctl
to determine if hwcaps should be used for feature detection.  However,
we can avoid this extra syscall by adding the new HWCAP2_CR bit. Then
libraries will simply check this bit in auxv[AT_HWCAP2], meaning the
overhead for "non-criu" cases is just a single bit check.

As for HINT instructions, there are two class of instructions.

The first one doesn't change a process state and they are not required
any special handling in term of checkpoint/restore. If a process is
checkpointed on a newer cpu, and restore it on an older cpu, the older
hardware will simply skip over that instructions.  The architectural
state (registers, memory) should remain consistent.

The second class such as PAC are instructions that actually change a
process state. These instructions require kernel/userspace coordination.
For example, usage of PAC keys can be controlled from userspace via prctl.
I mean when support for new instructions is implemented in the kernel,
we will need to consider that userspace should be able to control them.

>
> > Returning to the subject of this patchset: this series extends the role
> > of hwcaps. With this change, we would establish that hwcaps is the
> > "source of truth" for which features an application can safely use. Any
> > other features available on the current CPU would not be guaranteed to
> > remain available after migration to another machine.
> >
> > After this discussion, I found that the current version missed one majo=
r
> > thing: there should be a signal indicating that hwcaps must be used for
> > feature detection. Since we will need to integrate this interface into
> > libc, Go, and other runtimes, they definitely should not rely just on
> > hwcaps by default, especially in the early stages. This can be solved
> > via the prctl command.  Libraries like libc would call
> > prctl(PR_USER_HWCAP_ENABLED). If this returns true, the runtime knows
> > that only the features explicitly listed in hwcaps should be used.
>
> I do not think we should be pushing that shape of constraint onto
> userspace.

Look at the previous command.

>
> > You are right, the controlled feature set will be limited to features
> > the kernel knows about. And yes, we would need to report CPU features i=
n
> > hwcaps even if the kernel isn't directly involved in handling them.
>
> To be clear, that is not what I am arguing.
>
> As I mentioned before, the way this works on arm64 is that the kernel
> only exposes what it is aware of, even in the ID regs accessible to
> userspace. We usually *can* hide features, and do that for cases of
> mismatched big.LITTLE, virtual machines, etc.

I understand that. My point was that the kernel would need to report
features in hwcaps even if they don't require specific kernel-side
handling.

>
> > Honestly, I am not certain if this is the "right" interface for that,
> > and I would be happy to consider other ideas. I understand that these
> > hwcaps will not work right out of the box, but we need a way to solve
> > this problem. Having a centralized API for CPU/kernel feature detection
> > seems like the right direction.
>
> I think that for better or worse the approach you are tkaing here simply
> does not solve enough of the problem to actually be worthwhile.

This approach mimics solutions that some CRIU users are already
implementing in userspace, but those only work when the user controls/
recompiles all their libraries. I am open to other ideas, but we need a
path forward.

>
> > As for signal frame size and extended states like SVE/SME, we aware
> > about this problem.  However, it is partly mitigated by the fact that i=
f
> > an application does not use some features, those states are not placed
> > in the signal frame.
>
> That is not true. The kernel can and will create signal frames for
> architectural state that a task might never have touched.
>
> Generally arm64 creates signal frames for features when the feature
> *exists*, regardless of whether the task has actively manipulated the
> relevant state. For example, on systems with SVE a trivial SVE signal
> frame gets created even if a task only uses the FPSIMD registers, and on
> systms with SME a TPIDR2 signal frame gets created even if the task has
> never read/written TPIDR2.
>
> When restoring, an unrecognised signal frame is treated as invalid, and
> we can require that certain signal frames are present.

You are right; that was my mistake. My only explanation for why we don't
see this failure often is that C/R is rarely triggered while a process
is actually
inside a signal handler. This is definitely a problem that still needs
to be solved.

>
> > In the future, when we construct/reload a signal frame, we could look
> > at a process feature set for a process and generate a frame according
> > to those features...
>
> When you say 'we' here, are you talking about within the kernel, or
> within the userspace C/R mechanism?

... within the kernel.

Thanks,
Andrei

