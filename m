Return-Path: <linux-api+bounces-5914-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNgfIJ/yrmnZKgIAu9opvQ
	(envelope-from <linux-api+bounces-5914-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 09 Mar 2026 17:17:35 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0526023C93F
	for <lists+linux-api@lfdr.de>; Mon, 09 Mar 2026 17:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6A7753007B8A
	for <lists+linux-api@lfdr.de>; Mon,  9 Mar 2026 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690563D3013;
	Mon,  9 Mar 2026 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nGZzrxo7"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3323B7B7C;
	Mon,  9 Mar 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073053; cv=none; b=BtGT+644BIJ/dNDN5R0MMUo+UDllsPCQdNxFV9uvoxDFBQ6g4QmuA62JMG7DZq7giL96QbnuULXM6gHlT8PEvWXWATZeC58k+51TauNP6fLHp9F62Wv4KwT5vr8mz9HkuPKDW02xlwEThPZ3Ca3ed3xKxPb+N2AHuUPWTxw6p3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073053; c=relaxed/simple;
	bh=UD0dm+OloczYr1ek1MUFdc3Us4Kx5Rl5ZAUrOon9nzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oiBGzOY6NjpIuxCtKfVrWQESKpxFOPECqXyKlUwk143l3396sLJaqvcjreOWNw9z690rcpNSyQLQ+L1pczLyPWms3IKRujiJ+8q7yKdgflwWBwwjyNRfbOM+0SRTaENzaDwDsvg4soA8cJ3UqeSYYYc/onFhsO3E27/0X0Ewtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nGZzrxo7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 89D2540429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773073051; bh=T9zkIHLV7xrYDf350oGtXbmqwAFtsvJ1iVEnCrbfp4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nGZzrxo7I84z8s+QcErmdbvT01e61IguJUf+4btWOjDP7YqjAaR4p+l+K4zdIu+F1
	 oOxb/lRSBgwyUhoX6R44SeS6rxrg4nlQ+VupgTm+r9gvz8gXatCDIa1kLvEt+nyyI+
	 0LeCVLXET5TlxNpZBZ5OK5ERGGwUfOoWUXduOV7hYaPseqLGlY85NJ4ef3soBVCRg9
	 CRgg42kOeJjkFcanMcmHTKzjqE/iWUXKFkrzss2yHOXcbXAaXp9cG6H3biyoET1Bf7
	 HwpuCCevWa4TVyPK1ztg8En06SWKv7wpM6Gk/N7BbY44lL+XffgnlcE2yJc86nHqF7
	 yLde68mUltFsg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 89D2540429;
	Mon,  9 Mar 2026 16:17:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tommaso Cucinotta <tommaso.cucinotta@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 linux-api@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Shashank Balaji
 <shashank.mahadasyam@sony.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/deadline: document new sched_getattr() feature
 for retrieving current parameters for DEADLINE tasks
In-Reply-To: <20260304102843.1373905-2-tommaso.cucinotta@santannapisa.it>
References: <20260303104215.1324243-1-tommaso.cucinotta@santannapisa.it>
 <20260304102843.1373905-1-tommaso.cucinotta@santannapisa.it>
 <20260304102843.1373905-2-tommaso.cucinotta@santannapisa.it>
Date: Mon, 09 Mar 2026 10:17:30 -0600
Message-ID: <87ikb5vuxx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 0526023C93F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5914-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,infradead.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lwn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[trenco.lwn.net:mid,lwn.net:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,santannapisa.it:email]
X-Rspamd-Action: no action

Tommaso Cucinotta <tommaso.cucinotta@gmail.com> writes:

> Document in Documentation/sched/sched-deadline.rst the new capability of
> sched_getattr() to retrieve, for DEADLINE tasks, the runtime left and absolute
> deadline (setting the flags syscall parameter to 1), in addition to the static
> parameters (obtained with flags=0).
>
> Signed-off-by: Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  Documentation/scheduler/sched-deadline.rst | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Applied, thanks.

jon

