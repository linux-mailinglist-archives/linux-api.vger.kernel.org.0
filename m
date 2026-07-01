Return-Path: <linux-api+bounces-6757-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /IZtDCIbRWpg7AoAu9opvQ
	(envelope-from <linux-api+bounces-6757-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 15:50:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD8B6EE58F
	for <lists+linux-api@lfdr.de>; Wed, 01 Jul 2026 15:50:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=sQSfLOue;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="O 8HXW5U";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6757-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6757-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 475383172370
	for <lists+linux-api@lfdr.de>; Wed,  1 Jul 2026 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879C48B39C;
	Wed,  1 Jul 2026 13:12:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E348B386;
	Wed,  1 Jul 2026 13:12:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911562; cv=none; b=WdRxqj1OHEchXBL4P02NQvZy06FBFeS/jWMCEIfs1St7kC1p7DZP/vfRZXnWj8wRLVR54lihWBxm8/SGouLa834uUYDl6cKyknYUQ2fu7u/bEPltc10SLT/6lthldla5GGMZZ/2yMTQExZpI6yw5AQhtDyeI/tG1WneogviJGZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911562; c=relaxed/simple;
	bh=XqEEA6N5CwGJ6IA3lZOQ+4Ik7bEoUp9hnbB4/W/Zwik=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hE3mu/58wv9A5j32qXcFjKGnHN2+Bp7D0CfNdN/WxBfybCTRITsv/8aRwtNZ7e4MhsvIkC2+TlPXoKEMtl9+H15AA91o4ITUIgV2khBoSb88bZag9MMvNNST3Y8n8ghrWcpe1BSF4/zaAvOg5TcudZjLNKtPEjlrBILYgBgW0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=sQSfLOue; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8HXW5UO; arc=none smtp.client-ip=202.12.124.152
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4658D7A009D;
	Wed,  1 Jul 2026 09:12:39 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 09:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782911559;
	 x=1782997959; bh=XqEEA6N5CwGJ6IA3lZOQ+4Ik7bEoUp9hnbB4/W/Zwik=; b=
	sQSfLOueyGINlkU+m6V2rhx9l6c7DSh4peFKT2GDZON3Z0C4LcbV4ctXku49JLkN
	g+HFYP+lati0duVqQNupgWCUMLIDFQb3u5OhrYunrii8zZnVegxb4bXG1TicAdTZ
	1J6fEVDY8WkbUy5NVTaQZHbsMQqul3Z67raQ5Nzixux9IEaGnMSqdnlolXzBfyzT
	1kpbhhyClY1m74WD8UisTPPxiNBiHUK1gsKQyOz/Cllu1TQyh5Cgyl797knGzYpL
	s7dHJXo95drQLrIeVLutdn2sJJ7bSvCI+vVMLkubPKL1jYBySDDrpEnCUKSb1FpA
	H1/6b8NJRdzlwIK1yB4dwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782911559; x=
	1782997959; bh=XqEEA6N5CwGJ6IA3lZOQ+4Ik7bEoUp9hnbB4/W/Zwik=; b=O
	8HXW5UO+aYHUGl4LikMybwFP5BR8Y0BseQRJoQ7MMtQtRJUW7dx0z8kecrkKp6vE
	f8gRSqm+yzPUDG4VjaFkAv1+JLHl6ByRd2Nf8FazoyogYQkRl1dvBfFjZTfQSKk8
	VyfIiwjLPmwpzhOpCtWlTevYqBX8eA9E4N4h3nnP5TwUxyn6oD0Ms4mAgBntjB+r
	wSTbF3lQ5DcPe5gBp/7W0cOrfSMl8r/ZhRyWoVzntnmXr6AlgZ8B9Ylr2+j0d2d+
	HKycxjwa4Nz/b+UGNnW2aCoD4/MAS5C6pCPkk0ZH4p5+k2Pd89IwyHTMevvk/7Ze
	tUOd+Xhn/Bgdmdpcb/8fw==
X-ME-Sender: <xms:RRJFajJNuY7Ea447a624_w6t7wruejv0IM83V3g7A6KL8oggeAQA2A>
    <xme:RRJFah-e56FYyd82CwMxPWeJjpQRTsQnlwKSbLFSNlao1NsAE5Wp-CdM4hyLbkXQE
    _DlzPAfMzoE-whGqeOAnblKj8Oai3gyJlPqRfIoY39qPxdSMlnPpfI>
X-ME-Proxy-Cause: dmFkZTGla2qQNlSZKlIqara0zN5koG4KqHg1bkjXpggyAWCLJNg2kfVgLI8lLCbuU2lk8S
    kRgH252hH9LXdkXzSDSjqALczLdLPKlEPR5SaACUkXhDXWZtx+GoScADM9yWf1unDYqP8Q
    2WSsB+yxUTjScO4bMrLoRiVJEsOVtHKynDYkTDSNlV/FlVOr++ZZbwgmEhkG986gVx8K+K
    aifgVAxvA4y5ZVbSgxsda+zcFEbK/18X5WWflJ/ywdGPJlyZMoKT8cNBLhbRk76vDXjwpw
    QLo2apXc7MtJeiGpsVVyKxyOA/SHS/M5eq8vxnr8WZeLKtuTYlVXwaw/JxEnplkTQrl3Pd
    B7NJkf2pxDtojfaBQtKKBZV/obBu6aw/ly8+Aq5oikyGZRbLPSYuUz30ITeiZegu7GL1IY
    BH+bpbU2FYzgYNvuW0kYqCdaBa94ExMmldk/xGt6dBhZaPieoYjNF9biNBBc3rgUbgmFbj
    62LsHEdx24hoFQqVnJ9a9mVEjsfGg3qOJ5+MN46JlrX9eUQauDWHHEy0Awb0Lne6WNgaUO
    4yVurEkxq/P/EbUXu4DrDTid9azOO9+oXTmhGP+PV4UklaisM4awcqFWxNagTgrY4T7xHu
    8B7GWHRFLuVtfbbi9R9DHc8ER2iJp174rEfUAKSD/WUZBfVxKq+AH24iHCTA
X-ME-Proxy: <xmx:RRJFalJN2aoA8kDFMua_h-i5Chn-r0wU-KwqgCI_zyQFyJxETPlNhw>
    <xmx:RRJFajzXivGAASdZ72Is3bie1NpvnftEdIUPxmclVvZbBh4i5pzhmg>
    <xmx:RRJFatM652J4WnFqkRON4WLzi44_c61ZybTn0ej-5qq9fbWYJQjNfA>
    <xmx:RRJFanuRV787OOoAY7DQlxvI-5sNjEiRW1y01nGxGmEYB1CpRRmLyA>
    <xmx:RxJFavp-QxIqJqyh2AhOILa9hNEeIKNUBd7uz-YJn9OT8avMOzD2XKsB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 537641820082; Wed,  1 Jul 2026 09:12:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AE-5y0c3-Pto
Date: Wed, 01 Jul 2026 15:11:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-api@vger.kernel.org,
 sparclinux@vger.kernel.org
Message-Id: <a512dc5f-0734-4bd0-838c-61c8820e5f6d@app.fastmail.com>
In-Reply-To: 
 <20260701102912-ea8f3291-7bba-407b-9a7d-7c367a4c9398@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
 <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>
 <20260701102912-ea8f3291-7bba-407b-9a7d-7c367a4c9398@linutronix.de>
Subject: Re: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6757-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com,vger.kernel.org,lists.infradead.org,lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,app.fastmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CD8B6EE58F

On Wed, Jul 1, 2026, at 10:40, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Jun 30, 2026 at 03:00:37PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 30, 2026, at 09:38, Thomas Wei=C3=9Fschuh wrote:
>> > The "old" time types use 32-bit seconds which are not y2038-safe.
>> > Respect COMPAT_32BIT_TIME for functions using those types.
>> > time(), stime() and gettimeofday() are disabled completely.
>>=20
>> Looks good, yes
>
> Sashiko found an issue [0], which I think is valid. I'll change that f=
or v3.

Ok

>> > settimeofday() is kept as it is required to do the initial timewarp=
ing
>> > after boot. However the 'tv' argument will be rejected.
>>=20
>> Not sure about this part, did we already discuss this last time?
>
> This is my interpretation of [1].

Indeed, we did.

>> I can see how keeping the timewarping functionality is the easy way
>> out, but completely disabling the settimeofday syscall the same
>> way we do on new architectures seems so much more consistent.
>
> Shouldn't we then do this completely? Irrespective of COMPAT_32BIT_TIM=
E?
> And then remove all of the timewarping and kernel timezone bits.

I don't think we can simply kill the timewarping code since that
likely has users on architectures including on x86-64.

COMPAT_32BIT_TIME=3Dn is somewhat special because this is an
intentional (and optional) ABI break already and requires
updated userspace that avoids the time32 syscalls. Having the
timewarp still in settimeofday() or dropping it entirely is not
that different for userspace.

I was slightly worried about whether returning -EINVAL or -ENOSYS
is the better option here, but I think your choice is the correct
one after seeing that this is what glibc does other invalid
cases, and that in all of codesearch.debian.net, I could not
find a single caller that would care about the difference.

> It would be nice however if this series, and my other ones blocked beh=
ind it,
> are not blocked on that larger rework.

Sure.

I think you can go ahead with this version. I would prefer
to not have any settimeofday() for the COMPAT_32BIT_TIME=3Dn
case, but if nobody else has a strong opinion on the matter,
let's do it your way.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

