Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D24407093
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhIJRef (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 13:34:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:57684 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhIJRee (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 13:34:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4B76F380B91;
        Fri, 10 Sep 2021 13:33:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U-n7XFefRKdb; Fri, 10 Sep 2021 13:33:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D45CB380B90;
        Fri, 10 Sep 2021 13:33:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D45CB380B90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1631295199;
        bh=fyBfAPWK72tcGWzAw1LjOaKjhaPvI3SvgBP8CFWtZkA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ESuIYvVl7StxMYZ03ixttEVHeTUpTTtOM49yHd55P26zzEiQ03OYppALGQDZijl8W
         HK10x7PJBmxOHl3aNiUmZ7d9+kstS/z9ko89vJkuXqI3JvLmBAym0w6U5DEllaBtWW
         Z5YKlpZU8rlP3JCR8rP1/dWW5yfqzYRQyUMVK6rNRu0G96bRO7+2Tjy5P07KF6PoxX
         Wq3Z+LFvGcEFgfc0xUROcUouyG3iZIdMJaHJlWKORYrcZOGEbaTd9mqy4pMsSh/bHU
         wCZ45iu+rWGBztrVY5OK6yzZmvZpVwV8pXVTQ2ezd2y+GtiYWWjebo8dIGCv71ml/Q
         Q3BrV2mXCcPWg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eslYRUy70XKU; Fri, 10 Sep 2021 13:33:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C336B3807C6;
        Fri, 10 Sep 2021 13:33:19 -0400 (EDT)
Date:   Fri, 10 Sep 2021 13:33:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Oskolkov <posk@google.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1297400717.15316.1631295199656.JavaMail.zimbra@efficios.com>
In-Reply-To: <8735qcgzdu.fsf@oldenburg.str.redhat.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com> <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com> <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com> <8735qcgzdu.fsf@oldenburg.str.redhat.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF91 (Linux)/8.8.15_GA_4059)
Thread-Topic: Provide fast access to thread specific data
Thread-Index: 6E5ZkJnM0M7ffcKiAOClEV+FqAn9Iw==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Sep 10, 2021, at 12:37 PM, Florian Weimer fweimer@redhat.com wrote:

> * Peter Oskolkov:
> 
>> In short, due to the need to read/write to the userspace from
>> non-sleepable contexts in the kernel it seems that we need to have some
>> form of per task/thread kernel/userspace shared memory that is pinned,
>> similar to what your sys_task_getshared does.
> 
> In glibc, we'd also like to have this for PID and TID.  Eventually,
> rt_sigprocmask without kernel roundtrip in most cases would be very nice
> as well.  For performance and simplicity in userspace, it would be best
> if the memory region could be at the same offset from the TCB for all
> threads.
> 
> For KTLS, the idea was that the auxiliary vector would contain size and
> alignment of the KTLS.  Userspace would reserve that memory, register it
> with the kernel like rseq (or the robust list pointers), and pass its
> address to the vDSO functions that need them.  The last part ensures
> that the vDSO functions do not need non-global data to determine the
> offset from the TCB.  Registration is still needed for the caches.
> 
> I think previous discussions (in the KTLS and rseq context) did not have
> the pinning constraint.

If this data is per-thread, and read from user-space, why is it relevant
to update this data from non-sleepable kernel context rather than update it as
needed on return-to-userspace ? When returning to userspace, sleeping due to a
page fault is entirely acceptable. This is what we currently do for rseq.

In short, the data could be accessible from the task struct. Flags in the
task struct can let return-to-userspace know that it has outdated ktls
data. So before returning to userspace, the kernel can copy the relevant data
from the task struct to the shared memory area, without requiring any pinning.

What am I missing ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
