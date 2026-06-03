Return-Path: <linux-api+bounces-6526-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XtT8Ih6xIGoV6wAAu9opvQ
	(envelope-from <linux-api+bounces-6526-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 00:56:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51A63BB0D
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 00:56:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownmail.net header.s=fm1 header.b=Apr2ZnQC;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="F sfUp8M";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6526-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6526-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ownmail.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C298B3008FF5
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC2D4A2E0E;
	Wed,  3 Jun 2026 22:56:23 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E83D47D0;
	Wed,  3 Jun 2026 22:56:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527383; cv=none; b=Y6vsNBlY5oIb/HqAu5j/PfnhE8mhtxCR7J4r8f8d18l2lDso6273pIgLsm1qPNtl8VdzhpfSi20J67sXvjBolonirqbwE6bdYqJbJjkcAln5IpXFoM7ABTpVvKssbjw0nSrAGm1LqU8f3AVispBBuX+AxMgtgcmJ0DxHWcpACW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527383; c=relaxed/simple;
	bh=AtoLywmkm8/FMNLl1ZknpqesNH2sKddjCkBb89SUr8I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=RwZLrP9G72UTs6lGNiezrkSR416mtFQngQoYY6h54/LDKbACxJB56lGDxdnSZbKQu6kLEgEaEoICKVKgi4Cl0b7C9lJ7ddd1m/pu+kFzEr+xfrJ/dQYvtkHlbmZXb5h+/ALlzRk6g6FrHl7wgoNACbOYeKx1F6njEG6yRu1bc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Apr2ZnQC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FsfUp8MG; arc=none smtp.client-ip=202.12.124.144
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5403E1D00044;
	Wed,  3 Jun 2026 18:56:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 03 Jun 2026 18:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780527381; x=1780613781; bh=a5CZr3XaKhzFY2nfmXPaNYzwALzIIcMg4Es
	oDZpKyMA=; b=Apr2ZnQCcH9EdiwUw7P+yt7lwemVeSOdfkjw8scNzkm4fDdNZrK
	1bfiJD9ktIsPOkt0Uzz9B6bNilVouw4YgOMRxt6VtfXYJZ+Ju9vD04T0R7pZ2QHO
	zVHF11PGPxtCArcU6954I9U59Azoj7Y9uIJGVaf16q1kVWHiPj0yVNvRROLNCmiJ
	9r61f9PMsbB97TZBz6FzG5t5aOlHxmJbDmtE4bsDKJzSYsWrWfy39IQwBa7KsCPR
	Gbr+Pm9hxuj6LDdu5CnqTWesPwBNxNST1YQRudOZkvDKNet5J/2QTWwN19UYzXl0
	WETEH6WQB2pHCgugcHjvV/upGjOHnGmNR4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780527381; x=
	1780613781; bh=a5CZr3XaKhzFY2nfmXPaNYzwALzIIcMg4EsoDZpKyMA=; b=F
	sfUp8MGZLMUomWcoKo3VNwv/yGVGdVnx5JFFZjUwTVj4XWY8q6n16sANpf6kaqjh
	cpLGxblk3gAEchjYY1JO8Ix6OLKBHf+YtvU1YDorSBEMfm2DGrwyeS9WgNst2ExD
	R2GuHW/y6QdXkvW022y4vBPf61VxUP/KMWRvpaB1B4G9YqJVn2+1YsdNtt1gH6PU
	m8rjdlDKJo9GpEc74bfxb+qi76+irNlKJ5E96SUUq+aikrvrCUZ6K7jzqcLE/mOe
	dipicYovXnQfzx217bZSL/CVz7sZ3vmRW0rbmt7bsbv1OSkaHa/zW60FvHFG/o/v
	ULXiuaF9RmjdSdkVqrsTg==
X-ME-Sender: <xms:FLEgauP3okRVEBKcxDlbxuR3kmXhzAE0yC7j3dklsZWqL1O-i1PRsQ>
    <xme:FLEgagB_0jP28z3zKFBtCzfTq_SUF-0mxLYsJ6Ftm3JKGY7G5j_u0roIXhZ-zPSr9
    SxGyhTGuC9hkLIP5tK9v6-CQX8dM6nNaPc6-RWc7hm4467PvmY>
X-ME-Received: <xmr:FLEgav7q1547NIJp_aAiXBFYuFaMaeBXrbw6-QogmnS5-7T5KEx0UAKS-KwdN-9RSvA6WxgLgYozKQvMTzZCIOi56bitaRo>
X-ME-Proxy-Cause: dmFkZTFyqTTXsgmvOmZzY2p2ynkvACEz+xIOiYgtbZbCncJuFOH7Yuq+DnHnd5zKrkmR1K
    0ek2EqkUw24MnDt043g3+TQZVrpZBk8uDiTQvkQ6Z6i7aarv/Zmm8xbYd9KapYQ7QPgjnL
    5IP8p8JZMV1GYA0MaeQzxJCyr7lG9QzbExLqXxmh6QENqAS2QHqIVvYazv3hrOBZ3k/JjN
    ndwSEHusY1CWD97xYFUk6X5UamxDcCIflSe/qva2l/ufIRcgOYnEO6qB+9K2CtHQnP7zUb
    qGthh6HXmmzc7yP0shfLQZyLX+cK26eHPUZXLNS5QZrzu+w+vXF/CeM9CdYsRHO/1ebqpz
    uVi/LfFMSoHw/VNCXdYp9v1TOjMF08lYWYzE3CA0gQdOsjRY7CmOFKHHoUJSqnXYjtkARn
    qVyx/kvNC/rgSAiEBwqEl7tP5YhOsKujJhePVCr/StJsJ7WiT5fFg8PmrD911zeU8nHpFp
    UACRs7BauDZQeOvJCRRU9Idn+bqT5NjhUNHUKfp6PBfrZl2U7g3q6JLVmHCCNGRZfxIJVc
    UoFEA9o+323LPJYk1HBZnHJ7ntJ9yj/RqRqMMW/BMRMtbyC8zWUphLD+wGxPAUP+Z36KvL
    68tZeWgtWr499LGuCoO42R1auLalb6tbgghzWmgqaEnXYwi3e0SBMJlVDZfw
X-ME-Proxy: <xmx:FLEgaq65OV4pjKyDJ38TtGS-D0rux270-U2zpFvQkhKm6M43SDyR7g>
    <xmx:FLEgahTMjp9p8GwBlBstIYG0ubK3QjM4WtCuuaZsjR10chi38W97PQ>
    <xmx:FLEgai_tCHhNoctdw4S7U4LwvhQlvRAbsaL8sEUzTlgZcGImrXX6nQ>
    <xmx:FLEgaib5sxNf3Gvl9IAX-kl_uzmt9VeHkpRk1pyW-TxgaJ2XmcVGog>
    <xmx:FbEgapOfLIrGk2iJWf8CkI0U3Ud9htiE31FuX_23WYcz4YrZsgsSGt6B>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:56:17 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-api@vger.kernel.org
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Aleksa Sarai" <cyphar@cyphar.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <1571071834.388026.1780492561946@kpc.webmail.kpnmail.nl>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
  <20260525202937.466497-2-jkoolstra@xs4all.nl>
  <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
  <1825098847.140203.1780349158954@kpc.webmail.kpnmail.nl>
  <178035470365.2923901.16027569586235650310@noble.neil.brown.name>
  <20260602-sofern-filmpreis-erfordern-63998d3af067@brauner>
  <1571071834.388026.1780492561946@kpc.webmail.kpnmail.nl>
Date: Thu, 04 Jun 2026 08:56:15 +1000
Message-id: <178052737557.2082204.7627783397875879458@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-6526-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jkoolstra@xs4all.nl,m:linux-api@vger.kernel.org,m:brauner@kernel.org,m:cyphar@cyphar.com,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cmirabil@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[neilb@ownmail.net,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	FREEMAIL_TO(0.00)[xs4all.nl,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-api];
	HAS_REPLYTO(0.00)[neil@brown.name];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:from_mime,ownmail.net:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E51A63BB0D

On Wed, 03 Jun 2026, Jori Koolstra wrote:
> > Op 02-06-2026 17:44 CEST schreef Christian Brauner <brauner@kernel.org>:
> >=20
> > Yes, I agree. This would change error codes but I don't think it
> > matters:
> >=20
> > * O_WRONLY | O_DIRECTORY on non-directory -> ENOTDIR
> > * O_WRONLY | O_DIRECTORY on     directory -> EISDIR
> >=20
> > I don't think that really matters and we should be able to collapse this
> > to ENOTDIR.
>=20
> I will pick this up in the next version of O_CREAT|O_DIRECTORY. I think that
> makes most sense.
>=20
> I have an outstanding patch for changing the EACCES/EPERM to EOPNOTSUPP;
> Jeff and Jan were skeptical, but I want to know your opinion as well.
> I feel the the scenario where userspace has no fall-through but does
> handle every single -E listed in the man-page quite unlikely, so I say
> lets change them and we'll hear from them if somehow someone relied on
> this weird way of error handling.

Please cc linux-api@vger.kernel.org on code and discussions that involve
API changes.  I have cc:ed them on this reply.

Thanks,
NeilBrown


>=20
> > > >=20
> > > > There is another point, I maybe should have mentioned in the cover le=
tter: I have not attempted
> > > > to handle dangling symlinks for O_MKDIR. Not because I think they are=
 a great idea (as Aleksa
> > > > has mentioned, but I am not very familiar with the dragons it entails=
), but I wanted to discuss
> > > > what behavior we want in this case. Do we say that we never do a mkdi=
r after following a lookup
> > > > last symlink? I don't think that state is even recorded right now.
> > >=20
> > > I think the state might be recorded in nd->depth.  But you probably
> > > don't want to use that directly.  Maybe forcing LOOKUP_FOLLOW to be
> > > cleared if O_CREAT|O_DIRECTORY is set would be good.  But what would
> > > stop you opening an existing directory through a symlink....
> > >=20
> > > Probably we need a clear statement of intended semantics which we can
> > > review, agree on, then implement.  Have you looked at preparing a patch
> > > for man-pages to document the change in behaviour for openat etc?
> >=20
> > Ugh, dangling symlinks. Actually, scratch that: Ugh, symlinks. So
> > O_CREAT without O_NOFOLLOW allows you to create the target of a dangling
> > symlink iirc. I always forget that. I think this is a very subtle bug
> > and maybe - with both eyes closed - a feature at times.
> >=20
> > We should straighten the behavior for O_DIRECTORY | O_CREAT and we
> > agreed on that during LSFMM. It would be nice if we could get away with
> > simply implying O_NOFOLLOW but I think you're right, Neil, that this
> > prevents a valid O_CREAT | O_DIRECTORY on an existing directory which we
> > can't do. Makes this kind of a pointless excercise.
> >=20
> > But this shouldn't be all that crazy to do right. Using the O_CREAT as
> > an _example_ for what we'd need:
> >=20
> >     fs: refuse O_CREAT through a dangling symlink
> >=20
> >     open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
> >     symlink target does not exist, creates it.  Refuse to create through a
> >     dangling symlink instead.
> >=20
> >     In lookup_open() a negative target reached with nd->depth > 0 was
> >     arrived at by following a trailing symlink; since the dentry is negat=
ive
> >     the symlink is dangling. Set create_error to -ELOOP in that case.
> >     Reusing the existing create_error path strips O_CREAT for both the
> >     generic and ->atomic_open create paths and only reports the error when
> >     the target is actually negative, so opening an existing target throug=
h a
> >     symlink, interior symlinks, and O_EXCL (which never follows the trail=
ing
> >     link) are all unaffected.
> >=20
> >     Hastily-Cobbled-Together-by: Christian Brauner (Amutable) <brauner@ke=
rnel.org>
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index c7fac83c9a85..d20bbcc7e8d3 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4468,6 +4468,9 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >                                                     dentry, mode);
> >                 else
> >                         create_error =3D -EROFS;
> > +               /* refuse to create through a dangling (trailing) symlink=
 */
> > +               if (unlikely(nd->depth) && !create_error)
> > +                       create_error =3D -ELOOP;
> >         }
> >         if (create_error)
> >                 open_flag &=3D ~O_CREAT;
> >=20
> > It can't be that easy...
>=20
> This is what I suggested above, correct, in terms of behavior?
>=20
> In terms of the patch, I think this will work, but struct nameidata could r=
eally
> use some commentary for its fields. I spent the last two hours verifying th=
at
> nd->depth really does what I thought it did, and I am still not 100% positi=
ve.
> AFAIS, nd->depth indeed tracks the current symlink depth, which outside of
> link_path_walk() reduces to the number of trailing links followed.
>=20
> But if Neil's rework of lookup_open() is merged we lose access here to nd.
> @Neil, have you thought about what would be a good way to resolve that?
>=20


