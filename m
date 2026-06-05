Return-Path: <linux-api+bounces-6550-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UA3XG4idImr1awEAu9opvQ
	(envelope-from <linux-api+bounces-6550-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 11:57:28 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D236471B4
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 11:57:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samba.org header.s=42 header.b=3cszkcrM;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6550-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6550-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=samba.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C42E5305EF1D
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 09:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E03BFE5D;
	Fri,  5 Jun 2026 09:43:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4063B4E95;
	Fri,  5 Jun 2026 09:43:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652638; cv=none; b=ahf3nMeGd6HujGfLCyJ4vw3DM3m3xhtOqaQbHdxOh1g71Ss2kCjddahoRtW/tUhRZlfQQg3w07QdKvLry10wktdnfLpuF5HO9adXML4vtojkDl47z6n226x+/uBKjmYRhw0i7RWZJ+PcAeayeONN8AORMDcTeo+6BxjY/O8szK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652638; c=relaxed/simple;
	bh=ZIbQ24JKgwPuQnIbph4dB2FJG/E/xkurG6e2vnCxEJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M9sLr9eSGFw3iPKcrqZNIaZ8s4gvrmeFPaPIfTIfH9Q+u23ReigZwMyPxd8VlkRkSjJUpQuKJkTvw+3vAjEmis9SzKVp/DHFpGMKzlpM2znAAbZSpFpuZ/wZoe39T0qo2Ddch7kk/3+uWFOGKTD3Qk1P7UE4JMBSzW4tiC8TyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=3cszkcrM; arc=none smtp.client-ip=144.76.82.148
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=t9/ac27hGADmFEUeWK9UOrni0IAhBio+aj/EwSAvs6c=; b=3cszkcrMUa9e0iFFaqn9tXeh3m
	srCm+/TqQ5cDc/r3RDKwMGy6Kc+ytoNbB1Q7eyNWVRWZ7jmfMaMMlpFcd/ub/AFHPv/JGAgz4EKYI
	HDkqgD4MR2wj2Cm1vrMMXPl9rshyLdUrwxBHoYlFYuxdrzKvfbrg79g1kN0oZlWOl0MP0vB/eRVX7
	Uw+xPIK98RTZpLVkYW4ouxNPO6fBSmLoxnNFL42y9K4f1J6XeK3tm1EzALd7D8D3p+oD+lTXxDlJ3
	Xow8nZQd7OSqhlFTLh5d7SBPzOu5lfpOXRCCci2oZhsEVpGnNZqWx0q5gERdwlu93RGuZBplxAgxv
	jcXsoEEXvF+NdRDA82SzGph7eEdIFtE0lud0gFktxIHlcrCchpczpNRQbXrtro2Mb07859aL51067
	1XCBjS50nJ+uTGzrVGLCD8tgBc6Qg7OqKFWIl7KZnxQ9IW6W+AWmRo4aDXD74v7VLIpNM47Md+TlY
	60QLHdqSou+luNHxXAjl4G7z;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wVR5e-0000000EDwm-2S8I;
	Fri, 05 Jun 2026 09:43:46 +0000
Message-ID: <512d948f-7883-4d8c-b2c5-a777e70ca975@samba.org>
Date: Fri, 5 Jun 2026 11:43:45 +0200
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
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6550-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:mid,samba.org:from_mime,samba.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5D236471B4

Hi Linus,

>> Am I understanding correctly that this will completely break zerocopy
>> sendfile?
> 
> Very much, yes.
> 
> And it's worth making it very very clear that ABSOLUTELY NONE of the
> recent big security bugs were in splice.
> 
> They were all in the networking and crypto code that just didn't deal
> with shared data correctly.
> 
> So in that sense, it's a bit sad to discuss castrating splice.
> 
> But it's probably still the right thing to at least try.
> 
> I've seen very impressive benchmark numbers over the years, but
> they've often smelled more like benchmarketing than actual real work.
> 
> There's also a real possibility that a lot of the sendfile / splice
> advantage has little to do with zero-copy, and more to do with the
> cost of mapping and maintaining buffers in user space.
> 
> If you are sending file data using plain reads and writes, it's not
> just the "copy from user space to socket data structures".
> 
> There's also the cost of populating user space in the first place:
> page faults for mmap made *that* historical copy avoidance basically a
> fairy tale.
> 
> And not using mmap means that you have the cost of double caching in
> the kernel _and_ user space etc.
> 
> So sendfile() as a concept (whether you use combinations of splice()
> system calls or the sendfile system call itsefl) isn't necessarily
> only about the zero-copy, it's really also about avoiding the user
> space memory management.

I don't think so. Ok, maybe for webservers just serving tiny
html files, that's true. But for me with Samba it's really the
copy_to/from_iter() that is the major factor.

We can use io_uring with IOSQE_ASYNC in order to offload
the memcpy cpu wasting to different cores, but it's still
wasting a lot of resources.

For the case of filesystem => socket, we can use
IORING_OP_SENDMSG_ZC and that at least removes the
copy_from_iter() in the sendmsg path, but the
IORING_OP_READV of buffers in the sizes up to 8MBytes
is wasting cpu in copy_to_iter().

For the case with smbdirect and RDMA offload with 2x200GBit/s links
changes from only ~33GBytes/s are used (and the server cpu even if using multiple cores)
is the limit. Without the memcpy waste ~46GByte/s is easily reached
and the limit is just the network link.

Maybe another solution could be having a version of
copy_to/from_iter that uses async_memcpy(), but didn't
have the time to experiment with that yet. Maybe a new flag
to preadv2/pwritev2 could control that, so that the
application can decide what's better.

But without an alternative please don't kill splice.

A lot of people are frustrated because they bought hardware
that is able to handle a lot of throughput, but
e.g. with the default of smb over tcp they get no
higher than 3.5GByte/s on a 100GBit/s link that's able
to handle ~11GBytes/s. And io_uring and splice are
a key factor to fix that.

Thanks!
metze

