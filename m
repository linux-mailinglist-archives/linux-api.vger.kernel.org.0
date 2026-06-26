Return-Path: <linux-api+bounces-6711-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A/eIOzs6Pmo5BwkAu9opvQ
	(envelope-from <linux-api+bounces-6711-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 10:37:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E01E6CB680
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 10:37:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VuQ4qUsx;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6711-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6711-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A255A303FF24
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5E3E3D96;
	Fri, 26 Jun 2026 08:27:55 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8F3DA7FF
	for <linux-api@vger.kernel.org>; Fri, 26 Jun 2026 08:27:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462475; cv=none; b=hBeXgFNJdcpXrKdYWGHwsSWoWs24a1RJnXZOO+K61W9XFjcJeQVlaY/iBZ4S6Nw78TA4DXdcLfXKKFc/pOJLOYdb436/Obsytq0rEopYmulgYJYwoC10KeMRamk4/W8H/yJF1izYVVp07ANDaTyFUHJbUHn3icrqd42zs6DeywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462475; c=relaxed/simple;
	bh=zuf6ntfPTW462871MTn9iuX+pcWTpeY3OFHEjvBsUmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JkmvjcEo5nn/PS8suS9gyY5JfpW7fMouDt/7LqKk8l+nPtURi9+Ccq8x22IrjckFcqQClJkJMRHixf0bDWQemNR8Wu0ShOjbxk84sx0YgP86rLN3p9BOPhlPw3lWvA2W40YqSnO6a7WhgLzLCCp9ypUDIRjX/jtncAbICjjFHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuQ4qUsx; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49249707788so5928155e9.2
        for <linux-api@vger.kernel.org>; Fri, 26 Jun 2026 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782462472; x=1783067272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPblrGuL3HxTSPqhVNEf1Cuy4s+Ns4aI9V32Ls67imw=;
        b=VuQ4qUsx+cWNoimp2j+KEaMlEKsx6J7flpPXu/uCwRBlS0LPFCUDyGnk7Gd+EYk9aK
         il+5lgu0N+dhbh64JNF1FfVDtWS3EOwTEA7DPSBJLw4BKDTzHPemP0Ftf8FYZ614/Jzj
         EV+p0wKefRVA4EmFLrodWBZ6RH4EIEPFk8FFaB0sj8lv1XPVSsRZHAmK1UUlwhfMS3Hh
         2UFDsQO2vE9BJnHHbtGy9jViDAA5bvUgoTRby3xLcZd0H2kiVCxIFEfhUqU3se/4uz9y
         GMK8uPvMfIe+TXIeaRokXSiOP7QsSUU99yzH761XDm0a5/HuSdgbW3QCYffChpozoLLO
         TApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782462472; x=1783067272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPblrGuL3HxTSPqhVNEf1Cuy4s+Ns4aI9V32Ls67imw=;
        b=kh+tcE2W72RmnPpuHSvTKKH7mXR2chJME3R66oJETs2bPZsxp9y+JMK0qDG9YJxxwH
         5wZHWnGAafNV/6cqV9bULPV7SjwHWa60PqbMjR7QOvW4roX1ZCDRU3PX5nNwi7vh61Wk
         TMLsvgmwUWUR4JmGq+PfkZkPq3Hr155cTjnDreRIT0ti3GuFIJdctrJOYdWaKWayZqo3
         EFKSx1vL4ZBEqS5E+QiJiSPRh0KYGMhZw3kXs0f1w2ZfloMXOUisgkKHTqrj8odqNeq8
         vO228w7HKmTQJxa9aIJze4Zz2Yfi4LoWtQIQp5BzPrgTGEOq5gGXOgMRUqYj0idXCkMD
         deSA==
X-Forwarded-Encrypted: i=1; AFNElJ+LwSBiruO/NE8O9WoHOMBZ9zrO93Dr9skjNYPh7Cs7i0AeEnTL5yR7SDf2u+hHCsujROSHwFIwEKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkHVbtcECJvfGTc1xxdt4ZUxMlR/4dCIOWqZZkuArswrXv/45g
	cbG48OBQUwb/uyJLwbBfwaWvFbWIEu60dyhEoG5zEWGoKDbc7j+cWO73
X-Gm-Gg: AfdE7cltpfCJkp9aW4o/gLnQjzwAWHKBch+7ROhU0oz0CLaVZavH/aohgC5tivXMFSM
	16ZwmtUPnt720uOtvkrbFvIBDACH5XU8x9v+T6kxlf8SDABDFm5M4enVGLbMp+lL8+pLI6LhZau
	M/k4mE3SktLIJVtXMSeVCBtq8+WFTRubFu2VoVEnTm3rD+iBckiDzrfLL+3qBJrhMfPatMfOuP9
	LYBQqKqAbI/87QXWAMKYbylYBVlFcPcytl9Ajc105A3a1hSxF+WfK8YuQEO5UIPmyzQVdvyQFcF
	+ACokp/+pp/+sI0AkmjI7m+XjbRKJquO73QrMq5F+oNhyUDDNw68+DxkcR/cs74mCtDos/wFyLV
	UlIRu/8qb9PgT/SVi6k47n97sv8yrPIUzKyM/4/WCQoIhd5mvKLX/paGL2gVISxY5r6KqIFzx7s
	lZjSS57EWZGfPMqBy/d8MQWuqcfX8B0uc+UT7fCnx15fTSdK8+ug==
X-Received: by 2002:a05:600c:6094:b0:492:63c3:8eeb with SMTP id 5b1f17b1804b1-492668aa8b7mr81702715e9.35.1782462472357;
        Fri, 26 Jun 2026 01:27:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fde98csm65311585e9.6.2026.06.26.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:27:52 -0700 (PDT)
Date: Fri, 26 Jun 2026 09:27:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: John Ericson <mail@johnericson.me>, "H. Peter Anvin" <hpa@zytor.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Li Chen <me@linux.beauty>, Cong Wang
 <cwang@multikernel.io>, Christian Brauner <brauner@kernel.org>, linux-arch
 <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api
 <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Jan Kara
 <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, Sergei Zimmerman
 <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260626092750.58a8de9c@pumpkin>
In-Reply-To: <CALCETrWxi1g1wy2Bi4y6URW728Cmo8D3tchdMqs4GZ7S476iJA@mail.gmail.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
	<20260624231219.GL2636677@ZenIV>
	<29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com>
	<614b290f-e274-4eb2-b687-008b004de526@app.fastmail.com>
	<CALCETrWxi1g1wy2Bi4y6URW728Cmo8D3tchdMqs4GZ7S476iJA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-6711-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:mail@johnericson.me,m:hpa@zytor.com,m:viro@zeniv.linux.org.uk,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[johnericson.me,zytor.com,zeniv.linux.org.uk,linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,johnericson.me:email,pumpkin:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E01E6CB680

On Thu, 25 Jun 2026 16:09:58 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Thu, Jun 25, 2026 at 2:53=E2=80=AFPM John Ericson <mail@johnericson.me=
> wrote:
> >
> > On Thu, Jun 25, 2026, at 5:00 PM, H. Peter Anvin wrote: =20
> > > On 2026-06-24 16:12, Al Viro wrote: =20
> > > > On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:
> > > > =20
> > > >> #### Null mount namespace
> > > >>
> > > >> - requires:
> > > >>
> > > >>   - null root file system: absolute paths don't work.
> > > >>
> > > >>   - null current working directory: relative paths with traditiona=
l,
> > > >>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't=
 work.
> > > >>
> > > >> - All operations relating to the "ambient" mount tree don't work.
> > > >>
> > > >> - `*at` operations with a file descriptor do work. =20
> > > >
> > > > Huh?  The last bit looks contradicts the previous one - if you have
> > > > an opened directory in a mount from some namespace, those `*at` ope=
rations
> > > > with that descriptor *will* be seeing the mount tree of that namesp=
ace,
> > > > whatever the hell is "ambient" supposed to mean.  Either that, or y=
ou
> > > > will be exposing whatever's overmounted in that mount, which is a h=
uge
> > > > can of worms. =20
> > >
> > > It seems to me that this is really no different *in practice* to havi=
ng an
> > > empty mount namespace, no? You might still be able to stat("/") and g=
et a
> > > d--------- result, but how does that actually affect anything? =20
> >
> > The argument against just having an empty, immutable root directory and
> > calling it a day is the tie-in with a new process-spawning API discussed
> > near the bottom of my original email. I want to have nice secure
> > defaults, rather than forcing the programmer to remember to unshare, but
> > I also don't want to degrade performance by speculatively creating new
> > empty mount namespaces that might just be thrown away. Null fields alone
> > get us both --- security and good performance. =20
>=20
> This seems like a false dichotomy.  There's such thing as a singleton.
>=20
> In fact, we have this spiffy nullfs_fs_get_tree.  It seems relatively
> straightforward to have an API to get an fd to the singleton nullfs,
> and the default for a newly spawned process could even be to have cwd
> pointing at nullfs.
>=20
> root is still harder, because of the shadowing issue.  I think I
> proposed, ages ago, relaxing the chroot rules so that, at least under
> certain circumstances (e.g. the task is not already chrooted) an
> unprivileged task could chroot.  chrooting to nullfs seems like a
> somewhat useful operation.
>=20
> I can imagine more complex schemes to allow even a chrooted process to
> safely start acting as though their root is nullfs, but that would be
> potentially fairly nasty.  *Maybe* everything would work if there was
> a root-for-dotdot and a separate root-for-absolute-paths, and
> nameidata->root could point to the former, but I'm certainly not
> willing to say that I think this would work with any confidence at
> all.

You'd also need to sort out the 'pwd' mess.
The kernel inode always has its real parent, inside a chroot the scan stops
when the inode is the same as that of the base of the chroot.
But faf about with namespaces (IIRC I was doing an unshare to get out of
a network namespace) and that comparison can fail (if the chroot base isn't
a mount point) - so "../.." can go all the way back to the real root rather
than stopping at the base of the chroot (as you would expect).

	David


>=20
> --Andy
>=20


