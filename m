Return-Path: <linux-api+bounces-6774-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZzttEQN6R2rRYwAAu9opvQ
	(envelope-from <linux-api+bounces-6774-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 03 Jul 2026 10:59:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F4B7005E6
	for <lists+linux-api@lfdr.de>; Fri, 03 Jul 2026 10:59:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lew7qOMb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6774-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6774-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E4DC300EE96
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2026 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88252383339;
	Fri,  3 Jul 2026 08:59:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748441F30A9;
	Fri,  3 Jul 2026 08:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783069182; cv=none; b=sbJ0Rz/gwjFmDBxNlex2wLslau0OP39L30ISNfaIWMNujBlTbCsYUwuqIQ9AcYRtOUnS2Ta0mxDg5HN7Z+Kr7MnbZC6wzakxMiGLgnWl70Ev5w7oLgDWuZ3V8kWMAm6arP4y2wGpkLKEZVO9kk0Wfkmj2KKmI/tM3uetEWhXESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783069182; c=relaxed/simple;
	bh=4yzkqmFhZhfm3c7SM/OTRFnb8K8G8QjqSnoHzMwibSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz0aD2/aXxJe1VuP4SfzopYXbn3fDpZovVoDgmFBSy1m3dikfS+2VHNAPyg2C4+y92iBC15h6IIRN3VIYkweuRJAx0MmR0mkdsT7rKKenqjJbKnc3BSq0THbad8LrWJlTmkTLaqBtnSPgVfL8bc5FuXUxgoo6SzYuO3kYdBgqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lew7qOMb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B431F000E9;
	Fri,  3 Jul 2026 08:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783069181;
	bh=DwvXgjbOo23QIgi9Ih36T5WskUAMqQnB9cf7FG6IlaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lew7qOMbVkBL4AFoR7Oal6NOFbMmbRoynxobvOmbrJ0WmPGPY+8ixTsQNAyn8X2U0
	 0hgwwi9cy/uUvxXkg/PeeZR8Gwup490rtwI4cpF9riI0ViJMU8F0XnlNFbnQPgHvq6
	 bnsHm3BwilkW5auA71JOduE/oKPngBfSDGCcBdL0A3xAatNaHsrYt5esvPdg/D1rZu
	 Bp1WdkKsbktC9VuIxfheWdAkAo5Y/pidCyk4Pmc1wK1tWeptrjCyE32UTNi+xACvKH
	 mFBHc4R/NDbZzynBXyrvOLVeMIGki0yj4aOjLbuUmAHuRVp3PHq+8a9gMiYXy471U4
	 2m5oREXj8Jabw==
Date: Fri, 3 Jul 2026 10:59:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Ericson <mail@johnericson.me>
Cc: Andy Lutomirski <luto@kernel.org>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, linux-arch <linux-arch@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-api <linux-api@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Subject: Re: [RFC] Null Namespaces
Message-ID: <20260703-liftanlagen-rednerpult-briefe-5eb403e3cdaa@brauner>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
 <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
 <20260702-entladen-farbkombinationen-klarheit-fe24cb608f23@brauner>
 <5abd7c81-3c6b-45d1-aaab-195493c1cdc9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5abd7c81-3c6b-45d1-aaab-195493c1cdc9@app.fastmail.com>
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
	TAGGED_FROM(0.00)[bounces-6774-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mail@johnericson.me,m:luto@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.beauty,multikernel.io,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2F4B7005E6

On Thu, Jul 02, 2026 at 11:43:31AM -0400, John Ericson wrote:
> On Thu, Jul 2, 2026, at 4:34 AM, Christian Brauner wrote:
> > I think we could make that work with both FD_NULLFS_ROOT and
> > FD_FAILFS_ROOT...
> 
> Fantastic!!
> 
> What comes next? Do you want to submit the patches for this, Christian,
> or do you want one of us to? (Just trying to be helpful.)

I'll send a patch soon-ish.

