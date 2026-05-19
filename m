Return-Path: <linux-api+bounces-6355-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MA8nJkhNDGqWeAUAu9opvQ
	(envelope-from <linux-api+bounces-6355-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 13:45:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4D57DED0
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 13:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22C3E305C6B1
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 11:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F364A340B;
	Tue, 19 May 2026 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qm1jxd9e"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AC495523;
	Tue, 19 May 2026 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190935; cv=none; b=oWKlbrRHrljxkY9L3V+PwvSn2Jx2Wzan+O5moyoIO5qbpW3ryJbvnbaXpZPQoAfwnFg4YVOvsT/SS2Xxp0iTslIPpCgvx/PyMyrWptIboNYoPN7VP9hmH05QULaM8w6zu/lJ6IrnYteLU5ncrVoUgXLk5UayJOkmzSJg3WfUuuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190935; c=relaxed/simple;
	bh=Ki3Rp5yJ4v5ubO48sMHC83oQZh7+CgA8I0IigrUtArc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldrqJ6G54DvwrMrqWCZruaMTpgkKhK6WvILy+fWioTGlz5jR45gdV7P0RjIkUoXQnWNw6mUTxASibOgaAjOY0xLZ1/VdOqwRuYNZpddWl53eKvflzlnXpiAC8WrYQWVTJVVeF18JkhMUypN6eG+tqQKv/RHxJNBrjPZy88jc8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qm1jxd9e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+3KzmSz2CfeRwzjYKPwW110AYgzmgb84Yz0zPyKDkrM=; b=Qm1jxd9e9RTY3FAb7tHsHmDMKY
	0Vbv7Q4XlfkkdVnsAK6NL1vVJxXz58AEVWXvbD7u/KXsfutyLO4A2qGwh0gOLEM9PjAeklLlrj7va
	ynY/YnOSgWrwUmfy5b9LQMKKAZOKEwer3YMpjQfT54NOeKqORruybmc7oc194zN1reCZhRMWGip5V
	pobEbM052fKBMM2RqvzY01MHtxY6LjJhGYbkmq9dvewaBbsLBtUeleTe5AMMAq9AzWpjBuXT/wzrg
	bIzOYNyfNfPq7yHLIXQjuvJvVuAuXOkmkx5Mu/VjC/4unoQjAy18B2jUs9cScAGMQr5g5F3AMshoS
	whA8AMVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPIpt-00000001MYS-0LjC;
	Tue, 19 May 2026 11:42:09 +0000
Date: Tue, 19 May 2026 04:42:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	Cyber_black <Cyberblackk@proton.me>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Mark Fasheh <mark@fasheh.com>, linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <agxMkaEMMbQGzqsk@infradead.org>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org>
 <20260519022327.GA11894@macsyma-wired.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519022327.GA11894@macsyma-wired.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6355-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 41B4D57DED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 10:23:27PM -0400, Theodore Tso wrote:
> I disagree.  As I recall, we discussed whether or not FIEMAP needed to
> be unprivileged many years ago, and it was a conscious choice not to
> require root privs.  I don't believe it is a security issue to allow
> users to see the logical -> physical block mappings for inodes.

Users have no business even known it.  It is a side channel that can
easily leak information for attackers that know allocation policies.
And as the reported state it also is inconsistent with how FIBMAP has
behaved since the damn of time.


