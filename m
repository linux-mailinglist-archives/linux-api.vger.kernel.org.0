Return-Path: <linux-api+bounces-5873-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECogBZA2nGnsBQQAu9opvQ
	(envelope-from <linux-api+bounces-5873-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 12:14:24 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B57175576
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 12:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E77BF3020230
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 11:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B935D5F8;
	Mon, 23 Feb 2026 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU7ap3GP"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E19134FF49
	for <linux-api@vger.kernel.org>; Mon, 23 Feb 2026 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845258; cv=none; b=cPhJmq5JsvWBtJwMjdvDT5de3bEqVUcIHWGI45NQe1Ph29m15swQ48gqcyLSUwEgVxGJisal4pyM8za2NIHqT2l+WE91UvN6dpZXUtkE45zsrfLedJQEU8ntyowebbPLc5EuRQ2jCDqkQ+qD0PAHAq/Zz6rxbGRwGHzowW/iMxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845258; c=relaxed/simple;
	bh=Yd8cq7jhxBQD+nJL1cG4S1BqInpFBTV54XgA03pK4Xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hNp7EndRVqooWtnG2vVlV19U6KHsyvTAMy90jrVJnZH/MQ22+rm27V/zn8iuj1Wd4A9khW84cuH6DjQlPhP64mtZ/CtmIt2G88h3DilPZgvYUP86QuAtOi/qLLmDTogfvKd80Jgtxvcj45wH3V6EvL6ccrx4U2W+x/sQyfe+824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU7ap3GP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771845256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvSyvbvHe9TBXfOII9wq8hqN2AGyxv0aQKYcsksqKFg=;
	b=gU7ap3GPCyzlS0WiVQLkBWtZXYjIedb4vdtPPlsquLpCtWX3OIAnz0PudlMP2X3oSlFEur
	ECC65dqt52W0nKHRLHYmOzbxUlNXVwPCmzpp9nxRGH7zfCobx1kP3wtpaIH9UDXILnqKHN
	H9IcRXOXhFp4nq5u/54Vuf6BSyfa4Ss=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-zVZfYIWhOqG3B1y3NUeS-g-1; Mon,
 23 Feb 2026 06:14:13 -0500
X-MC-Unique: zVZfYIWhOqG3B1y3NUeS-g-1
X-Mimecast-MFC-AGG-ID: zVZfYIWhOqG3B1y3NUeS-g_1771845251
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C15F2195608F;
	Mon, 23 Feb 2026 11:14:09 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 534EC30001BE;
	Mon, 23 Feb 2026 11:14:01 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Carlos
 O'Donell
 <carlos@redhat.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  Peter Zijlstra <peterz@infradead.org>,  Rich Felker <dalias@aerifal.cx>,
  Torvald Riegel <triegel@redhat.com>,  Darren Hart <dvhart@infradead.org>,
  Thomas Gleixner <tglx@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  Davidlohr Bueso <dave@stgolabs.net>,  Arnd Bergmann <arnd@arndb.de>,
  "Liam R . Howlett" <Liam.Howlett@oracle.com>,  Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>,  Michal Hocko <mhocko@suse.com>,
  kernel-dev@igalia.com,  linux-api@vger.kernel.org,
  linux-kernel@vger.kernel.org,  libc-alpha <libc-alpha@sourceware.org>
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
In-Reply-To: <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com> (Mathieu
	Desnoyers's message of "Fri, 20 Feb 2026 18:17:36 -0500")
References: <20260220202620.139584-1-andrealmeid@igalia.com>
	<0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
	<67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
	<a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
Date: Mon, 23 Feb 2026 12:13:59 +0100
Message-ID: <lhusearzp8o.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5873-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0B57175576
X-Rspamd-Action: no action

* Mathieu Desnoyers:

> Trying to find a backward compatible way to solve this may be tricky.
> Here is one possible approach I have in mind: Introduce a new syscall,
> e.g. sys_cleanup_robust_list(void *addr)
>
> This system call would be invoked on pthread_mutex_destroy(3) of
> robust mutexes, and do the following:
>
> - Calculate the offset of @addr within its mapping,
> - Iterate on all processes which map the backing store which contain
>   the lock address @addr.
>   - Iterate on each thread sibling within each of those processes,
>     - If the thread has a robust list, and its list_op_pending points
>       to the same offset within the backing store mapping, clear the
>       list_op_pending pointer.
>
> The overhead would be added specifically to pthread_mutex_destroy(3),
> and only for robust mutexes.

Would we have to do this for pthread_mutex_destroy only, or also for
pthread_join?  It is defined to exit a thread with mutexes still locked,
and the pthread_join call could mean that the application can determine
by its own logic that the backing store can be deallocated.

Thanks,
Florian


