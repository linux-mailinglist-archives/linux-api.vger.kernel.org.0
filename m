Return-Path: <linux-api+bounces-6483-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIC4LGmzHWqkdAkAu9opvQ
	(envelope-from <linux-api+bounces-6483-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 18:29:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AFE6228FC
	for <lists+linux-api@lfdr.de>; Mon, 01 Jun 2026 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C69A306A62C
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2026 16:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94B12D3A75;
	Mon,  1 Jun 2026 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BifbDx5D"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4BA28C2A1;
	Mon,  1 Jun 2026 16:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330661; cv=none; b=uCXNAPw3/Rb+29/E9gZPM1lVsViGrmdmwcW84GYp/JKRYKBpcj+ZhdlqABv6eOlK26ipeapBtUP70c2s8hMC+L0cGfzAzvDJEvHwj0778e7np7jg4bh4kBE9pegItQYJ6ixMliGywCcZXHXqJ11TImMQS0zBjFWBYgQsHRcRRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330661; c=relaxed/simple;
	bh=Q/KncJprqoJCnS3aH2kF+5RbWfUXbgZH5dY8f1wE2u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mahYEJWZfb0cUzaC0snMvoKnfxzDezAwnFGgQSwI8ELRxQcC/mNVf1MWfVL8ZUVjssQaBrJ5Q7q0i0oLosiwFP/4VQD+aWAB0Xgs3nw6de7kmx2CSjg4CcP+TN4JDBh1OsJIrQUDjtSYyA3Di2jhhwnwOXSgU+CEK5AB6+vP9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BifbDx5D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E1C1F00893;
	Mon,  1 Jun 2026 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780330660;
	bh=rNLnkxLxw0b3sBZzOdV8X6NVlh7ujukPI0iIaNRmGIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BifbDx5D653jXTMEUYB65fYghTtrNqepjSBzEEPnsZHuvMiKkUOlVvAuDnhiuDt+S
	 304eftkIVK3rIX5PhVwBL44KNhsA9dJwCSyTFzVTvI30ARJthbxHrK6U7NK9+WK5GY
	 TC9AesLZFTlE3g6mll/KzrdOMnxuE7tBLKicmwOzeWy73MC+/4AL/ZfXfEjcqljG9V
	 pBY6dZiayBvckutKYiFU/gdYkCs+GfJfmG1ifRYuW+2TFchPjF+q+XEM/3y/pdWpRJ
	 eCatAhyfCn+EEyD2fqdkmd2KXIZ26Uz9dsqb3EYg5nVWNFlArRGKYC3M0cqkoD14cB
	 9u/DYe8gzQbPg==
Date: Mon, 1 Jun 2026 18:17:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260601-aufweichen-dissens-ausrechnen-0d9b84728113@brauner>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <CALCETrW__=8mSusayfXG7UFCfue5BGbx+vqESj1d9wqOfX4s8w@mail.gmail.com>
 <ah2nBAdsE5vVJ2PL@casper.infradead.org>
 <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFuud0Nn3B9YpTWyQja08TeXVk2AB-aAkmVXyigOagbQ@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6483-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,amacapital.net,gmail.com,vger.kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,kernel.dk,redhat.com,linux-foundation.org,kernel.org,suse.de,szeredi.hu,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: 68AFE6228FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 08:50:00AM -0700, Linus Torvalds wrote:
> On Mon, 1 Jun 2026 at 08:36, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Can we review this series properly?
> 
> Well, since it pretty much is what I suggested a few years ago, I
> certainly won't NAK it.
> 
> And the patches looked very straightforward to me. Just the final
> diffstat is worth quoting again because that certainly doesn't look
> problematic:
> 
>   7 files changed, 33 insertions(+), 204 deletions(-)
> 
> and it removes that GIFT flag that was truly disgusting.
> 
> So I'm certainly ok with it from a "looking at the patch" standpoint.
> I didn't _test_ it. I don't have any workload that might remotely
> care.
> 
> I did a quick scan on debian code search for vmsplice, and after ten
> pages of entries that weren't actually *using* it but had lists of
> system calls, I grew bored. So there are likely users, but I don't
> know what they are and how much they care. It *might* be a big
> performance issue somewhere. Unlikely, but...

As usual I would argue to accept it and revert in case we get actual
regression reports...

