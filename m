Return-Path: <linux-api+bounces-6398-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eO+OMQfgE2qzGwcAu9opvQ
	(envelope-from <linux-api+bounces-6398-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 07:37:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBF5C5F46
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 07:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18D60300A537
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 05:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7BD340A47;
	Mon, 25 May 2026 05:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mI7+58UN"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7271AC44D;
	Mon, 25 May 2026 05:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687428; cv=none; b=c99XjiBtF9kXo7DlyEOxewEH2A0csj6o3LIy9xZkcvbfA3LmU6WuwU1/zkw2DB30OCtFr0hiB1psPlCNmnlLeciYM7Fvd2rw1/Q/2trMIRVJ3TFj11ZIKXw71tUpXTTkU/Ds/qVISIlqB6oG7CN2Ujvx43P2I9o+8PGOOb/mSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687428; c=relaxed/simple;
	bh=aSUk+GkfuNtV5doxYAl/uvzB5aZCrVlMtp/gV8VEcc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I90zeiJYWgAOFwp4TXYvu0ym4Warra1cJ5RW6TBumt2cewEGTkcNhkF8CVo1cAIvZ9WxE09Q/MbZfddhNAQttxeV/8UsJhoznUWOqyhDt+F6LC30sJCKXxawWiyW0sk6zC7g7711iR81/FkKA/VCTST78khY4rHXgNbyVz6pjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mI7+58UN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bPlnrUAngQhntq0icVQxK0A5R6EP/y6CGfxUmuJ8Roc=; b=mI7+58UNZvQ1rHO+UR+G3zOxD7
	/8Q4dyZKxJcdSNb/R47cH8reyDTtiHoTo+ZY1PEHKP1sCy7wV2KEhwd8MNm/M9D7VXNwHZoztfouo
	ellPDj7sZaVnwIcwtuRKY+kRVN9tGtX3CfEZ+71st7D3jw6OwcdGneEEFEF9XNvEvTxVz0XU8F5v6
	aKLKYaDQcv0dpz+Vxwj0TvKoeLyqOXxQt3Fs7io8F6fnGJKSnqnfrBDTuM9Bjn1mwkQsNTWDDnfhD
	qxzwqs5H2TVfEJQkzZA/O6FF3yMLeD+t3A5pcA1FIZEHbDav7HM47fbADf9+YeeWA6EZTFKtS8mej
	OhB0Hp4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRNzu-0000000GKn6-0I3f;
	Mon, 25 May 2026 05:37:06 +0000
Date: Sun, 24 May 2026 22:37:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahPgAog1c6SltcQS@infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag_OVwPF49LSZ7rz@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6398-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 36EBF5C5F46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:32:39AM +0000, Jaegeuk Kim wrote:
> I went this route because Android heavily restricts ioctl() permissions
> and we needed broader access for this to work within the framework. It’s
> definitely a pragmatic choice just to get it running in production.

That is not a good reason.

> If ioctl() is a right way for upstream, I'm happy to change this patch. By
> the way, I really don't understand why all the messages are so offensive,
> even without trying to understand the problem or guiding right directions.

The right way is to:

 1) Talk to the relevant subsystems (MM and fsdevel), and if it affects
    userspace that linux-api list and actually explain your use case.
 2) And then actually listen to feedback.  f2fs just keeps piling these
    ABI hacks on without any review, and it is causing real problems.


