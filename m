Return-Path: <linux-api+bounces-6660-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r0JIBjFuPGrNnwgAu9opvQ
	(envelope-from <linux-api+bounces-6660-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:54:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46606C1EC0
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:54:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=HXcDlgan;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="H HcKeJG";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6660-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6660-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B163C302867C
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 23:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FDD2F8EB7;
	Wed, 24 Jun 2026 23:54:19 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA8283C82;
	Wed, 24 Jun 2026 23:54:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782345259; cv=none; b=tr/fvitXN+uzmvUEXP4bzFBELmt2vkm4sOWtmQVbXXJtlO4fSZg+ZWG3v+4lGfpfabzccQoWkwvlDD8KDsxP5wt4Gjx07PQEmKSa49C3fZRTmY+DWIm0q9b6U5sYr5rtixIlURNlop57pkgBJ2jyOt5HgI3u+yCsMwCVgiiOS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782345259; c=relaxed/simple;
	bh=P3V2Uu560/1MtkRyRTXZ1LEwW0Db5QL8/+RbA+s9aug=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hTFYf1Tj4N/XJvvCeomxUiErZKyXLFyf6ed77VUziury3t6biCgBYC90ZX9rojfZkqiP/eVp4FhOcBP66QWjeH/mUmoCPPybi07z4gvEeW4KOoAQIrMviRd/Bawcgvj0e+c56xxuzgSU0Gnzby9t/WaRbENO+EJVKq/WJBRYRvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=HXcDlgan; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HHcKeJG2; arc=none smtp.client-ip=103.168.172.137
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 263FD13806A6;
	Wed, 24 Jun 2026 19:54:16 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 19:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782345256; x=1782352456; bh=bW19RR8Jqkyd81tn1P+0gV7Cr4ti6wEP
	w6guMpo8Wrk=; b=HXcDlganrojg0fNjK9UoU7zJZVLvUEbKzUS8cBwWYnyuMllM
	yi+h77WYUss19m4u5XaNsaV5WPyZTY79giTjt3WchH86wHmbp+7WecP9SN9A+olL
	CMuRLjFQdQ5qqAS4B4S7OzaAxz5Tsqpzp6F/QesT743elK4gxzwq9eQZED/Mj857
	ivLoEutZ9iI0cfHTvnEzfGI2FCzETqiZd9bPMzGCrMM/9K6PwoFBNiAhawGUc4bj
	I97GASlcsoTPVdVPtWW9zz47ZX9gxpzSSQ10ykXOhe31E1UA05VFydWF0VzUnSfN
	nagQtY7F5JHw1mBzSzk8AKO3eiBgOi/9MBfjvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782345256; x=
	1782352456; bh=bW19RR8Jqkyd81tn1P+0gV7Cr4ti6wEPw6guMpo8Wrk=; b=H
	HcKeJG2D2WRhbPIPiPUVbO34VDkYtggLbai9mKYjFXySM/TWDPIB4yRMBBc8Hq6s
	M+rFEOS4iQHakW1mnY2xOK1j6siW3T2udtJfu6EtlZhAJAItc3/bkdUfd3dl7lFV
	9hJCveV/evVkw9OAe00MhQuSxaBNtG0J+TWXNt1nxI6ukOuTvwY+nrNchn2xNGMf
	s/alko7tgODleOSt5KmjnGKYBLOKA0+qq0PEoY080tyTkPUBThvtw6FQ7c11GOG9
	ou8DJZDlZ2mCwmAeCHwUs8fgP7z5RBY2sMs3j9hfdTr9bj3xAIFSTLS79w3mbnTM
	qf1P5lLc5kEGBUo8C7GJw==
X-ME-Sender: <xms:Jm48ajPXyaqm_kEsQfFOl9jgPCtPF64Qka-XPvTKVeN46SvEhbQvDg>
    <xme:Jm48aoxG24dYQpSFeFa1AJLVwKosiYKidBopXpy_plfpX8RiDy1p8l1F4EBClZpSd
    mWkjEMxHznPTEqgQWljlsnQYsFfDREZZemXdrxPr2Gu0CQJHtX8YxQ>
X-ME-Proxy-Cause: dmFkZTFwp32v586PIguACgskVA4TkYoZNHqAgUJbUnYjwysP/ZqbHPxgOgNBEi3ca2Iqpw
    YOieO595pzpydEUoO/DJRdN1EWzKeLS6d9VDgR5/ECeg3D31eFX0h+7w4LeeoZYHvlPhf6
    7LL8ugMUz2NPX3VAzEw/oZtjJj+JYh4vdxlzYVxhn7eVcZ11tZFie78yUxN8ks14AlsbGS
    rzH08vEwmH+zNN3Q1g2f7fW4y/lsS74VTujX7Csg6y17HelZR/BV1X90pywJzqxJCgTeTq
    BrLnInJV9ZzmZdAIewa/uvpvAJAzM2tKoNUeSbHcsJt8ZeT9rVZ0Hx5C84P0UoM/3Jt3Vp
    JmIj4Q2O+jk7oby+2cKwOklSmPsH6nUKyhidPkrK0H8GOJpKXlBE/kj4H9ntM4LNC6kCU8
    g12soyBlouSaIpHMqsvtxN/QwoSMq5jnnpM7F5sEOIkQQ9vHZbAIUqjJgryqa0sAF7W2UF
    hnZ2yA/gscbsCKTp/2RQzFzbq/0pJDybzVhYmDOutzhu8sJq19jxO1sFtQ7kfbdvfNtOoX
    DRrtrBdDHCJlQ/PoWIVJ+wcC/tWUD262/XHGm23xSl+QvmQxIR2YWBPq8eeWgd9JiTBAkB
    +LRKmedstxopUyrlaoZuLNB2/yrm5j5WqFawyyLiogsP40Oxqfd8YzLha5/A
X-ME-Proxy: <xmx:Jm48asCjJFfi3y51qgt16JG9kfIjCSSvh1cyhbsrdpt9zGPN3ktWog>
    <xmx:Jm48agJAgZCQ7w0GoRO3zqdmpCmNvFZdtYw30WRvYogLu69c0ikSFA>
    <xmx:Jm48ajryI8sBOY2_CgS1QTh_yN6ImMWJ1XqaLeGezO8Ias9KzSo29w>
    <xmx:Jm48apPldymAdJTVYe1zjld2sSF1GHt1DNT5UcDFcxzQGPcqdn7eqw>
    <xmx:KG48ajCXJ3_afeNl5o1AIhLSzKU98sN3XwNK808BvyiRJU4od9TAcsQz>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E827B2CC0083; Wed, 24 Jun 2026 19:54:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Wed, 24 Jun 2026 19:53:53 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Andy Lutomirski" <luto@kernel.org>
Cc: "Li Chen" <me@linux.beauty>, "Cong Wang" <cwang@multikernel.io>,
 "Christian Brauner" <brauner@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Kees Cook" <kees@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <103524f8-1658-41df-88e9-cf49c628a721@app.fastmail.com>
In-Reply-To: 
 <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
 <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-6660-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,johnericson.me:dkim,johnericson.me:email,johnericson.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C46606C1EC0

On Wed, Jun 24, 2026, at 7:20 PM, Andy Lutomirski wrote:
> I think I like this, but some comments:

Thanks, that's really nice to hear!

While arguably this is just the culmination of a direction Linux has
been going in for a while, it could also be seen as a very "out there"
idea. That at least one person likes the rough sound of things makes me
feel a lot better!

> On Wed, Jun 24, 2026 at 4:06=E2=80=AFPM Andy Lutomirski <luto@kernel.o=
rg> wrote:
> >
> > On Wed, Jun 24, 2026 at 3:52=E2=80=AFPM John Ericson <mail@johnerics=
on.me> wrote:
>
> > >   - null current working directory: relative paths with traditiona=
l,
> > >     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't=
 work.
> >
> > It's perfectly valid to cd to a directory that does not belong to
> > one's namespace.  We have fchdir.  What's wrong with letting it
> > continue working?
> >
> > Regardless of that, the current directory either needs to be a
> > directory or to be nothing at all, and if we support the latter, we
> > need to figure out what /proc will show.
>
> Thinking about this more: I think that handling CWD might actually be
> a prerequisite for the series and has little to do with namespaces.
> Maybe try adding, as a standalone feature, the ability to have a null
> CWD.  Define semantics and see what the implementation looks like.
>
> Then, if you add null namespaces, you could optionally make
> transitioning to a null namespace set a null CWD.  Or those features
> could be orthogonal.

Hehe, I had the same thought after working on the filesystem patches,
along with the analogous thought for the root filesystem. It had been so
long since I had done a `chroot` without also doing a mount namespace
`unshare` --- despite the former being much older --- that I had
forgotten this separation of concerns.

My apologies for forgetting to include this insight in the original
email.

> Maybe the way to go is to implement the ones that have clearer
> semantics and to defer the others.

I would much prefer this, actually.

I wanted to discuss a bit about each type of namespace to indicate that
this is a concept I think works across the board --- it wouldn't be such
a good solution for the process spawning API if it was only applicable
to some but not all namespace types. But the truth is that I have
thought about the FS cases the most, as I think you have picked up on.

If there is interest in landing

  1. null CWD
  2. null root fs
  3. null mount namespace

in isolation, and then returning to the other namespaces to iron out
their details, that would be fantastic. It would be much nicer for me to
get some momentum that way, without having to design everything all at
once first before getting to implement anything.

John

