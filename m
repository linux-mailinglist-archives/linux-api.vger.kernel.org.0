Return-Path: <linux-api+bounces-6709-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IsozEly1PWpo5wgAu9opvQ
	(envelope-from <linux-api+bounces-6709-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 01:10:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D086C91A2
	for <lists+linux-api@lfdr.de>; Fri, 26 Jun 2026 01:10:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VDVKKK7c;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6709-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6709-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 180693035991
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 23:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98F38550E;
	Thu, 25 Jun 2026 23:10:14 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFAD31F9BA
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 23:10:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782429014; cv=none; b=dALhizd4exYHc0YfUUZkKlwSPicFxJZO1x8/g3UEDkgSN7k46eejVEaXMBv25m7rcA2rG59RMLhhOiYyOLqhEiTMRJ1ejAFLGepoLihIyCGBFDwOdK5y9lH4EU4jOhGAYoJ5mYHGolynY5LlCs7RGRaIh68kGVrMjSSn8tYfGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782429014; c=relaxed/simple;
	bh=RivFshPEa3foAoC+Ik5bFickIujQglTHZsmL6g8UQTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ws1yOm1rMOf1r+vVKfK3VRhLIrY0PvkjPK7lYbJZt/MLiEfK8uLnMFQlYrb7jGHjy6bN0G0TOitJNgoq99JxCT027MzUgw4uAKNu5r526i6si4exFfbmjK1Tuq+cjTrYiABrwi2DNdRYnrA4REn/tlKyFe9WAoMhCyTgc5gyEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDVKKK7c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731301F00A3D
	for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 23:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782429013;
	bh=7wdojVO4lfNrrtrf+y6Y72fQrQM84chAKPF6jVlnuvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VDVKKK7czT9OG8eau4dHEFjAbOqFl3JHLQorAk7zEi1qzy5yPodHOE+tny8AJqaqp
	 9p2FVBQU9hJ/Uy+5iMDzXtf49P/pW9dELNLq7OY1MT5IgwTKpb4SdBGHxUG+Z5wrn0
	 KBZRTHUxKxpoFWl7aRQoAwfSkVe9cmUcLD5X1k4qH0x4ntycCiHqwTzps5xOmgMxxa
	 PbdeH/gVZdfUUnuvZPzyLqkbvWJAQO8xwcJlwOUd1wV4FjWqg2Hyf+FPtk01H0n45x
	 bZ4u4TRlr1gy+Qm70cn6GjNYajnGIQr8/9UnOgzRWcnDrhdPB2UhinduFh3g2fUNJT
	 DKFesUwNu3o8w==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aea517451fso281628e87.2
        for <linux-api@vger.kernel.org>; Thu, 25 Jun 2026 16:10:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoaurlEBwQV4IJRUssLdPxjZYitd1SItlNyb8p3NaLKSGKJCtRDgEMzNP+qTaB0ViOBo3LMjknRYxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDByZ06ntKHrEs7vdMbebEHa/sfPyeaia67rHuD6YNpGraOBG2
	wjYxn5i5wvGgQiBtKGQsOSSwEc9QQUmof0VziHJ/x0f/QQwo9CYLriWZqRuLobmevLieKWgla7A
	YIMJ79zUA4Xnqu2pJ6/GUTQT+Z6d4oP9iTMzJtACD
X-Received: by 2002:ac2:5689:0:b0:5ad:5308:c8d with SMTP id
 2adb3069b0e04-5aea1f4cc5cmr1616885e87.27.1782429011491; Thu, 25 Jun 2026
 16:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260624231219.GL2636677@ZenIV> <29cd3188-2d7c-4470-a39a-6648638f795e@zytor.com>
 <614b290f-e274-4eb2-b687-008b004de526@app.fastmail.com>
In-Reply-To: <614b290f-e274-4eb2-b687-008b004de526@app.fastmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 25 Jun 2026 16:09:58 -0700
X-Gmail-Original-Message-ID: <CALCETrWxi1g1wy2Bi4y6URW728Cmo8D3tchdMqs4GZ7S476iJA@mail.gmail.com>
X-Gm-Features: AVVi8Cen3kKGY39fZg-K6UFdMhU0KAGDW55tLH1dVHKank4s2aEYmav_eUhtxOg
Message-ID: <CALCETrWxi1g1wy2Bi4y6URW728Cmo8D3tchdMqs4GZ7S476iJA@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: John Ericson <mail@johnericson.me>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Al Viro <viro@zeniv.linux.org.uk>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, Christian Brauner <brauner@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6709-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:hpa@zytor.com,m:viro@zeniv.linux.org.uk,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[zytor.com,zeniv.linux.org.uk,linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8D086C91A2

On Thu, Jun 25, 2026 at 2:53=E2=80=AFPM John Ericson <mail@johnericson.me> =
wrote:
>
> On Thu, Jun 25, 2026, at 5:00 PM, H. Peter Anvin wrote:
> > On 2026-06-24 16:12, Al Viro wrote:
> > > On Wed, Jun 24, 2026 at 06:51:47PM -0400, John Ericson wrote:
> > >
> > >> #### Null mount namespace
> > >>
> > >> - requires:
> > >>
> > >>   - null root file system: absolute paths don't work.
> > >>
> > >>   - null current working directory: relative paths with traditional,
> > >>     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't w=
ork.
> > >>
> > >> - All operations relating to the "ambient" mount tree don't work.
> > >>
> > >> - `*at` operations with a file descriptor do work.
> > >
> > > Huh?  The last bit looks contradicts the previous one - if you have
> > > an opened directory in a mount from some namespace, those `*at` opera=
tions
> > > with that descriptor *will* be seeing the mount tree of that namespac=
e,
> > > whatever the hell is "ambient" supposed to mean.  Either that, or you
> > > will be exposing whatever's overmounted in that mount, which is a hug=
e
> > > can of worms.
> >
> > It seems to me that this is really no different *in practice* to having=
 an
> > empty mount namespace, no? You might still be able to stat("/") and get=
 a
> > d--------- result, but how does that actually affect anything?
>
> The argument against just having an empty, immutable root directory and
> calling it a day is the tie-in with a new process-spawning API discussed
> near the bottom of my original email. I want to have nice secure
> defaults, rather than forcing the programmer to remember to unshare, but
> I also don't want to degrade performance by speculatively creating new
> empty mount namespaces that might just be thrown away. Null fields alone
> get us both --- security and good performance.

This seems like a false dichotomy.  There's such thing as a singleton.

In fact, we have this spiffy nullfs_fs_get_tree.  It seems relatively
straightforward to have an API to get an fd to the singleton nullfs,
and the default for a newly spawned process could even be to have cwd
pointing at nullfs.

root is still harder, because of the shadowing issue.  I think I
proposed, ages ago, relaxing the chroot rules so that, at least under
certain circumstances (e.g. the task is not already chrooted) an
unprivileged task could chroot.  chrooting to nullfs seems like a
somewhat useful operation.

I can imagine more complex schemes to allow even a chrooted process to
safely start acting as though their root is nullfs, but that would be
potentially fairly nasty.  *Maybe* everything would work if there was
a root-for-dotdot and a separate root-for-absolute-paths, and
nameidata->root could point to the former, but I'm certainly not
willing to say that I think this would work with any confidence at
all.

--Andy

