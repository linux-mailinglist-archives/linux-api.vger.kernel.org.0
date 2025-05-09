Return-Path: <linux-api+bounces-3733-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598ACAB1091
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 12:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9497A1F2D
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402728F53F;
	Fri,  9 May 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="BglxVlNw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159628ECF1;
	Fri,  9 May 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786359; cv=none; b=IbEu+3nmblgBLnUthTrwjnxavQvdj6cLmd4kV1bpqDy/tDjvLKIsm7g0TtFSYyVmRxjhXLwKMefGo3Kb6YrldKfPS+F1zHb4ufrihmog6Kbhd0baW+WUrkZrgfHu8qnO1oJdqcXNSzABId6XRgCQRUdiQFvnlr7qN9WjhUE0M+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786359; c=relaxed/simple;
	bh=OxS6DvXO+8eOgjDfLvGYh6+wk4bWROUD7iORRi/rAiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Go0k2Ft8uO2So0Yk/iFSZLXj4aM9QnGfTPDZP6KUAdv0/C6MOhYUqL3O9qxnk1xbYOp2Wr4PnOzTHovT3ia+IWpwJmpKzKb9P2x9uujyEzPCHVWDziP5gT12gd510lLQRpZsC1tVwTj2e/2MZh6/5dw6/I15nwPFrnisOkOiFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=BglxVlNw; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zv4s60c9lzS2f;
	Fri,  9 May 2025 12:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746786345;
	bh=4jbXzsKP31lmI+uQkAYIeHsAd5eM2lwzdOE3RMFxOd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BglxVlNw/7xX6TzIN/a8/DV3S9+llL38b1bd92BHaA8Z3qQP5MPWOw30Isq9q2K7M
	 X0FWucBkQykudH9+ttgDoP9YGEv5oR93F80x1EMKJCAt6WOvzxrN7gAkKyRaAKcVC6
	 U1vV0tYgVz4akJSECfuBFJibHzvqqFzfjPFJxGyw=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zv4s36FSSzCvl;
	Fri,  9 May 2025 12:25:43 +0200 (CEST)
Date: Fri, 9 May 2025 12:25:39 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: John Johansen <john.johansen@canonical.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Maxime =?utf-8?Q?B=C3=A9lair?= <maxime.belair@canonical.com>, Song Liu <song@kernel.org>, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	kees@kernel.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
Message-ID: <20250509.bokeiCho2oov@digikod.net>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com>
 <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
 <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
 <470689f0-223e-4d26-a919-8d48f383883b@I-love.SAKURA.ne.jp>
 <7da224cd-fd9c-4c80-9a23-cb977420f50b@canonical.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7da224cd-fd9c-4c80-9a23-cb977420f50b@canonical.com>
X-Infomaniak-Routing: alpha

On Thu, May 08, 2025 at 12:52:55AM -0700, John Johansen wrote:
> On 5/7/25 15:04, Tetsuo Handa wrote:
> > On 2025/05/08 0:37, Maxime Bélair wrote:
> > > Again, each module decides which operations to expose through this syscall. In many cases
> > > the operation will still require CAP_SYS_ADMIN or a similar capability, so environments
> > > that choose this interface remain secure while gaining its advantages.
> > 
> > If the interpretation of "flags" argument varies across LSMs, it sounds like ioctl()'s
> 
> yes that does feel like ioctls(), on the other hand defining them at the LSM level won't
> offer LSMs flexibility making it so the syscall covers fewer use cases. I am not opposed
> to either, it just hashing out what people want, and what is acceptable.
> 
> > "cmd" argument. Also, there is prctl() which can already carry string-ish parameters
> > without involving open(). Why can't we use prctl() instead of lsm_manage_policy() ?
> > 
> 
> prctl() can be used, I used it for the unprivileged policy demo. It has its own set of
> problems. While LSM policy could be associated with the process doing the load/replacement
> or what ever operation, it isn't necessarily tied to it. A lot of LSM policy is not
> process specific making prctl() a poor fit.
> 
> prctl() requires allocating a global prctl()
> 
> prctl() are already being filtered/controlled by LSMs making them a poort fit for
> use by an LSM in a stacking situation as it requires updating the policy of other
> LSMs on the system. Yes seccomp can filter the syscall but that still is an easier
> barrier to overcome than having to have instruction for how to allow your LSMs
> prctl() in multiple LSMs.
> 
> 
> Mickaël already argued the need for landlock to have syscalls. See

Landlock indeed requires syscalls mainly because of its unprivileged
nature.

> https://lore.kernel.org/lkml/20200511192156.1618284-7-mic@digikod.net/
> and the numerous iterations before that.

This link might be misleading though, it points to an initial version of
the syscall proposal (v17) and it was then decided to create one syscall
per operation (v34), which is why we ended with 3 syscalls.  See the
changelog:
https://lore.kernel.org/r/20210422154123.13086-9-mic@digikod.net

> 
> Ideally those could have been LSM syscalls, with landlock leveraging them.

I don't agree.  The Landlock syscalls have a well-defined semantic, with
documented security requirements, and they deal with specific kernel
objects identified with file descriptors, including a dedicated one:
[landlock-ruleset].  For the features provided by these Landlock
syscalls, it would not have been a good idea to reuse existing syscalls,
nor to rely on the syscall proposed in this series because the interface
is too specific to some of the current privileged LSMs (i.e. ingest a
policy blob).  Making this interface more generic would lead to even
less defined semantic though.

> AppArmor
> is getting to where it has similar needs to landlock. Yes we can use ioctls, prctls,
> netlink, the fs, etc. it doesn't mean that those are the best interfaces to do so,

I think it would make sense to propose AppArmor-specific syscalls.

> and ideally any interface we use will be of benefit to some other LSMs in the future.

The LSM syscalls may make sense to deal with LSM blobs managed by the
LSM framework (e.g. get/set properties) when the operations are
common/generic.

Security policies are specific to each LSM and they should implement
their own well-defined interface (e.g. filesystem, netlink, syscall).

The LSM framework doesn't provide nor manage any security policy, it
mainly provides a set of consistent and well-defined kernel hooks with
security blobs to enforce a security policy.  I don't think it makes
sense to add LSM syscalls to manage things not managed by the LSM
framework.

