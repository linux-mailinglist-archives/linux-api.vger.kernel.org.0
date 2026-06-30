Return-Path: <linux-api+bounces-6744-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cqfeES++Q2oegQoAu9opvQ
	(envelope-from <linux-api+bounces-6744-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 15:01:35 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2336E48F3
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 15:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arndb.de header.s=fm1 header.b=ry3ErCIg;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="k fBRfO8";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6744-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6744-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arndb.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02482300A8CF
	for <lists+linux-api@lfdr.de>; Tue, 30 Jun 2026 13:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A5A3F58FE;
	Tue, 30 Jun 2026 13:01:05 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C96F15E5BB;
	Tue, 30 Jun 2026 13:01:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824464; cv=none; b=e1r1hGTOKKKLjwaWPhCJlyptuVGLdXumJeSlfCiLiYHUB93xmGBCdlu1qkqsh7PYfwJqQXxXFU5seozrDIyMEzc5NHDbEu57x5zoIW5Ssu45a1Ofwwhj13JoPLv1JVzjtkQtPNJRNsZDeCwoSe4l+bXFw8catPyX6VI1QZcc1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824464; c=relaxed/simple;
	bh=KT+MLdjzY7QUGS6/AXvsg0V/mYqQlkmm12IVXGeeX3E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o8b6b0s9zUYQ6AktAud6w8hgBXkd+lI8CgY+nLAHU5w6DhoS0o8YXrddZAaE6iAFyfIHu3kmlcfWycVL/o6MlGRxMW6mrJjWfYx4S0txkOJueuF7jfXNgOuYYxCLWrgmzMbxnc4JnsuowT6m8tnsvPmYUHl4mFkJ4OV9VGIXiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ry3ErCIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kfBRfO8t; arc=none smtp.client-ip=103.168.172.157
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 476C714000FD;
	Tue, 30 Jun 2026 09:01:02 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 09:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782824462;
	 x=1782910862; bh=iYYuOZov12hcbQiyTHde5c/x6Htp8xzdQNZ4OeiKrk0=; b=
	ry3ErCIgNRDEDsfHFWvdAucEyRmy1vqSMs/gfI/scpThnGl1wLNhTbBU0BGK54nN
	ht1qWRUzhzQhtlKdQX6reCDsDZ2X2kHfWFVMcEFcwdoG3cDOnz4nZxvuSEzVYUHQ
	2oaAzoPvYr0kJKO3ZQty4rYr7r/rLrCbTy8wu8hVlgmO7fsIigipT4gbi0BTkWP8
	bDcK8G8Ncl4AOCdv+CoM9o9VntK7sshEERlPd19i2yqox5jU7q2kynHihvpnxjDl
	eGvYqaVuEtNr3te5xjgouwWha3Qd8iLrHxVBBv//00X9AfaLMXYDc24pGQ8Sop2m
	7dBgI4LYMgQAKkKFhaOVwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782824462; x=
	1782910862; bh=iYYuOZov12hcbQiyTHde5c/x6Htp8xzdQNZ4OeiKrk0=; b=k
	fBRfO8tMofkAsXlnBZPmcGB1lwBrGKQF+b6p505NKpOUEvFEtx7xFIIqOjs4OUDv
	mD317UdnXKt5eOYc1UdK8O2jZu9etc6o8RhGgjg/UvFGIyMo1DqA2RJUDmv5FiOK
	4hTUCaAA50Ki3P86JUkpFJjbFRkAAWM4K6oD3ms0d/BdXuhVE2nU5mi/6YAhJ8V6
	D8DPUhyOen7AKRA86g02cfq+5I0TERz0U0Z/JmGJyXU6UMl19HZhkXPpRED0SPcG
	HTiXeQUeUrTjJ2B5UoMFRle0oTC7soZb08+SssLMlOqOHGU3w1+Jf6yEBPxORo2v
	WBXJT/2HSU2feAmiVXScA==
X-ME-Sender: <xms:C75DamD18Rj1TgalP5-y811xofhTnl-Y9Wt1crTVpizthWJL3TSTEw>
    <xme:C75DarWNiFFubb4rT9hDz0k2hjVF0CT0IXOQW0rVyFykLxE15ayFn0-DRw2QJLA1l
    LgoDKPJJY_fsLXr2GxAf4_rG29A2Ux6V4WS6J78RQzGPwcrgmXvaw>
X-ME-Proxy-Cause: dmFkZTE1CTZhcONSe2BMdJBc5eCarLTeeHvKT/Ij+U/FNs3FbpGNzgb8fGDmfnxjnx7lfY
    m7ZQSYyTOmNikhSa0Mi3YiUC3XLmfICeSpKo7Zw/Aa0/z6MAnVgMZKs+iC49hPcELYt+DF
    8vu6XGLJUDEh3WfggJITcuPacvy6ArBa5WP+8G2PugMbliAtz1HeacvYXnjkhw8scaRfj8
    27dcf7d5REJxpixhyne/AAIUrs5aLrCOEKPKXaUwR4ltWFZej0PburpLDKlSiYpuHJscFg
    BjGdlF8V3QH1GWCht9abUmCEyhY1hPUctG9KtzKR2advcKrKOzgfTmgFXK0oCg8f5TgEnL
    ocE6pM8g5QHpugvF8GVT6N3j9l0Ldpj/bmGhrcHRsJmyrCImeOB07cBh8IuhEW4xnaOteh
    9UknhQs1fe70bZ0cU0AKfSJ4j9+3dFhaViNEI+PlMcOr5wrEITkUEQlYC/PFvDzfioIyHr
    Wcs1o4mOMKh49ywK9vXE7doihKC+vy2vwJ7UXXKze7bntlSLpJ2MrmQIK13JJdVWXmkhWR
    6KdS6ldARlm5gZ82fBXcjLBJ9yq3vSGY+OEzm2akWS9Zhsb4mRk0r05mKEDVbiB1RkDji/
    zzA2pE9TajJ46bVehIVbUb4sPf7V1H2dPFdZtNMSfzMtzNRyzOWCcWR2/JNQ
X-ME-Proxy: <xmx:DL5DanA4pstSClCxjPSEsBz4THdM2pU18jZBYSJ_cJBYzhzNAi3jYg>
    <xmx:DL5DagLnr8fzcmqr5OsPSsS792FtyCoka_tk7eXVCa83oI5HFIbluw>
    <xmx:DL5DaiHWYhtyi2WGGLnozydbeBPaJh5sbkUWfcJrn3THEBgKBss1aA>
    <xmx:DL5DarHFaCmEAZo0MHmGScZt8uCjJTxKcbkYQQNuQwCyu7stXO13dA>
    <xmx:Dr5Dagh0vDsYlZmqg66mKbxW_OBL4eHDxBD-rOqyyVxAKdWvwhEhCknp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC3A0182007E; Tue, 30 Jun 2026 09:00:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AE-5y0c3-Pto
Date: Tue, 30 Jun 2026 15:00:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Andy Lutomirski" <luto@kernel.org>, "Thomas Gleixner" <tglx@kernel.org>,
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
 "Andreas Larsson" <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
 linux-api@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <0cda7366-2eb9-4ecb-b76a-b3b68ee10043@app.fastmail.com>
In-Reply-To: 
 <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-1-520d194640dd@linutronix.de>
Subject: Re: [PATCH v2 1/9] time: Respect COMPAT_32BIT_TIME for old time type functions
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thomas.weissschuh@linutronix.de,m:luto@kernel.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:tsbogend@alpha.franken.de,m:vincenzo.frascino@arm.com,m:jstultz@google.com,m:sboyd@kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-mips@vger.kernel.org,m:linux-api@vger.kernel.org,m:sparclinux@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_TO(0.00)[linutronix.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,armlinux.org.uk,arm.com,linux.ibm.com,ellerman.id.au,gmail.com,alpha.franken.de,google.com,davemloft.net,gaisler.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6744-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid,messagingengine.com:dkim,vger.kernel.org:from_smtp,arndb.de:dkim,arndb.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF2336E48F3

On Tue, Jun 30, 2026, at 09:38, Thomas Wei=C3=9Fschuh wrote:
> The "old" time types use 32-bit seconds which are not y2038-safe.
> Respect COMPAT_32BIT_TIME for functions using those types.
> time(), stime() and gettimeofday() are disabled completely.

Looks good, yes

> settimeofday() is kept as it is required to do the initial timewarping
> after boot. However the 'tv' argument will be rejected.

Not sure about this part, did we already discuss this last time?

I can see how keeping the timewarping functionality is the easy way
out, but completely disabling the settimeofday syscall the same
way we do on new architectures seems so much more consistent.

Note how scripts/syscall.tbl blocks sys_settimeofday on
architectures that don't set the time32 flag, which ideally
should match the COMPAT_32BIT_TIME option here.

     Arnd

