Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D285B04B0
	for <lists+linux-api@lfdr.de>; Wed, 11 Sep 2019 21:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfIKTyc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 11 Sep 2019 15:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbfIKTyc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Sep 2019 15:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EEA3D3018FC5;
        Wed, 11 Sep 2019 19:54:31 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-117-150.ams2.redhat.com [10.36.117.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C2B7B5D9E2;
        Wed, 11 Sep 2019 19:54:25 +0000 (UTC)
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
Date:   Wed, 11 Sep 2019 21:54:23 +0200
In-Reply-To: <4a6f6326-ea82-e031-0fe0-7263ed97e797@redhat.com> (Carlos
        O'Donell's message of "Wed, 11 Sep 2019 15:45:14 -0400")
Message-ID: <877e6er4ls.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 11 Sep 2019 19:54:32 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Carlos O'Donell:

> On 9/11/19 3:08 PM, Florian Weimer wrote:
>> * Carlos O'Donell:
>> 
>>> It would be easier to merge the patch set if it were just an unconditional
>>> registration like we do for set_robust_list().
>> 
>> Note that this depends on the in-tree system call numbers list, which I
>> still need to finish according to Joseph's specifications.
>
> Which work is this? Do you have a URL reference to WIP?

  <https://sourceware.org/ml/libc-alpha/2019-05/msg00630.html>
  <https://sourceware.org/ml/libc-alpha/2019-06/msg00015.html>

I think realistically this is needed for the Y2038 work as well if we
want to support building glibc with older kernel headers.  “glibc 2.31
will have Y2038 support and rseq support, but only if it runs on a
current and it happens to have been built against sufficiently recent
kernel headers” is a bit difficult to explain.  The current kernel part
is easy enough to understand, but the impact of the kernel headers on
the feature set has always been tough to explain.  Especially if you
factor in vendor kernels with system call backports.

Thanks,
Florian
