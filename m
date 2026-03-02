Return-Path: <linux-api+bounces-5892-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKeFDQ+upWleEQAAu9opvQ
	(envelope-from <linux-api+bounces-5892-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 16:34:39 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7231DBEFA
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 16:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0E3D300AEC7
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2026 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9C729D267;
	Mon,  2 Mar 2026 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvCDI9yb"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48121DF261
	for <linux-api@vger.kernel.org>; Mon,  2 Mar 2026 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465547; cv=none; b=ERwZVHeNxWhwoxQcq4S22emLuzxexKnncuWg8hyI1i+HssR65cKAsS/t3s+laTVtBKaJ8Zo3KW4D6dB1tL/0uu15O3tunCDCE17aoa9DYK7G/IiBsXum1Eqk/F9jWFRIvJe+5gpp659S3Rjb3ptLAv5/6XUgYH+14Vlvwjede6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465547; c=relaxed/simple;
	bh=07AFOAYM5vfEUnX59OT7L69W5DOHLejKZ7KAB4hHRqM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKA/AzroME+FHJKocyNnmg1Se/9NztPWZrKVcXh9pnIOPwP7AOsHSM4GDz/JbZaB+osvE9fwB1X2FBMh8hBhVoiu0GDyh7Do1cbvx1Vw2nqVtRijwlwF3ljRFFcGmnLNtwGULHd0ABWDN0DtP2jj1MRq1SmeEatDmSwkDRdRzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvCDI9yb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772465545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/bP2GpU7CpVeBmXT55ftLubjTqYeNp+MMqNPe+CYZiQ=;
	b=hvCDI9ybleRgyz5elo0Ft07D7JqYT/h8bYVWt06bmFpVY9tTzpeC2OCc6TASREwNmFJirq
	0zHm2wCLKLeVk+B8y+xVJoSQk9w3+unMv0i+Ox/J9jB7D29/WkQ3RHo8YWlzk30mCPmmuf
	j6ONTowaq86cyYdnL5aTqTWbg5t5IOo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-5H8lYTy6NHaiNhghbAgpGg-1; Mon,
 02 Mar 2026 10:32:21 -0500
X-MC-Unique: 5H8lYTy6NHaiNhghbAgpGg-1
X-Mimecast-MFC-AGG-ID: 5H8lYTy6NHaiNhghbAgpGg_1772465539
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0AAD18005B7;
	Mon,  2 Mar 2026 15:32:17 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DFA861956053;
	Mon,  2 Mar 2026 15:32:10 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,
  kernel-dev@igalia.com,  "Liam R
 . Howlett" <Liam.Howlett@oracle.com>,  linux-api@vger.kernel.org,  Darren
 Hart <dvhart@infradead.org>,  Thomas Gleixner <tglx@kernel.org>,  Ingo
 Molnar <mingo@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Torvald Riegel <triegel@redhat.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Rich
 Felker <dalias@aerifal.cx>,  Carlos O'Donell <carlos@redhat.com>,  Michal
 Hocko <mhocko@suse.com>,  linux-kernel@vger.kernel.org,
  "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,  Arnd Bergmann
 <arnd@arndb.de>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
In-Reply-To: <6bbc7276-4f06-4ec4-ba1a-53425871a6cb@efficios.com> (Mathieu
	Desnoyers's message of "Mon, 2 Mar 2026 09:57:17 -0500")
References: <20260220202620.139584-1-andrealmeid@igalia.com>
	<0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
	<67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
	<a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
	<ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
	<bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
	<694424f4-20d1-4473-8955-859acbad466f@efficios.com>
	<lhufr6ihelv.fsf@oldenburg.str.redhat.com>
	<6bbc7276-4f06-4ec4-ba1a-53425871a6cb@efficios.com>
Date: Mon, 02 Mar 2026 16:32:08 +0100
Message-ID: <lhu5x7edz7r.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: AA7231DBEFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5892-lists,linux-api=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

* Mathieu Desnoyers:

> On 2026-03-02 02:31, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>> 
>>> Of course, we'd have to implement the whole transaction in assembler
>>> for each architecture.
>> Could this be hidden ina vDSO call?
>
> Yes, good idea! I think this approach could work as well and reduce coupling
> between kernel and userspace compared to the rseq_rl_cs approach. It's OK
> as long as an extra function call on robust mutex unlock is not an issue
> performance wise.

I don't have a performance concern there.  It would be specific to
robust mutexes.

>> The question is whether we can model the unlock operation so that
>> it's sufficiently generic.
>
> I suspect the IP ranges and associated store-conditional flags I identified
> for the rseq_rl_cs approach are pretty much the key states we need to track.
> Architectures which support atomic exchange instructions are even simpler.
> We'd just have to keep track of this unlock operations steps internally
> between the kernel and the vDSO.

If the unlock operation is in the vDSO, we need to parameterize it
somehow, regarding offsets, values written etc., so that it's not
specific to exactly one robust mutex implementation.

> But you mentioned that rseq would be needed for a flag, so what I am
> missing ?

It's so that you don't have to figure out that the program counter is
somewhere in the special robust mutex unlock code every time a task gets
descheduled.

Thanks,
Foorian


