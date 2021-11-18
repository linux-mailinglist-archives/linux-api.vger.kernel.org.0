Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761CF4562FD
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 19:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhKRS6y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 13:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231912AbhKRS6y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 13:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637261753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9HVY4B10w2YUIuNR2KoKxqB+ZMgawiLLF8SLbZ8UG7M=;
        b=fCAJi6uOpqURJ2M+pp6zt1J0LesRwT0iJ1WqQInvg7MSdpfGfoh59XgWP6yBeJX57OayoZ
        mox9BYJBnPTs0pVR8p0yTyYs/qObGe5eejXTsmlQi+a8s1hVRlZieghFYPbOtwqu7wdEZ4
        CJuwlFBmyVsSaBaY1WltvKVxP2uL8YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-vnwhZPSfOWmLAgD0iuciRw-1; Thu, 18 Nov 2021 13:55:49 -0500
X-MC-Unique: vnwhZPSfOWmLAgD0iuciRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FB6010055AB;
        Thu, 18 Nov 2021 18:55:48 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D19F26DEE;
        Thu, 18 Nov 2021 18:55:45 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Rich Felker <dalias@libc.org>
Subject: Re: Bringing rseq back into glibc
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
        <CAFUsyfKGOCk9vhWTsfP2tH1-P=iYe41vCxbUdfx-b3Oa9ma7iw@mail.gmail.com>
Date:   Thu, 18 Nov 2021 19:55:44 +0100
In-Reply-To: <CAFUsyfKGOCk9vhWTsfP2tH1-P=iYe41vCxbUdfx-b3Oa9ma7iw@mail.gmail.com>
        (Noah Goldstein's message of "Thu, 18 Nov 2021 12:42:53 -0600")
Message-ID: <87mtm1e1jj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Noah Goldstein:

> On Thu, Nov 18, 2021 at 4:17 AM Florian Weimer via Libc-alpha
> <libc-alpha@sourceware.org> wrote:
>>
>> I would like to bring back rseq for glibc 2.35.  I propose the following
>> steps:
>>
>> 1. Enable rseq registration in glibc, for internal use only.  This time,
>>    put the rseq area into struct pthread, not into a initial-exec TLS
>>    symbol.  (This helps to avoid with initial-exec TLS bloat with dlopen
>>    and simplifies initialization somewhat.)
>
> Isn't THREAD_SELF also implemented in TLS? Or am I missing
> something?

THREAD_SELF uses a pointer in the thread control block, and that pointer
is not replicated for different libc.so.6 copies with dlmopen (like the
rest of the TCB and struct pthread).

Thanks,
Florian

