Return-Path: <linux-api+bounces-5748-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMrqLSw8dWlUCgEAu9opvQ
	(envelope-from <linux-api+bounces-5748-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 24 Jan 2026 22:39:56 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ED87F13B
	for <lists+linux-api@lfdr.de>; Sat, 24 Jan 2026 22:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2B043011760
	for <lists+linux-api@lfdr.de>; Sat, 24 Jan 2026 21:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E9F2836A0;
	Sat, 24 Jan 2026 21:39:45 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090F42836AF
	for <linux-api@vger.kernel.org>; Sat, 24 Jan 2026 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769290785; cv=none; b=FgWtgIwfVjr/m8FNOacLONiQFcQEsaPYzRoyFGC1kX4n7eXSqU2SwnNTUSFVDniehlipL1cFeCj0rwJuFj8WVd9eOMhohBcJ1ciR2eRtqDXHlZVyqn5Nu3xNnaw0t249QKVCmND4vOsn30MDrptbx4DJ9Eanw/qvCCDIAjJPeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769290785; c=relaxed/simple;
	bh=/mid9Q9CXUWG2ha83G0bBjVrJ0AD7rA0cgemMAil4co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eol8xSHcOn48vfIXZnYtIHt84ipk/IgS10GA7nk8E75vWIGn/XpopPhcAbkkoNFk3hFzl8XQMRTvpJSRODEB3yt3fZWCP4xksgT+E0AKJLYfuSs4uknzQnpaZKh8AqPWZEvWi1uVncceBD1iV2aENZ4bUkJwegpqKNS4CSIGQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Sat, 24 Jan 2026 16:39:34 -0500
From: Rich Felker <dalias@libc.org>
To: The 8472 <kernel@infinite-source.de>
Cc: Zack Weinberg <zack@owlfolio.org>, Alejandro Colomar <alx@kernel.org>,
	Vincent Lefevre <vincent@vinc17.net>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	GNU libc development <libc-alpha@sourceware.org>
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20260124213934.GI6263@brightrain.aerifal.cx>
References: <20250517133251.GY1509@brightrain.aerifal.cx>
 <5jm7pblkwkhh4frqjptrw4ll4nwncn22ep2v7sli6kz5wxg5ik@pbnj6wfv66af>
 <8c47e10a-be82-4d5b-a45e-2526f6e95123@app.fastmail.com>
 <20250524022416.GB6263@brightrain.aerifal.cx>
 <1571b14d-1077-4e81-ab97-36e39099761e@app.fastmail.com>
 <20260120174659.GE6263@brightrain.aerifal.cx>
 <aW_jz7nucPBjhu0C@devuan>
 <aW_olRn5s1lbbjdH@devuan>
 <1ec25e49-841e-4b04-911d-66e3b9ff4471@app.fastmail.com>
 <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f60995f-370f-4c2d-aaa6-731716657f9d@infinite-source.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	DMARC_NA(0.00)[libc.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dalias@libc.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-5748-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 20ED87F13B
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 08:34:01PM +0100, The 8472 wrote:
> On 23/01/2026 01:33, Zack Weinberg wrote:
> 
> [...]
> 
> > ERRORS
> >         EBADF  The fd argument was not a valid, open file descriptor.
> 
> Unfortunately EBADF from FUSE is passed through unfiltered by the kernel
> on close[0], that makes it more difficult to reliably detect bugs relating
> to double-closes of file descriptors.

Wow, that's a nasty bug. Are the kernel folks not amenable to fixing
it? I wonder if that could even have security implications. I think
you could detect these fraudulent EBADFs (albeit not under conditions
where there's a race bug) by performing fcntl/F_GETFD before close and
knowing the EBADF from close is fake is fcntl didn't EBADF, but that
seems like an unreasonable cost to work around FUSE behaving badly.

Rich

