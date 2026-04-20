Return-Path: <linux-api+bounces-6120-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDWTHmRZ5mmtvAEAu9opvQ
	(envelope-from <linux-api+bounces-6120-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:50:44 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DFE430185
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 18:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E85396ADD9
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2026 15:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4713E3D9050;
	Mon, 20 Apr 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhQanICp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326A3AB29B
	for <linux-api@vger.kernel.org>; Mon, 20 Apr 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695497; cv=pass; b=t7cNdZitbVQ+6v99O0Vr1AmVgHODHeiEPKBHN1C9ffwfEUVfKyh/KLlJS6bfTvEFQj9mrfNJB9zKWnnsmVnkXQR8UxiKYnKlus+2CQbsPxgJzjYM/sld8UEFuwbNAl09ShpUS3VkUM/zL1xteRtSGb4Gjzi5+ZdzW9JRi8Fo9To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695497; c=relaxed/simple;
	bh=kqPRzU1r8Upp5TYgefpiWZ9RVnkrVKI+N7GY819VmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8i1xGHOebwQrYeqmw70WBZPPJkLICnCBMAqQbytu7uSj7Z/yPfr7nqdGrqEZ5Dl7/boYC0WaEddAm+pwphr8+8mdpJmHV9F64ki41uwWIzNmdL7gKp1InKPALQvcPurpRZJ7C5Qv8qFEqXw3MkvYT9c6oMQD6GFltr4Z+yeq60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhQanICp; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-56efdc96b05so2030206e0c.1
        for <linux-api@vger.kernel.org>; Mon, 20 Apr 2026 07:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695494; cv=none;
        d=google.com; s=arc-20240605;
        b=PUIyTx0nEl32Y2/0DKJB2Tta6bfFWbh/EDrwTF9F+jPfH4z/J4/Mr1V/S0i4zaV4Lz
         WRcBO4vNubNN5gqmXg0iolvEvADVVQDeZOKNw+/XuZsHJzORQwkWpJGuX6vnhxffhPMA
         AYhfcqbYl1i/S6fNZy63w5lGCGQDK9Iz15r2VnAEZSqXL5JPUrUID8adIqWcu7M+mnxs
         yrIXlB4hvTU42yuhF0SlIgNXUcs170QzEBKgydnruARA5LFxBreTt0BIhCno3dJZw2vd
         v626BXLuqIW7ffIgJegGrzNPYcgNfAfX9H7DpWcTUvpOLHVMe3mzVZRZme90kL430bAy
         WioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        fh=0LqjTip+2hy5wSIADqKPKqeDOlDpBjReoIC+hGHNpMo=;
        b=O1fOaSuyE+P8YNwYqllGterYSn0fRBRTw5aWQmfcbP7mSxbTcpUdhIT2ZlzO4REMR7
         IgA0th3CIl5GXcvOMndXQyL0MRrciLrfaPlGXzjdcRroHH5U+bVX2cAD3xPd95s9NpF/
         wGRInJ6fLtmNu/Y6W/nsTxTbJuXUGqPbq4d3Ew+EfyY/zvw8uI0S4t633ZL67cUG8Gzg
         +eYBW6NK5GnyS8uz3gXoVQrEaJ/zViJRZsgdXS28iKnkUCvO1edT46F+AQsFUccOt0Nj
         YyGFEtlQ0ADcqAnO8KBFICyhW/FEb3O+r64mQCyZu6lH24VW44xS4MaAzxz2usDjAS4a
         VJ2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776695494; x=1777300294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=EhQanICpPv6wEMAT2QVDm8MgxITvcGEAYHe1m42iLSyMQj1Y0WareKAEFrCkR4fDyS
         SPGbqqTXwePHWW8p/f+2UlF/X2ihrUtbg8fbhtFxe6Qkqi2/QsyMkbJOzqro8eqXQAMl
         WcTOuWJXsUbOkZXsn0mFPAAJhM+mIGkIVvCxhoXQub2kbpvG2XE+6iWz+07ORoIJhtIs
         ClD0K9/EMLGHnjeD7QhTdYd1UAPBisbBisjidOI06FRByUtkXvWoSYx8MVyVgkzYR17D
         5S+1XoMelyZ02D7ZT3mCabthO4VIPjJuimT5uUTlee+2Q1h9TgB0nS+/3YwCJhdIarG8
         Pp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695494; x=1777300294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=n1bCOpQkcfyp5qGE5wsx5fqQn36LAmKTYNbeiqSgxiIZzmCafCo1hSkCHnkceU8l2F
         LUZuSLp1AF1sr0gsL1niWyiV/DtqUCX8T2aaO+RkhMTA8ACGtjqaVJqlqs+Lo1yWkPa8
         DfyPU6cxhZHOlx5A1aR6HDyKtBEUwJjCUD9JIdEqZB2QAOemnfDFSEBh6Zy8b1mz0fuy
         NssSQP9BSYHljSNFs+7kj/7xJp2Zcv15d+7DZo1otA/IwG6CFJXuaS9NMkEjLX9TRXJs
         WQZYiMKO99VcYNhZqnlbU9h2KNn7NsozvGIPqJ8i5OgFYNYwTimX1INKJgVS6NuchDpu
         eBpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/m/nAHghhTxM2wBlYv05gN3JqkA4bbFcn8pQ14o1/xTa5eMcGaesOVTkxaaWP556BG+ct2AQCKjtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zk60msfJyGDsXQqIY4wofGBAa/yCw4SIbEStc6BnP8B7Youw
	ly173T0qWr9kwDKFWrT7aOW15zUsasF7WL+R9Mz/nFkRzOWJ0Y+5w6ZPiut3yVFWes4c/wnCriF
	ZckdoZEJ2PZ8LU76A5zI0uSKWp7W61bQ=
X-Gm-Gg: AeBDiesfl9rgjE+MKobqjJ1Wlg/GvHPCPw9nTqhiEY0oiG8XqF4xLJAREcvV6OmuHDQ
	waUns1HiGmmoOfrTgUAIW0tFZ4VtKdWQWUvfzYSUNBEOQjHn2NZRwf43caOlequCOXIfyJQSJPG
	QK1H4ybbiZY2ztQdZZeqIofhUYeX3zPiE871t4ZfmD7vL8s2DJ/3TjCutIslvliPKdK/LyNXMI+
	cNnpdlbfCHlExula0kHF4N16797TNW3kpuJ06TPqefEHNoyee7EVi1gflGd95+xi98x+OKyUknU
	FPGsyi5utNrZRVwNt8H5DmqACEdoc+wy6gN5CdSzzJVoZFpQcsHw
X-Received: by 2002:a05:6122:4d12:b0:56f:9512:145 with SMTP id
 71dfb90a1353d-56fa5a39aa7mr6593038e0c.13.1776695494119; Mon, 20 Apr 2026
 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
 <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
In-Reply-To: <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 20 Apr 2026 20:31:23 +0600
X-Gm-Features: AQROBzDP8Lx2bqkiL-O80tZkD0rFOUG8sjvNKKIkhcPgFqdc6FHkIJDo6D1Xn7k
Message-ID: <CAFfO_h5FH36eqYuuoYy2eVRXGytmQHLfz5p7fLi+3wHmQN9MnA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6120-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uapi-group.org:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2DFE430185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 7:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 09:22:03PM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > > I came upon this "Ability to only open regular files" uapi feature =
suggestion
> > > > from https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > > and thought it would be something I could do as a first patch and g=
et to
> > > > know the kernel code a bit better.
> > > >
> > > > The following filesystems have been tested by building and booting =
the kernel
> > > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_R=
EGULAR that
> > > > regular files can be successfully opened and non-regular files (dir=
ectory, fifo etc)
> > > > return -EFTYPE.
> > > > - btrfs
> > > > - NFS (loopback)
> > > > - SMB (loopback)
> > > >
> > > > [...]
> > >
> > > - I've added an explanation why OPENAT2_REGULAR is only needed for so=
me
> > >   ->atomic_open() implementers but not others. What I don't like is t=
hat
> > >   we need all that custom handling in there but it's managable.
> > >
> > > - I dropped the topmost style conversions. They really don't belong
> > >   there and if we switch to something better we should use (1 << <nr>=
).
> > >
> > > - I split the EFTYPE errno introduction into a separate patch.
> > >
> > > ---
> >
> > Thanks for fixing up and picking this one up!
> >
> > >
> > > Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> > > Patches in the vfs-7.2.openat.regular branch should appear in linux-n=
ext soon.
> > >
> >
> > I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
> > git.kernel.org.  Maybe this hasn't been pushed yet?
>
> Nothing will get pushed prior to -rc1 which is due this Sunday.

Understood. Thanks!

Regards,
Dorjoy

