Return-Path: <linux-api+bounces-6661-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u0wPH2+APGo9owgAu9opvQ
	(envelope-from <linux-api+bounces-6661-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 03:12:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B894C6C2160
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 03:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.org.uk header.s=zeniv-20220401 header.b=lS0jlFVy;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6661-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6661-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=zeniv.linux.org.uk;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2BC13043513
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1606368D7C;
	Thu, 25 Jun 2026 01:10:32 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D0036826B;
	Thu, 25 Jun 2026 01:10:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782349832; cv=none; b=BoT6m3lCE8kev44SAPEjwAR3ogieNq2Kp57L4xwzpQVx8Sa0k66kKn32Uf4rFtCSiT7VHRr1jT5dVMGiy02QQF28Is72jOZa1Px1qEmYtZIiYkjh82RioaU+BfltgjhAyVgYffcOWf0toQXmlY8Yo2baarB0vGWIQFNG3PUFXwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782349832; c=relaxed/simple;
	bh=CqwfMqI7Lr/nMU8ct+Xrq+khEb3WLP3QzcepDFSZkM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovOtYoXI+LgaYOV/9pvs7v/TVlNm6GvIFny+ItkCgPy/lX72MtwbXZnzU8H2z17KbcfDbX995U6WnmTyDNpru8PY7YXznLZ3PL6ol4BcIxP2lJ3oS0XggcX1IisRJYjTtK6NMqm7yQXlczy4klxAduX7ZR1Ost7yWkxgJU1fonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lS0jlFVy; arc=none smtp.client-ip=62.89.141.173
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hYRs/fxYUnkXklcro/L2vZevBsDfMonAZUv31Sq9qQ8=; b=lS0jlFVy0HdzioRFRFJPBGvCLn
	Rvc1kh+NFMzO9UpMKeuX62GqobexdfhY/1LvkMFgSVHa5L4tgjY/NEPSQsVyp3FuLlHXbojkiKGBg
	FsAEASiDPwIH+atpDSROOPztQp6ns5FyjiQ7ht04Z8rQjH1cEiaYPm7S9qJzrpARU1VXpyj0GKknj
	gapNPLw8tYCmmmcEwKytAS6AUqe86o+p8t8JtF0rym6i/W3zSmjaoJ7bcR0e/izJWvp3phGInMMWy
	Wt9jtDLPNahr4h+cQ38Jp6vqUQAR0MVwLJaIOere/KF4Iy4uXCEX06H045Ly9pm4GWsroazib5oW7
	S08E/BxQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wcYbn-0000000Ce4N-3caE;
	Thu, 25 Jun 2026 01:10:23 +0000
Date: Thu, 25 Jun 2026 02:10:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: John Ericson <mail@johnericson.me>
Cc: Andy Lutomirski <luto@kernel.org>, Li Chen <me@linux.beauty>,
	Cong Wang <cwang@multikernel.io>,
	Christian Brauner <brauner@kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-api <linux-api@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	Sergei Zimmerman <sergei@zimmerman.foo>,
	Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260625011023.GM2636677@ZenIV>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
 <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
 <103524f8-1658-41df-88e9-cf49c628a721@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <103524f8-1658-41df-88e9-cf49c628a721@app.fastmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:luto@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[viro@zeniv.linux.org.uk,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6661-lists,linux-api=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,ZenIV:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B894C6C2160

On Wed, Jun 24, 2026 at 07:53:53PM -0400, John Ericson wrote:
> I wanted to discuss a bit about each type of namespace to indicate that
> this is a concept I think works across the board --- it wouldn't be such
> a good solution for the process spawning API if it was only applicable
> to some but not all namespace types. But the truth is that I have
> thought about the FS cases the most, as I think you have picked up on.
> 
> If there is interest in landing
> 
>   1. null CWD
>   2. null root fs
>   3. null mount namespace
> 
> in isolation, and then returning to the other namespaces to iron out
> their details, that would be fantastic. It would be much nicer for me to
> get some momentum that way, without having to design everything all at
> once first before getting to implement anything.

Please, start with explaining what, in your opinion, a mount namespace _is_,
and where does "mount X is attached at path P relative to mount Y" belong.

What's the fundamental difference between CWD and any open descriptor for
a directory?  Why does it make sense to ban the former, but allow the
equivalents done via the latter?

