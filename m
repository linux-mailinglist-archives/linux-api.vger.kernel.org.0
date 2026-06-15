Return-Path: <linux-api+bounces-6611-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fYf6E92aL2p4DAUAu9opvQ
	(envelope-from <linux-api+bounces-6611-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2026 08:25:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EEA683C45
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2026 08:25:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=packett.cool header.s=key1 header.b=ircNaqFJ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6611-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6611-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=packett.cool;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2965930082A6
	for <lists+linux-api@lfdr.de>; Mon, 15 Jun 2026 06:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F612F83A2;
	Mon, 15 Jun 2026 06:25:20 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CC1A6816
	for <linux-api@vger.kernel.org>; Mon, 15 Jun 2026 06:25:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781504720; cv=none; b=pUiH/iR/RuDd5VBSrFqGUNfQCMzb+YFm3Hbgbk1IQjNun+n2R+hhkKOY96A/Pth26RfhD0LsHuaOGgkoZAhpqwYXF1rj5tNebZLFN/lVbqJbkP+0JiW1giH4cq7Dg3D4lTH15OQjQOYDud8LByPrA6t2fBAz2uzKo43imAnacVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781504720; c=relaxed/simple;
	bh=eMpF6TIlf6+lXcDXCRWJ1GSlKGnokAF6Mi84MZza0gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdmxhOrLPXpeQhJALV1SVDXW5aB8hgFn1iWQwWGM9N9n+XL506Is9WdduLj5jzKkpokZdLuRB18OxL7ZciVClnvfzb/4q6z4kpxQx9Pjn5x60j1XenVmINj3Od8RpWiGyr0/SrOB5tp2eXtJQBnzobpeWR+Fs8NcqQhSNog5jN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=ircNaqFJ; arc=none smtp.client-ip=91.218.175.184
Message-ID: <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1781504714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIagr78v8+wu8I0zN50DJ/gAtpHtsl0YE4lvqsZn4bE=;
	b=ircNaqFJIqIbLoIQAsKyoXo4rpXEoQiRy6zyFmI9hK3HrAfkw05xW4pZqyr/gEPP8FmgQe
	YCMXXOF0Ojr6Ke64K6mJnYe9JlDM5n9QaPTquf4RxnS2VJebzilW8irZlVAq2ZBbu8tU3H
	Ym5nnlp7yvHYcIa6UVoQguJIN6I828BXaZ6Oa3MyWDm++G633gd71/V0K0NJtv18Wf3rcc
	TGhtZ7HAjNfT3f/melWV8TK5yeAV4SGF18G26grrndY/UhwmBAr77wIkgpV/3r4qCrE+rr
	yyIzP94mT15QER7XOLBnD39ifvW2hpCx+GHe19vIvRAPUfC7zO4rmCN5XEqkKQ==
Date: Mon, 15 Jun 2026 03:25:04 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
To: Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Askar Safin
 <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, netdev@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Steven Rostedt <rostedt@goodmis.org>, Joanne Koong <joannelkoong@gmail.com>,
 fuse-devel <fuse-devel@lists.linux.dev>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <20260601173325.GH2636677@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[packett.cool,quarantine];
	R_DKIM_ALLOW(-0.20)[packett.cool:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6611-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,m:rostedt@goodmis.org,m:joannelkoong@gmail.com,m:fuse-devel@lists.linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[val@packett.cool,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,linux-foundation.org,suse.de,szeredi.hu,lists.linux.dev,suse.cz,goodmis.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[val@packett.cool,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[packett.cool:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4EEA683C45

Hi,

On 6/1/26 2:33 PM, Al Viro wrote:
> On Mon, Jun 01, 2026 at 10:17:23AM -0700, Linus Torvalds wrote:
>
>> TLDR: maybe we could ghet rid of "f_op->splice_read". *That* would be
>> a big simplification.
> FUSE might be interesting - fuse_dev_splice_read() and its ilk.
> Communications between the kernel and fuse server at least used to
> seriously want that, so that would be one place to look for unhappy
> userland...

speaking of fuse_dev_splice……_write actually, this series has broken 
xdg-document-portal!

https://github.com/flatpak/xdg-desktop-portal/issues/2026

Specifically what happens is that the EINVAL is returned due to oh.len 
!= nbytes:

fuse_dev_do_write: oh.len 16400 != nbytes 15526

(where 16400 == 16384 (read len) + 16, 15526 == 15510 (file len) + 16)

After reverting the series, there is no error because oh.len 
becomes 15526 too.


Thanks,
~val


