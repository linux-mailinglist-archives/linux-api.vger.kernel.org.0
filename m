Return-Path: <linux-api+bounces-6505-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RodKHFLgH2p+rgAAu9opvQ
	(envelope-from <linux-api+bounces-6505-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 10:05:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2AB6357FE
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 10:05:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="L2Up9Zp/";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6505-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6505-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0B033164D5
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 07:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED493FF1B4;
	Wed,  3 Jun 2026 07:50:23 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A53D47DC;
	Wed,  3 Jun 2026 07:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780473023; cv=none; b=s4wqQP++zvwP1pVV6iKvg5n4yUB3cGCnSwgxnQO79P+m539YghvQSdznI/XKqQI5JuOMd10BaXzZF1rxNLbJpB54beKnLWXfOwDGxDw5YLfymHsSM5UDj83KM5Hq8RCg1dzqH7eoBZHqUgxnCTuWABgmDiZbAvFYOuPxOAEat6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780473023; c=relaxed/simple;
	bh=4SlNVuIUt4a+Le1/sIdYKbYIKA3fRJN6rU1+wZYsBfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNKl2HqwTYNB2Q1DEZeHKsAqkpC0RDM71rGeuGZVl/R92HGWRFW6fC5YWdlmuF9X/YBbwfFZKxzwKXWLc25uwYpklmWw5BOTv6Hs2HjhvxsElzDHAizbX1moBjLZ4b6zMYcgclbEn+eOKXuiY3Uv4ZK0dOuHcTg3qiDk1qdVIwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2Up9Zp/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7D1F00893;
	Wed,  3 Jun 2026 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780473022;
	bh=88hbOu2kVMzvRDy1eOcozFAmg35YAXSjbmJFuM/mDK4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L2Up9Zp/7tLPcWy426HJxpyxK5jrLwIKsJh/I7EJrRqcMVmPW2D3+n64+taNy6XZD
	 ZwdSTJ3RON53sNMh72dYcdBngzi+//cBXjPCP2TR0P2pLDzeSCUSNIp2+t/UrFFG+f
	 l5kJXpa9fMPly8p1SjmScFTJJ15uQW2Zu81INbFDgDLPz5mtcYEx1uNknRioWz8unX
	 U0un4cVpgXwBSRBNNymxkAycgiZmzK55Txhoa8kYnHkznYtABdxBsIRTGYEIQQqIYB
	 F0JhkZF7PR8dLeyUevRBWaTjlMrnD/sVqHpvTV1ougk40oJuqlpF6GsQKvj5/BOxGQ
	 cyjSy6gZLovcA==
Message-ID: <df22c9ff-6705-426e-85b1-b5018590d723@kernel.org>
Date: Wed, 3 Jun 2026 09:50:15 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>, Askar Safin <safinaskar@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org,
 netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 David Howells <dhowells@redhat.com>, Pedro Falcato <pfalcato@suse.de>,
 Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
 <821ed41e-5b2f-4d17-aeb2-71b0361f8e7f@kernel.org>
 <20260602184440.GB2503276@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260602184440.GB2503276@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6505-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[david@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE2AB6357FE

On 6/2/26 20:44, Eric Biggers wrote:
> On Tue, Jun 02, 2026 at 10:25:06AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/2/26 02:28, Andrew Morton wrote:
>>>
>>>
>>> Well yes, The patchset seems sensible from a quality POV.  But to make
>>> a decision we should first have a decent understanding of its downside
>>> impact.
>>
>> I guess most (all?) of us ... dislike ... vmsplice(), so trying to remove it
>> entirely is certainly very appealing ...
>>
>>>
>>> I haven't seen a description of that impact in the discussion thus far.
>>> And that description is owed, please.
>>>
>>> I assume a small number of specialized applications are using
>>> vmsplice() to great effect?  What are those applications?  What is the
>>> impact of this change?
>>
>>
>> I did some digging, and the kernel crypto API documents using splice/vmsplice
>> for zero-copy[1] and libkcapi [2].
>>
>> I did not find performance numbers, how much vmsplice/splice actually gives us.
>> Playing with the kcapi-speed tool [3] (specifying --vmsplice vs. --sendmsg)
>> doesn't really reveal a big difference at least on my notebook. Not sure if the
>> parameters I specify are reasonable.
>>
>> I don't know whether downgrading vmsplice to preadv2/pwritev2 would perform
>> significantly worse than sendmsg ... and I don't know what the default would
>> usually be (default to vmsplice or sendmsg). I might try finding some time to
>> play with it more, but I doubt it, so if anybody else has time ... :)
> 
> AF_ALG is a mistake and isn't commonly used.  Using a userspace crypto
> library is faster and is what almost everyone does anyway, as it avoids
> the syscall overhead.  There are many other issues with AF_ALG as well.
> 
> 7.2 will mark AF_ALG as deprecated, mostly remove AF_ALG's zero-copy
> support, and remove AF_ALG's async I/O support:
> 
>     https://lore.kernel.org/linux-crypto/20260430011544.31823-1-ebiggers@kernel.org/
>     https://lore.kernel.org/linux-crypto/20260504225328.25356-1-ebiggers@kernel.org/
>     https://lore.kernel.org/linux-crypto/20260523-af-alg-harden-v1-0-c76755c3a5c5@gmail.com/
> 
> In practice, the programs that are keeping Linux distros from disabling
> AF_ALG in their kconfig outright are just iwd, cryptsetup, and bluez.
> They use AF_ALG just because it was mistakenly thought to be easier than
> using a userspace crypto library.  They don't need maximum performance,
> nor do they use vmsplice, splice, or sendfile.
> 
> There is other highly niche code out there that does implement the
> AF_ALG + vmsplice + splice thing, e.g. libkcapi.  But it's just not
> enough of a reason to keep zero-copy support, especially considering
> that AF_ALG has always been the wrong solution in the first place.  The
> fallback to copying the data is fine for this deprecated API.

Cool, thanks for sharing that Eric!

-- 
Cheers,

David

