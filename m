Return-Path: <linux-api+bounces-6037-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLG7ORYfx2k9TQUAu9opvQ
	(envelope-from <linux-api+bounces-6037-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 01:21:42 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287534CAAC
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 01:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFDDB301E986
	for <lists+linux-api@lfdr.de>; Sat, 28 Mar 2026 00:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9411A9F86;
	Sat, 28 Mar 2026 00:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWwyjB3U"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507B1A680A
	for <linux-api@vger.kernel.org>; Sat, 28 Mar 2026 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774657300; cv=pass; b=BQ02diItQRskMgUgifJEhBuInL+LvxH7UnVQy/ivvpE7xzYUIgsAChP4h297g1ihPcagb3EXqycaEEpU2vcGA+x+pVvYB2Kf6IPOvVZ2LnL0Fi21XpeGQ71aAwznP1DH0MTvbbtpuy+LZZxbZ3pi+8ZrFSfTFsnd33rhZPlq1wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774657300; c=relaxed/simple;
	bh=vV5WV0HLSYcQy+A0cA2Js7gosI1iQQ3g9tIu/GBiDJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GViNcXns0vJEighjuiTNArkHnXck3MnNqtk6AAFAMwIv/c7FPneGyyUuZ/vCmBgq0+Ayn29mHpXg9zfFpskyhHHqKCIirwMfeIJ1iiBZ8RX+wpFj3QuWOYa2dplL3d758ek5pxBKKMRoqPZKiZ8OIl3y36Tyy+W5o+LuFWLVqkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWwyjB3U; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5091ed02c54so131801cf.1
        for <linux-api@vger.kernel.org>; Fri, 27 Mar 2026 17:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774657298; cv=none;
        d=google.com; s=arc-20240605;
        b=BQ7/eE5wqhysmXICabVUL2hAG4yCKCyVvUOq2mCrXbmliY58V74Ejh5GW4xTAYvPbk
         UsPvsd1Ztltin+uB4sRocogZwEak5e+oRbxxro7XWJmiP1we0WPeEI8yAxvXFhKvZEu6
         uNB1BOoOLvH18VTiDo3SoZV2UZb0smLF9xAUY8x5/9rZe9cswzW5vF2cXJmq5p8YJSdp
         z1El4eFs4fcCeB2CB/XYTv94TRBjItrrkNUAPP5UCbx/0RnXEkkK+mV7tMUCN0YlJJXA
         H1mIRZDX1ISMYQXtK/rlo1Q8jDic9s9maPvmfpHSvG3OMt51KwDShcS2Km+3rmui9N7C
         Qbpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K9bPtEBHXKpRO9CjXfaCqUQKt7R+Gz6rl79/OVT+YNo=;
        fh=ZoLgjnRawAVhTT2/ukmLYeNtWGyqUE5d0D4w+3CGwmk=;
        b=GnWWUyIfKJoLfAnMfon2UhrDbUgAeXmpTNo4lYqb6FCb1ZrE7sG9szsciqYcL3QYvG
         awA+LPxf58TLmo2GiNf/0ZrClJeRt3ORlm/VhHBTrroJNnCNkLYQwsPBuZEI41xaiD7t
         5DSbsWrcCjrgFNDmyfCElhrEFp1UxjUV8FBDmhnIr7MgGTswpoZMlA8Aq5NF49UdS98G
         8WY+i9wjnm3w8mmBF9HEu5ozx9e/ZZD2yvVpqEU0fcq253/JuTN08Qc5czdYWFqN0GM6
         ZgxM6Yh3+UkW5ppHUWiZlTnewSoLOE7SgET/mPg5e0dbtk7aTmyJp9TsWS7QBsKJxTNt
         PR5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774657298; x=1775262098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9bPtEBHXKpRO9CjXfaCqUQKt7R+Gz6rl79/OVT+YNo=;
        b=NWwyjB3UfYeV7edM9egaGo7HgyNb/papUg2FICs1v4K996gpTD631K0ks6qsaoXnip
         1XKQQJ7XugBoN95nibA/VOYFXsMd3m4sKD4h1xEZvIC0fu0Qs7EUEEK3acAHPb/YHZjQ
         /vezt11v8Yd4wBQbDge8sJnNth4jo6/11rp9oU4Y5O+NoSVeb+KK1toc+/l89T8MgVYA
         P5919sChlIVa+LVoCmJEZ5seas/+vMXbyI2hn19fS8hbdtjjRUkCVuP36pH4EeovELpp
         b+xCsFrvJifzzlU4o/BJ7o0pV1wQ0rUGZ4pR56ewhBNJVLD7RLEBIRJ+y4owp5dNDYXJ
         qNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774657298; x=1775262098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9bPtEBHXKpRO9CjXfaCqUQKt7R+Gz6rl79/OVT+YNo=;
        b=Z7f/HJCsyzcJfXLd+tqCOhDO0dsm1Pmw/kCmQXJu5XuO3czu5pjGAi/7ZTTsLn6hAY
         1jhToPzzcVar8c4h1KCysHkA0tBQMfhvwj0Tb/UWuEDK7+Hf7xhq+n9dAuHZLK6v1ax6
         YnhWjllobjZMQGl820aG0+HEK6pAn8g/hVwRVZYGxtMa4VfM3YAoXHEjCfsvM1LYmOM2
         HkauKc+V301ptu2+WhPAOjTUkYtXw0vCj9P9icmxyYWnnpiv9rb5XQ2HT51TmnIHN60a
         b6jNjp65L+W5rl/7bMWEm2h3I+w9BRt5jhejkg5hEWg2bQxdZuMysLfVnA6LJtEjOt87
         Dnmg==
X-Forwarded-Encrypted: i=1; AJvYcCV9V3sv+zmUGL7TL0TQ5/TRTYDFfmlsZpFacnlqVQmDRkoZbplKP7N73gTVcRmZYqY/2s0FfJ09UmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDL/MdjyxJ3xdVADbHq/V/u9jlmqtj0HBTTVMaN8Byk7DRSDf
	fTsS3jOxIYizPMml24rcSZ++gPWqb3fWwo9q9oSdZYsRdGHaGxPSGo5SCRQ1OPjr1EcoqX3XMuY
	D8F5rIc8ADoCX9IPZN4H0UJZtKEe05YoCSP/fAAog
X-Gm-Gg: ATEYQzy89gzR/iqLrfzAmYFsLzH/uBA+ZyKOVtLucUuRpOhtfh+hL3zdiYr4qVH33sX
	KTmFrSIIW1QZH8J/4g3FC1PEdQ72GkH/IFq3gFdv9+Ec5NhsbtMD5DSTr/JojGdLIenitNqBt2z
	YFrhd5xp+Yg6sbvUBZnBvPj4VPbxtoh7+EvqtFOGZ48+ol509iqei28Rc/+4ZDN5F5cFUwxomiD
	XD/0qK7Mdpm8ie0my4YaLBE9EZ1uchNc36Q6Fef5/pE4+BH3IpMGGwvU6cDyocE5cDtcugzeADr
	nPcp0U7YzimT+cpULA==
X-Received: by 2002:a05:622a:4c8e:b0:509:14f0:bff2 with SMTP id
 d75a77b69052e-50bb27f62edmr6416861cf.12.1774657297623; Fri, 27 Mar 2026
 17:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323175340.3361311-1-avagin@google.com> <20260323175340.3361311-2-avagin@google.com>
 <acGEonF9I6sPA42B@J2N7QTR9R3.cambridge.arm.com> <acJnOB-rlyt-3jU4@willie-the-truck>
 <CAEWA0a7iR8YHooqXJfhersV6YhAXGMZDUhib3QQH5XGn=KNowA@mail.gmail.com> <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com>
In-Reply-To: <acarA3sGKY4Acozw@J2N7QTR9R3.cambridge.arm.com>
From: Andrei Vagin <avagin@google.com>
Date: Fri, 27 Mar 2026 17:21:26 -0700
X-Gm-Features: AQROBzAZx6vusK91xtphbHO0OyQ8WklBK8fprRQAhCkwYE-GzsBGKaet5s4vnp4
Message-ID: <CAEWA0a7AZiuy1F+0LDxtEtJpdu=zA-RKhPb1wcDMpy2tSMFO5g@mail.gmail.com>
Subject: Re: [PATCH 1/4] exec: inherit HWCAPs from the parent process
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>, 
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
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6037-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,samsung.com,gmail.com,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,arm.com,lists.infradead.org,huawei.com,xmission.com,oracle.com,suse.com,futurfusion.io];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@google.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: 9287534CAAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 9:06=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Tue, Mar 24, 2026 at 03:19:49PM -0700, Andrei Vagin wrote:
> > Hi Mark and Will,
> >
> > Thanks for the feedback. Please read the inline comments.
> >
> > On Tue, Mar 24, 2026 at 3:28=E2=80=AFAM Will Deacon <will@kernel.org> w=
rote:
> > >
> > > On Mon, Mar 23, 2026 at 06:21:22PM +0000, Mark Rutland wrote:
> > > > On Mon, Mar 23, 2026 at 05:53:37PM +0000, Andrei Vagin wrote:
> > > > > Introduces a mechanism to inherit hardware capabilities (AT_HWCAP=
,
> > > > > AT_HWCAP2, etc.) from a parent process when they have been modifi=
ed via
> > > > > prctl.
> > > > >
> > > > > To support C/R operations (snapshots, live migration) in heteroge=
neous
> > > > > clusters, we must ensure that processes utilize CPU features avai=
lable
> > > > > on all potential target nodes. To solve this, we need to advertis=
e a
> > > > > common feature set across the cluster.
> > > > >
> > > > > This patch adds a new mm flag MMF_USER_HWCAP, which is set when t=
he
> > > > > auxiliary vector is modified via prctl(PR_SET_MM, PR_SET_MM_AUXV)=
.  When
> > > > > execve() is called, if the current process has MMF_USER_HWCAP set=
, the
> > > > > HWCAP values are extracted from the current auxiliary vector and =
stored
> > > > > in the linux_binprm structure. These values are then used to popu=
late
> > > > > the auxiliary vector of the new process, effectively inheriting t=
he
> > > > > hardware capabilities.
> > > > >
> > > > > The inherited HWCAPs are masked with the hardware capabilities su=
pported
> > > > > by the current kernel to ensure that we don't report more feature=
s than
> > > > > actually supported. This is important to avoid unexpected behavio=
r,
> > > > > especially for processes with additional privileges.
> > > >
> > > > At a high level, I don't think that's going to be sufficient:
> > > >
> > > > * On an architecture with other userspace accessible feature
> > > >   identification mechanism registers (e.g. ID registers), userspace
> > > >   might read those. So you might need to hide stuff there too, and
> > > >   that's going to require architecture-specific interfaces to manag=
e.
> > > >
> > > >   It's possible that some code checks HWCAPs and others check ID
> > > >   registers, and mismatch between the two could be problematic.
> > > >
> > > > * If the HWCAPs can be inherited by a more privileged task, then a
> > > >   malicious user could use this to hide security features (e.g. sha=
dow
> > > >   stack or pointer authentication on arm64), and make it easier to
> > > >   attack that task. While not a direct attack, it would undermine t=
hose
> > > >   features.
> >
> > I agree with Mark that only a privileged process have to be able to mas=
k
> > certain hardware features. Currently, PR_SET_MM_AUXV is guarded by
> > CAP_SYS_RESOURCE, but PR_SET_MM_MAP allows changing the auxiliary vecto=
r
> > without specific capabilities. This is definitely the issue. To address
> > this, I think we can consider to introduce a new prctl command to enabl=
e
> > HWCAP inheritance explicitly.
> >
> > > Yeah, this looks like a non-starter to me on arm64. Even if it was
> > > extended to apply the same treatment to the idregs, many of the hwcap
> > > features can't actually be disabled by the kernel and so you still ru=
n
> > > the risk of a task that probes for the presence of a feature using
> > > something like a SIGILL handler or, perhaps more likely, assumes that
> > > the presence of one hwcap implies the presence of another. And then
> > > there are the applications that just base everything off the MIDR...
> >
> > The goal of this mechanism is not to provide strict architectural
> > enforcement or to trap the use of hardware features; rather, it is to
> > provide a consistent discovery interface for applications. I chose the
> > HWCAP vector because it mirrors the existing behavior of running an
> > older kernel on newer hardware: while ID registers might report a
> > feature as physically present, the HWCAPs will omit it if the kernel
> > lacks support.
>
> On arm64, the view of the ID registers that userspace gets *only*
> exposes features that the kernel knows about, as userspace reads of
> those registers are trapped+emulated by the kernel. On arm64 it's
> not true to say that something appears in those but not the HWCAPs.
>
> I understand that might be different on other architectures, and so
> maybe this approach is sufficient on other architectures, but it is not
> sufficient on arm64.
>
> > Applications are generally expected to treat HWCAPs as
> > the source of truth for which features are safe to use, even if the
> > underlying hardware is technically capable of more.
>
> I'm fairly certain that there are arm64 applications (and libraries)
> which check only the ID register values, and not the HWCAPs.
>
> Architecturally, there are features which are detected via other
> mechanisms (e.g. CHKFEAT), for which HWCAPs are also irrelevant. Even if
> that happens to be ok today, there are almost certainly future uses that
> will not be compatible with the scheme you propose.
>
> I don't think we can say "applications must check the HWCAPs", when we
> know that applications and libraries legitimately don't always do that.
>
> > Another significant advantage of using HWCAPs is that many
> > applications already rely on them for feature detection. This interface
> > allows these applications to work correctly "out-of-the-box" in a
> > migrated environment without requiring any userspace modifications.  I
> > understand that some apps may use other detection methods; however, the=
re
> > it no gurantee that these applications will work correctly after
> > migration to another machine.
>
> I think the existince of applications that detect features by other
> (legitimate!) means implies that there's no guarantee that this feature
> is useful and will remain useful going forwards.
>
> For example, what do you plan to do if an application or library starts
> doing something legitimate that causes it to become incompatible with
> this scheme?
>
> I don't want to be in a position where userspace is asked to steer clear
> of legitimate mechanisms, or where architecture code suddently has to
> pick up a lot of complexity to make this work.
>
> > > There's also kvm, which provides a roundabout way to query some featu=
res
> > > of the underlying hardware.
> > >
> > > You're probably better off using/extending the idreg overrides we hav=
e
> > > in arch/arm64/kernel/pi/idreg-override.c so that you can make your
> > > cluster of heterogeneous machines look alike.
> >
> > IIRC, idreg-override/cpuid-masking usually works for an entire machine.
> > We actually need to have a mechanism that will work on a per-container
> > basis. Workloads inside one cluster can have different
> > migration/snapshot requirements. Some are pinned to a specific node,
> > others are never migrated, while others need to be migratable across a
> > cluster or even between clusters. We need a mechanism that can be
> > tunable on a per-container/per-process basis.
>
> I think that's theoretically possible, BUT it will require substantially
> more complexity, to address the issues that Will and I have mentioned. I
> don't think people are very happy to pick up that complexity.
>
> There are many other aspects that are going to be problematic for
> heterogeneous migration. Even if you hide the HWCAP for a stateful
> feature (e.g. SME), it might appear in one machine's signal frames (and
> be mandatory there), but might not appear in anothers, and so migration
> might not work either way. Likewise, that state can appear via ptrace.

Hi Mark,

I understand all these points and they are valid. However, as I
mentioned, we are not trying to introduce a mechanism that will strictly
enforce feature sets for every container. While we would like to have
that functionality, as you and will mentioned, it would require
substantially more complexity to address, and maintainers would unlikely
to pick up that complexity. Even masking ID registers on a per-container
basis would introduce extra complexity that could make architecture
maintainers unhappy. There were a few attempts to introduce container
CPUID masking on x86_64 in the past.

In CRIU, we are not aiming to handle every possible workload. Our goal
is to target workloads where developers are ready to cooperate and
willing to make adjustments to be C/R compatible. The goal here is to
provide developers with clear instructions on what they can do to ensure
their applications are C/R compatible. When I say "workloads", I mean
this in a broad sense. A container might pack a set of tools with
different runtimes (Go, Java, libc-based). All these runtimes should
detect only allowed features.

Returning to the subject of this patchset: this series extends the role
of hwcaps. With this change, we would establish that hwcaps is the
"source of truth" for which features an application can safely use. Any
other features available on the current CPU would not be guaranteed to
remain available after migration to another machine.

After this discussion, I found that the current version missed one major
thing: there should be a signal indicating that hwcaps must be used for
feature detection. Since we will need to integrate this interface into
libc, Go, and other runtimes, they definitely should not rely just on
hwcaps by default, especially in the early stages. This can be solved
via the prctl command.  Libraries like libc would call
prctl(PR_USER_HWCAP_ENABLED). If this returns true, the runtime knows
that only the features explicitly listed in hwcaps should be used.

You are right, the controlled feature set will be limited to features
the kernel knows about. And yes, we would need to report CPU features in
hwcaps even if the kernel isn't directly involved in handling them.
Honestly, I am not certain if this is the "right" interface for that,
and I would be happy to consider other ideas. I understand that these
hwcaps will not work right out of the box, but we need a way to solve
this problem. Having a centralized API for CPU/kernel feature detection
seems like the right direction.

As for signal frame size and extended states like SVE/SME, we aware
about this problem.  However, it is partly mitigated by the fact that if
an application does not use some features, those states are not placed
in the signal frame. In the future, when we construct/reload a signal
frame, we could look at a process feature set for a process and generate
a frame according to those features...

Thanks,
Andrei

