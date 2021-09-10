Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24FA406FC4
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbhIJQjJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 12:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhIJQjH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 12:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631291876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CAdzkTXaTtsnhj1wGgFOSI+YlIYEhF5ZYiGUnrefr0=;
        b=iAUGymsqA/V/lfUxtbcRX8sHOPAT+05sykdi8oBs0bPfYkvZt2Z4qhDQ1eGuyV8vF+aKZG
        29CehX+vekoL1sbaxjtfClc80dMDMnu8bcKF5xj2OdcuWEM3QkAHLg8xykJRbyytk3yiM8
        8Es1j4fNlwSCvCBjh+l8KL4Seja3Ago=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-wpfwJVvDPaaA7XFsknzfvg-1; Fri, 10 Sep 2021 12:37:55 -0400
X-MC-Unique: wpfwJVvDPaaA7XFsknzfvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 867781B18BC0;
        Fri, 10 Sep 2021 16:37:53 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.195.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC61919C79;
        Fri, 10 Sep 2021 16:37:50 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: [RESEND RFC PATCH 0/3] Provide fast access to thread
 specific data
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
        <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
        <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
Date:   Fri, 10 Sep 2021 18:37:49 +0200
In-Reply-To: <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
        (Peter Oskolkov's message of "Fri, 10 Sep 2021 08:18:10 -0700")
Message-ID: <8735qcgzdu.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Peter Oskolkov:

> In short, due to the need to read/write to the userspace from
> non-sleepable contexts in the kernel it seems that we need to have some
> form of per task/thread kernel/userspace shared memory that is pinned,
> similar to what your sys_task_getshared does.

In glibc, we'd also like to have this for PID and TID.  Eventually,
rt_sigprocmask without kernel roundtrip in most cases would be very nice
as well.  For performance and simplicity in userspace, it would be best
if the memory region could be at the same offset from the TCB for all
threads.

For KTLS, the idea was that the auxiliary vector would contain size and
alignment of the KTLS.  Userspace would reserve that memory, register it
with the kernel like rseq (or the robust list pointers), and pass its
address to the vDSO functions that need them.  The last part ensures
that the vDSO functions do not need non-global data to determine the
offset from the TCB.  Registration is still needed for the caches.

I think previous discussions (in the KTLS and rseq context) did not have
the pinning constraint.

Thanks,
Florian

