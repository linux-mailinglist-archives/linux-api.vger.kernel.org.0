Return-Path: <linux-api+bounces-6732-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YsEdDWRFQ2pIWQoAu9opvQ
	(envelope-from <linux-api+bounces-6732-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 06:26:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 502706E0420
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 06:26:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=johnericson.me header.s=fm3 header.b="CY5n/daV";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="c RLHxcM";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6732-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6732-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=johnericson.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 119B43029798
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 04:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5503B27D9;
	Tue, 30 Jun 2026 04:26:09 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F10040D58A;
	Tue, 30 Jun 2026 04:26:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793569; cv=none; b=GLSjx+WAIYy8whrqswxxBArV4ZgpKcfDLOHoZNVQD53TWGe0nEfh4O6FiPLzd/cRU7DapwYobhdHyt2pw5F4I7Us0i3LKPGz6bBRppH8iGQfHy5BQzz4OaV/McJXsRb3ANzIZReDHNJ/Dedqj+zgkJPfa+XhSJXBj4BJ7OEBOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793569; c=relaxed/simple;
	bh=gMkDjI8pLSSaiJABn+DlFtwhttvw5oIUpdj32vvX/DY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=nTwcDv2Dff0WUiKg1OpPPYHPRI1QzmAquhGxumySaafENkcxbXlb2xcrmcHd70FDzPoBe6+cS4tCSDPlnbOzoC7bXQyYIKlOjXUJsRIjVvEKlXTuRuyDrimwbMBySmzEChgWPYztIqDFAFe13tPkHNXMWSKFuaoZutqSj66rNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=CY5n/daV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cRLHxcMR; arc=none smtp.client-ip=202.12.124.141
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id AE9041300082;
	Tue, 30 Jun 2026 00:26:05 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Tue, 30 Jun 2026 00:26:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782793565; x=1782800765; bh=Cq0SDG1bX6UfqZ7YDqjT29nGwXSZM9eE
	119G9Kh4YMU=; b=CY5n/daVEvrgL6pcUALLkTgazc1UPyamJTcREEVWABGWS8/K
	lHvs9zMgFhSSnxK/6BcKAXTkm3TZ4qwE0oIgCUa74bwOP8xBnmiMQKSCilDrG+Lf
	yJVV/mUOjm+mmwlxt/K8IwGTJBd4EtRjtxDk/yuNoa7xMx0VfyeGEtEYDLicJyM+
	m1DUesVGAThfYWtO6hvS+g2iYUPILPxudakvmyIqe9jZ/80Wo4BvfP9IMBO4VHz3
	HuojBgOsq68DBWXbE9vAgqwLDCdK5ej+LlMOyIxvbO/wOkHw013rp82wv3jMEZiu
	g4eE2hbDKtPEfOogOHBYIT4wHdPAgAeFzEOEJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782793565; x=
	1782800765; bh=Cq0SDG1bX6UfqZ7YDqjT29nGwXSZM9eE119G9Kh4YMU=; b=c
	RLHxcMRGapV4qOgIgtfMsksO+qjp3JImzJPSm35hft7nVbWNmF/RGTnpLdVzF0NY
	k0qTqu3UYWbxfUEq0GFx5/jyQGzu5TiCGhu8yz99hFBrCQt0Inz2cluUWSgp43O9
	UK/+lIfFb34bB87gQtyH6hygjz09mf3G5HkxfnfXmcRH8QJn33WUNiOjD4qjAu2V
	1QQYgGvKElYsMYe4qRlV2/IhpzsO8qqaFHN04D7qkXQt/WM7yJ8NWRVIbutf7tby
	nNX/Xfpj1k5qUSYG2CKMC/T0Hj97J/XdbCEISPRKjK7hIQY9TOdYwyzDNxY0YE4z
	vzePfGZ1KOCs9GY9YwzCg==
X-ME-Sender: <xms:XEVDag5b1kXVwGlIoDY_vhwVEZ7hXdfua-OASXpW3XBavNIhSubr_Q>
    <xme:XEVDasssikIpl5nGu50_hrDSrgnrJyfUyoBaM0pzzi0Vl9IIXDgutyzbKHKgzoalk
    3jmT6lxi0UxacqZe7geFljpoIkJs5_DmabdzXQZT8Lykpp5-b-M>
X-ME-Proxy-Cause: dmFkZTEzeWZh6yfQyyEPj9UUA3Ge4mxpRpo5O926hDZlYtMgTX4yQKOX+736PiEDiezAnf
    4aeu+NVpH/pxZuN7sxm03HOeA3khgTw112pCCgAF54Q4axwyd2HAtipuhXWMtvpWD5vTcn
    /aEMXKzWXO9eUGRBT3hOY98KsjGRLGAao8xHrPxV68MhAjb+ucMmK0Pp7CHT17ZZAKct3m
    ORTQnI5Fg0gsgrWllHNzGo6Ee9MdjkT9tqXMyJb5L7zesqaLD0nXdYi1ecdWeTUTOV5leQ
    OFIUAXfy3afLTep8bVFZqoLBIH2Pxck9ajKTvZL0IPRTqR/mmcVVgfk1w9PzSZFN/WMmmJ
    XyO0Drg5dRKzoG2qKDiyARaoYUGd78hjHNzZyWqg4U4NFGV5JzybFDQrtG2u52LY0OQrRT
    8yGmmVLiknmgLS21hlwzi/rbOcAojd02L8JIPtcl94Ug4qjoulkVGqJcSWexhsoXH6OZpZ
    VUWiIV1O2iLAJWyA9ZZAS+vCW+qebHUd+pcDq3wGp/C1qLPq7YkEJ8BaRlv8KmIJT+H+f5
    xQ6w8/7RRMDs1KU25C/764fdyN4uGKvrbSX6nyoFpkXO9Z8IAdDutwV77XflR2oPo8R2W4
    NdfGTcbzU3kHehDDJ7H+pd6sDQSeCI/4vhrcDlXetFnIFmjhVdj/NT4nNzsg
X-ME-Proxy: <xmx:XEVDasrAp7R6Yx7zXCdhEtBnlmJgVTfz-6qt-NgTJN-llWOt1d8LXQ>
    <xmx:XEVDav3oEp_lpOCDXOUKetQPXDo6VfOG3nJ7JHUSQalTLWNLLWtKZg>
    <xmx:XEVDalv6U9_olpZtIRcjfZ683t12G3qMssHbGCammEQi-rga-bdrCw>
    <xmx:XEVDagFiXFUiTCeRnjsDG2sQ5F_z5GmwFHz2JdOXZln7j4XQ2lD1cg>
    <xmx:XUVDarqF-7cVwqmK2RR2f_-O5EoISX-3CXj9ofjl2tP6zcxfSo_LXpQ7>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 45F532CC0083; Tue, 30 Jun 2026 00:26:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AG8qDlxFSDr7
Date: Tue, 30 Jun 2026 00:25:44 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Andy Lutomirski" <luto@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Li Chen" <me@linux.beauty>, "Cong Wang" <cwang@multikernel.io>,
 linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-api <linux-api@vger.kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Jan Kara" <jack@suse.cz>,
 "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Kees Cook" <kees@kernel.org>,
 "Sergei Zimmerman" <sergei@zimmerman.foo>,
 "Farid Zakaria" <farid.m.zakaria@gmail.com>
Message-Id: <c854819e-598a-4a86-bfc5-ea558101846f@app.fastmail.com>
In-Reply-To: 
 <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com>
 <20260629-hauer-erhitzen-sobald-96d3dff68707@brauner>
 <CALCETrVuh0-biOw=TgYN9ERTFAoiki57XeZ3S2T3dO2+hL54gA@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[johnericson.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[johnericson.me:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6732-lists,linux-api=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:brauner@kernel.org,m:me@linux.beauty,m:cwang@multikernel.io,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,messagingengine.com:dkim,app.fastmail.com:mid,johnericson.me:dkim,johnericson.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 502706E0420

On Mon, Jun 29, 2026, at 5:06 PM, Andy Lutomirski wrote:
> But if this happens, maybe we could finally land one of the patches to
> enable unprivileged chroot?  It's been tried a few times.

> If we had a way to make an OFD to a directory that forced
> RESOLVE_BENEATH (or RESOLVE_IN_ROOT) and that propagated that
> restriction to anything you open using it, and if an unprivileged
> process could chroot itself to nullfs, then we would be getting quite
> close to what Capsicum can do.

I just want to briefly say that I agree that these are both things worth
pursuing.

Once the root and working directories are sorted out (whether by nullfs
or by making those optional in `fs_struct`, see my other email), I am
fine putting my yet-unsubmitted patches for the null namespaces
themselves on hold and addressing these things instead. I can indeed see
it may be useful to wrap up such loose ends in VFS-land while we are
here, before switching gears to other namespaces and other subsystems.

John

