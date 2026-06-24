Return-Path: <linux-api+bounces-6657-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FfzrHR9jPGp+nggAu9opvQ
	(envelope-from <linux-api+bounces-6657-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:07:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEB6C1DB7
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:07:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D+CioFwH;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6657-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6657-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0D2302975F
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 23:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D193B4432;
	Wed, 24 Jun 2026 23:07:08 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84626159E
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 23:07:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342428; cv=none; b=UxIts2qc7xZVvML3EcOElniIES0X0jkT+nzNpMQnRKvr9xJHp7XSkTYKZVCw4Js2ADPzCaqiECaHqLB6xLQRAFdCGN9HCaVbxu+JnNsXAjCxX+f3/CNs6Jye2fDtfjCqgwXmE/agoHUGCTYnC2rLpr7In2894eabJV9SvQiuD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342428; c=relaxed/simple;
	bh=dpDGPS+CbSXMjHrMq5m4eMoFsVU1+GvMNg12nCjgA6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRwvTbBkoI0NLv4E6xw+xJFQDfgMQFApF2lfg5FKPukzBJLSiXPP5fNzAuT80R++D8xowS6wqTMI7NDn/kVxGWYeUNtQ5RY2CR6CnnTD8Xl0ynRYhsltVJZ/5pYjFO7VhkoTZuI6tVwFMegROUkjNjOxG/kAd0LxYKe8dhTkqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+CioFwH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4091F0155D
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782342427;
	bh=Lqk0vUDZmRAN6Wkq/vMaSQtPAqbaSllRSJtlN1AeleM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=D+CioFwHNShCL36JNgds7zyG0Ct5oWjPbFP3i1u31776rBYS/pFEwQYZ5YXxJQU57
	 FftKbPxydVk/+5GHJvXVpnBLvr9iE+6B7h3U/few223Z/jT8//MsiewyJKNiswErSD
	 /DcUI4iEbFOZZd74jg/yrqP1QOEXCHEwruZkhRPbeW3TrJcmxPs12Syyc1+CLz9kSs
	 f2Xo6E29RLwXpKmScimBYkbh4axlU7M9LpagtpP+qowRXjCGgpnOMAOyRLH+7hjfvw
	 mm2/j9tA0/9BvislSRQCbY61xLbZslWeaphcsBLZu2z+8sz3RuECmr5XAyVXQmvn7Z
	 VcH5YDOT0P7vg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa5edf347eso1071599e87.3
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 16:07:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrEu0VckKLeoqpId7g+GVXzGmS54IwQbDqVVuU0ROo+N6+d3BCWijhXIh1jGuSoRq2u/vnZQtOTA8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9nXq3T91406Me5Qgo36jz1ipmBC0iwF9WTMAW6ALS/m0zx2U
	JW+02mHeCdkrqVRvQZBW5q4Cf+kH/GoeJaMPwYUP5Chlh+9T/Syz/0uoAljOrqS3IbliEytQ07E
	cRJH1Ljg1TqosyDlTEI7L6cvtAm4ENK4kSSVUcIXi
X-Received: by 2002:a05:6512:258c:b0:5ad:3a58:1bd2 with SMTP id
 2adb3069b0e04-5aea1f40f8dmr19888e87.3.1782342425655; Wed, 24 Jun 2026
 16:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
In-Reply-To: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 24 Jun 2026 16:06:54 -0700
X-Gmail-Original-Message-ID: <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
X-Gm-Features: AVVi8CdSDW0ba0Y4xuAHrcAmazhGgaHjA5VuAjrHJUgPlMDH6WiZlebtodOpUF8
Message-ID: <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	Christian Brauner <brauner@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, Sergei Zimmerman <sergei@zimmerman.foo>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6657-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[johnericson.me:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BECEB6C1DB7

On Wed, Jun 24, 2026 at 3:52=E2=80=AFPM John Ericson <mail@johnericson.me> =
wrote:
>
> Hello, I am hoping to discuss an idea I've had for a while, that I am
> calling "null namespaces" that has become more relevant with some recent
> other discussions. First I'll discuss null namespaces in general terms,
> and then I'll link those recent discussions and relate null namespaces
> to them.
>
> ### Null namespaces
>
> The essence of null namespaces is trying to give processes as little
> ambient authority as possible, so they are lighter weight and allowed to
> do even less than fully unshared processes today.
>
> Namespaces as they exist today are frequently described as an isolation
> mechanism, but I think this is the conflation of two different things.
> *Removing* a new process from its parent's namespaces unquestionably is
> increasing isolation --- no disagreement there. But putting the process
> in new namespaces is something else; I would call it supporting
> "delusions of grandeur" of that process. For example, namespaces allow a
> process to do mounts, have `CAP_SYS_ADMIN`, create network interfaces,
> look up other processes by PID, etc.
>
> Conceptually, to remove a process from one ambient authority scope (the
> very name "namespaces" indicates they are about ambient authority)
> should not require putting it in some ambient authority scope. Just
> because, for example, the process cannot see one mount tree, doesn't
> mean it needs to see another.

I think I like this, but some comments:

>
> Here's what I am thinking would happen concretely:
>
> First, the simpler cases:
>
> #### Null mount namespace
>
> - requires:
>
>   - null root file system: absolute paths don't work.
>
>   - null current working directory: relative paths with traditional,
>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work.

It's perfectly valid to cd to a directory that does not belong to
one's namespace.  We have fchdir.  What's wrong with letting it
continue working?

Regardless of that, the current directory either needs to be a
directory or to be nothing at all, and if we support the latter, we
need to figure out what /proc will show.

> #### Null user namespace

A user namespace is kind of about how *non-current* uids and gids work
for the process and how it perceives its own uid and gid and not so
much about what uid and gid it has when accessing outside resources.
So...

>
> - Process has no user or group ids

What does that mean?  What does ps show?



Maybe the way to go is to implement the ones that have clearer
semantics and to defer the others.

