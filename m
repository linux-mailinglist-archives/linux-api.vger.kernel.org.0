Return-Path: <linux-api+bounces-5920-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGcrAqWCsGmwjwIAu9opvQ
	(envelope-from <linux-api+bounces-5920-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2026 21:44:21 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93020257FC8
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2026 21:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07C043008D6B
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2026 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BF33E5EF6;
	Tue, 10 Mar 2026 20:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sNIzx4QN"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E41261B9E;
	Tue, 10 Mar 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773175459; cv=none; b=S3M2Wx/e25VfVWgsuCzpeZ/1LPY9GyD4KQWpmRoAKYzcy+/DdNr2mQIetg1sGqC5GDaCvQXSi6tf5/Epkwz/aOMzBWyBLWhlqTLHq7J4ffj1DeKfhZTVcLH/reT1cE2U0uzEj50H6IZzeEm5C8e007XZ2UiTTlHl5eTAl+H0Ox8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773175459; c=relaxed/simple;
	bh=uvGliFoDQ0fmeDSJR9e4GfS4Ku2PCRNiPq4Eo6t78GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmGZbfJ2nmFEUdrTcLLlS7hXjYtya6V3tEKbalEfpHQNs4Q4kk6OL1Op+uLXWToo0rFaMmtIibpQgMIxMimVXNIAtcxPTjmzjY1trnB9xkfjtlWROpHrpcOdJA/G9Zz4IqAtcv0Q95xK2UuBfQKUSL/rAM8JZf61QORUAAgPsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sNIzx4QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4E9C19423;
	Tue, 10 Mar 2026 20:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773175458;
	bh=uvGliFoDQ0fmeDSJR9e4GfS4Ku2PCRNiPq4Eo6t78GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sNIzx4QNk52Ec2LE3W7bANu5Ays77Xa3a89rEaIP6KXZgJrbEOfhMUF34NoCBpVEU
	 k6WCpz/HH1coaXsHn1jLhowd9imYnTt7MNPvZ2obpGby//4J65ed64sZ5LnKtiRCb8
	 45fKGCdbTq1MlgaPjIqOgegqRqS0myg/QwwwznoN5bSNOveugD/xZcr+49cZTbLBM+
	 Y/vsFSovnDE86lj2t5SoSEjR/gC6jszq7/W2zmSY1+Zoehl63ptnHLGXPpi3jYr3Po
	 CtMOHq4Np/Dorr2fzYTT6OiB3EER+lqYXX5L1/hEqJQJqnTJFRh08EQwmrw+hdrAzq
	 aOeJ8xZ5IINPA==
Date: Tue, 10 Mar 2026 13:44:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: brauner@kernel.org, hch@lst.de, jack@suse.cz, cem@kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: add generic write-stream management ioctl
Message-ID: <20260310204418.GY1105363@frogsfrogsfrogs>
References: <20260309052944.156054-1-joshi.k@samsung.com>
 <CGME20260309053427epcas5p23419afbe49e4e35526388601e162ee94@epcas5p2.samsung.com>
 <20260309052944.156054-2-joshi.k@samsung.com>
 <20260309163325.GE6033@frogsfrogsfrogs>
 <2cde8902-6d50-4035-b9c4-89bd5e2c9468@samsung.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cde8902-6d50-4035-b9c4-89bd5e2c9468@samsung.com>
X-Rspamd-Queue-Id: 93020257FC8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5920-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 11:25:25PM +0530, Kanchan Joshi wrote:
> On 3/9/2026 10:03 PM, Darrick J. Wong wrote:
> >> +struct fs_write_stream {
> >> +	__u32		op_flags;	/* IN: operation flags */
> >> +	__u32		stream_id;	/* IN/OUT:  stream value to assign/guery */
> >> +	__u32		max_streams;	/* OUT: max streams values supported */
> >> +	__u32		rsvd;
> >> +};
> > This isn't an very cohesive interface -- GET_MAX probably only needs
> > op_flags and max_streams, right?  And GET/SET only use op_flags and
> > stream_id, right?
> 
> Yeah, right. That's the trade-off with swiss army knife type ioctl which 
> uses op_flags to decide what it should do. Apart from keeping a single 
> ioctl I was thinking a bit about extensibility (for anything new we may 
> be able to do a new op_flags with some rsvd or union) too. But if you 
> feel strong about this, I can take 3 ioctl route?

struct fs_write_stream {
	__u32		op_flags;
	union {
		__u32	stream_id;
		__u32	max_ids;
	};
	__u64		reserved;
};

perhaps?  You might want to look into whether or not we're allowed to
have anonymous unions in UAPI headers.  We all ❤️ C11, right?

--D

> >> +#define FS_WRITE_STREAM_OP_GET_MAX		(1 << 0)
> >> +#define FS_WRITE_STREAM_OP_GET			(1 << 1)
> >> +#define FS_WRITE_STREAM_OP_SET			(1 << 2)
> >> +
> >> +#define FS_IOC_WRITE_STREAM		_IOWR('f', 43, struct fs_write_stream)
> > EXT4_IOC_CHECKPOINT already took 'f' / 43.  I/think/ there's no problem
> > because its argument is a u32 and ioctl definitions incorporate the
> > lower bits of of the argument size but you might want to be careful
> > anyway.
> 
> Indeed, thanks!
> 

