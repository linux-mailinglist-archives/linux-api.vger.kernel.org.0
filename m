Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7D838CE0B
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 21:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhEUTTT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 15:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbhEUTTT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 15:19:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8357C061574;
        Fri, 21 May 2021 12:17:55 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d:444a:d152:279d:1dbb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 77D8A2F3;
        Fri, 21 May 2021 19:17:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77D8A2F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1621624675; bh=Xm2ZcunaeMCF59JtFhGKPUZwAFVrpYPgk1Cgjmzkh1I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZGM71Y0RHRY3Aa13dkY1orOEI6svm5gyj0gNAeBF5zJaeQjaHREOoHM8uWL9AozyT
         tcsef9Ma5zjbbYrpNKwkNv7ykW2H2wWM6V6s/Jlb4A1IipfLVZRiuy/HCZFe/MBz3R
         LjAX8N7uf6FXP1goGPBZDBVCMySM497mrLdpM/6DNHhdxIyuAzhMGAAFIJq0AuOgY7
         e9Ev1Mcmo9W4eBoENrq/Od2LF+NqaRqEKIl6rVAtZf4unZX5oNr58HwOBSW7KoxDlz
         mxF/pLWMXrCTg8pqnZQTSj670XhL2Nxe5cIXMbr7YqiYls/iqvQpn1hEC6S+Ib2B01
         U8tQext7fuj0g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
In-Reply-To: <CAPNVh5fhkgscs44Lpj3DPBrA9NrhFohUpRwpT2iMM1BDBcLW4A@mail.gmail.com>
References: <20210520183614.1227046-1-posk@google.com>
 <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
 <87eee0m8ez.fsf@meer.lwn.net>
 <CAPNVh5fhkgscs44Lpj3DPBrA9NrhFohUpRwpT2iMM1BDBcLW4A@mail.gmail.com>
Date:   Fri, 21 May 2021 13:17:55 -0600
Message-ID: <87wnrrlwv0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Oskolkov <posk@google.com> writes:

> On Fri, May 21, 2021 at 8:08 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> [...]
>> Documentation patches can help to guide that discussion; they also need
>> to be reviewed as well.  So yes, I think they should be present from the
>> beginning.  But then, that's the position I'm supposed to take :)  This
>> is a big change to the kernel's system-call API, I don't think that
>> there can be a proper discussion of that without a description of what
>> you're trying to do.
>
> Hi Jon,
>
> There are doc comments in patches 2 and 7 in umcg.c documenting the
> new syscalls. That said, I'll prepare a separate doc patch - I guess
> I'll add Documentation/scheduler/umcg.rst, unless you tell me there is
> a better place to do that. ETA mid-to-late next week.

Yes, I saw those; they are a bit terse at best.  What are the "worker
states"?  What's a "UMCG group"?  Yes, all this can be worked out by
pounding one's head against the code for long enough, but you're asking
a fair amount of your reviewers.

A good overall description would be nice, perhaps for the userspace-api
book.  But *somebody* is also going to have to write real man pages for
all these system calls; if you provided those, the result should be a
good description of how you expect this subsystem to work.

Thanks,

jon
