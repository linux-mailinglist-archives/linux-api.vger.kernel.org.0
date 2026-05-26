Return-Path: <linux-api+bounces-6407-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id elO/GrgUFWpcSgcAu9opvQ
	(envelope-from <linux-api+bounces-6407-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 05:34:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74B35D05B9
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 05:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FE8D3013D4A
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 03:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B63803F1;
	Tue, 26 May 2026 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ox+6z2Bb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA71922FD;
	Tue, 26 May 2026 03:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766452; cv=none; b=U4CQ9kzNC7D4KDofViCDLTBjNhfd3nBZle/Yv+tZZjXFcZtQZJTuK++u55pPljGzWnI5/Wqsmua9veWcGLDE/7uRFPP57INL07IL9H+K5oiirt4IogYt7mKzWLHJWQESSqrZBUIpXw0mRaxueRlNW1FH53vO/FCc9ndEk2cJtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766452; c=relaxed/simple;
	bh=pPhRBG0MXJTwzas0bfTazDUS8yaD06Gxs72Je5u1SZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn0Imwfr4D9v3oDz+hxhOngxl+1e/f9MMZohSpTqxrNE8OlEpYbUQp+NbP3M8lq8xeAyTm6jB1gHWn4Y3+agzHcHhyp4BphT+bIOpvcYyI4up8e02Jh2FGlOTu0BZR7vFwvLLCNRDa4/FL/jiel8AFU2G+9ig9fZ88hVIBrAVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ox+6z2Bb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D83A1F000E9;
	Tue, 26 May 2026 03:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779766450;
	bh=kzxIDQSSkfJgeOWIE/b/66yps/8QKZUf6btX6QP9PLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ox+6z2Bbjg3Ky/+rp0Bm1D+6MC26KlSfeMtVH9uQjXCZSGA9a5fpcM5Le8m82mWEI
	 2Ww0aMuvq88M/TosuQf9mS6uLWIUceeIN+DjUZFT56jeT2NHNjY9jp3E3LCHVoMgtt
	 rkmSLKjwU5fGSkFJm8xHevnqNl0DaAMktd1/efGifsG2Qe9RgF735AFBuqjJOxIsHv
	 5eUXkfiRT319JXGDS0KRGF/oHdzCvyZ/LJNwS9BLfKd4k2vHiKdFMmfRp/Npm4UzMW
	 crbIBM8hJO6QnAZTfWdtC8jZxzEBkVtJ6X/fk+sW6mle9oBXOPjE6ZGtjTZMW5Y72O
	 cZ8DmHAeH8sDw==
Date: Tue, 26 May 2026 03:34:09 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahUUsXZS6FN7dr3M@google.com>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ahUG3ZCnc1RQ0EL_@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahUG3ZCnc1RQ0EL_@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6407-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B74B35D05B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/26, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> > Let me try to write more details, helped with Gemini.
> 
> This is garbage, and frankly disrespectful.  I'm not going to argue with
> your AI bot.

I wrote down all and they rephrased it a bit. Which points are you feeling
like that?

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

