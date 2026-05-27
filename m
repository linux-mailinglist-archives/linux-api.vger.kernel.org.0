Return-Path: <linux-api+bounces-6423-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGJKIeKPFmrHnQcAu9opvQ
	(envelope-from <linux-api+bounces-6423-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:32:02 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE2A5DFDE5
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A12B7300E283
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DA238F254;
	Wed, 27 May 2026 06:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUzqHve8"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373D2140E4F;
	Wed, 27 May 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863520; cv=none; b=iXWJnauMmTKFqgfV9An6Hx4yvMoCmaaCk64SNOUhrCVkh1diKhWpF9uuPFv0rj7UEA25ZfhN4xW9FRrx0Ns7gcCZNrEj3USJagXBgkoLSrVNuNUUA+tXYl/kkPB8iQA1Gbylc4aNVz8Uf3cS3aSjrXN7vYf2LU6LK5ALwWx6/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863520; c=relaxed/simple;
	bh=f4uf+8uNOy9gjTRC+xUpy219vU0iEBItjTCMIrroVeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8Xxve2V8f4jAjZMWAQTbY5XRqsBpLl00UjMBLoOPmQdfrEPx6PihrGwkAhO8cj1MKvvM1miIxmidn+yJkwUoog12yyS1tPjuAvOUJpVLcWKoz7eLdA8B7SClue23RLLliYAkY2z7z7rp7VsLuV+JmDrSfNTqd8rnppDuLTx5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NUzqHve8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nWhD6NqGWQeaAF9weLMiDIdx5fT308tj+4gRK0S0CiQ=; b=NUzqHve8UC+23s3rUSjCC3Rq5Z
	KvOYLnH5KIouDOlaogy7L0fmNrUmy3yijttvpBzJWa34SwE6Ts5eOS5uZ1zQ1kwMkiH0FCTME1B5v
	343TQK3949E+T+zXA3en4J0yTTU2Y5tU6fB5QuMbUJd/5ETZzIpFVCEHjbHjZalxiwm0udRHofEPu
	JoJ9lz+Twd7M0Ycq+jimrec5bxUKNGPtkxkW4SYh78xE5r/tNgL3P1R+4wRRh5mkSL2rn9+oLSsUi
	pm7o2iyAxQC9R6MV1khw1ig6MyNgg3P6JHfeaFj5IfJeeQlXPWtEWzFdtFA8ygTTVW300stpZHCo6
	RoL2an7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7o6-00000003PEM-0j4G;
	Wed, 27 May 2026 06:31:58 +0000
Date: Tue, 26 May 2026 23:31:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahaP3p1ZTBIDAuhH@infradead.org>
References: <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
 <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6423-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4AE2A5DFDE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 08:21:43PM -0500, Theodore Tso wrote:
> The bottom line is if it's right after device boot, there are simple
> techniques that don't require hacking up the f2fs.  But in the
> demand-loaded case, calling compact_memory() is the last thing you'll
> want to do.  You're better either asking the mm to allocate the 4k
> pages, or do whatever compaction it can do to just free up 2GB worth
> of folios.  (Calling compact_memory() is overkill, and only makes
> sense in the context of benchmark / proof of concept demo.)

Or have a lot of clean pagecache using higher order folios that can
you can instantly reclaim?


