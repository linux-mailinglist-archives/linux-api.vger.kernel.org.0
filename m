Return-Path: <linux-api+bounces-6344-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE0BO/+eCmpY4QQAu9opvQ
	(envelope-from <linux-api+bounces-6344-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 07:09:19 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A49565DFE
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 07:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A36C23002D39
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 05:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BB8380FF9;
	Mon, 18 May 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kLJMVYFj"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA61377004;
	Mon, 18 May 2026 05:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080905; cv=none; b=t6lZuL8/DA6dthLLpOsYhm6A1lEZ6T0CBKithA7Rwbc//g+LNefnyqP3zh+G5O+p7SBi1dcGIsfQHy9nXcSiheT0Z3qZG2GDYDQkQ3l4eS0AyYIsXAIljxsn+J4nxL4Q7EHz58ZVJ+DhIY+JL+igzJBOXkg5KCTbTk5Y+IiNR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080905; c=relaxed/simple;
	bh=maPAoW3smVxAUqbqrJ4q4Ge7moP/mr1oPW5r/SpQC/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBO97+CmwGp8JLUtfVvp8Me4TjGP5XsVhEn/qB0n4RXzTN3Be/y6ByC5ZzfJBtn1vl2y50TSRCa6Bloz0nk1XARvfgtZU+TYqroxhaVRU1xdnJp6uyPo9190b4qwdegHqYnxxYhurbfN50MvUwmHBZNJFgVv1F60U4vTei9bULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kLJMVYFj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8VLXo68qsPFoCf2qo8fOLvYIOZf/Qe4Ug1wysRydhEs=; b=kLJMVYFjp5oqYK+IX5J3oU9tLh
	+hKqv5MCr+HxIgyMgbUJjWhN+zAbU5lFQFcAaQTHuhXsKi9zYXE88ejTTpdtTHA/+aIeE/THFmf9r
	d63SwpNgsfXDgGp/D+lljzxkBv3wUtA5nei43f6J6tcWAt3Sp8aBysCTh/XMy/OHB6Q+lKj9Ncbi/
	pcWvh1uDh+ukneLMMlq4QQEKdaqvAQhdQpGGcG9D+S8oeopoJJMWqlrTEYY0bDqklUtTHdBeoXe2b
	I/dZQAQqH9vc6JlPkKFxLE0k6ibppOYvMy53gMLdvmrHbVIjW3b1stxlKHI+TX9yJzi4I7P1+/+mT
	38EQAn4Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqD7-0000000EDxs-0pyw;
	Mon, 18 May 2026 05:08:13 +0000
Date: Sun, 17 May 2026 22:08:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Cyber_black <Cyberblackk@proton.me>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <agqevS--YYBVW2Oz@infradead.org>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: 95A49565DFE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6344-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
> This restores the intended restriction, at the cost of breaking
> unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
> This option is a larger ABI impact and likely undesirable.
> 
> The preferred fix is Option A, since FIEMAP has been available
> unprivileged since 2008 with no reported security issues, and read
> access to physical block layout is already implicitly available
> through open() permission on the file.

No, FIEMAP really should not be available unprivileged.  So I think B is
the right thing.  Can you send a proper patch with a proper signoff?


