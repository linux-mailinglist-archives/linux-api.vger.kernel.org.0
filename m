Return-Path: <linux-api+bounces-3735-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3910CAB10C7
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CF3174187
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581226FA53;
	Fri,  9 May 2025 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="qOLP19H1"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776538FA3
	for <linux-api@vger.kernel.org>; Fri,  9 May 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786739; cv=none; b=j/foXCF4vLx0u/gh0ifzdwcjAIUMtFhxkunCvBhsm8rvuWBlVWeZ2/zIiJZphaNBTXxUAjVCRLLxamd5x5xAMm7jDeGCxZd6kNobldXoRdhfVqKVqOX9jP34kJxSmdKl7zYV4dIf999qg09CHa4lfBe0FrzoknFoBul2bis/HCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786739; c=relaxed/simple;
	bh=KqNzpGlXvYPxbZV20k0U7Oey6ED4zNDafqlF1kyyiSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS+h0nNRn1ltIgCgr6YL9b7nlHUtdLD1D+TeaayTIQXBzYgwbodxpHPST1A4OF5g+mXPxzzxY38guYMnQsgmlvjtpKXDLYHRM6NIOcrHT2JWTOTV4YXLoE+/Z+yXnd/SReki70jqeUPdyik7D2vYBKWfgcyuqJRB4ifcVMobQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=qOLP19H1; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6b])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zv4sZ2328zsXS;
	Fri,  9 May 2025 12:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746786370;
	bh=bILtYHuoVN6FrclTI4aJzyW8su3B/F4qiUGtahlBZxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qOLP19H1yidbzzP8ApnFxC4YAJ/AUtnjhouaiBHNmVH2X0SR/OpPaoOPsberi/5Ft
	 rhgbDwIewBsvg2tRJMTCKXTmwCYHcAu85bovrq34E16SH3OQsnLiKbD5d1Dh2OaymK
	 rwI4PU2F1cg/nHd5mG8H/T06sbavjQMKYZ+q7hgA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zv4sY4F4qz57l;
	Fri,  9 May 2025 12:26:09 +0200 (CEST)
Date: Fri, 9 May 2025 12:26:08 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: John Johansen <john.johansen@canonical.com>
Cc: Song Liu <song@kernel.org>, 
	Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>, linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
Message-ID: <20250509.ePu7gaim1Foo@digikod.net>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com>
 <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
 <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
 <CAPhsuW4FVMS7v8p_C-QzE8nBxCb6xDRhEecm_KHZ3KbKUjOXrQ@mail.gmail.com>
 <9aaeda3a-8ef5-4820-b2e4-9180b73fb368@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9aaeda3a-8ef5-4820-b2e4-9180b73fb368@canonical.com>
X-Infomaniak-Routing: alpha

On Thu, May 08, 2025 at 01:18:20AM -0700, John Johansen wrote:
> On 5/7/25 23:06, Song Liu wrote:
> > On Wed, May 7, 2025 at 8:37 AM Maxime Bélair
> > <maxime.belair@canonical.com> wrote:
> > [...]
> > > > 
> > > > These two do not feel like real benefits:
> > > > - One syscall cannot fit all use cases well...
> > > 
> > > This syscall is not intended to cover every case, nor to replace existing kernel
> > > interfaces.
> > > 
> > > Each LSM can decide which operations it wants to support (if any). For example, when
> > > loading policies, an LSM may choose to allow only policies that further restrict
> > > privileges.
> > > 
> > > > - Not working in containers is often not an issue, but a feature.
> > > 
> > > Indeed, using this syscall requires appropriate capabilities and will not permit
> > > unprivileged containers to manage policies arbitrarily.
> > > 
> > > With this syscall, capability checks remain the responsibility of each LSM.
> > > 
> > > For instance, in the AppArmor patch, a profile can be loaded only if
> > > aa_policy_admin_capable() succeeds (which requires CAP_MAC_ADMIN). Moreover, by design,
> > > policies can be loaded only in the current namespace.
> > > 
> > > I see this syscall as a middle point between exposing the entire sysfs, creating a large
> > > attack surface, and blocking everything.
> > > 
> > > Landlock’s existing syscalls already improve security by allowing processes to further
> > > restrict their ambient rights while adding only a modest attack surface.
> > > 
> > > This syscall is a further step in that direction: it lets LSMs add restrictive policies
> > > without requiring exposing every other interface.
> > 
> > I don't think a syscall makes the API more secure. If necessary, we can add
> 
> It exposes a different attack surface. Requiring mounting of the fs to where it is visible
> in the container, provides attack surface, and requires additional external configuration.

We should also keep in mind that syscalls could be accessible from
everywhere, by everyone, which may increase the attack surface compared
to a privileged filesystem interface.  Adding a second interface may
also introduce issues.  Anyway, I'm definitely not against syscalls, but
I don't see why the filesystem interface would be "less secure" in this
context.

> 
> Then there is the whole issue of getting the various LSMs to allow another LSM in the
> stack to be able manage its own policy.

Right, and it's a similar issue with seccomp policies wrt syscalls.

> 
> > permission check to each pseudo file. The downside of the syscall, however,
> > is that all the permission checks are hard-coded in the kernel (except for
> 
> The permission checks don't have to be hard coded. Each LSM can define how it handles
> or manages the syscall. The default is that it isn't supported, but if an lsm decides
> to support it, there is now reason that its policy can't determine the use of the
> syscall.

From an interface design point of view, it would be better to clearly
specify the scope of a command (e.g. which components could be impacted
by a command), and make sure the documentation reflect that as well.
Even better, have a syscalls per required privileges and impact (e.g.
privileged or unprivileged).  Going this road, I'm not sure if a
privileged syscall would make sense given the existing filesystem
interface.

> 
> > BPF LSM); while the sys admin can configure permissions of the pseudo
> > files in user space.
> > 
> Other LSMs also have policy that can control access to pseudo filesystems and
> other resources. Again, the control doesn't have to be hard coded. And seccomp can
> be used to block the syscall.
> 
> 
> 
> > > Again, each module decides which operations to expose through this syscall. In many cases
> > > the operation will still require CAP_SYS_ADMIN or a similar capability, so environments
> > > that choose this interface remain secure while gaining its advantages.
> > > 
> > > > >    - Avoids overhead of other kernel interfaces for better efficiency
> > > > 
> > > > .. and it is is probably less efficient, because everything need to
> > > > fit in the same API.
> > > 
> > > As shown below, the syscall can significantly improve the performance of policy management.
> > > A more detailed benchmark is available in [1].
> > > 
> > > The following table presents the time required to load an AppArmor profile.
> > > 
> > > For every cell, the first value is the total time taken by aa-load, and the value in
> > > parentheses is the time spent to load the policy in the kernel only (total - dry‑run).
> > > 
> > > Results are in microseconds and are averaged over 10 000 runs to reduce variance.
> > > 
> > > 
> > > | t (µs)    | syscall     | pseudofs    | Speedup       |
> > > |-----------|-------------|-------------|---------------|
> > > | 1password | 4257 (1127) | 3333 (192)  | x1.28 (x5.86) |
> > > | Xorg      | 6099 (2961) | 5167 (2020) | x1.18 (x1.47) |
> > > 
> > 
> > I am not sure the performance of loading security policies is on any
> > critical path.
> 
> generally speaking I agree, but I am also not going to turn down a
> performance improvement either. Its a nice to have, but not a strong
> argument for need.
> 
> > The implementation calls the hook for each LSM, which is why I think the
> > syscall is not efficient.
> > 
> it should only call the LSM identified by the lsmid in the call.
> 
> > Overall, I am still not convinced a syscall for all LSMs is needed. To
> > justify such
> 
> its not needed by all LSMs, just a subset of them, and some nebulous
> subset of potentially future LSMs that is entirely undefinable.
> 
> If we had had appropriate LSM syscalls landlock wouldn't have needed
> to have landlock specific syscalls. Having another LSM go that route
> feels wrong especially now that we have some LSM syscalls.

I don't agree.  Dedicated syscalls are a good thing.  See my other
reply.

> If a
> syscall is needed by an LSM its better to try hashing something out
> that might have utility for multiple LSMs or at the very least,
> potentially have utility in the future.
> 
> 
> > a syscall, I think we need to show that it is useful in multiple LSMs.
> > Also, if we
> > really want to have single set of APIs for all LSMs, we may also need
> > get_policy,
> 
> We are never going to get a single set of APIs for all LSMs. I will
> settle for an api that has utility for a subset
> 
> > remove_policy, etc. This set as-is appears to be an incomplete design. The
> 
> To have a complete design, there needs to be feedback and discussion
> from multiple LSMs. This is a starting point.
> 
> > implementation, with call_int_hook, is also problematic. It can easily
> > cause some> controversial behaviors.
> > 
> agreed it shouldn't be doing a straight call_int_hook, it should only
> call it against the lsm identified by the lsmid

Yes, but then, I don't see the point of a "generic" LSM syscall.

