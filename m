Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032BE40CD07
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhIOTNz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 15:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhIOTNz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 15:13:55 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3DFC061574;
        Wed, 15 Sep 2021 12:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FhF5ZEUfgtRm0W8Km2DWenQUkdHHR5Cd4JcveZESDfQ=; b=VHRzgjaQjFEk4mLIFinoi1c2Sk
        GmyHxKZnMqs6KiQsGqEHuig15rcLVGccWq4rMoxdzfv7CInmVLrKhxIjxONTQfD8Ms9uGxK2iJa9q
        i4chkJ9DbDCZ84rNuXjUoKAFfRt7jKmfLj4j1O/DYumJ95cAfk7d5qTQH3eWugN4/JJasXjUBGIPO
        3gs3/n2LCoe2qvDlpTYNrK2/ZnEpF7cT4bFfTptjw5CtS7EFNx6RKk5xyyaYq6Lu/cN/Or1wbPdF7
        Xiw7n917xLS293xtCWDVK8djzZwuLEysQti/wEj42oH3qoaAgPoZPbBQgc72Ez97tVkMIHWh3TrtJ
        n+I2kzZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQaIa-003STh-1v; Wed, 15 Sep 2021 19:11:01 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3B419811C0; Wed, 15 Sep 2021 21:10:23 +0200 (CEST)
Date:   Wed, 15 Sep 2021 21:10:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Peter Oskolkov <posk@google.com>,
        Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
Message-ID: <20210915191023.GF4323@worktop.programming.kicks-ass.net>
References: <20210908184905.163787-1-posk@google.com>
 <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
 <d656e605-4f89-4ea2-8baf-f7786f0630d9@www.fastmail.com>
 <YUDlzxLjNsW+oYGC@hirez.programming.kicks-ass.net>
 <f6fdecfe-963d-4669-ae05-1d7192467a19@www.fastmail.com>
 <YUIUWs9pIfHh51lP@hirez.programming.kicks-ass.net>
 <CALCETrUnnHN0dyx02ewuRu=_TZ+cD=HaEzNs34ADNbWps1tTBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUnnHN0dyx02ewuRu=_TZ+cD=HaEzNs34ADNbWps1tTBw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 09:50:41AM -0700, Andy Lutomirski wrote:
> What's the precise problem?  The code would be roughly:
> 
> if (try_pin_the_page) {
>   write it;
>   unpin;
> } else {
>   do nothing -- .fault will fill in the correct contents.
> }
> 
> The time this takes is nondeterministic, but it's bounded and short.

You can't do this from sched_submit_work(), you might already hold
mmap_sem. Hence the suggestion to, for UMCG registered threads, pin the
page(s) on syscall-enter and unpin on either schedule() or
syscall-return.

