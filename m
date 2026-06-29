Return-Path: <linux-api+bounces-6725-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KgG8NI9JQmoK4AkAu9opvQ
	(envelope-from <linux-api+bounces-6725-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 12:31:43 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FB26D8EBF
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 12:31:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jHr2ajkK;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6725-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6725-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6553300F459
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 10:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AE03B71D6;
	Mon, 29 Jun 2026 10:31:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A26328CF5D;
	Mon, 29 Jun 2026 10:31:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782729101; cv=none; b=g5P+RUvGAaD5EqJ8EsmbP1zh1b+Nr01rYdHjlBvc0lltWYXyCQvDmTn2caTUJTlMMowwy9a5kO3B57mkBzPoHnYQYbBWDhX2EI2mb3iDGB7kU59ix2ye+Il+kDZo2U2l+laYgC8gKdo48M8PQ1Yp3L+Joq3q+xA9kMrwkOmTibU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782729101; c=relaxed/simple;
	bh=ytkV7hcokUzl4TuVl61zJBHjebIrKvs1gvmLCTFBA4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OEkuBKawSWeyh9IlB9/0ZZmegzQf6BOuavsBsrp7vLReDkSuE+3IVUz3QaW0n9yFVA9tQBadslNeM45M55KBBrXLvbtedyGjppZtVlhAYWsshXrbSHdxNtnxo0KZe7y+MQoSCZQYSnH4NJmJfCqlgcxJT61KwN+brg0eTHIihUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHr2ajkK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3511F000E9;
	Mon, 29 Jun 2026 10:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782729100;
	bh=RT8yWbDeKwEmQZtLq+f3M6TtP8uGbz5p5b/YTk59k20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jHr2ajkK5owuB7Yg5VBd8ULJvukLZc0+xaFZn/wsJViqPHbC9njU4HVpn5wJAKk6x
	 +R5BjVoBKzOlU9a133aFg9AXxhtbF0JdeoJYLsfKsQh7KAnAxM6DWSNjgm0Wn24Lt1
	 a5KUjVFBy7m+r4edcTwIkFZtI1kKdHGEVb/jaY3Udcn4ILRowdiOP/a4fQfPzzkiQI
	 QZ5+6nlh5c7hwhOHz76VYMGiMrHN5gCgGw/aneIU1YFsgAyTqSnaNVnJlVUFh63twf
	 cdF9+r26nvDhX/xi9HGymnUTYj+l4sg8VgupcQE+iCk60ftbAtG6LyKY1gHhRilmj5
	 GeCqdLhXq6iWA==
Date: Mon, 29 Jun 2026 12:31:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: John Ericson <mail@johnericson.me>, Andy Lutomirski <luto@kernel.org>, 
	Li Chen <me@linux.beauty>, Cong Wang <cwang@multikernel.io>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Sergei Zimmerman <sergei@zimmerman.foo>, 
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260629-parabel-kraut-waldsee-a4ebfab949ee@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
 <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
 <103524f8-1658-41df-88e9-cf49c628a721@app.fastmail.com>
 <20260625011023.GM2636677@ZenIV>
 <a75a9b82-a15b-4893-8f92-62b62664ea83@app.fastmail.com>
 <20260626001538.GO2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626001538.GO2636677@ZenIV>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6725-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:mail@johnericson.me,m:luto@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[johnericson.me,kernel.org,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75FB26D8EBF

> So supply a library of your own and try to convince people to use it
> instead of libc.  You'll have to anyway, seeing that a large and

I agree. And in fact that is what we've been doing:

https://github.com/cyphar/libpathrs

I also plan on splitting the chase*() machinery in systemd out as
a separate C library as well:

https://github.com/systemd/systemd/blob/104750fd60da4c563650785e272a7ce0a6694d01/src/basic/chase.c#L238

> hard-to-predict part of libc will be non-functional.  Which syscalls
> are used by your library is entirely up to you.
> 
> Would that kind of thing added kernel-side assist the development of such
> library?  Maybe, but I wouldn't bet too much on that - if you start from

It wouldn't really and we haven't needed it for that.

