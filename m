Return-Path: <linux-api+bounces-6346-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GnZDKc8C2oJFAUAu9opvQ
	(envelope-from <linux-api+bounces-6346-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:21:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FEA570CA1
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1083D303FA83
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967F648AE1E;
	Mon, 18 May 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhr9Q2UG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE0309DDF;
	Mon, 18 May 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121252; cv=none; b=snDMr8Th6SEzJYTnGyL4xGX0Cu+4X6+nWF0s3mqMtFHpF8xg/Ay9oketKjxze2JDnfhoTCviC6/0w8ueVFBSjwO9uUsCZu8mjxsmWS4aSIxK4EEF7R0r5OFvVsxDdXyzK4PmnOgD/1EDipNUsysSA+EA2G4VX7F3WK6X3Tkhhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121252; c=relaxed/simple;
	bh=XcbAsQ3Xp+6zYnBxzGsycrWyONyquPeXYpSeZDRCN94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+Uiex3Q1vl+pJ4oPkdAUNe2/bzfWAsBJGc0zwzBISb+6LHlsLvmHTeWe/bod7LWLKfvea1J3pcLjOdrKWwvwWUikpFAd8uqTtpRHF9tvE3lLDYMiGok2ys/Zkkk2/PGSJJOP54pr1nkmUcK0aciVjHYn1lTCV6IGUHHtrcLfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhr9Q2UG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84664C2BCB7;
	Mon, 18 May 2026 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121249;
	bh=XcbAsQ3Xp+6zYnBxzGsycrWyONyquPeXYpSeZDRCN94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rhr9Q2UGCvL7cNkeFjsCUxkDv7efs77N0Kcmp+1qGgE1mgaZKdLtyhlbgVX9SKoy9
	 irXsLh+YGC+p1k3C7DYy//+no++gCxtdxMFnNJupqYFku+ywdxVTkV2IJh/TkrxzMo
	 m0cIqvhRhLI9AB8YD5R2ZcNqqU4/KroImjyW+TP/peFaNSxqD0Tjh5XjLebS5nKvff
	 ydUimtlVHup625bTFL1SHQBBXBRaSEgQi2K41I0byXYV5XSVFlNmHJUoipLnuQcayK
	 xywvaZZYfRk3jzaR/gUg9Upac1loSnRCcEYJbg6/ZvuzBDiWqMYmn6nOAZpY2evEzE
	 eheX7L0Jbq4hg==
Date: Mon, 18 May 2026 09:20:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Cyber_black <Cyberblackk@proton.me>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Mark Fasheh <mark@fasheh.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-api@vger.kernel.org
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
Message-ID: <20260518162048.GC9531@frogsfrogsfrogs>
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agqevS--YYBVW2Oz@infradead.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6346-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 86FEA570CA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
> > This restores the intended restriction, at the cost of breaking
> > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
> > This option is a larger ABI impact and likely undesirable.
> > 
> > The preferred fix is Option A, since FIEMAP has been available
> > unprivileged since 2008 with no reported security issues, and read
> > access to physical block layout is already implicitly available
> > through open() permission on the file.
> 
> No, FIEMAP really should not be available unprivileged.  So I think B is
> the right thing.  Can you send a proper patch with a proper signoff?

For anyone who might be relying on FIEMAP output to find sparse regions
-- don't.  FIEMAP is a lowlevel fs debugging interface; it won't tell
you about dirty pagecache backed by unwritten disk space.  cp was burned
by that a decade and a half ago.

--D

