Return-Path: <linux-api+bounces-5884-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJo4B7ftoWlDxQQAu9opvQ
	(envelope-from <linux-api+bounces-5884-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 20:17:11 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 728FD1BC935
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 20:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2929030692D4
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B15E3859CB;
	Fri, 27 Feb 2026 19:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="etL++Tem"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE2A2EBB99;
	Fri, 27 Feb 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219764; cv=none; b=pLI9iu3/c3/jZJC1Scl1V4aQV4Kf9pZc0F8OepetrO6cka49lxfkxe4MadPrmL4ZxWAXrmsYcWhAgN1P9CMVkzIo3jqM3eo2pfA4aVj61w6fS3uQYB8Hjl0edq0/TZVTwMC2Cy7rsEuqv5hxkDlMO6TJuj5evJHIs5YCiv5EYQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219764; c=relaxed/simple;
	bh=1c2xHMfAsbb086sCkiX9ZYBxF5DPDk731lam2Gj6nKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alhvg3kT/Lj3TXLMNVYQsa3Q5BqTO6c4WZmN4KsK0zHMdbmUePuB1YGcpmfsU6UIHjWNNFO+k27KyytuGfvPvgWppGz6icyBVuz7tAuhi0FmHG+VjU+EoAbzpaELlWP4nET+LXkNeDthjwBkyY15DGzZ1ztekOTnBEZ08D0iYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=etL++Tem; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fdsDvGh3gSL+GLLtJVpYBZijFWZYFV5EbhITDkY14FM=; b=etL++TembeEunHcgrX+NXU9DB5
	LNNz/0lz5KZdJCU0lnCBAF0/NqIbpG4p64aTNafURZGm3gGqveqwUkCA7zsCJfb2Gjk8hJYbdhSzM
	qbjP0f4N4c4gsCE0a8pyc98rfhU0PrG08Yz7Je1aHsjZK/LVZzutI3Q9ZtYcGsyhUrKgBWmJxskNJ
	w9hEEC4vUdt/92eyKiobB3bqcK/g8yzZbAm93gCsKvIUB5GD/uMQDaYhyXyeJIpJxiJJZCLzngTqJ
	KmFwwWkp7+9SwM5rd4ZJudY7uzPqH5kEGx83mrUTWnIYGaSBhE0NrhSPiCP5V1tTtcgCD1iK0SAyZ
	jCXL6aOQ==;
Received: from [177.172.125.177] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vw3J6-006eZk-0T; Fri, 27 Feb 2026 20:15:24 +0100
Message-ID: <1f0b5684-3146-424e-87e6-7a5994415f7e@igalia.com>
Date: Fri, 27 Feb 2026 16:15:13 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Carlos O'Donell <carlos@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel-dev@igalia.com,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <sn6isqtjcgzix4iwifcg6fy2lq3klfdykezyodzbt7fz7urhcs@dc5sxuzypdoc>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <sn6isqtjcgzix4iwifcg6fy2lq3klfdykezyodzbt7fz7urhcs@dc5sxuzypdoc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5884-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[igalia.com:-];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourceware.org:url,igalia.com:mid,igalia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 728FD1BC935
X-Rspamd-Action: no action

Hi Liam,

Em 20/02/2026 17:51, Liam R. Howlett escreveu:
> +Cc Suren, Lorenzo, and Michal
> 
> * André Almeida <andrealmeid@igalia.com> [260220 15:27]:
>> During LPC 2025, I presented a session about creating a new syscall for
>> robust_list[0][1]. However, most of the session discussion wasn't much related
>> to the new syscall itself, but much more related to an old bug that exists in
>> the current robust_list mechanism.
> 
> Ah, sorry for hijacking the session, that was not my intention, but this
> needs to be addressed before we propagate the issue into the next
> iteration.
> 

No problem! I believe that this reflects the fact that the race 
condition is the main concern about this new interface, and that we 
should focus our discussion around this.

>>
>> Since at least 2012, there's an open bug reporting a race condition, as
>> Carlos O'Donell pointed out:
>>
>>    "File corruption race condition in robust mutex unlocking"
>>    https://sourceware.org/bugzilla/show_bug.cgi?id=14485
>>

[...]

> 
> There was a delay added to the oom reaper for these tasks [1] by commit
> e4a38402c36e ("oom_kill.c: futex: delay the OOM reaper to allow time for
> proper futex cleanup")
> 
> We did discuss marking the vmas as needing to be skipped by the oom
> manager, but no clear path forward was clear.  It's also not clear if
> that's the only area where such a problem exists.
> 
> [1].  https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u
> 

So how would you detect which vmas should be skipped? And this won't fix 
the issue when the memory is unmapped right, just for the OOM case?


