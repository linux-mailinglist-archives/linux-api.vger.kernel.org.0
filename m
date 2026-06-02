Return-Path: <linux-api+bounces-6496-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8L7OM9ZVH2rbkgAAu9opvQ
	(envelope-from <linux-api+bounces-6496-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 00:14:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1D6325E4
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 00:14:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=GDTb1snu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6496-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6496-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CA2E3024A38
	for <lists+linux-api@lfdr.de>; Tue,  2 Jun 2026 22:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF03A9DA9;
	Tue,  2 Jun 2026 22:14:43 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112F3AB482
	for <linux-api@vger.kernel.org>; Tue,  2 Jun 2026 22:14:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780438483; cv=none; b=d8D2cYrDtQ2vVj6kCeANy0xaObi2+IYcZ5og5CCwCRgQIbckbm2Ef3sI4DiwztDqp4KQDH5txobU9bgrKP16O+a3OMg5+ApZ86WbMR6vYn9jG42ReH2pUjCFz9yYsjbOqDJoG4yfPwWpV7zkVbmVEXlBcLirYdZwMiAng29cPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780438483; c=relaxed/simple;
	bh=ggdn1Kxplzazv5OLdinIKnlry9LYLtLaNuo30kwvE0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJjRprOhJsuN8bC9CFrB6W/UwKb/sYxWnZs98yAgIvCXKl1we67KFphOHh3BVwXBcGXm2yQzcHmgm37pPYWgkr8tA6lNhusAS0ZbgC0Gh+Q0uwK4fGBvu2Tyy9Zm9P1Rkrz4f7fRWMEbbDMIODdMfPTXrla7V70xAh59HRTDHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GDTb1snu; arc=none smtp.client-ip=209.85.167.51
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so3144380e87.2
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2026 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780438480; x=1781043280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qw8RVcymrwPdvtyZ+lyACgxH7IqaYDBeV32TfvS6Ats=;
        b=GDTb1snu7OxKFn+E+0tR/5Gt3fmw+JQIAdmmjdcz3eMydpCZ5w/3qSZ57Ca0tR9g9D
         0cd1YOYAEHNj1kpZPlGKQon8kYtcu9GVMCQzyMeNyNnIuEGktJ+3Rk/e0p4m9pLS0AmJ
         KQ4JEpZ7IkB74156VhBCsHC54VFwRjIBAcTX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780438480; x=1781043280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw8RVcymrwPdvtyZ+lyACgxH7IqaYDBeV32TfvS6Ats=;
        b=jm1K0FLT03bvtomzdabcL6CCKUIl/QoxuxO/PJG0+UZKy6uQqmrmTocxvUyrOpb0zp
         a4QP1BzoRIeINRqQqNfwj4eEp6gqbeyBSXCZE6c4v0i7kSrUjNmmR+kXcSlr7s7+Fm0i
         2eRHb/6AezDMn+27/krv7GWj+Lrv7TPG6agbuC0zSRNJzCfJjley4ShqBTAQ5OZWknaP
         LItuU6RuiXFFeex+nw6dDKCbw5O7fSf5UwGcUdfuHajh3zV2ZvigHdiI6xGF3julDbWv
         HiVtM2Srk/AvFqHGmHowVI8qlW2NuJAW0KVhdKLCDriEFsEhrydnBSuhIl1oWUl7GC00
         rA+g==
X-Forwarded-Encrypted: i=1; AFNElJ+7+PJHXS4V3JMX9uAwWbq/DFswjiIJ8cxVJGyDK6V7ZGzpRcBLMJUulAjjqPl5xdZoh3d2vdNoqQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk1RcQsn5r0AlFA5jU6w+KDqxK0DL78o+R/JUtBY6oKh+1Y438
	mzjxgPXDQKdZd7n1UuF4gaCB2RMucpkhXM3pX6HoxS9YhEVkTawdbFOxuv10E6v0hj+5yUZPyWP
	kvqeI/u9oNQ==
X-Gm-Gg: Acq92OFQoIW2nSGFqoHeFQBJJlKvOUZkZvNnZNJshr2HfIITRtlo6uYoiQqJufi97mU
	pWCoSjj9q0pSdBXiaAmfaRDK+WNEwD6uhSzbNKFUPZhHK9Gn9iK1exg15H+1/V7JJkaHx0TjVct
	DU9kf/9wGCcwdNI6SWe3z+0eg8T30VlbYVPQtbBxe/ef1XMIcOM+wPvi/TMcbo9T6WgM06BRDmW
	8Xe/GW6SjpOm64FDEuYqLofz8qYHLWqOvbfiXbPQEMn11FYu+To7mPKGB8K/N7EiVgyHJ342rKU
	lkKVZ35VCpJHpX0pZj4rPLVoIH2ISiht848GO2aO5r0l1UY6i2jk7ZjTW5ARo52jtsLj7epA8N4
	/bEuNwjbsRymKE317lVQUl6f2e9/ld5Ej68YY0f0wT40Lv1iWgGUOr16eQu3BgOqx7cZlWijrYA
	Icr42Z0w5iy8u2snBjhq4nxmf5sYw4okZIJa3xOXNq9ks5VFkFz+bOiCvecNdATzFto4kAXsJ2v
	L4HjJn5EA4=
X-Received: by 2002:a05:6512:a83:b0:5aa:6f49:2ccb with SMTP id 2adb3069b0e04-5aa7c08892dmr228419e87.9.1780438480136;
        Tue, 02 Jun 2026 15:14:40 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbcdesm217153e87.21.2026.06.02.15.14.39
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 15:14:39 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa61e3d3f3so3486732e87.0
        for <linux-api@vger.kernel.org>; Tue, 02 Jun 2026 15:14:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8GpWa3KZW5wChphiokUWMgR7cEqDzT+WSr4+APW/jNxpK/48cy9dnILbc/q8+QPHNty1ylPHaVhdk=@vger.kernel.org
X-Received: by 2002:a17:907:3f19:b0:bed:62c1:f7 with SMTP id
 a640c23a62f3a-bf0ad9ebf64mr15174966b.20.1780437983314; Tue, 02 Jun 2026
 15:06:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan> <20260602211242.13870-1-safinaskar@gmail.com>
 <ah9LaPQayJ6tBE53@pedro-suse.lan>
In-Reply-To: <ah9LaPQayJ6tBE53@pedro-suse.lan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jun 2026 15:06:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
X-Gm-Features: AVHnY4La_ZzADdnhLw7VXJvUOP1cc6TzuLIwNWiX_o8vXHDUu8ML9nZoEC5oxec
Message-ID: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Pedro Falcato <pfalcato@suse.de>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6496-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,suse.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48A1D6325E4

On Tue, 2 Jun 2026 at 14:37, Pedro Falcato <pfalcato@suse.de> wrote:
>
> Well, that's most definitely part of my patch. Also, you cannot outright
> remove splice() functionality

That isn't what Askar's patch ever did.

You apparently didn't even read it.

Honestly, I think you are the one out of line here.

Askar did something I suggested years ago, and didn't remove any functionality.

It just changes vmsplice to be a copying model (one of the directions
already was). It doesn't change regular splice at all.

And yes, it has the potential to be a visible behavior difference - if
some insane user uses vmsplice and then modifies the buffer
*afterwards*, then that would be semantically different between a
zero-copy and a normal copy.

But that would be insane behavior, and was never really reliable
anyway even with zero-copy (ie subsequent writes to user space buffers
would potentially do COW breaking based purely on timing and memory
pressure etc, so anybody who relied on it being visible wasn't goign
to get it realiably anyway)

Perhaps more importantly, it has the potential to change performance -
zero-copy *can* be a performance win, although typically it really
doesn't tend to be (looking up the page mapping is often slower than
copying).

I would expect it to be very clear in trivial benchmarks that aren't
actually real loads. And probably not visible anywhere else.

But your responses have been making it clear that you didn't seem to
actually look at the patch or the history of it.

Trying to make it look like Askar is the problem is only making you look worse.

Anyway, the vmsplice() thing is queued up in Christian's tree, and I
guess we'll see if anybody even notices anything.

              Linus

