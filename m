Return-Path: <linux-api+bounces-6746-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zKcDF+P6Q2rpmgoAu9opvQ
	(envelope-from <linux-api+bounces-6746-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 19:20:35 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 588796E6D99
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 19:20:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b=VNtiFqsK;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="C Yop166";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6746-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6746-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 643433015852
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3218D3D813D;
	Tue, 30 Jun 2026 17:20:32 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189493D6692;
	Tue, 30 Jun 2026 17:20:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840032; cv=none; b=uDYY3lqekG8GPlyy7SQ4sc6YhU+HumuO8PMeQ/aOA2JTGf4xEWcNj7B1UDwowxgUI5YOabsV/RWLhbo68ttOuW46ITh2QrYcfTi0zj5OYDAcej/DycTjUWLcUb17+4pGu+Pzoc2Fyi14XHG1VofXkxOF3Pw9MnnHAB+70YFs1O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840032; c=relaxed/simple;
	bh=SyX5kxtOy/n74SGPEGriKku/5TzujsXwQuC4sCWCa54=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tNYWytLwvmVhVHWWpwkGfjoMIrpa/4dffYpGKyFJ//EA8WIETc87vcm6GRiIHuybvXqiyuSGvraGarWR3jZSLRX+9vNaduey7jTPwp4LXiOiARyAtJvhyDtd/joGvFfFms4IDvzzY8HG5KfxdIHlZnmMsx0aOuqnD/snDaQfOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=VNtiFqsK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CYop166X; arc=none smtp.client-ip=103.168.172.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 1204B1380313;
	Tue, 30 Jun 2026 13:20:29 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 13:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782840029; x=1782847229; bh=SyX5kxtOy/n74SGPEGriKku/5TzujsXw
	QuC4sCWCa54=; b=VNtiFqsK12Z2kwgdsJ3lfywwskbJMc2rhxDft+sKYWFuVBt0
	7OILp0i7EFr19XwjkGlgPs0xQ8QdhMJ1aes1nUUDDrP8pqk7kMVXEN58Ez9Rq0Kc
	5JKk7Y3s5JsUqpQ0zTX7mvjrJXYf1L4FnQwqNcmzbKeBrIHBFs86fQIGRdJPfoRU
	OAmeWJnZCNBV/biE1Ck8YAd2gP0aTzCufXIgBIGYNUcyh5+Ub4CPet07XxwV7ccq
	ac/TmrNLRUOXL2zgAUEB18kKXFrOhrZO7Dr87YMxao+obSkF+QF2EIYvMJ67w9Ly
	gKPGG2uchhMAH8n6SCK7Y+XnCA8TKPIZDtjFSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782840029; x=
	1782847229; bh=SyX5kxtOy/n74SGPEGriKku/5TzujsXwQuC4sCWCa54=; b=C
	Yop166XSLBUkfqOPPw/sv9X7RkOaFOoclhcUodPzDfhSnoVNxgszsKRHqAjo4Auf
	04kSrh/E3cLWbe1giLrZvlBpG530vS0oI4k/8ktuwEBN6BGfjgdMn2cUjTiecZpq
	2WvEYlfekZvMgrp5o7nRigiDaw7stBO7rly3c5GJ+LeZXhbkLZ/dodrh0FkLJ2cM
	YapEgyWG5mpyclwsq0Qco4vmgkAHBpVBmkmb7b0/vocw+xQYT7wJsSEDaGTLovvp
	2a/PKjLcTVhRIll3PS/Hmr4C/xzbVDikhRBGDCB6Db3ZE40XGK8GhiO34EU9UQ00
	PCJFObds4xk5IcPJp0PTA==
X-ME-Sender: <xms:2vpDajVdfcikRsBvrGgBunGw6SfpY4GRMUaRWQswaCGntjV6extAWQ>
    <xme:2vpDamYhib1RoWshsAhTwjiHdpC6KAbfpnSLwosV4pIGATOrKgYLQMScV6uDE_cq6
    86o6PmPuVIvBU9pGSMXVSKs2qUGBuXpuy9yJJDkedFOHzr4NyAdsg>
X-ME-Proxy-Cause: dmFkZTGGgGolmyu0ogXLBjub7n86zRQ8XQCuZCS7KOAZMtm7jSuchTomZHqxhb4BMv4fT2
    Ki9o5wI9FRu97zHnR7tqI+245ASJaJWBYdvu78Q2qjp/3PcTMYHqOiieul8IObhuxuQdCq
    plibFZfr9ky0RpzNl6/aOxlZHtUhFkwvRVoOfzghSvX3zyigdWfVFHa+A4d8UnxjYuL+9p
    HxOw/RsRTDTSJ7/1q122mn8TY6ycs1f/1om/ukNAh2kwTKUplffaoBB2PtW+DK7nVSYNCr
    Aktrtzs8VVIGlZ7brOUO+nHNiXCnN7zlB/ycbwtyfFz94EHVGJ6VlLNEA8mt4EkEc2lmZ6
    AUVIpkL8ejRp52DHJRgprvWQRh4Z/qxSsnld4WCGAoMQzdG4emkMNkye2OyTF2daRormSz
    nH5J3x5OEs4DbiR6e8ojAaAziMUyHFXI/a+nEI0PKOS0sKvKUj84osa0MObLifw5o/Z7nq
    xW7EVBbILtlGwH8d79uE7geBnzh7NUUnusOogiITfdfavVIKO/oPLlAptcdcN/j3QJRjP/
    fv+xASlb0UPOQzZqFfAPUq+e0rG/UOnr3I7XCd4SgE6Q2LOmLn3Y5eKdioLoQ94JPTZsHv
    8TD1pdf1KQdUU1E3V1BBNVpDlFDM8pM3W1Y1iVBTYDgUlvIeMUXNAlxUzk2w
X-ME-Proxy: <xmx:2vpDapmmMvucY97hBNggDxsRP2TBCEF95Fxm6OEvUQGRtk_Jm9k-HA>
    <xmx:2vpDaiC8gs9hvfNLpHq5l-zHNObrFg_Z7oW9WP4VEDd8ERHt_SHQ9w>
    <xmx:2vpDakJS5vRkOz-q1oWRCL57RonYpwag2AFQRMWlKvawUg3o4MsXvg>
    <xmx:2vpDalxZmVqujb2Y1lUnJ80rcdqT-1onXwnZBuNEm_POeRVBG_vPkA>
    <xmx:3fpDanM5EY2iRnJDCRyrhYazh7Izg5wJtCLWlxyLMz2jkhjCi8slINmt>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6BBD82CC0083; Tue, 30 Jun 2026 13:20:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Tue, 30 Jun 2026 13:20:05 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Li Chen" <me@linux.beauty>, "Cong Wang" <cwang@multikernel.io>,
 linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Kees Cook" <kees@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <372c1f13-e6eb-46e6-8685-3c39da4e9f72@app.fastmail.com>
In-Reply-To: <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
 <eb390c52-eeb3-44b3-88e9-e65c52a26c05@app.fastmail.com>
 <20260630-kippen-jobaussicht-restriktionen-2149cc663b22@brauner>
Subject: Re: [RFC] Null Namespaces
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6746-lists,linux-api=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[johnericson.me:+,messagingengine.com:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@johnericson.me,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.beauty,multikernel.io,vger.kernel.org,arndb.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,app.fastmail.com:mid,messagingengine.com:dkim,johnericson.me:dkim,johnericson.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 588796E6D99

I'll throw in the towel after this email, I promise :)

On Tue, Jun 30, 2026, at 3:14 AM, Christian Brauner wrote:
> I think Al is about to have a stroke reading this... and I might too.

Hahaha. Alas, C does have a longstanding beef with discriminated unions
--- I can't do anything about that! (Well, other than wait 15 years for
this stuff to eventually be rewritten in Rust, that is ;).)

> I agree with the sentiment

Thanks, I appreciate it :).

> You know what the easy solution is: don't allow a struct path to be
> empty...

Just so we're clear, my quibble here is purely behavioral: the nullfs
directory can be opened, right? And that open directory can also be
getdents64ed (yielding no entries, since it is empty), right? If I am
wrong about these things then sure, no objections from me --- let's ship
nullfs FDs right away!

My reasoning for being a bit of a weenie on that behavior is just that I
think "fail fast" is good. A lot of userspace programs crawl the file
space pretty willy-nilly (e.g. they are doing some caching thing, or
they are looking for something, etc.). I suspect the nullfs approach is
going to result in more "red herring" error messages and google searches
about "why can't I write to the working directory, not even as root"
etc. I just think "no directory" vs "immutable empty directory" sends a
clearer message to userspace, and will align mental models more rapidly.

Put another way, if there were no implementation downsides to either
approach, I assume everyone else would also slightly prefer "no
directory" over "immutable empty directory".

From that premise, I am further presuming that any non-empty `struct
path` to a directory that doesn't exist would be a real VFS crime, and
so making `optional_path` one way or another is the proper way to
implement this behavior.

If I am wrong about either step of my reasoning --- that nullfs like
every sort of FS ought to be openable/readdirable with sufficient perms
at the root, that a valid `struct path` to a "non-object" is bad design
--- do say so, and I'll drop the `optional_path` stuff completely.

> I disagree with the details of this

You mean the unergonomics of making a valid `optional_path`, right?

> and touching the whole kernel for this.

I want to make sure this is a difference in opinion and not a difference
in the view of the facts.

The linchpin of my prior email was that very little of the kernel cares
about these fields in `struct fs_struct`, or even cares about `struct
fs_struct` at all, so this is *not* a "whole kernel" change. Yes, thanks
to `current`, a bunch of code *could* look at this stuff if it wants to.
But it should *not* want to, regardless of what we do.

If there were a way to make parts of `struct task_struct` opaque
(without including another header) to enforce this design principle, I
would definitely go contribute that. (I remember the desire for
something like this coming up with the "fast headers" patches, but there
wasn't a good implementation strategy in C, alas.)

Likewise, for the tiny few usages outside of `fs/namei.c` that I found,
I would be happy to more creatively look at that code to see if I can
indeed avoid `struct fs_struct` altogether.

Cheers,

John

P.S. The "regardless of what we do" part was key to my earlier code
review argument that gave you "mixture of amusement and slight anger":
of course I don't expect other maintainers to keep abreast of subtle
null pointer invariants, but the simple rule that nothing but
`fs/namei.c` really ought to be consuming these `struct fs_struct`
fields is, I believe, all three of: good, already true, and intuitive.

