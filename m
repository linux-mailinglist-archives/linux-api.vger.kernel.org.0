Return-Path: <linux-api+bounces-6096-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ASiIBnP4GkkmQAAu9opvQ
	(envelope-from <linux-api+bounces-6096-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 13:59:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7240DB83
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1A5A302BE59
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2026 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA823B4EBF;
	Thu, 16 Apr 2026 11:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv/iJipA"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A5A3AEF37
	for <linux-api@vger.kernel.org>; Thu, 16 Apr 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340752; cv=pass; b=hH/7tZiqhROrY8qVYzf4pRci5F+uWk4sCYlaEdtDugWCmyZEmuxJJitsvO4eZaqNga5hFTUD0MG75v7/2rDfAE82r4n+wxHTpnPic9lkRxWISP4Ll19ginX0PIcXjxZM5PbTf6jANbEDZ0Be246CzZUUxc+jSL+yAdSX7f7xKtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340752; c=relaxed/simple;
	bh=Bw7/eU46XNMmEAY5yaZoewjP327xtGOJwYlC+oEFeMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4Qge5vc5wZCgGzv6gAmeXU0yIwoE+/eRs8/BDyNd6oETk+2T8jW9gmLCw6lH3n66UJajv0zTqUIwR4n1hBsuzoC1ViTGp3Upmmz3zQblFfsIihoFlvNDuRgJpTysFAKGIwal1sSddbjiqk70hW+b8l/dLbCx7ns4ZgQsejdGOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv/iJipA; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-60591ade110so5455519137.1
        for <linux-api@vger.kernel.org>; Thu, 16 Apr 2026 04:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776340749; cv=none;
        d=google.com; s=arc-20240605;
        b=cspaCGpFlcDkdjez8jFmEjTYxn2Q0XhmzNM8uFv9V8XTpG0BqUa8aYG/d6WuVeVaYS
         aqw2J3xQ2kn3C58X13VYlPTWFOiN7FSj8/89BQWxynNPUZcEiEjB2OvgZz8FhzWf2NZ6
         z5+B4ow1X/5mNc8lUguk2wa9elSEL1cJ0dHg2G3QXYfqf6OoPlb6ovTxIAfGpDM3pYvT
         nchUjQ0IwXOdjeBAe6vw6FR3TFPp4gltZDWmdTKRN2euXXjSr8/YWzlg+cLGIMkL9QZ/
         50QV2SOx3Q+Vu2AndKJEUZwwB2syaHEqAcRtdbfzAwtLu3bofmpishUYPfFHo0gcRGW0
         EYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        fh=CMP9Bq9D0d8+ubXnKaS1E7WbV2FMVLtaQsX9h50YWGM=;
        b=AA+/6F/60Ze2pPXMY98IZ0+xs/5TlwQq+4hoe+tsc4YB1Ycn2/X5HP3Su35kWKnD9C
         c3syeL5rqxQQm6MAk91MJbNvPaOXM8dRC8a6eOVn3id3F4z/GBTXH7w7PM3PI02J4IWs
         UiijC+DK7IbE/2g/TDN0qqFqhm+A7yJV4hW9o12OY+gNIVeVxHC57oHdihFMNDyL5hzP
         qAugaxhLH23a+HmJLUAGh3wDdpdWZL/b2BxgI3j5+LcAfLacT5RGXFsmYWnqPdUoU8UW
         xoh1gsJli7IGZqyXXceFu6NO5s0a+XMDl3Fcn/chuh4Bib1vrfvBym652dkfa7COOrON
         nEkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340749; x=1776945549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=Yv/iJipAA+nhsL4hM00ueWwDagedY8BECDRzHx12spLwNgoS8ZakY4zrK2dkiR6l2J
         mQ3pEXXlrCi9kMRBkZi2YHE6qORxLcsWe+D8l+wjDn8HWOrCtWjKCgf5gVQmenh2NByp
         MCPNQ/tGjC/7AKKVlE3P3sIa6vn80p3d3lTSYo8ONK1oz6WoMzmPVNtYluTYxoNlq/gl
         23amyKa5o+u6+Qji1591D7SZNcgKyeEHjHsrOnz+jlamox/cVrUC1NkqUB4QzAKYFrCI
         XYiMktKmpNaISctvSp/Zchtq++MLrF/hVgPWAelzahh5Lq/eJ/sH7+6gxH0vD3vgUtNt
         7D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340749; x=1776945549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=XskpL9794Wpz/86A2hbf/3IRvx2+L6XQSobBZNWs80nY7nLvQTIZ10HoWdvVr6g/G7
         JQowfHezum8N0xlkBhQzJoQOT2EnBN4lU/eF3QQdtjIWAPlOysbeCwFwRVOFI+lk31eO
         YZ7mcGAepYxxONQbC4i9gJQGJAviyCto5loaiJmaSSVQyKwdA45o23rf5PNz0Pwa0zgq
         +DA6j3L0m5jW1G5wLIVdsXQDv0CWkBU9ViYQr4g0hEUrjVWTNgQGzpeMZeqQfSa69PMW
         H/j9T94fveceKAgiZoEwci/8XQVYvB7IJCU6/uMJYuQi/dLc7GWzWnP2rdJPhgZXnOYl
         BBOw==
X-Forwarded-Encrypted: i=1; AFNElJ8zM+GwmDynuS9L5XIEOvzhGI1PfuTofFCzi9z2Xgnm2/3cGXEK307L/79KG+oEYw2OYna5Jck06jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUuMFv8HjTPD/7l81gWeoNpUHuQrpuAq5SwA94JXIj7tUHn0b
	1C3oSXj8mhpRmI7JhlEukh4WCZyKinoRr0F/xCLf0dXiI3BlLHa5HDBMf3pESHvbTdgqLFa33eA
	+givwDFJwVERTxOH+yqznM9ZJguSz1FA=
X-Gm-Gg: AeBDieuE2Pg6iE2hpqnWBOv/+bmQ8aYBg7/DUc1Lq0W9xTQo9CMPF+e1nhiq59Riip/
	3RlinmZ+GaXJk+xFLDEJSFhHrAR1FYI0q9Teducq3AeWhvbjscPYQtPulMfUQulz4btHWrBfOQ5
	Zl0AdJudjVXweQ0rk/zLdRC06TJhwUiZrFgCPRs7MncMOwifRfXQc9hQNw1Uc3kvaZ4IHBacS4/
	e7AxleJ6hYtWX9G/IqhMemXGxJ+dV26qVyYmL1zCqMf/UTRZYZJBe1Z9Rbqh0Mn5S1KJ8ON2Kky
	iAJ0Xg8I71KH+kNNUaDPw0S1nig4iS48FVix+8496g==
X-Received: by 2002:a05:6102:6a94:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-60a00c36c76mr12126981137.26.1776340748680; Thu, 16 Apr 2026
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
In-Reply-To: <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 17:58:57 +0600
X-Gm-Features: AQROBzAEjiDzwaGAEKhFLRhObmxO2qMMzryZZhbLCURVPls0DvUuWHW8g_k7mMU
Message-ID: <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6096-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[43];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cyphar.com:email,amutable.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uapi-group.org:url]
X-Rspamd-Queue-Id: 14E7240DB83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
>
> Aside from the nit below, feel free to take a
>
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
>

Thanks for reviewing!

> > diff --git a/fs/open.c b/fs/open.c
> > index 681d405bc61e..a6f445f72181 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
> >       if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> >               f->f_mode |=3D FMODE_CAN_ODIRECT;
> >
> > -     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > +     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2=
_REGULAR);
>
> It's not clear to me why you dropped this, I didn't see a review
> mentioning it either. (General note: Ideally the cover letter changelog
> would mention who suggested a change in brackets after the changelog
> line so it's easier to track where a change might've come from.)
>

Thanks for the general note. I will keep that in mind.

The review was from Jeff Layton in v5
https://lore.kernel.org/linux-fsdevel/5fcc2a6e6d92dae0601c6b3b8faa8b2f83981=
afb.camel@kernel.org/
" 1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips
open-time-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
  but does not strip OPENAT2_REGULAR. When a regular file is
successfully opened via openat2() with this flag, the bit
  persists in file->f_flags and will be returned by fcntl(fd, F_GETFL)."

I think it makes sense to strip off as OPENAT2_REGULAR is an open time
only flag (like O_CREAT and the others already), right?

Regards,
Dorjoy

