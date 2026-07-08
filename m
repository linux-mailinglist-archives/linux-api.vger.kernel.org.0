Return-Path: <linux-api+bounces-6799-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nU66MtmeTmpmQwIAu9opvQ
	(envelope-from <linux-api+bounces-6799-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 21:02:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640DB729C43
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 21:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="Glm/llwh";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6799-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6799-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFD93057760
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859A335FF6E;
	Wed,  8 Jul 2026 19:02:08 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDC31619C
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 19:02:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537328; cv=pass; b=I196d+GFbOEzHP7datwhgWj2p/0Qk6qLgVkCK7uJrH2PteO6bcCmn5KY5ebGzYr5fEbZqpEUAqQJhVVWfUfGdBW9bBBKSs77huKFHU651o21xsxEB9TDWgOo4irab16QOI/bExmfj8oZ7Np63ip4EVHBqXofbwB14UbPTsEM0sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537328; c=relaxed/simple;
	bh=RrokN5hI2xrJP0hSZASJxB0o58XKatfrhNPDXueAhYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TBqyXD1CxAEQNNDvBWs/w8jlaGda4b4Ah1tyqs9EbBrhKCoDJa69Zciz8YOr0M6Wzc9zur6m11ubp/6NVh863W5MyyqmfmpPf9kTUzXd/TAJ8evN503gg6lXyt8DZ7aZ+ZxgUpDw/+TqAIOc7greDu/XCXs5xs6dQrwWACQtxTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glm/llwh; arc=pass smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so1861125a12.3
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 12:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783537325; cv=none;
        d=google.com; s=arc-20260327;
        b=oKFF8O7bHflboSpRy1nBnOYeABb0dUGHTVPtmyOaAUvSOdEgQYG8jdx2riHhZ9qHcd
         m9g7eUmB8P+kXlo9/GEWFDdPbya5uFja/HM+mL4KOhA+PKuw3PeJf8LheoyX1gp/Fx4A
         tjd0Eo9ksZN1WfVtITM+XqqyU0XyRVhoT3Z/Rb6ogt6+0WSBmatptym2Lo0LePtF8Ezq
         WJ7RBiocdcaJ/hifjq30hm1XHYM4vINnXsDCvpoVjEzNCMSE5ESY93I9QwjwuzMwHL5Z
         in22dJDZINTHW1X8ZM62Y4ORNqvKDyZukDtm7Y4bAzLMl3TPKYkdQkXuSnW2v9wbfMLS
         GtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        fh=jVwfkPAuPWqGa149hhgv7NrWlTd9xadR9cn8VVSgAGU=;
        b=EEDcSdmv06H5P+KOgT/oya/XrrehtcD3WhKEQel3A2JMUG+2IgrplJqj8xS3OQGnX9
         4WW4n3RYKESlOfSjBbBD3N7htUoYiUYKI0wpqfK9grwdVn+aIHt1/Jn6Gbty+IzfO7w+
         UaZr9Lon97Mit2iC3uftV0t9E/xQ9dWcVHkTZgiqqUDhcq4HtM3DSxXDTXEF71gYOgR7
         PPNnwJGz7kCaSP/7MIFDIQctoKlYlBZaz22jRku4CdXzrGHE0V5XNizHUgYKvi1jFJmm
         9Gr4kUxm7NT/Fda+1f35sNdzas6WqnqL3WL0/C6/jXluuNK1oXcIsYwXrTsnLVz/vJZW
         tdQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783537325; x=1784142125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        b=Glm/llwhmN/OqN4srBrldQ2ar8nOoVYOXQIzgUAQusWDAUbWpUwfXvP7QQfe4hkzoC
         6T/1wWq6ZNv49ZgET+xVVQSy2BN8YuxH2ZQBTCI9FVUMS3kwODjqebtAoJxFSmhKKNLM
         26/dxR/PyXTA4pftE5BznuI2QJ9J8kd/1iis8BTs4fXPRzTV2okI6hfdEdafzGZS0Try
         t/7iH6EVPIQDdvm8s2MIflJ78xi2Ceh3zPPB6y9EXOcq/3MwuQnb6nH7H3JoowV58uRo
         c2Ct1hRUgr8w6j7fAa/f8XIFy1Bwj5Q+kIo1xLn5oKxdJnEK00J1cLUkxzco0vC5m49z
         kJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783537325; x=1784142125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        b=OaNawWM19XEV6bUMaIw1q/GDV3JlwQ2Sdsl8uvXGzhB7Ewg0ncLKD6L4zhA9H5KYuw
         1c88B8QWfRQY1DtT2MWyjldTMGMO1mW958kwKeNiOwq8UM0XwFChUkXvLSVh4f3e+4ov
         lvCU03Tlg7KUSk8laLTauJZU+6+mLLWUR7KJfIDaIw5LZ0rBDU7e+mrf69kUpET/UH30
         fCZQgE44CwdMxaFtUbHpbH3nF7GGVcWuE5IJ2nb0Ujlugbb+vSRbWysUDaa+KPNCGDkQ
         oCviRapEHWD2y1A7+6hcWjXXe9qb5ESs5qh7b5xGtjfhhQNAVoki6sC+mCa2OMZX7WVW
         E4Cg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7uPdoDa1FIOuMPnqLWLVjCGsg+lqwH2nV55DQzqYyfTQgMdyCauzbPG78oM5pgXhpJbz/SNXz3T8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTCHCwK14uNpG3UzdBO9oNfwazvxbS+KEbEc6Y9MzxP4ILnp6H
	VNll0WqwwL5ELkIcfNsg0NQV7QrE9viR/VhXoxewlYv09EDy72Amx2iPSpsdUPjwNljX8o0uQlf
	ZiZQ75PxnSkUjkS3iAijLj8Xpk9OxUFE=
X-Gm-Gg: AfdE7cnIcvb2VAUr+nSbyLP/nD07nx/qcxhAaIfEsUNdi0kvoLUGLlGS7gp6eD+3TPB
	BtSgIsEjLYTV+cGthEuQO3UTHN8BQD2eUm0vAcT9cLWApoV4zmzRrU4YQT4i2byC17uyqOh6psr
	JEITp31nfSABiCZG8VqfeWtqFEBgyYBS1B3JLQrs6abk5A8pGI489/fcoWRfI8GSwkLyVXLoJRP
	DSzX4FWWdw45csLfX3o+t0iigUY2Z3RizpePPdhY2Y2sESHjkRS3YlPp5wglLUtSd2p7Gin0A==
X-Received: by 2002:a05:6402:1f89:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69ab44b5e42mr1817377a12.41.1783537325129; Wed, 08 Jul 2026
 12:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com>
In-Reply-To: <87o6gh79yi.fsf@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Jul 2026 21:01:53 +0200
X-Gm-Features: AVVi8CcH_8D2AVPgSdZmur5rdOwKhUpVaCHJD-tULtZMblV_EPw4hJoYlLj59_k
Message-ID: <CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6799-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 640DB729C43

On Wed, Jul 8, 2026 at 5:55=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wr=
ote:
> >
> >> Amir suggested to add that functionality when I've asked for some
> >> feedback before sending the patch here.  I am fine to drop it if this =
is
> >> the consensus although I see its utility from user space.

I was thinking that getting the number of layers or info would be
a good idea to complement getting a layer fd.

I agree that the same information is probably available via statmount
by parsing the upperdir/lowerdir/datadir mount options.

> >
> > How about a completely different interface:
> >
> > int get_fd_opt(const char *name, unsigned int index, unsigned int flags=
);
> >
> > Enumerating layers would be as easy as passing an index stating from
> > zero and stopping when -ERANGE is received.
> >
> > It would work for all filesystems that use files as options.  No more
> > fs specific ioctls.
>
> Is a new syscall really justified for such a narrow use case?
>

I feel the same way.

Giuseppe,

Could you add some high level context in this thread on why you need
this functionality.
I think it's this composefs-rs work. right?
https://github.com/giuseppe/composefs-rs/commits/reuse-mounts-and-prevent-g=
c-overlay/

I must say this seems a bit upside down to me.

If you want to keep a pool of mounted erofs images, you could do that
in userspace -
create a service that indexes mounted erofs images by unique mount point pa=
ths.
Then you can introspect the overlayfs mount options referring to those
mount points.

Going through the kernel to get an fd and reuse that fd for a new
overlayfs mount
sounds like a strange way of accomplishing this.

If the overlayfs mounter is unprivileged, it would have to go through
systemd-mountfsd
to request a mount of erofs trusted image, right?

Can't the same service provide the "is_image_mounted" query which provides
the mount path?

I am not against introspection of overlayfs, but I'd like to understand
the use cases before finalizing the uapi.

Thanks,
Amir.

