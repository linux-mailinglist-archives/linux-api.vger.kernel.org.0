Return-Path: <linux-api+bounces-5693-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FJ6MBkMcGlyUwAAu9opvQ
	(envelope-from <linux-api+bounces-5693-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 00:13:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3413E4D93E
	for <lists+linux-api@lfdr.de>; Wed, 21 Jan 2026 00:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD7E0B2FCEF
	for <lists+linux-api@lfdr.de>; Tue, 20 Jan 2026 22:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1C93A7F69;
	Tue, 20 Jan 2026 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kAc22uQU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tYmqSu53"
X-Original-To: linux-api@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24973A89CA;
	Tue, 20 Jan 2026 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948369; cv=none; b=lLXSYJwEmrnyk8I8sHIgQ0uKpNnzB9+LcCyr0HLb1Xjs+OGnNLTO1X+pHu4C2jdELYEs0amD6YYhg2mcFMcwtYtr3006kudITql6DIl6M6c0cd+i2YfGA4NZNeQa1fubtbSBvp/G3GP8DAfgLzEYCAUqWao/grS0J3OUjR4WP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948369; c=relaxed/simple;
	bh=Ec5nLUVBBHk65ofIYmXQtueLkYFVsJIiQkbCsxC4PRw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=D+d7SKQwIQknr0u+hWFI9w3QhPbQAJdmPjC6NuP4cMTJwBq3LZRjm4rxUYdNI25bt70hdbJXP208YKu6OqfdONNX3J60cKHg8km+IPhP7W6J06dIEKEOr72jox9yHUcjmo62m99tFNp/Pl68yk2L8U1axjq/liykKF9TqNCrMoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kAc22uQU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tYmqSu53; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ADE2D1D000AC;
	Tue, 20 Jan 2026 17:32:39 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 17:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768948359;
	 x=1769034759; bh=l2K+9wbriq4bT48xhrJHk7wRuoiZlQpD/0NetqMPAB4=; b=
	kAc22uQUt3RwaetR8gwcGj6GV7jeINmsy/+ihCWIB1DR0W2ETPRX0PAyhDjNxlD8
	4xaFqnaLFemoWHKg0P8IdXFBa0t/mA9ivBFGgLRwng+QKbGq3Z+5owu/8YX/txzf
	FshZbby9gMomAkIb2xo175ZvL6AFLzPWUWEjFiELR4OU5CfCo+cXnhoH6usKhn2c
	z+JNZoxSfyz8au+Q1AtUyRT2/yi511yJA743wOjbLMCEbaeDOVjgdraDQzGGeVfN
	W9txVyoAGuQFAzeZaqdT1SElP1/q4PblzlbIC1S7S5yfEnYPthXaBat96DT0DDnO
	Rn9GbrT8nTF8Wrm2AY06RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768948359; x=
	1769034759; bh=l2K+9wbriq4bT48xhrJHk7wRuoiZlQpD/0NetqMPAB4=; b=t
	YmqSu537xkjC96U4WXJ9E/PtLpqaHdIspiDQOSjlxaMBtZMDO4/vGYfHnEPwUTGB
	Taq5vIOBt5UJMyvtuLZtihXvMc+DPCp/ok3XmjmawBClliUsMXBEsJGN/VAbesJ4
	emK1RG+tsvcnO/F3e2mFJOEqWdK28MTEyjsKWFN9SZFGYCO4E73t7NrxNBfoNzBi
	LXql3SAJDMdxDOTHgideVRZKFBirdbLM0S+otU66rBxN3epsuUwe1n4CBQeAKKUn
	nA13Vy70yC2zVx02iC7IP71vaDLgKeYla1uritAYTg4zBai5QBk0VYzhPWBA4l+s
	u0z1j/WsU8Zhto4glMPGw==
X-ME-Sender: <xms:hwJwad9mV3pXUYyPHRWNm1Rpxpsp-FfYlK9HTM0kZDRDGFxq53PpXw>
    <xme:hwJwacj6xbD9kvP8p3-ofWaANmh7xIsg11dObQ5wIGspI48-3lQiqMrleBz3gZdzJ
    1kaLMjPRWh_O1o74BR1FezJNVFLhcIvj6P0XX2Z8qVuxMPJqsALbWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhunhhihihusehgohhoghhlvgdrtghomhdprhgtphhtthhopeifihhllhgvmhgssehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopegurghlihgrsheslhhisggtrdhorhhgpdhrtg
    hpthhtoheprgguhhgvmhgvrhhvrghlrdiirghnvghllhgrsehlihhnrghrohdrohhrghdp
    rhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonhhigi
    druggvpdhrtghpthhtoheptggrrhhlohhssehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhisggtqdgrlhhphh
    grsehsohhurhgtvgifrghrvgdrohhrgh
X-ME-Proxy: <xmx:hwJwadMQyofZ0wGJAkAHEqd-3K72QKHUwcjG0RzMwwoqGESfUt1nsg>
    <xmx:hwJwacU7ixli3QVHtvCVSKRs9bJVtx45_SWPaUpao66gYbNltFx6NA>
    <xmx:hwJwaQsCUyoPU0YYJ3fUNmEEWXFCNNovvJvIaShTpGe9yjJJlU8pZw>
    <xmx:hwJwaX3VhowBTVfO3LCMHaBf3dAdTd4_EAvPTArUyWgYKpDYGnWRUQ>
    <xmx:hwJwaTiEAyA2G8mCJoe0ekQ3CNY4CD_Jlq5z0-iXsA6a3CA57x1Q0jlb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 085D3700065; Tue, 20 Jan 2026 17:32:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWxaZBYfOtsV
Date: Tue, 20 Jan 2026 23:31:05 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Eric Dumazet" <edumazet@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Xi Ruoyao" <libc-alpha@sourceware.org>,
 "Carlos O'Donell" <carlos@redhat.com>,
 "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
 "Rich Felker" <dalias@libc.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, klibc@zytor.com
Message-Id: <212d2e51-abc1-47bb-8666-755917cad889@app.fastmail.com>
In-Reply-To: <0fc5b4ef-c468-416f-a065-f64989d75378@zytor.com>
References: <20260105-uapi-sockaddr-v1-1-b7653aba12a5@linutronix.de>
 <934ca004-0aef-49a4-a4f1-3d39a2e71864@app.fastmail.com>
 <0fc5b4ef-c468-416f-a065-f64989d75378@zytor.com>
Subject: Re: [klibc] [PATCH net-next] net: uapi: Provide an UAPI definition of 'struct
 sockaddr'
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.95 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5693-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_POLICY_ALLOW(0.00)[arndb.de,none];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-api];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 3413E4D93E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026, at 19:50, H. Peter Anvin wrote:
> On 2026-01-05 05:50, Arnd Bergmann wrote:
>> 
>> This looks like the right approach to me. I have previously
>> tried to introduce a 'struct __kernel_sockaddr' structure and
>> use that in uapi headers in place of the libc sockaddr, but
>> that seemed worse in the end, and introduce the same problems
>> as using the existing __kernel_sockaddr_storage.
>> 
>
> You say "the same problems". It's not clear to me what that means.

I must have accidentally cut that from my reply, sorry.
Looking at it again now, I think I ran into problems with the
flexible array that was removed from the in-kernel sockaddr
structure in commit 2b5e9f9b7e41 ("net: Convert struct sockaddr
to fixed-size "sa_data[14]""), so there is a good chance it works
now with the (once more) fixed-size version.

The other problem is that the structures that embed 'sockaddr'
are used a lot inside of the kernel, in particular in 'ifreq',
so changing the uapi sockaddr to __kernel_sockaddr requires
additional changes wherever the struct members are passed
by reference.

> Based on my own libc experience, hacking both a minimal (klibc) and a
> maximal (glibc) libc, there are a *lot* of advantages to having
> __kernel_* definitions available, *regardless* of if they are exported
> into the libc namespace at all.

Absolutely, I am totally in agreement about this in general, which
is why I tried this approach first.

      Arnd

