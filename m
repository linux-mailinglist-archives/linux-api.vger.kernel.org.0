Return-Path: <linux-api+bounces-5778-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Jo4InqGfGmbNgIAu9opvQ
	(envelope-from <linux-api+bounces-5778-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 11:22:50 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B5BB94D3
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 11:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB0D302262C
	for <lists+linux-api@lfdr.de>; Fri, 30 Jan 2026 10:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BAC35DCF9;
	Fri, 30 Jan 2026 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i5nWeqU4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHbe7Nps"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEE35C193;
	Fri, 30 Jan 2026 10:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769768544; cv=none; b=Ma/qliDGP9oGEsrf+EGzi4QUajjiyDssDRuX/f1Anh0RT4DZJAndhoRcAWKd1RFolCjy8O1hAv6+9DN+7FVZv/qaVbUaWnp0vR1GgY/sLh+BDW8rwMDZhXCBc0W1G/963HXrSBC47MyliRIxFjTTXj5XTz1QeMSxDAF16dO7L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769768544; c=relaxed/simple;
	bh=Eq2G7Xi3OimnQOM/OPf23yrh0oiEwbP1aeWoGbFDTqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2pHs5JD4ViBns+UTLs2nNOIPHNR7wt0zghHZnUXmEZCnfNu9V0uu241GsTvnK2tmYkDtOrnmrr7wvDT/9iZ3wkvaRrOgruh2sGrxvIi0f94ci/EWSn108mbdf+UxduwjGo/A+BnNu2xXsnQ6ZP8CRZJFgj+9nXuveaZPFPpg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i5nWeqU4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHbe7Nps; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 30 Jan 2026 11:22:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769768540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfQHnA2BmBI6ftm9auzvWJDnwuKHz7JY0ERZmZ33OkI=;
	b=i5nWeqU4DrtCSygkhNXk0clW9sdJeYUn+nu/Lp14hRLsdOkRPW/to9G74aQNkjj8/JTbn+
	EVuWx+CmaVxnH53spKOTa7yTwq+7Tl5lbIaIOm6gfGtyYUgNE6YFmOkXoVoKgF7DIPCyUf
	y1lAx0HgGSDiub5A9zPaedO1HVcaiXfp8sro3/sdIma6WQfHSaspq9hNO8iPB5ZcgcMbe7
	NHxgCPJn4K4WRfNe8JCnTOItY+RoBL8mYl7doxD5VtpmDXKdPBP/9LsAR9z4WEYm+EfAXY
	56WuhmuxkZV0tie3qdFvjlHPysRbMXP1CcsyWmgKLMDJcorskgLzg36usAwFSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769768540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SfQHnA2BmBI6ftm9auzvWJDnwuKHz7JY0ERZmZ33OkI=;
	b=FHbe7NpszOxXo2LOeb2aDyUedizHq4EKWZVTWJo3btpIoSScU03CQEk/9T3wpc7XZUEEHy
	j7CSY3+NgBT2CcBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	libc-alpha@sourceware.org
Subject: Re: [PATCH net-next v2 1/4] selftests: net: Move some UAPI header
 inclusions after libc ones
Message-ID: <20260130111949-4b4eb870-6df7-4026-a48c-730fa8660ad6@linutronix.de>
References: <20260120-uapi-sockaddr-v2-0-63c319111cf6@linutronix.de>
 <20260120-uapi-sockaddr-v2-1-63c319111cf6@linutronix.de>
 <4e673f7f-c49c-46b0-85b4-bae6e4efcb3a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e673f7f-c49c-46b0-85b4-bae6e4efcb3a@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5778-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: E6B5BB94D3
X-Rspamd-Action: no action

(trimmed the recipient list)

Hi Matt,

On Mon, Jan 26, 2026 at 07:13:50PM +0100, Matthieu Baerts wrote:
> On 20/01/2026 15:10, Thomas Weißschuh wrote:
> > Interleaving inclusions of UAPI headers and libc headers is problematic.
> > Both sets of headers define conflicting symbols. To enable their
> > coexistence a compatibility-mechanism is in place.
> > 
> > An upcoming change will define 'struct sockaddr' from linux/socket.h.
> > However sys/socket.h from libc does not yet handle this case and a
> > symbol conflict will arise.
> > 
> > Furthermore libc-compat.h evaluates the state of the libc
> > inclusions only once, at the point it is included first. If another
> > problematic header from libc is included later, symbol conflicts arise.
> > This will trigger other duplicate definitions when linux/libc-compat.h
> > is added to linux/socket.h
> > 
> > Move the inclusion of UAPI headers after the inclusion of the glibc
> > ones, so the libc-compat.h continues to work correctly.
> 
> Thank you for looking at this!
> 
> Here is my (late, sorry) review for the modifications related to MPTCP:
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > index 8e0b1b8d84b6..af25ebfd2915 100644
> > --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> > @@ -1,11 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /* Copyright (c) 2025, Kylin Software */
> >  
> > -#include <linux/sock_diag.h>
> > -#include <linux/rtnetlink.h>
> > -#include <linux/inet_diag.h>
> > -#include <linux/netlink.h>
> > -#include <linux/compiler.h>
> >  #include <sys/socket.h>
> >  #include <netinet/in.h>
> >  #include <linux/tcp.h>
> 
> There is a remaining one (linux/tcp.h) here that you might want to move
> below too.

Good point.

> > @@ -17,6 +12,12 @@
> >  #include <errno.h>
> >  #include <stdio.h>
> >  
> > +#include <linux/sock_diag.h>
> > +#include <linux/rtnetlink.h>
> > +#include <linux/inet_diag.h>
> > +#include <linux/netlink.h>
> > +#include <linux/compiler.h>
> 
> Note that I just noticed this is the only file from this directory where
> the "includes" are not sorted by type and alphabetical order, see
> pm_nl_ctl.c as an example. A bit of a detail, but if you plan to send a
> v2, do you mind doing that too here while at it, please?

I'll send a v3 during the next cycle.

> If not, I can look at that later, but better to avoid doing that in
> parallel.

If you want to fix this up already during this cycle,
that would also be most welcome.


Thomas

