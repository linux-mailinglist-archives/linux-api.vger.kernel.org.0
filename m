Return-Path: <linux-api+bounces-6806-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kGcnIDGzT2rpmwIAu9opvQ
	(envelope-from <linux-api+bounces-6806-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 16:41:53 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A973264E
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 16:41:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="O7/KyWE+";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6806-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6806-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39C90310F54F
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 14:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF73769FA;
	Thu,  9 Jul 2026 14:32:17 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F35376467
	for <linux-api@vger.kernel.org>; Thu,  9 Jul 2026 14:32:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607537; cv=pass; b=bfTXAbksVJBvaKTvOq35K5SfCI0OnJl2MjtnDmPJaBkntI5sLbT7GyE450QVK9lrFrDuGGYg/76TT817UzbXKcpJ7f1XTLq/qcKOVOExyFNVAs0Ofxd2KD9laYPVHVvc3peR0sK56cUaUElYd+GZhTek5fV2Tw+lyjafV4ekgGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607537; c=relaxed/simple;
	bh=V+vuL0j1CDdaZ4B2w4C4rlJ2/cn1tosD1AB7fGsK18g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXZZ2pAGs5cFk+ZGQy1LBYvorufBhdN1g2TKdQ2cHw8r3P0dtp1R5d18qicX/kC4RTh8CBcMf5c5M3J5nB6R+33ahBHc93mm/r87GfhUYA71UMGZV7m1Xyyau3UT+Aq9MwdRLzQI9OWA18iO25RQ2HUMW9vhPSSrjLcKcwR1xSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7/KyWE+; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso3088674a12.2
        for <linux-api@vger.kernel.org>; Thu, 09 Jul 2026 07:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783607534; cv=none;
        d=google.com; s=arc-20260327;
        b=OcOYsLkCOZLwCaHd1ohPNqEz+IFsASszN9BKau4CqMKm20XAGqUQ6GL8V+qAdkU0F5
         ZlpOsekMtTnj1MHe+OowVFkeDEzgxIN6JV8DzWTuCN7hKEj7ynsWRdFfRxribaEIYNJy
         3dVoPI+40n9HRIyui5L9MXoeY1g/MUuIOEF1Pb9a7b7HLbTBxp17iCOmGxBn+7sO+usZ
         R1V5eliBwCZoWUl0GpygkVU/GJFWFV2KGvtu8cdZoGBr8kCYA9h2GRfdvnsUAUxAyJKs
         zppNtBifonXUT3Xc0/OdS6pGxnZWVqpK9o/XAq85ZxKC511iwyId+z6M+Ox/o/hEencA
         oK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xhzYe1XjtaTfQ052TLMa/MvT2DI4Z/2XBeyITmqTEjM=;
        fh=unSE9Z+N2J8Cs9tNvr2FBRXWSDgG4UTvpqqZS4ugbVo=;
        b=Sszhl2WOP/ok5LvK5SdzamWfNxQ9jyuTIv3m400qbf6LOQfbeWfn2E7xtG2SxWaEjM
         oQSuIPOZXcd5osaDVooMRI7TQTcoH9+mjc/HjcfXO2U+gYQdZcgcNmtwBgGloZNyL3E1
         3AZKVwSiuNW89drUNIX1Hr3hr9/K3NTGUrxh2r6OHXWsB2lcQyovBsN51Hd+9iffxvVr
         eEOMgIJqlJX0G8r9nSntBmpt0cUT9zIsar4o3SGrI/7f0BbDjZJYeZFUozXYKCem/4NU
         sP34MKX50K/hv1p5dzgNh5ER6Ft60ZBrHGkWJsNiGMwZ95SfsTCibCd+P8TvKAcgZ/Ri
         v9/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783607534; x=1784212334; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhzYe1XjtaTfQ052TLMa/MvT2DI4Z/2XBeyITmqTEjM=;
        b=O7/KyWE+y6ah8SKUEau4X6rsSTeI5LcfWGUIzU8Wtion9C+SD1nmIODKPpmIsoKrrh
         HiSEn6TwdZctQyMb1yv7aitw6jSRILjMFYXiPixTwm2kN6DfG8ZkA0lA429KmYiByvcy
         UXN6l82m+94NDmsWERpSpMAgwM+BwADhyLL54J1ONR1aDbXNA16dPET4SfPD4onl0pcp
         1SeEC9NP7fpx1jAHFnMOGVH+jMIPA2NFxdRZnqDUawg6tyQJTgkqa6z9mqigZLBqSRUU
         bdct+sGe/pZlqZI53bS0gEKjUAC1bvzg+PtQRm9n+WWg7a/qlK8Ps1jNLpIhjl+r22+G
         MJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783607534; x=1784212334;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhzYe1XjtaTfQ052TLMa/MvT2DI4Z/2XBeyITmqTEjM=;
        b=mfA1AqLru1Lat4VlA0DxsykfRiXb4P+ppZNu0kEut459tqI4Ey0D+4OTnToCmxT94a
         mmPvVAxjlKUcdijImD0giYtTyQDg3mE08lXPPL9CV02EoI2opPJIM3/Msd6H0j+KHk9B
         /GsS77fuAqS8Smm8v1KGHTlR9u9gj02WOdWhiAz2iOt5b4fMZTVYHgMOIpzL3Fj8TdKg
         dwlxneF+KqFCDGD99Gujni9WIBW98pdgXnAyGmGCT1852tiMAcxul/10DhYWfjHLOLdm
         WNe6F5bb9X/IQaEbgfv45hBXeK/JyTolkVolzOs6GBwhgYn44ayv6ToOjMQpzS8+vyW/
         Wzxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2FLZdVqDedbl00JwO/RzSYvSp7z/hJGPGz++oP5WWH4i7kUm53DtwwjGSiymSUfc0DufWQYdbmko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLH/2yx8TMjdledTvj4oP53DtCvDkMAIe2e9EDh9VRcdnOL40Z
	ExNZmpxvybOPX07YJ/2nouLQDRXk3JSJcvuPmd3Dy5/BRnQSUv+Ljg9KXcYbSrQXN7J55yWAr8V
	BO9vKd9hWV9VaMbGJBxSlOHR61+B4F8k=
X-Gm-Gg: AfdE7ck3zVVRKOlhC+01d9NS9e795B9Np5PPR9jawD7ibG+vvLKfm3VGzxBvYrkYL6z
	xRDsXFwb085P3VV4kQW1Qwduj+xP4moAXx1cQgncMuAAA8x7cTsOMa4FoHnOPrhN+SHCOXBbSaa
	/XBoMfA60+GC+nfg8xb7YQ37PfP9aNCYVZ69imvhgghVkeyhX7VndoXaeIBWCRY62QLG2eDiWzk
	YemMm/zXRnUa4J/QRF9KQQ8PT2TuiNt5AC9/OovbDDNnG1Mn1qeOI5EyM966rD6uzYqILfYRA==
X-Received: by 2002:a05:6402:4512:b0:697:8136:6d85 with SMTP id
 4fb4d7f45d1cf-69ab445d5b3mr3087023a12.3.1783607533539; Thu, 09 Jul 2026
 07:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com> <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
In-Reply-To: <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Jul 2026 16:32:02 +0200
X-Gm-Features: AVVi8Ce_W-yxg-OnXjZQCWKXwRdUfH6E4eFRwx41VYV2twepSkLr2IZMZq1JXHI
Message-ID: <CAOQ4uxgZuJ+=RQDh3577H7PFAfYyF=wRJ55aPuuUW814Htrmbw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Giuseppe Scrivano <gscrivan@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6806-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,zeniv.linux.org.uk,kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:daan.j.demeyer@gmail.com,m:daanjdemeyer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE2A973264E

On Wed, Jul 8, 2026 at 9:45=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 8 Jul 2026 at 17:55, Giuseppe Scrivano <gscrivan@redhat.com> wrot=
e:
> >
> > Miklos Szeredi <miklos@szeredi.hu> writes:
> >
> > > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> =
wrote:
> > >
> > >> Amir suggested to add that functionality when I've asked for some
> > >> feedback before sending the patch here.  I am fine to drop it if thi=
s is
> > >> the consensus although I see its utility from user space.
> > >
> > > How about a completely different interface:
> > >
> > > int get_fd_opt(const char *name, unsigned int index, unsigned int fla=
gs);
> > >
> > > Enumerating layers would be as easy as passing an index stating from
> > > zero and stopping when -ERANGE is received.
> > >
> > > It would work for all filesystems that use files as options.  No more
> > > fs specific ioctls.
> >
> > Is a new syscall really justified for such a narrow use case?
>
> That's the reason I advocate pseudo fs based solutions.  Let's see, we
> had a proposal to use openat(), something. like:
>
> openat(base_fd, "mount/options/lowerdir+/0", O_ALT | O_PATH);
>

Ack for this, but please don't use mount/options/... it's a bit ugly
because most mount options are not opan-able.

Please stick to something logical like "fs/layers/N" corresponding to
ovl_fs::layers, where layer 0 is reserved for upper.
We could also support opening by aliases fs/layers/upper->0 etc,
but no rush IMO.

What I am contemplating is whether we should implement
introspection of the ovl_entry stack for merge dirs in addition or instead
introspection of fs/layers.

IIRC, the root dir stack does NOT hold references to lowerdata dirs,
so support for "fs/layers/N" is still needed.

For directories we could implement "real/0..N" with aliases
real/upper->0 real/origin->1.

For a regular file we could have constant aliases real/upper->0
real/lower->1 real/lowerdata->2 and/or dynamic aliases
real/data->{0,1,2}, real/metadata->{0,1}, real/origin->{0,1}.

Those could be used to implement "revert to origin".
Specifically, I think Daan asked for it during the last LSFMM.
Although I don't think we currently store the original lowerdata
in ovl_entry when lookup is done post data copy up.

Thanks,
Amir.

