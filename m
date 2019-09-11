Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BCFB04B5
	for <lists+linux-api@lfdr.de>; Wed, 11 Sep 2019 21:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfIKT6R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Sep 2019 15:58:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbfIKT6Q (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Sep 2019 15:58:16 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 826FD307D8E3;
        Wed, 11 Sep 2019 19:58:16 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-150.ams2.redhat.com [10.36.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 250266012A;
        Wed, 11 Sep 2019 19:58:09 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v12)
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
        <20190807142726.2579-2-mathieu.desnoyers@efficios.com>
        <8736h2sn8y.fsf@oldenburg2.str.redhat.com>
        <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
        <87ef0mr6qj.fsf@oldenburg2.str.redhat.com>
        <4a6f6326-ea82-e031-0fe0-7263ed97e797@redhat.com>
        <877e6er4ls.fsf@oldenburg2.str.redhat.com>
Date:   Wed, 11 Sep 2019 21:58:08 +0200
In-Reply-To: <877e6er4ls.fsf@oldenburg2.str.redhat.com> (Florian Weimer's
        message of "Wed, 11 Sep 2019 21:54:23 +0200")
Message-ID: <8736h2r4fj.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 11 Sep 2019 19:58:16 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Florian Weimer:

> * Carlos O'Donell:
>
>> On 9/11/19 3:08 PM, Florian Weimer wrote:
>>> * Carlos O'Donell:
>>> 
>>>> It would be easier to merge the patch set if it were just an unconditional
>>>> registration like we do for set_robust_list().
>>> 
>>> Note that this depends on the in-tree system call numbers list, which I
>>> still need to finish according to Joseph's specifications.
>>
>> Which work is this? Do you have a URL reference to WIP?
>
>   <https://sourceware.org/ml/libc-alpha/2019-05/msg00630.html>
>   <https://sourceware.org/ml/libc-alpha/2019-06/msg00015.html>

Sorry, there was also this:

  <https://sourceware.org/ml/libc-alpha/2019-05/msg00629.html>

I also posted a build-many-glibcs.py patch at some point with an
automatic table update, but that still had the massive bot-cycle time.

My current line of thinking is to implement some --use-compilers flag,
so that you can build a fresh glibc checkout against an old, pre-built
compilers for the system call tables update, and then use the patched
glibc sources for one (and hopefully final) bot-cycle.

Thanks,
Florian
