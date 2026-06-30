Return-Path: <linux-api+bounces-6747-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJdNOJYARGqjnAoAu9opvQ
	(envelope-from <linux-api+bounces-6747-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 19:44:54 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C786E7024
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 19:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lVZMvhvp;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6747-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6747-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B8B830A2B9F
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1A43DDDDE;
	Tue, 30 Jun 2026 17:41:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD9366541
	for <linux-api@vger.kernel.org>; Tue, 30 Jun 2026 17:41:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841316; cv=none; b=CbSzTgQQQqJ+ekKwfamS+fh4OLIGDferKwZeBYS3Kmk7qGpl0xzaJZzJ1VtbapAk5NN21yMdjlmAg7sWF38G9TJD+QZwmEYOHDsnFMQS4+FadP23sEsKknWL4oy+eVJSdTxZrlcArzVcQKtd7iugbU+dg4om+Eh7KiyjAhwz6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841316; c=relaxed/simple;
	bh=NQdl1jXhBDSNriuKrZCDP2J5EVMaBjcrUPDyNxQxkas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxSKvy/3a1i6ZmGxtXCqHuut6YM6MYUlYs8gsLGyPjDeomLGPfOKN8FkEBA+yIMj9+3GvQmSB9Fbc7bDXc15CUlH0ZkE9UuGAIOqKOtfaPI13ya08EWNrHHvU/ejXl6JxfCczHq1Q0fLZYFedyhdV0J0EESQgSYcFrhiEfvhaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVZMvhvp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68061F00ADE
	for <linux-api@vger.kernel.org>; Tue, 30 Jun 2026 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841314;
	bh=+z2eGjaR2XxqSwoLqqHAijQCJxgnb5Yi71u88EQbJ7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lVZMvhvpURn9+NtmjNKAERttoqNX31ZVarA97fkTBGJSJ6MpjH6t/XbY80IiPe9zH
	 GwXC1kHsZGru7y48LMqOuYiZmhU1jCeyjzqeGS/jFuZopuVBDNI2NE/QDsyKhExrbg
	 rSIyROr+wetVzoPOwf+HsXVxUbAFj53tgF9EnIJq3Na9W49/yScbAchtXzGQTcUnEa
	 614RvhH+qDIkhA8nvM8FqFZC2wgPInnJUK04NdV8YKWuAPA89LiNODg7ts6+MHpB+r
	 fU7p5eDgDSbnvdKDjDO4qYzhCuchS/J4lUI8oYfXevy4EyttOWBAj7u7/PzC8d2OUF
	 YmzyLKMK6jHHA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aebae2f310so1804442e87.3
        for <linux-api@vger.kernel.org>; Tue, 30 Jun 2026 10:41:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqtZeXn+aeV9boVM+5k5SI1mSUH1PEbTIyCPk9/s9e1QzJrU0im8YJ6wNbMinRNesDDifZ1ui3v55s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhKQ9FvqJCi/5yaHmDQCyr7TW9Vf7roSLjJmkvUye160/XyQS9
	fV1B+qE8PiGbqhvKI5a33G2esgKWn4KJhCHsx/Cpz67Jxu8VeSNXGEeKIbNLQ/sk4ETgpHqLgvc
	KZabzkXB1oZyJSOGc5RxSd/IomKXSOVZJjR0CqWuN
X-Received: by 2002:a05:6512:1352:b0:5ae:a969:be90 with SMTP id
 2adb3069b0e04-5aebdb9dc40mr1241023e87.25.1782841313034; Tue, 30 Jun 2026
 10:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner> <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
 <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner> <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
In-Reply-To: <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 30 Jun 2026 10:41:41 -0700
X-Gmail-Original-Message-ID: <CALCETrV8T3KOWgjZL6wy2j7E+Y6zOjfN1aCDsVH4PadvE+yxSw@mail.gmail.com>
X-Gm-Features: AVVi8CeUBlWGEkjHdS5BeIIzHXmtA_f4D4jT5R2_iP12sFg1FBcaLKf8siZYtr0
Message-ID: <CALCETrV8T3KOWgjZL6wy2j7E+Y6zOjfN1aCDsVH4PadvE+yxSw@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: John Ericson <mail@johnericson.me>
Cc: Christian Brauner <brauner@kernel.org>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch <linux-arch@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6747-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:brauner@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[johnericson.me:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38C786E7024

On Tue, Jun 30, 2026 at 10:20=E2=80=AFAM John Ericson <mail@johnericson.me>=
 wrote:
>
> I'll throw in the towel after this email, I promise :)
>
> On Tue, Jun 30, 2026, at 3:14 AM, Christian Brauner wrote:
> > I think Al is about to have a stroke reading this... and I might too.
>
> Hahaha. Alas, C does have a longstanding beef with discriminated unions
> --- I can't do anything about that! (Well, other than wait 15 years for
> this stuff to eventually be rewritten in Rust, that is ;).)
>
> > I agree with the sentiment
>
> Thanks, I appreciate it :).
>
> > You know what the easy solution is: don't allow a struct path to be
> > empty...
>
> Just so we're clear, my quibble here is purely behavioral: the nullfs
> directory can be opened, right? And that open directory can also be
> getdents64ed (yielding no entries, since it is empty), right? If I am
> wrong about these things then sure, no objections from me --- let's ship
> nullfs FDs right away!
>

Christian, how would you feel about a variant of nullfs that fails all
operations instead of acting as if it were empty?  (I'm far from
convinced that this would actually be better, but it at least seems
pretty straightforwardly possible.  And obviously the
nullfs-at-the-root-of-everything would not want this variant.)

> My reasoning for being a bit of a weenie on that behavior is just that I
> think "fail fast" is good. A lot of userspace programs crawl the file
> space pretty willy-nilly (e.g. they are doing some caching thing, or
> they are looking for something, etc.). I suspect the nullfs approach is
> going to result in more "red herring" error messages and google searches
> about "why can't I write to the working directory, not even as root"
> etc. I just think "no directory" vs "immutable empty directory" sends a
> clearer message to userspace, and will align mental models more rapidly.

This is the difference between a greenfield project and working with
existing designs.

If I were designing an OS and its entire API from scratch, then, sure,
the cwd and the root directory would just be well-known items in a
capability table, and they could be absent.

Linux's implementation and its API are not greenfield projects,
though, and it seems pretty silly to try to make this change.

--Andy

