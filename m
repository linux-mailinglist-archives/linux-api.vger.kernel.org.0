Return-Path: <linux-api+bounces-43-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371827EB518
	for <lists+linux-api@lfdr.de>; Tue, 14 Nov 2023 17:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231B2B20AC3
	for <lists+linux-api@lfdr.de>; Tue, 14 Nov 2023 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3F3D3B4;
	Tue, 14 Nov 2023 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUSy74X+"
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349313FB1C
	for <linux-api@vger.kernel.org>; Tue, 14 Nov 2023 16:43:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A3411B
	for <linux-api@vger.kernel.org>; Tue, 14 Nov 2023 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699980209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7cok8Q3IObYPFL+9sXuypqM5Ca4C9SOJD0kAH42Df6o=;
	b=hUSy74X+ZBHcNNx5cFi5fLs3RNkw708oTPxD/bE+0CbT3rpB+C0Tkvw3XdQPeTdG1jB6c5
	nWe5ypWwfccW1JkzMLyQXAgGQdZn29KkW9XOQqB1RgJqTr/GTOMpqX0UVBCvUMk4qTmA0J
	tAEoJxp/WfkH7mR//xseoI8P/8mcMqE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-KeUFTFdVMxGEvUF3WrroaQ-1; Tue,
 14 Nov 2023 11:43:25 -0500
X-MC-Unique: KeUFTFdVMxGEvUF3WrroaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 508C63827962;
	Tue, 14 Nov 2023 16:43:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 248331121307;
	Tue, 14 Nov 2023 16:43:21 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xi Ruoyao <xry111@xry111.site>,  libc-alpha@sourceware.org,
  linux-kernel@vger.kernel.org,  linux-api@vger.kernel.org,
  linux-mm@kvack.org,  linux-arch@vger.kernel.org,  Thomas Gleixner
 <tglx@linutronix.de>,  =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
	<d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
	<20231114153100.GY8262@noisy.programming.kicks-ass.net>
	<20231114154017.GI4779@noisy.programming.kicks-ass.net>
Date: Tue, 14 Nov 2023 17:43:20 +0100
In-Reply-To: <20231114154017.GI4779@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Tue, 14 Nov 2023 16:40:17 +0100")
Message-ID: <87ttpowajb.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

* Peter Zijlstra:

>> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
>> index b5379c0e6d6d..1a1f9301251f 100644
>> --- a/kernel/futex/futex.h
>> +++ b/kernel/futex/futex.h
>> @@ -17,7 +17,7 @@
>>   * restarts.
>>   */
>>  #ifdef CONFIG_MMU
>> -# define FLAGS_SHARED		0x01
>> +# define FLAGS_SHARED		0x10
>>  #else
>>  /*
>>   * NOMMU does not have per process address space. Let the compiler optimize
>
> Just the above seems sufficient.

There are a few futex_wake calls which hard-code the flags argument as
1:

kernel/futex/core.c=637=static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr,
--
kernel/futex/core.c-686-         * this.
kernel/futex/core.c-687-         */
kernel/futex/core.c-688-        owner = uval & FUTEX_TID_MASK;
kernel/futex/core.c-689-
kernel/futex/core.c-690-        if (pending_op && !pi && !owner) {
kernel/futex/core.c:691:                futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
kernel/futex/core.c-692-                return 0;
kernel/futex/core.c-693-        }
kernel/futex/core.c-694-
kernel/futex/core.c-695-        if (owner != task_pid_vnr(curr))
kernel/futex/core.c-696-                return 0;
--
kernel/futex/core.c-739-        /*
kernel/futex/core.c-740-         * Wake robust non-PI futexes here. The wakeup of
kernel/futex/core.c-741-         * PI futexes happens in exit_pi_state():
kernel/futex/core.c-742-         */
kernel/futex/core.c-743-        if (!pi && (uval & FUTEX_WAITERS))
kernel/futex/core.c:744:                futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
kernel/futex/core.c-745-
kernel/futex/core.c-746-        return 0;
kernel/futex/core.c-747-}
kernel/futex/core.c-748-
kernel/futex/core.c-749-/*


Thanks,
Florian


