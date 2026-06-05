Return-Path: <linux-api+bounces-6559-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iG61Gpz1ImoefwEAu9opvQ
	(envelope-from <linux-api+bounces-6559-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:13:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D210A649A81
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:13:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=Db4VlMey;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6559-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6559-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 534DF3077CAE
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 16:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710783C6A29;
	Fri,  5 Jun 2026 16:03:15 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA66937DEAA
	for <linux-api@vger.kernel.org>; Fri,  5 Jun 2026 16:03:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675395; cv=none; b=AflGuI3wSbEHKxImhU/8eblbac2Bb13YHp90i4T07sdbLyTjU63hCiVRcjVLYNe24Noapc+N/NGwLKGb+CePo4WF5ieXqcSy+OO50BTJ1jcvYk8pPf8oXg5WnlrBI6L86QXiZBUdoTw/p6GE3c6Qh1VLdk+B9QWlM5OLMnSgTuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675395; c=relaxed/simple;
	bh=3Jk2TzG5gR2RH4+LwM3XSlFeV25EIj3RoPOfWA1O8Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDnVW0BpEHFw/e2TH8/wdxtnKIuUlTT/DR7uEAjztJ0NbfwfigFN26hQXqt6iw5v4K8WWaFNQjxWvA0qQpWi+SjX8zFhtbf/hop7br7LFjREc/vJN+La9D/GYCJ0LgW801nfk6dXzAPvxyg08bq/AdksixhTXZqCoQhD4zQAVGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Db4VlMey; arc=none smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bdb3fd39045so267029166b.3
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780675392; x=1781280192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
        b=Db4VlMey7aOrXifHlB0bd3gFxZGcgccsE1dp/1r0znjB2M9Vpl5GmXTvUkTZwtgNIj
         4+CPKJLrTN+zEGsJEgPDjX9lRyIEvq7sqyDk0dwfvxsi158HH4YthBarO40aW2/baXrA
         hPRjncUvFeV2ihESB6RGuWVDJghPSZj5G5DaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675392; x=1781280192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6UQFMgxs4xPTWbEaYQXP4WreuO3V04h3DiBWisQT8s=;
        b=ip9fZ6LsHkOBLTbLzRKueu8YkjAKiCY0AC33NIrXS9APzIOlKa69eh8lHI0445khEO
         JbIeSv2Rosc40KwGkEaH+g9NEzTe6CvCKTtwFgfCLKg1rILzu4vQ7soPfiHQy8ZNbOla
         6Q/0lYh3KYfIDdCNiBbTq5ybMsShEQqmEEICrbvGQKxQX+6qQCOvr2Y3NwaSpQ/r8I25
         eVVFKUscrvIrRF7SYBsKdOwvROtGFE4MgrgFiQroCVVyzf/SHub/XbTYD8Ky0OF09bAr
         O6KPjowa4R1R6gA7vNWvPGRtxQcxD2x9thDO3kVnECzRoGU+dCaYF/oinHrzoPjIVc1v
         ksnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dmOWjjnNZ+WvKKn5nGJhRX4W3IBBRHK9mPKwFVaXJ6X72IxnrBfKJzONHdtevT6/+dXGtwURjYvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaD8MXr6jYinta+yDIYCniiNVv39mMSPfKJhmMwKFXHdOYzGu0
	TjDv0LbvUf9T+bnNRaDunjvQufcpmxxIPdumU1ULtUcJkB6h/lJSHc1+yUZ8hbEDKi8lUv+z3wa
	YWLubjXYOag==
X-Gm-Gg: Acq92OFSSrHjkFFX76e2lO+hkB1msYCsUMGTuniQf5pohOo5FKukkYVn6PgifTZ2F6R
	k1o0tMu8YwTn9iLZUzDhHKvZpNarlWAXKr+j0zOfcyhBcth9FAkMYa5znj54tSTTBLa8kNJV9Gh
	Oy8hcno6O+VMagNve99mRnVu5mLXQNwogbmAtF4kr3i96AUH3fFr9S4mn2bYVRo+uv3hknY5mPE
	OvIEq7JcvACyeqR6gXVIyXZXCt0Cg6sazzB5R27LEW5UewCwBs0zs4jHZgDXXdzQWHiGoOdZcbV
	tYlUu53m800kiMM+bCT096dGMv/QshqVosPDQtXR+PmI4/VJGXxjju8ujrZR4P5Sv2PWVRJuwS/
	gOmGStCAe6fJx7ElZ/gUU8Af0D95eymcZUUuXwvBsHGyDXBuVv9IiNTOGBh0/HYlKGqltf1sn3X
	6ux9fD5C2fFbaLPmd2Cz8jEUG+p2Ws/7RNNsON0TpKqt3W3CrppNFRVeTySdV14TJ8izZLR5wn9
	lKc20eKJjI=
X-Received: by 2002:a17:907:9812:b0:beb:7b50:3a7e with SMTP id a640c23a62f3a-bf3733fbae2mr230186566b.45.1780675392127;
        Fri, 05 Jun 2026 09:03:12 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05176fd20sm497701766b.7.2026.06.05.09.03.10
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:03:11 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bebc80100efso233390766b.1
        for <linux-api@vger.kernel.org>; Fri, 05 Jun 2026 09:03:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+VDhLeLhXg+n1265o+a+byqq4P3iq9YhQo9Jl/8r4RYRHETZ2i/cgyLsQkpmm6dEnRR9iXoIxJb1Y=@vger.kernel.org
X-Received: by 2002:a17:907:9686:b0:bee:323d:1239 with SMTP id
 a640c23a62f3a-bf372e1e4fdmr260752266b.38.1780675389972; Fri, 05 Jun 2026
 09:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com> <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
In-Reply-To: <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 09:02:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
X-Gm-Features: AVVi8CdZ5f-_r2ry70kDuq_xsye2rLgypwsymONxqFNfT92KlgrDUIUXs4-jBmo
Message-ID: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Mark Brown <broonie@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Aiswharya.TCV@arm.com, ltp@lists.linux.it, 
	Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6559-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:broonie@kernel.org,m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:Aiswharya.TCV@arm.com,m:ltp@lists.linux.it,m:miklos@szeredi.hu,m:patches@lists.linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,infradead.org,kernel.dk,redhat.com,linux-foundation.org,suse.de,arm.com,lists.linux.it,szeredi.hu,lists.linux.dev];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:from_mime,linux-foundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D210A649A81

On Fri, 5 Jun 2026 at 04:02, Mark Brown <broonie@kernel.org> wrote:
>
> FWIW this is triggering a failure in the LTP vmsplice01 test case (which
> sends with a vmsplice() and then tries to read that with a splice()) in
> -next:
>
> | tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmsp3vEmQ as tmpdir (tmpfs filesystem)
> | L4471tst_test.c:2047: TINFO: LTP version: 20260130
> | L4472tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260604 #1 SMP @1780589917 armv7l
> | L4473tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
> | L4474tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s

I htink this is the same thing that Christian already noted (he said
"reported by David", but I don't know which David ;), where the
vmsplice() writev() emulation was done as a blocking write, even
though vmsplice only blocked at the beginning (ie waiting only for
_initial_ space to write, not then blocking afterwards).

                 Linus

