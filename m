Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC33932DD
	for <lists+linux-api@lfdr.de>; Thu, 27 May 2021 17:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhE0Pwx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 May 2021 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhE0Pwv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 May 2021 11:52:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E95C061574
        for <linux-api@vger.kernel.org>; Thu, 27 May 2021 08:51:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B95322B7;
        Thu, 27 May 2021 15:41:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B95322B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1622130092; bh=FMSKn4e0PiNZmGAn49x7L99C4DLbqARxZqL3Z9qcmcg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jx+OhiAVhkww8yizLhUkbhoge+62/ESNfylfnXqTvZLoxAFcssCQAoFLAf3s2Ydes
         GX/S4ceeQstUhJlcuUFWirrW2n6fIEnJ+K40es4m18j0jzufcSHSiz6bouLCMyw6Oy
         970nmPiSP3y/vnOVRXkxVtm2kh5RfieCiqfK03/MS6dqitQSYdfQU5YAJfpWW3IqRK
         +srS/lU+2BkRTcJCXaS/XjQrVj9NlMVQCTyRfIC3KLI3/IOJw1nMxuwmf/eQ4uqUDQ
         U1tOdABTVtEl9IgiymokjGTqLDn1lOSj2jRuDnaPetBqUtTOhP0vWlXb/jM6VFdf56
         ceqOSGeJ/8tXw==
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
In-Reply-To: <CAPNVh5feas6o_8pk5-kiujTDJf6XT4uxapxC4eZokaj+iv=rqQ@mail.gmail.com>
References: <20210520183614.1227046-1-posk@google.com>
 <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com>
 <87eee0m8ez.fsf@meer.lwn.net>
 <CAPNVh5fhkgscs44Lpj3DPBrA9NrhFohUpRwpT2iMM1BDBcLW4A@mail.gmail.com>
 <87wnrrlwv0.fsf@meer.lwn.net>
 <CAPNVh5feas6o_8pk5-kiujTDJf6XT4uxapxC4eZokaj+iv=rqQ@mail.gmail.com>
Date:   Thu, 27 May 2021 09:41:32 -0600
Message-ID: <87h7io421f.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Oskolkov <posk@google.com> writes:

> I've pasted below the content of umcg.rst file that I'll add as a doc
> patch to the next version of the patchset. I've also attached a PDF
> version of the file rendered, in case it is useful. I also think that
> it is a bit early for manpages - I expect the API and/or behavior to
> change quite a bit before this is all merged. I'm also not completely
> sure whether the manpages should describe the "porcelain API" or the
> "plumbing API" (see the .rst below).
>
> Please let me know if you have any questions, comments, or suggestions.

So this is very helpful, thanks.  I've been through it once, and have
some overall comments.

 - Parts of it read more like a requirements document.  A document going
   into the kernel should describe what the code actually does, not what
   we think it should be.

 - I would make a serious effort to get a handle on the terminology.
   The term "kernel thread" has a meaning other than the one you give
   it; saying "kernel thread" here will lead to a lot of confusion.  I
   hesitate to suggest terms because I'm terrible at naming (just ask my
   kids), but I would pick clear and concise names for your "server
   threads" and "worker threads", then stick to them.

 - The library documentation is good to have, but it will really be
   necessary to document the system calls as well.  *That* is the part
   that the kernel community will have to support forever if this is
   merged.

Thanks,

jon
