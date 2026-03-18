Return-Path: <linux-api+bounces-6007-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIbhM0e2umlWawIAu9opvQ
	(envelope-from <linux-api+bounces-6007-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:27:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E12F2BD177
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A606E306465B
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B963D904F;
	Wed, 18 Mar 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MmHH36B4"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7113D75DD;
	Wed, 18 Mar 2026 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843417; cv=none; b=kPslycq/UTFbkf814kAO8MBJsSjIV2s5e69wzikzYpz4ENX/crCdGXhgWY9Bwyqvtg/80bPaUO2fnEXl3+IqZZTn7/XrbLTHSoXpGWiFRBYGJ48j+Uih2EA+ZQ7w8V7isxXnI5uOVQJKcMZQ0Res75BAWCN5mfIxx8ji0A334kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843417; c=relaxed/simple;
	bh=niTTayRNIX4EEYyDdhdDQo8aWS9N/JBwImjwEF9evEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UKDzzWh+X0deYpDry/WMAbByGJ7FBY3znD+Q3vDqBGn59A9YpIBu3dlYNUDCBOYp4t3h/sqtGLXO7eRcogPyoqCFEevMjP+7QaTY9GA2jM+V3suI5F8CkFcKuyaP120RpQPcI/Fkebf7Yyza3ZqhDBblP/XHkxlGlSsWHruc3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MmHH36B4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4104141213
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773843414; bh=pZLknu9kNmkFJXKOV+mk6Nd6QgIhMbsMx+SciRU/lEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MmHH36B45RNVUcw2zeWJbjSLA17c3huYZJvv3IiLmRQSMPfMzN9w59kEH762XP9ap
	 NA0yipMcCGzpT2FROqqTQWpLCRaoj8s1lP67wUn6DvXnmtYZTLSSKGIG8mwQhYhpXy
	 Y+WU1fIGCHaAemAFR29akbXlLYslpxGGb7IM7oMyrrsX3fWETZoIOG4JtgluqJSE87
	 ndrllFLei8HjKkxQRTIR5opx2UePst3Xd+gbi3O/RyZYqXuXjJKcmg/NjF8p81cqLg
	 UIpSExyazmd4/bn1J6GWBrsafDss8lyvwTtCQa4juny+otE0FNVRXGsl6ClDM515S9
	 djt568QbhK/Xw==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4104141213;
	Wed, 18 Mar 2026 14:16:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org, Thomas
 Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Dmitry Vyukov <dvyukov@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge
 <jake@lwn.net>, David Laight <david.laight.linux@gmail.com>, Askar Safin
 <safinaskar@zohomail.com>, Gabriele Paoloni <gpaoloni@redhat.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo
 Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/9] kernel/api: add API specification for sys_open
In-Reply-To: <abqyv0DiT0LFUU4v@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-6-sashal@kernel.org>
 <2026031343-raft-panhandle-0a21@gregkh> <abQ-iIylzpuqlRv3@laps>
 <878qbq9uau.fsf@trenco.lwn.net> <abqyv0DiT0LFUU4v@laps>
Date: Wed, 18 Mar 2026 08:16:53 -0600
Message-ID: <87jyv96x4a.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6007-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,kernel.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.754];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lwn.net:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E12F2BD177
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sasha Levin <sashal@kernel.org> writes:

> On Tue, Mar 17, 2026 at 12:37:13PM -0600, Jonathan Corbet wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>
>>> On Fri, Mar 13, 2026 at 04:33:57PM +0100, Greg Kroah-Hartman wrote:
>>>>On Fri, Mar 13, 2026 at 11:09:15AM -0400, Sasha Levin wrote:
>>
>>>>> + * since-version: 1.0
>>>>
>>>>I think since older versions :)
>>>
>>> Right. I guess that in my mind 1.0 was the first official "release". I'll
>>> update it to 0.01.
>>
>>That kind of raises the question of just what since-version means.  The
>>version-0.01 (or 1.0) version of open() surely didn't do everything
>>described in this specification.  So it's saying that some version of
>>the system call has existed since then?
>
> You know, I'm not entierly sure what the definition should be here.
>
> I stole this from man pages where they indicate at which version the API was
> introduced in. I'm not sure if it really adds any value.
>
> Any objections to just dropping it?

Not here.  My general objective with the docs is to describe the kernel
as it is now, without that sort of history unless there's something
specific it can tell current users.

Thanks,

jon

