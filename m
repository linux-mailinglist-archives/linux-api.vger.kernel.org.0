Return-Path: <linux-api+bounces-6490-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAZxO8AjHmoohgkAu9opvQ
	(envelope-from <linux-api+bounces-6490-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 02 Jun 2026 02:28:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0F6268AE
	for <lists+linux-api@lfdr.de>; Tue, 02 Jun 2026 02:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C8C3304BCC3
	for <lists+linux-api@lfdr.de>; Tue,  2 Jun 2026 00:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CC2E2DF2;
	Tue,  2 Jun 2026 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TwGEmlgk"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888873BB57;
	Tue,  2 Jun 2026 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780360107; cv=none; b=jGGk+SxMbIBR8BO2H0ngBRSSZq/dcaEGiGqCX2k1ucyPaxuML6ZSlgTGYlakNGjxftEk3qIB4y9ueHdNAM0WSm3o8K7ZcY4C+lJy+RymGjbCb4go0BiwxgZu3MgLh4SVy+I22As55dFuDQZcOw5qozxJUb2RiCp1H6JxWG02uBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780360107; c=relaxed/simple;
	bh=+a2ZO95kxdHvWsGSafCiYuXUQ71T5a+8Z3XcVsOahyE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BSDYR1px7bQm5kPtmSgwEcsIhR38nyaD6BUYmVGrScKK0x9mExYC6oimaS06hXtavUZ9DhbMOuXFI4GZI2UhrRVnLVU9+Igli1VTiFHuHJPUJtUZowGRt+8SL7qNceyXIT3nnUwNyntzs+nvJPpDrk/oCVzxe915veEaPv0ApSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TwGEmlgk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A011F00893;
	Tue,  2 Jun 2026 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780360106;
	bh=Slg9d12DIpflrilD7A2AKj3teZ7pACuCN0yNTcRFtLQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TwGEmlgkOSCqITM58gG6pT8IVelTAcsMweMr/i4OOMCAtucX/zJUxGFLy723fHJ1G
	 2zlZx5fxbmhgSh+6f1UJERPZ+etSvyv8toosvcWhnhuWo6IZGx2gdxEPCnM2ebBfjO
	 WPCRazYPlC4PvMA51SubT1XwysVby5d6Cgb2Sz3c=
Date: Mon, 1 Jun 2026 17:28:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds
 <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>,
 Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
 David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-Id: <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
In-Reply-To: <20260601160455.2c187574@gandalf.local.home>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
	<20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
	<CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
	<20260601173325.GH2636677@ZenIV>
	<20260601160455.2c187574@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6490-lists,linux-api=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,linux-foundation.org,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim,linux.org.uk:email]
X-Rspamd-Queue-Id: 68F0F6268AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 1 Jun 2026 16:04:55 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 1 Jun 2026 18:33:25 +0100
> Al Viro <viro@zeniv.linux.org.uk> wrote:
> 
> > On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
> > 
> > > TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
> > > a big simplification.  
> > 
> > FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> > Communications between the kernel and fuse server at least used to
> > seriously want that, so that would be one place to look for unhappy
> > userland...
> > 
> > splice-related logics in fs/fuse/dev.c is interesting; another place
> > like this is kernel/trace/, but I'm less familiar with that one.
> > 
> > rostedt Cc'd (miklos already had been)
> 
> Thanks for the Cc. The tracing ring buffer was specifically made to be used
> by splice and the libtracefs has a lot of code to use it as well. As
> reading the ring buffer literally swaps out the write portion with a blank
> read portion, that portion (sub-buffer) is used to be directly fed into
> splice, providing a zero-copy of the trace data from the write of the event
> to going into a file.
> 
> trace-cmd defaults to using splice to copy the tracing ring buffer directly
> into files to avoid as much copying during live recordings as possible.
> 
> Whatever changes we make, I would like to make sure there's no regressions
> in performance of trace-cmd record.

Well yes, The patchset seems sensible from a quality POV.  But to make
a decision we should first have a decent understanding of its downside
impact.

I haven't seen a description of that impact in the discussion thus far.
And that description is owed, please.

I assume a small number of specialized applications are using
vmsplice() to great effect?  What are those applications?  What is the
impact of this change?

Once we are armed with that information, is there some middle ground in
which we de-feature vmsplice()?  Fall back to pread/pwrite in the
tricky cases and still permit vmsplicing if the application is
appropriately restrictive in it usage?

