Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE8A207C0D
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 21:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404900AbgFXTMF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 15:12:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56517 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404744AbgFXTMF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 15:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593025924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RmSMwzny06NsdSKMt6qmuqIVCIN71KDJe+6Vq4O89KQ=;
        b=SsL53J3EPkGud5uFpIey1Sp6Pau/62/f/Bk+zeVi/tV+3pYLvK1v55zJ46L6kDRGH3khm+
        a/0OBN08OUVt9nzAq5UsWITuoYr2uJRW1y0Zbe9kMjbvBRPFuTfNQNQ+l9Ns5IEJ42mHkx
        kmk0h0ki7lakODucLygYcgWGZlIbjqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-5OaKHX9gPHGWHiBQm6g_uA-1; Wed, 24 Jun 2020 15:12:02 -0400
X-MC-Unique: 5OaKHX9gPHGWHiBQm6g_uA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4540804001;
        Wed, 24 Jun 2020 19:11:59 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-18.ams2.redhat.com [10.36.113.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F1B1008034;
        Wed, 24 Jun 2020 19:11:52 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and thread creation (v21)
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
        <20200622180803.1449-2-mathieu.desnoyers@efficios.com>
        <87d05obl4w.fsf@oldenburg2.str.redhat.com>
        <1158112159.11628.1593025203438.JavaMail.zimbra@efficios.com>
Date:   Wed, 24 Jun 2020 21:11:50 +0200
In-Reply-To: <1158112159.11628.1593025203438.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 24 Jun 2020 15:00:03 -0400
        (EDT)")
Message-ID: <87r1u48eix.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> I'm still worried that __rseq_static_assert and __rseq_alignof will show
>> up in the UAPI with textually different definitions.  (This does not
>> apply to __rseq_tls_model_ie.)
>
> What makes this worry not apply to __rseq_tls_model_ie ?

It's not needed by the kernel header because it doesn't contain a
__rseq_abi declaration.

>> 
>> Is my worry unfounded?
>
> So AFAIU you worry that eventually sys/rseq.h and linux/rseq.h carry different
> definitions of __rseq_static_assert and __rseq_alignof.
>
> Indeed, I did not surround those #define with #ifndef/#endif. Maybe we should ?
>
> Just in case the definitions end up being different (worse case scenario), we
> should expect their behavior to be pretty much equivalent. So going for the
> following should address your concern I think:

I think we should keep things simple on the glibc side for now and do
this changes to the kernel headers first.

Thanks,
Florian

