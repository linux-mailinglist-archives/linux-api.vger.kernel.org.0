Return-Path: <linux-api+bounces-6374-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBn+MOtCD2r/IQYAu9opvQ
	(envelope-from <linux-api+bounces-6374-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 19:37:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C73935AA60B
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 19:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1CB830C64B6
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 15:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FE3369D7A;
	Thu, 21 May 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lL1NHx9I"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE5368D40
	for <linux-api@vger.kernel.org>; Thu, 21 May 2026 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378578; cv=pass; b=SV2/OBbHj8s24CIhXaxsp8PfxiRcPFr8eXa5S5RlQdLOtfwuGctGP80WROgtTFd+gRjsAY5zQs2ukqhvDmRWPcsTG1yTvBOZ5eIBogJes5XePqLuLOtSOivxkJkCRVDcOzLYNaQTogl+tp+/g48Ju7UKU+k2CdcJSJHwf6eu62I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378578; c=relaxed/simple;
	bh=oTJGeDYTACLQP4b7lcnYS7MF/F8SkeHi472hQfd2CPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnoed14J5rO2QVUiQu2qylOOQv+fUAo63srtZYhmNFy0rBhCeFYd60eMd3OfWrngvV44bCub6YHyaewELgi/WZ+WLvsuWGjyljDIHTFqXttVRPAAn7Ug/DjMPAhK/ipPAy4GkU7LwwrOVF3ycgid2jRO2C1wkDEs3ULosAPeBl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lL1NHx9I; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-6314287380bso4501347137.3
        for <linux-api@vger.kernel.org>; Thu, 21 May 2026 08:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779378575; cv=none;
        d=google.com; s=arc-20240605;
        b=fYqlIzG/dWUTgsczVCR0/rIzBU2H8cXlWFWkDy8Ex1rF1heCADN4K8+OgbwL67VsXm
         vBVE+uAuA6Xt9kZn47DG00cPdL389LgrNYqIlvIZcVARhhjCIY5TKRvWXqGLEVkhHa/S
         73S/Xt8U4+Yzvd+5XhwJkYkmBxQasQmwStPvkG50QSSCIqpiKDJqhiOUs6Rpe3cQMaAH
         9IyADs8/T8YN8ASAkcqnunP/lRwoL61i/EowPwgBRdE/bRwgRI7Kst9/3CC9IIgED/j/
         wKWBo6/vF82IDasrGhdaxkdGKNFP9D1Ujm2gxaFY5FjlXtvRewkCr0/OJHpUamgyrzrJ
         7++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        fh=gjIoxyE+DhGlFCwXESobSlQUC3J67tQ2Rp+NGwKJqOY=;
        b=G3d5RfRICKdMP54+dM9opFKPWOs28Z0ZRUVyW043zBsJHESnzn9F5VdE9d0Y2EAWUb
         eReE8wjlYG0nYmC6p98lJaJzEB0af60OIvzFiDOOMJTBPOf+tVlQMiqwZRMaFalZMFCH
         wA3ENAaNdLyQLo1tdswksm9gmQy54DRZ4mcfjDBENiXWrxB51xS4RxGZaE/sg2G3jE8x
         jjppkcAT9Atm9b82Ql4BaCjguH0gr/eZ2H8GHiOs063pi9Jlqbk6cgH03OSH4ytgbIIh
         qNqW4i9dJcQ3rmL5qlaHL3PXZH5FeKy0FJHnEMGnupBkKvIAKHFRif2DB9H5xJ3v85XM
         iHqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378575; x=1779983375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=lL1NHx9IIKtcx4n399OipzLHTG7xOmxIhzXqniZ5H/PlWZnBHPquJmbnT+WXpW8VGl
         gD5K7nwalvqc4Jt0om+M7KYYupeksRrANY4jRunce7CrRXOXxqnPI7tkmKyFagBaXwF0
         8hbAFX6ZrBAhSIQxY+fV56hM0QhsKH/3w0jYikbW8LAIDNiMade6YzJVU1Efx90sVY3x
         4RhbDvS072Slf7nSGxLx08t5GZTGyaCT39m+CpTwAhqunSH3Y9mmA6I+HSghd2xMwMha
         PQ0O8KzBHHVN1VIStAFdCi0DV3GfXQMWyTqCZkVW0qbXHgDdJtycc4DpHzSHcGvAFvB1
         f1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378575; x=1779983375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BTiKHHtH6isAoh5+/ntoHPqjIgkFbjjbM7Qgllx7bcY=;
        b=McDccevRZWuZ8Op4WIZonq3l+temg1szco1leMfTXZQfvpGDgzvcSGzd9C1Yo53cOQ
         o6ChnWz2CLQWS8QvReuBUSTuI4URXKwl7+trQnsV/cAIFcnG0P48e3gogioouyohjCPp
         6c+C6aI+LWhycws2YjGe0QY8Xc56TUGKd97ysVyTYpElBt9bnmsFhQAFY3Q+CoqZFu9T
         7Qr7Om1Ru4T4pGGN7oCSKWF1YdPH6klk+WXUlxWRc4c3krMrfwUEdWoQwqusXbG6wZkR
         kENe1EZRn+3OPaIC+uv8kDLGcznZin8zILlJ8wEOC6UuUJ0RBD8XqB19oO+VV8r3g5v8
         vKdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/e3KQuwk287le0UxbwBJXTtjah6kv4mg+ThxfwShK2n5Z91GX3bH+Aj4QvR79I9ajleNhSz88wpL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mU/xLmK3nq7YNxAiUGdUTyqU0A+/MaNFz3HlqELOpZJa4NOp
	WEs5NTK4TuT0fWEUUsEN+mcEwq5YV12jrxdCbbDQUHkvKT83Z1MwcDXIzP/JgaTs7lBAmVF2+qP
	zQWh3yvUfUb+UZsScjsUTXohvsCXBJ7c=
X-Gm-Gg: Acq92OGREc4UfTzP8NA7YrOOjF2DZATQinXJCYosBVkG5Z5bdLwyopmKKP4iAHKCl7w
	w+rXONPEaDO4HjNk7DDW5MjeO2uVjMWF8bzYVMA2GVHf0Q3KEd6ZcPUqncfe0qsYTLxplAF31uJ
	+kwmDUZHpDwP5Jk1AmdilrtIq5da0aME9N8yxe6MHaXG6usujyCNsNDaxhYBR5dZw+HxiCbg+3u
	acDOSNChJTyRPDDQ8r/C3uAyNRizhgh13niRxkpdG0agbeR+EgCMA4OeJJT3A2DdnH5i4gJ9zGH
	VbOHZPA7dfIuVxuQa9m+lCwyoInjag1nD8EPkh2cb9pXhBHYf8xS7aU=
X-Received: by 2002:a05:6102:1591:b0:650:a9f6:4d29 with SMTP id
 ada2fe7eead31-67390b66b29mr2592164137.13.1779378575543; Thu, 21 May 2026
 08:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <20260521-grube-leitfaden-0e5420c9bedc@brauner>
In-Reply-To: <20260521-grube-leitfaden-0e5420c9bedc@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 21 May 2026 21:49:23 +0600
X-Gm-Features: AVHnY4JMLUcx8yOSfS2Q9vtP8tvb48vFjP_vPMN644Wd5G5CD5CLlCbq3u4DVJI
Message-ID: <CAFfO_h4Em26Hfbv-DWF+9dNS8TBuGpfWjWFBUhLr7jYCKzj3_Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6374-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,kernel.org,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C73935AA60B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 4:54=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 03:07:12PM +0200, Christian Brauner wrote:
> > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > I came upon this "Ability to only open regular files" uapi feature su=
ggestion
> > > from https://uapi-group.org/kernel-features/#ability-to-only-open-reg=
ular-files
> > > and thought it would be something I could do as a first patch and get=
 to
> > > know the kernel code a bit better.
> > >
> > > The following filesystems have been tested by building and booting th=
e kernel
> > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REG=
ULAR that
> > > regular files can be successfully opened and non-regular files (direc=
tory, fifo etc)
> > > return -EFTYPE.
> > > - btrfs
> > > - NFS (loopback)
> > > - SMB (loopback)
> > >
> > > [...]
> >
> > - I've added an explanation why OPENAT2_REGULAR is only needed for some
> >   ->atomic_open() implementers but not others. What I don't like is tha=
t
> >   we need all that custom handling in there but it's managable.
> >
> > - I dropped the topmost style conversions. They really don't belong
> >   there and if we switch to something better we should use (1 << <nr>).
> >
> > - I split the EFTYPE errno introduction into a separate patch.
>
> So I've massaged this series a bit in that I moved OPENAT2_REGULAR into
> the upper 64-bit and internally use a __O_REGULAR bit. After having
> thought about it makes a lot more sense to move the openat2() only
> features into the upper 32-bit for the uapi space. I also ported the
> selftests to the TEST* framework to fit with Aleksa's recent rework.

Thanks for fixing up!

Regards,
Dorjoy

