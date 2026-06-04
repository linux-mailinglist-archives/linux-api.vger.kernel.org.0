Return-Path: <linux-api+bounces-6534-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NjhzNhyRIWoiJAEAu9opvQ
	(envelope-from <linux-api+bounces-6534-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 16:52:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA4A64115B
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 16:52:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=R3eN1z2k;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6534-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6534-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E418307CCAC
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503347B439;
	Thu,  4 Jun 2026 14:39:18 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B647ECC5
	for <linux-api@vger.kernel.org>; Thu,  4 Jun 2026 14:39:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583958; cv=none; b=m1m8AN/7nHURTckny4FUTsJXx9rT6tHwwJUGi+Lx8iYto2bArSSMMw6AZgdUCDa1mkPM7aeYDaOYd+JVm0BIbSsIsMD2nGpPcIPibzVQVFzuTnUISTivfioHEU6ubLPoG0NdT+2KAnocVuAXKizo8nQfSjytTg8Jat1MDHpD6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583958; c=relaxed/simple;
	bh=+HiAUq8B9doNx03/+UK5dzZU592ZQOyFYQ50hXTQNq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf/DKqk9JuHdYpfomW49vEpfTl0h5KSMZi8bx/M0o1KDUtDSiCalxkJtnPJ8OURT3dZq2ibCIgCYSSK8sCxFRDK7J6bhs/ipOzM8SAkgJBgSpyWzuE1VEe9VrOxM2BvOtj/f9ur+lISokVn8KfMzi8r7+uxhLdz9UwhU6/JoH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R3eN1z2k; arc=none smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso128327166b.0
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 07:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780583955; x=1781188755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jHCD/usXrKJEgEC7iBTBFv6T3P+9p6Aw20cG/HazQio=;
        b=R3eN1z2k7UviTNTtXTmms/tm421YGcPPTSlmw2GSLQRoyMsR0EKtB96190UFSI+1RA
         ZJK6ntF40ileWLePrAMoVu+FwnNLZd6z/hAQUGwsTvrO2xP1d9ruJVcHiFRhLmxQ2Tdv
         nebMib70cEA7Sd3g+/FNvlW3MER7KU/AVkzs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780583955; x=1781188755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHCD/usXrKJEgEC7iBTBFv6T3P+9p6Aw20cG/HazQio=;
        b=mnDpk/hLiiSQGu9Hk3JgTJr+C0JryEVgAZld5k4tvcUT2QsSj12vxpAGfWj7k4KNuy
         bbrOhS57W3afHkDfghOlem+SrTVp0O+fjiXz4pZevOVuUKjtMS9ARM12VaC+uptEAqnA
         FylBy4bVD6cTLgm5qgK4ybIk8r024VwYAPWMYXebgympKYeYSiV6yZb2KMrPtZd94PwZ
         I+iXEYd8hDMD9JCB3W0PwTri/gI3AXqABa0h4NzVp7NcbJLIzGsip0fVWuuvU0cvw05Z
         2ZtWVJ588TRkBYseXQ8Z5XVx38/7uaNmml/Cq68lIUGwyZdWG+Ty2h9xrmdE95O5ft3S
         upiw==
X-Forwarded-Encrypted: i=1; AFNElJ8XySuCbZlYGyLmICMMlCPyUY0Pw+8URCdzRoUCwUyZLZ8wDGBTPNwxFAu1OVah7SwUUXGzbXJV9hE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx70Bbe8S80ASpLKAciq20Po78SK+Gttfevf5RyfFNNb3bC25Vj
	LJrvtkSMJ5QGZaIrOgA/nYjZjkVNwG9775+ZzzDImGMTaiMcNiJ0jI/yY/NldB3flDgcTnnjB42
	41I8tHwuqGQ==
X-Gm-Gg: Acq92OFZbwVgFPoMmSXY2yhG3IZ+CGlR9eKIq+8E8XSF4Mq1yTND++ZKEXxfo3BzLZG
	yXHvIEV9YH/6P6OWr7j5hhUjTpW+2HotiHEXIdsvyJ6zPFrInAO1QPdbOFRrpvm7cawo+2w4ysF
	d1LfYJEm4q+NfXN5M+aAPB1OMBm8AJfpNWvo8SyiyvPhhC7fclrbwQm7hn4g0dGOZsU1rThLnh1
	0QI/E60aiUvrn69IM6o8nX9mPrbvevDw7uFem/bfnzxr2ukfaX2sfsTNFOBdt1nKSk5SEVbletS
	4IhPJh/k2/UU8EdgWtPe2IgfUFcpXCE+AqntzOPWGIJUYKyBvocGG269+dizmn7oYFG3OjQ74Xg
	5/VehXeLSn649egkO4Dn2nD+qrax0GbPSl+1bpT2+QDu1pXwK09Cg8/dMIN3lgTGOcJAX5lDA/d
	q1cIVVGbLr6AA/Wi1rPn73OYPnXC5bG7J/nEg2EpbB+gP+ZTZgFmMfAFVTa9ifyBaRjXHL0ZnK6
	6d1fj6e6Bc=
X-Received: by 2002:a17:907:28c6:b0:bd5:18e8:1ac1 with SMTP id a640c23a62f3a-bf0ac4022bdmr302664866b.5.1780583955053;
        Thu, 04 Jun 2026 07:39:15 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1ac0sm312943266b.62.2026.06.04.07.39.14
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:39:14 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bdb3fd39045so102370266b.3
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2026 07:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/BAkELIfCOs13+MgUhxlTpyMFfnrGoZl93DTzdYuBhkHbpXrU9Jz4YbqSGpagX2clQBKkZsVCN4PY=@vger.kernel.org
X-Received: by 2002:a05:6402:43cf:b0:688:12fd:789c with SMTP id
 4fb4d7f45d1cf-68e70412737mr4177929a12.9.1780583507075; Thu, 04 Jun 2026
 07:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org> <aiEb8CTM-ovMIq7-@1wt.eu>
In-Reply-To: <aiEb8CTM-ovMIq7-@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 07:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
X-Gm-Features: AVVi8CdMcH2Yi8zy-bOiW7jRaCCsKof-RnAg4JQ3nwUYFdve2Wu3l5Vz6H4KhIU
Message-ID: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Willy Tarreau <w@1wt.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, 
	patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6534-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:w@1wt.eu,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:from_mime,linux-foundation.org:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1wt.eu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEA4A64115B

On Wed, 3 Jun 2026 at 23:32, Willy Tarreau <w@1wt.eu> wrote:
>
> I'm using vmsplice() + tee() + splice() in high-performance applications,
> load generators to be precise, and soon a cache. This is super convenient
> and extremely efficient:
>
>   - vmsplice() is used to prepare a "master" pipe with data to be sent
>     over TCP or kTLS
>   - then for each request, we do tee() from this master pipe to per-request
>     pipes.
>   - the per-request pipes are those that are used to deliver the data to
>     the socket via splice().

So most of those would actually not be affected by any of the existing
patches: the pipe->socket splice would remain, the tee() code would
still just take a ref to the page count.

The vmsplice() would change, but looking at your haterm.c sources, it
looks like it's mostly a fairly small thing ("common_response[]" being
16kB).

That is typically *faster* to just copy than look up pages.

HOWEVER.

It looks like you're actually doing exactly the thing that I thought
was crazy and wouldn't even work reliably: you change the
common_response[] contents dynamically *after* the vmsplice, and
depend on the fact that changing it in user space changes the buffer
in the pipe too.

So that would break *entirely* with the vmsplice() changes if I read
the code right (which I might not do) simply because that looks like
it really does require that "wrutably shared buffer after the fact".

Interesting.  Because the vmsplice() code uses get_user_pages_fast(),
and honestly, it never pinned the page reliably to the original source
- it breaks COW randomly in one direction or the other after fork()
(and I thouht even after a page-out, but thinking more about it the
swap cache may have made it work for that case).

Uhhuh. That does look like it makes the vmsplice() changes untenable.

But I may be reading your haproxy code entirely wrong.

               Linus

