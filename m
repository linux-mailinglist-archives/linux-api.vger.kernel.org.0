Return-Path: <linux-api+bounces-5894-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLlYFDLApWknFgAAu9opvQ
	(envelope-from <linux-api+bounces-5894-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 17:52:02 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F6E1DD438
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5617B3077389
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2026 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93B426ECF;
	Mon,  2 Mar 2026 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/kHqwpa"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC47F426ECB
	for <linux-api@vger.kernel.org>; Mon,  2 Mar 2026 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469775; cv=none; b=Kl3gPWI7kuuy4SOqI/b4zu20IUeFF0VepmwrOLCcgtuBEVGiBfROS6s6itzp/PRk4YdYLQA4FEftAqO5bACVcG7vxVK5xREGcpwUoV6c+laVnG+V6TtDoEy3bvhXv5Pw2VlZGb79pPsPA7jOCDkgmZaA3KX/gAx9xhdfb67vHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469775; c=relaxed/simple;
	bh=zP2nU09JAGsFXcx67pfuGBd9qbXbVblGAWiRtU3aico=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MUqmbh7kT+mTz5eKYtOG/gqSjBO7M4KgCfzF31s3CVZVGFlriUBRiEavkiBbHZ/tHn4FFcwEeQPDywaYjhApG0jCWF/t3WzaVQDKpFj1hs+Y5rhuCUNU0MjG5CrRx9t0CjIXgQlsMOVruxM4oYTzeFBlYFfnQ0htpo+5GeJvUw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N/kHqwpa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772469772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPOa7hNykA/Y7FLwl6+kEOzGGlQdLnDvX0rRezjTWcE=;
	b=N/kHqwpanTzN/rzjftrQI4JLkRn5nJWl2a69ZWFVlIwplo/59dDqMFgawO1meD0XmuJdar
	blX653Ujxd4XQpUXxPxr+4pejTcXVczo/B9zTFU3hCotEj8mCB1TpL3x0HMSPDu2FPNM3K
	IIcS9cO8zAIsVwypq1yMVpiW4pVPLIc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-T4CJj72AN0ezTQqtD3td1Q-1; Mon,
 02 Mar 2026 11:42:48 -0500
X-MC-Unique: T4CJj72AN0ezTQqtD3td1Q-1
X-Mimecast-MFC-AGG-ID: T4CJj72AN0ezTQqtD3td1Q_1772469766
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18AF21800365;
	Mon,  2 Mar 2026 16:42:45 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.151])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C02619560A7;
	Mon,  2 Mar 2026 16:42:38 +0000 (UTC)
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
In-Reply-To: <3f30f2f0-5173-42e2-aa89-0af9bb391c0e@efficios.com> (Mathieu
	Desnoyers's message of "Mon, 2 Mar 2026 11:32:26 -0500")
References: <20260220202620.139584-1-andrealmeid@igalia.com>
	<0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
	<67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
	<a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
	<ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
	<bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
	<694424f4-20d1-4473-8955-859acbad466f@efficios.com>
	<lhufr6ihelv.fsf@oldenburg.str.redhat.com>
	<6bbc7276-4f06-4ec4-ba1a-53425871a6cb@efficios.com>
	<lhu5x7edz7r.fsf@oldenburg.str.redhat.com>
	<3f30f2f0-5173-42e2-aa89-0af9bb391c0e@efficios.com>
Date: Mon, 02 Mar 2026 17:42:35 +0100
Message-ID: <lhuqzq2chdw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: B8F6E1DD438
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-5894-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oldenburg.str.redhat.com:mid]
X-Rspamd-Action: no action

* Mathieu Desnoyers:

> On 2026-03-02 10:32, Florian Weimer wrote:
>> * Mathieu Desnoyers:
>> 
>>> On 2026-03-02 02:31, Florian Weimer wrote:
>>>> * Mathieu Desnoyers:
>>>>
>>>>> Of course, we'd have to implement the whole transaction in assembler
>>>>> for each architecture.
>>>> Could this be hidden ina vDSO call?
>>>
> [...]
>>> I suspect the IP ranges and associated store-conditional flags I identified
>>> for the rseq_rl_cs approach are pretty much the key states we need to track.
>>> Architectures which support atomic exchange instructions are even simpler.
>>> We'd just have to keep track of this unlock operations steps internally
>>> between the kernel and the vDSO.
>> If the unlock operation is in the vDSO, we need to parameterize it
>> somehow, regarding offsets, values written etc., so that it's not
>> specific to exactly one robust mutex implementation.
>
> Agreed.
>
>> 
>>> But you mentioned that rseq would be needed for a flag, so what I am
>>> missing ?
>> It's so that you don't have to figure out that the program counter
>> is
>> somewhere in the special robust mutex unlock code every time a task gets
>> descheduled.
>
> AFAIU we don't need to evaluate this on context switch. We only need
> to evaluate it at:
>
> (a) Signal delivery,
> (b) Process exit.

Ah, missed that part.  It changes the rules somewhat.

> Also, the tradeoff here is not clear cut to me: the only thing the rseq
> flag would prevent is comparisons of the instruction pointer against a
> vDSO range at (a) and (b), which are not as performance critical as
> context switches. I'm not sure it would warrant the added complexity of
> the rseq flag, and coupling with rseq. Moreover, I'm not convinced that
> loading an extra rseq flag field from userspace would be faster than
> just comparing with a known range of vDSO addresses.

It wouldn't work for the signal case anyway.  That would need space in
rseq for some kind of write-ahead log of the operation before it's being
carried out, so that it can be completed on signal delivery/process
exit.

Thanks,
Florian


