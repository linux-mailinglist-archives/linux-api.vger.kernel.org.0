Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0829F019
	for <lists+linux-api@lfdr.de>; Thu, 29 Oct 2020 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgJ2PhC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 29 Oct 2020 11:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728238AbgJ2PgE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Oct 2020 11:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603985763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RfT7TevZRXoXBrEtY9OkWsu/sfZhCB94tCFpayBZytE=;
        b=AsWIqICS1mUOp6kaP4TlXS6RdMSIx3eAmioV/4o1Y+nYjodi6J1S5fnYpbOFeX6pvs8UYG
        WR3R/my/SZoD5+O800h6fM6X/ZOl+VaP2ZP0uEl4g7pKait59i42giel2okHnQN9N2RDh/
        y2hCqPkPRbT9GoORN/73E2PbhSdnmDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-oFRVhYZsPYiI0Joqa_I-WQ-1; Thu, 29 Oct 2020 11:35:59 -0400
X-MC-Unique: oFRVhYZsPYiI0Joqa_I-WQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39098760C6;
        Thu, 29 Oct 2020 15:35:57 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C2ED60F96;
        Thu, 29 Oct 2020 15:35:51 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com>
        <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
        <905713397.71512.1601314192367.JavaMail.zimbra@efficios.com>
        <873631yp8t.fsf@oldenburg2.str.redhat.com>
        <1247061646.32339.1603219677094.JavaMail.zimbra@efficios.com>
Date:   Thu, 29 Oct 2020 16:35:49 +0100
In-Reply-To: <1247061646.32339.1603219677094.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 20 Oct 2020 14:47:57 -0400
        (EDT)")
Message-ID: <87a6w5rqne.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Sep 29, 2020, at 4:13 AM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>>> So we have a bootstrap issue here that needs to be solved, I think.
>>>
>>> The one thing I'm not sure about is whether the vDSO interface is indeed
>>> superior to KTLS, or if it is just the model we are used to.
>>>
>>> AFAIU, the current use-cases for vDSO is that an application calls into
>>> glibc, which then calls the vDSO function exposed by the kernel. I wonder
>>> whether the vDSO indirection is really needed if we typically have a glibc
>>> function used as indirection ? For an end user, what is the benefit of vDSO
>>> over accessing KTLS data directly from glibc ?
>> 
>> I think the kernel can only reasonably maintain a single userspace data
>> structure.  It's not reasonable to update several versions of the data
>> structure in parallel.
>
> I disagree with your statement. Considering that the kernel needs to
> keep ABI compatibility for whatever it exposes to user-space, claiming
> that it should never update several versions of data structures
> exposed to user-space in parallel means that once a data structure is
> exposed to user-space as ABI in a certain way, it can never ever
> change in the future, even if we find a better way to do things.

I think it's possible to put data into userspace without making it ABI.
Think about the init_module system call.  The module blob comes from
userspace, but its (deeper) internal structure does not have a stable
ABI.  Similar for many BPF use cases.

If the internal KTLS blob structure turns into ABI, including the parts
that need to be updated on context switch, each versioning change has a
performance impact.

>> This means that glibc would have to support multiple kernel data
>> structures, and users might lose userspace acceleration after a kernel
>> update, until they update glibc as well.  The glibc update should be
>> ABI-compatible, but someone would still have to backport it, apply it to
>> container images, etc.
>
> No. If the kernel ever exposes a data structure to user-space as ABI,
> then it needs to stay there, and not break userspace. Hence the need to
> duplicate information provided to user-space if need be, so we can move
> on to better ABIs without breaking the old ones.

It can expose the data as an opaque blob.

> Or as Andy mentioned, we would simply pass the ktls offset as argument to
> the vDSO ? It seems simple enough. Would it fit all our use-cases including
> errno ?

That would work, yes.  It's neat, but it won't give you a way to provide
traditional syscall wrappers directly from the vDSO.

>> We'll see what will break once we have the correct TID after vfork. 8->
>> glibc currently supports malloc-after-vfork as an extension, and
>> a lot of software depends on it (OpenJDK, for example).
>
> I am not sure to see how that is related to ktls ?

The mutex implementation could switch to the KTLS TID because it always
correct.  But then locking in a vfork'ed subprocess would no longer look
like locking from the parent thread because the TID would be different.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

