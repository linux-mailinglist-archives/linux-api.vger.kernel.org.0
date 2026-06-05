Return-Path: <linux-api+bounces-6546-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bR1wAsYuImpOTgEAu9opvQ
	(envelope-from <linux-api+bounces-6546-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 04:04:54 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BD64495F
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 04:04:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h5kFVbKG;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6546-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6546-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EBA3059308
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 01:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B53E1216;
	Fri,  5 Jun 2026 01:57:38 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED3380FC1;
	Fri,  5 Jun 2026 01:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780624658; cv=none; b=YaAwXcRzk1GPsDMyAobyXw5QivNFUkKlvsW/YzYO7J3R32bIeVwbBd1wOJVv5iauS8TBF23gxRGtVdUiE/CDHuJli8VleKNvymdGeSTad6R9AUGyT0g08ZtnzHlkYBp8LbyvTE8+NPdskHW1zXdQ9xxL+Hf4ljU5STgARzRzsUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780624658; c=relaxed/simple;
	bh=FyD284KL2h6kq9Zsrb0/HR/oaReskZnD6LUfv9AEEkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIecx0VqdRaoEhJqTr0/tT+gNAqMHhbqjiblHILGFqOyJFxd+P6WCML/8h29qY/WXsQMxdf7/Fnn4JEedZqPFoOWMHmhrWOV8AYWAqrqEZud2wUwRgvJlBTv1cdSkQyMVoY2pzwF84dnOmogdaA9i3Jfep2U/MIDqUn6qjCGc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5kFVbKG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4348B1F00898;
	Fri,  5 Jun 2026 01:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780624651;
	bh=hSMeDgYWfG9legqy7nLxVx38jDi5V+SRhptqZ18fLp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h5kFVbKGgWVM4/By8YauS1zHj3ZfSM7nv7xk5g47JSYjO4uExbSJ8vU62gwc4dAjb
	 9QQCREwAtgUZqllgZ0AZ8AUIqgkKZFTwlNCOGAb9zpcS8ZM+lT1XkImHiYqor5wnS1
	 /XlH4Q1yDcsbIC2OsFk+IKqTlK9WBNa20C5VrMvxCEruIE9fHYYaJ7JmPuzX3Wtp2i
	 3EghSwMOFry9oSJBFg7uVX9Lsap2HZmy+EoldQIf4mz2RbBTkpKKaPMVrv4PmoLKgA
	 g6YTizz/03AnztZfkq647HYGn7jqBBAF5k1WupLx5j698k7fx5hbgFDH/ed/3FrRFy
	 43v2riFR3o/4g==
Date: Thu, 4 Jun 2026 18:57:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Askar Safin <safinaskar@gmail.com>, metze@samba.org,
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
	david@kernel.org, dhowells@redhat.com, hch@infradead.org,
	jack@suse.cz, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260605015724.GA520134@ax162>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com>
 <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin>
 <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604223216.73468830@pumpkin>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nathan@kernel.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-6546-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,samba.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ax162:mid,godbolt.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 502BD64495F

On Thu, Jun 04, 2026 at 10:32:16PM +0100, David Laight wrote:
> Talking of broken compilers, had you noticed that:
> struct foo {
>     int a;
>     char c[32];
> };
> 
> int b(struct foo *f)
> {
>     return __builtin_object_size(f->c, 1);
> }
> returns -1 (size unknown/indefinite).
> You can't use __builtin_object_size() to stop code running off the end
> of anything referenced by address - even when the size is constant.

That is the entire point of using '-fstrict-flex-arrays=3' in the
kernel:

  df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
  https://godbolt.org/z/bvfrh7W58

Without it, all trailing arrays in structures are treated as flexible
arrays, even those with fixed sizes.

-- 
Cheers,
Nathan

