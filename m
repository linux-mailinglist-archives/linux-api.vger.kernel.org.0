Return-Path: <linux-api+bounces-6554-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 08ORKhnsImoffQEAu9opvQ
	(envelope-from <linux-api+bounces-6554-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 17:32:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AA14064956E
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 17:32:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samba.org header.s=42 header.b=YuDPDQ6Q;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6554-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6554-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=samba.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB2483060A41
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC60400DFB;
	Fri,  5 Jun 2026 15:15:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E335BDDB;
	Fri,  5 Jun 2026 15:15:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672558; cv=none; b=DFkTxsjyQ3sKi7jyBAd1yf3+6/AUy4nU+hwj1t+RKPq3kITTZu+T2SiwbiUc3Yz9OWTVcZeCq10nMv7m7GozHaGWBvTLCaM8MsT1xiQnGQUiFG2OYI3T/aBJRLYWVMU0gqXRkOKTXLJzpQZcQUmuFCkIMt0StJkkjFj9vawHjxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672558; c=relaxed/simple;
	bh=RnQ5TAwvjnXWmVPbdQrqA2q6NYo+tJf+sDdBGFn/yMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZNaHtk0mX5wXCvL14DqBAw6ZrM5NE8L9KFiMgK0d9wC/FZJTpBqY5QPmer3LUfhMjImQhdR30BXUFeqNUfM862zoNbTdXipxCqsAxxXe47uukVlezauDIcYBCXDofilAMJ2SlvxQ0uh9gLDtcklmOtxtTfHErNolMVXx4+eH4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=YuDPDQ6Q; arc=none smtp.client-ip=144.76.82.148
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=53NeptYyaF5olDNYNWO0bJ8crWCXIS1XcDfrtYn88/o=; b=YuDPDQ6Q+LUcMPqoxR7mHb6PrZ
	y6obdJ0OOI2BVMrzNG8xQiporP9alfySr3RP+58Qpo9BKcJeYZYvMOlo83U9MFrz5E4K1OBS/jjwN
	M9JBNIdAV2sNgyIpIWnCyGhYMHwAQta7Oqk6A0YS8rdUVowtFVReJUxzhfCD9kNe+QASCPOD77B+d
	rDTJXMiO/f8MyE/25J0GnblyrCr+0y0gmELA6K1NS1vlkb1Md7LvLopGmCV5Xjg/rh/ALFYyCEVkr
	CGPGWSbgPI8lZsCMpw/8ZGfHDLDM/08U4XfvuriX5ANszUaM1ZvoSRNFgyAs89SrWVsp1neyThmgi
	FWiTWyaXaW+K/Q34yU06NrX2cTk/9JeCAFXyl6lqH7DY+dQ1xquqF5w94eCuNcJ7TAwhcjqIk0g8i
	uvWuHksJmqdKLXn0lpTAeNaFxnbI4CWMMQ6d/18Xv5j58pXT/O3cpqgwNn52Ra4zgB40L+Jiy2pBU
	9yKmLz6kOirkFXxGVJSejpkD;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wVWH3-0000000EIOH-0FeB;
	Fri, 05 Jun 2026 15:15:53 +0000
Message-ID: <f1c7fbbf-5be1-48b0-8927-2d9b75a35816@samba.org>
Date: Fri, 5 Jun 2026 17:15:51 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org,
 axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com>
 <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
 <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
 <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6554-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[metze@samba.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
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
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:mid,samba.org:from_mime,samba.org:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA14064956E

Hi Linus,

> On Wed, 3 Jun 2026 at 15:23, Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> So I'm suspicious that you've possibly make bugs much (MUCH) harder to
>> exploit, but the underlying awful code and opportunity for bugs is
>> still there.  MSG_SPLICE_PAGES is still around, and there is still
>> (AFAICS) no actual coherent description of what it means.
> 
> I don't disagree. I've only looked at the filesystem side.
> 
> The networking side does some odd stuff too (and I did look at some of
> that, and had to be edumacated by Jakub on some of the subtler rules
> for what skb data sharing is ok and when it's not - really not my
> area).
> 
> But at least MSG_SPLICE_PAGES should be kernel-internal only
> interface, and once you don't share page cache pages with networking
> code I think that kneecaps a lot of the attacks.
> 
> So that's really the aim here for me - at least _attempting_ to go
> "maybe we can just limit splice enough that it doesn't even *matter*
> when networking does something odd and questionable".

While prototyping a smbdirect_splice_to_bvecs() in order to
do use rdma_rw_ctx_init_bvec() I found things like pipe_buf_try_steal()
and dived a bit deeper into struct address_space and found things like:
mapping_mapped, mapping_tagged, mapping_deny_writable, mapping_allow_writable
and similar things.

With that I'm wondering if we could allow splicing of
pages only if nobody mmap'ed the file => mapping_mapped() returned 0
and the page is not tagged with any of PAGECACHE_TAG_{DIRTY,WRITEBACK,TOWRITE}
and once a page is spliced we tag the page in the i_pages xarray
with a PAGECACHE_TAG_SPLICED. In all other cases the page would be copied.

Then any call to do_mmap() or vfs_writev at the highlevel
and at the lower levels most likely filemap_get_entry()/filemap_map_pages()
will remove the pages marked with PAGECACHE_TAG_SPLICED
and allocate new pages used for the pagecache of the related index.
It would be a bit similar to invalidate_inode_pages2_range() for direct io
writes. Maybe optimizing by clearing PAGECACHE_TAG_SPLICED if the refcount
of the page is 1.

This would also mean the content of spliced pages won't be changed
by future writes to the file, which removes the problem with unstable
pages and checksums.

It means the most common workload, e.g. a file only opened for
file serving (or simple opens in general) would still be able to
be optimized.

Does that sound useful and doable?

metze

