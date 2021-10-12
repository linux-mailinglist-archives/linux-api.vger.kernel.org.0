Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0FC42ACA3
	for <lists+linux-api@lfdr.de>; Tue, 12 Oct 2021 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhJLS4i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Oct 2021 14:56:38 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:14761 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhJLS4c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Oct 2021 14:56:32 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 14:56:30 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1634064870; x=1665600870;
  h=subject:to:cc:references:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=fr0h/E/BFvN1dJoZmJSjdbZ+4m+4eoZS+8tjp01uHac=;
  b=XrHTeY0vtDqQr1hSqPRFoDjiiBtz3P50oCb2qU4SuyfDAlFq7r8JWCCv
   cVD+2w6nAe/H9Liv52JzOx9xTUT1dVHnJymdRe7F5rThBqTB2/N5UX62d
   acuBoT/sQCzFyGsIGx0d8udqdMqc47OLRnEMGd0qsLRg7SRHeZxJMawpD
   A=;
IronPort-Data: A9a23:QlHVpqI/mZn2o/9UFE+RNZQlxSXFcZb7ZxGr2PjKsXjdYENS3z0Pz
 DAaWDrXaK3eMGPyett0a46+8R4AuJ/XmtBrTAcd+CA2RRqmiyZk6fd1jKvUF3nPRiEWZBs/t
 63yTPGedJhsJpP7jkjxaeeJQUGRUchkf5KkYAL+EnkZqTRMFWFx1HqPp8Zj2tQx2IDgWVvX0
 T/Pi5S31GGNim8c3l08tvrrRCNH5JwebxtB4zTSzdgS1LPvvyF94KA3fMldHFOkKmVgJdNWc
 s6YpF2PEsE1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXee0v0XRYRQR4/ttmHozx+4
 O9NjrbgeyYbB5fNgOEneiV0HA5XBLITrdcrIVDn2SCS50bBdX3sxq0ySkoxO4sV8foxHH5H6
 fECLDcKKBuK7w606OvhG6892YJ5dJmtYNh3VnJIlFk1Cd46TZ3HQr7O6PdFwz4si9pKGvGYb
 MNxhT9HNUWRPEcQYAh/5JQWmbmyvkjZKDJh73GF/YkSwTDazg5az+24WDbSUpnQLSlPpW6ar
 2TA/0z2BRYVMNHZwj2AmlqlmObAnCXTV4UVG7m1sPVthTW73msICzUZUly0pfT/gUm7M/pVM
 EEb8y4qhac180OvQ5/2WBjQiGaGojYTXN1fF+B84waIooLQ4gCEFi0NVj9pdtMrrok1SCYs2
 1vPmMnmbRRrsbuIWTee+62SoDeaJycYNykBaDUCQA9D5MPsyKkvgRbfZtJiFrOplNrzGCG2z
 z3ihC0/gboUpdQG26Wy4RbMhDfEjoDEUgMv9C3WWGy/5w90bYLjYJangXDD6u1DBJ6eVVrHv
 X9spiSFxOsJC5eAnzDLXfoEALyz4/GCdjbV6bJyI6QcG/2W0ybLVehtDPtWfy+F7u5slefVX
 XLu
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2021 14:46:51 -0400
Received: from [10.42.0.123] (10.32.190.116) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 12
 Oct 2021 14:46:50 -0400
Subject: Re: [PATCH 5/5 v0.6] sched/umcg: add
 Documentation/userspace-api/umcg.txt
To:     Peter Oskolkov <posk@posk.io>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
References: <20210917180323.278250-1-posk@google.com>
 <20210917180323.278250-6-posk@google.com>
 <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca>
 <CAFTs51W6ZHrGaoXEbXNCkVKLxe7_S2raYcXMBzypC7VUDMrU-w@mail.gmail.com>
 <e162fdea-5323-89d2-49d0-3fe56ba2ec3a@uwaterloo.ca>
 <CAFTs51X0kQLngHYXD-BxBmm6oRyMk1vy9nzaPu4V46PifO99LQ@mail.gmail.com>
In-Reply-To: <CAFTs51X0kQLngHYXD-BxBmm6oRyMk1vy9nzaPu4V46PifO99LQ@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <40c37212-ab15-01ac-f5c5-e3f53c9b8e4e@uwaterloo.ca>
Date:   Tue, 12 Oct 2021 14:46:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.190.116]
X-ClientProxiedBy: connhm02.connect.uwaterloo.ca (172.16.137.66) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 >> Just to be clear, sys_umcg_wait supports an operation that, when called
 >> from a worker, puts the worker to sleep without triggering block 
detection
 >> or context-switching back to the server?
 >
 > Potentially, yes - when a worker wants to yield (e.g. as part of a
 > custom UMCG-aware mutex/condvar code), and calls into the userspace
 > scheduler, it may be faster to skip the server wakeup (e.g. reassign
 > the server to another sleeping worker and wake this worker). This is
 > not a supported operation right now, but I see how it could be used to
 > optimize some things in the future.
 >
 > Do you have any concerns here?

To be honest, I did not realize this was a possibility until your previous
email. I'm not sure I buy your example, it just sounds like worker to worker
context-switching, but I could imagine "stop the world" cases or some "race
to idle" policy using this feature.

It seems to me the corresponding wake needs to know if it needs to enqueue
the worker into the idle workers list or if it should just schedule the 
worker
as it would a server.

How does the wake know which to do?



 > I don't see a big difference here, sorry. We are  mixing levels of
 > abstraction here again, I think. For example, the higher level
 > userspace scheduling code will have more nuanced treatment of IDLE
 > workers; but down at the kernel they are all the same: IDLE worker is
 > a worker that the userspace can "schedule" by marking it RUNNING,
 > regardless of whether the worker is "parked", or "woke from a blocking
 > op", or whatever other semantically different state the worker can be.
 > For the kernel, they are all the same, idle, not runnable, waiting for
 > the userspace to explicitly "schedule" them.
 >
 > Similarly, I don't see a need to semantically distinguish "yield" from
 > "park" at the kernel level of things; this distinction seems to be a
 > higher-level abstraction that can be properly expressed in the
 > userspace, and does not need to be explicitly addressed in the kernel
 > (to make the code faster and simpler, for example).

 From the kernel's perspective, I can see two distinct operation:

1 - Mark the worker as IDLE and put it to sleep.
2 - Mark the worker as IDLE, put it to sleep *and* immediately add it
     to the idle workers list.

The wait in operation 1 expects an outside wakeup call to match it and 
resume
the worker, while operation 2 is its own wakeup. To me that is the 
distinction
between wait/park and yield, respectively.

Is Operation 2 supported?

I'm not sure this distinction can be handled in userspace in all cases. 
Waking
oneself is generally not a possibility.
