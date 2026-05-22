Return-Path: <linux-api+bounces-6379-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MztqDL3UD2rIQAYAu9opvQ
	(envelope-from <linux-api+bounces-6379-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 05:59:57 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9665AE6B2
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 05:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66AA03009E3B
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 03:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27892346A18;
	Fri, 22 May 2026 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY0ImQzy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB92285041;
	Fri, 22 May 2026 03:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422389; cv=none; b=rhSKubSTMdoQ7Ko7MKuPWHV4WVWe4j+cgsahrSDyRw0+ip5RsK6Kq/0GDOC6jSX93kHHXYH9YCpudYeYxbtxBq/5zn1spFlUoI5uwJOboYWVuhDK/YT4BtHqp8cmjdy4Tz3DuMEDs/sdt+WduxhlWqmkjlJQkF1HCq/XutfoqZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422389; c=relaxed/simple;
	bh=f1cRlrQaa8c+2t9khxERxAhv4PRbJsPxezKquJq/rNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPkQSPo12d5HJ8pHuWdS4kwkjfahCTr1JzcbYaNAkLohEJmaIBajEgXbaWpkcE1DEOEHrzDcougNJCtNb/cXVB4zOXw2lUarGeSQ6fRDFabn8xvgncKKpxrYDOBJqgjY6z5HzPgoD7su1R3GMyQAmn6v5QrYwdR/kp67a21f3gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY0ImQzy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D00C1F000E9;
	Fri, 22 May 2026 03:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779422387;
	bh=H/gaClVuyqlkbt2yK/hC2NqGH4xbGZ4Tk12L6ljTkqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TY0ImQzydhJitS5Ddrvd57wmJkpFKQRHHejclNNLrSp/Pt3ZjbuAZXZ6t/deQEjPo
	 B6RG70234GDvgoN2I1JfdyuZjEp7N7PcfGq56V+OZOfrgX/Kj3BGrDRD6gMp7QdGaZ
	 3XwaJGMmhDnnGJ9avnNUQFntrpWJ2DEMUmgcarvpvvrVDL+W/u+6c95VquTHO8Ly9L
	 YhjfG/p75Pd4tjFa4tixP2g+M6KlXSRuVMElS1m+U1YdvCaX4tSQDzEzY1TnKgRNIH
	 2N5F82yOOXvzqrpGDeJFwkB/Mn2fFSJD/5ZgU9X/duY2SuPkz1gG+tRoDpon4nQWBc
	 dSLeX2oApTWMQ==
Date: Fri, 22 May 2026 03:59:45 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <ag_UsW_OrlXD9dWX@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag9D6_7dttbDGHZ6@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6379-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C9665AE6B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/21, Matthew Wilcox wrote:
> On Thu, May 21, 2026 at 11:57:48AM -0400, Theodore Tso wrote:
> > So let me get this straight.  This is a magic xattr interface which is
> > not even persisted in the file system, but instead sets a 32-bit
> > bitmask in the struct inode which disappears once the inode gets
> > flushed from the inode stack.  And it uses a generic xattr name,
> > "user.fadvise".
> > 
> > There's no way in *hell* any other file system is likely to adopt such
> > a broken interface, so why didn't you just use an ioctl to set this
> > magic f2fs-specific flag?
> 
> I mean, yes, this API is horrendous.  But it's just another example of
> f2fs thinking it's somehow special and not just enabling large folios
> like other filesystems do.  This hurts everyone, not just people who use
> f2fs.

From the production viewpoint, I raised a concern on setting large folio by
default, since that exhausts lots of high-order pages, which were needed for
essential system services and critical apps.

