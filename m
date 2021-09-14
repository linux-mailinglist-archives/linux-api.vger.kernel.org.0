Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D395740B691
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhINSOv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhINSOv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 14:14:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF19C061574;
        Tue, 14 Sep 2021 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=KD4Vc3vVXYvxW9rLdfJ2x8SJCDKSSlc572HoaFCtWLk=; b=qrX2GCVbRq7ZToTRh+/20Ru05J
        q/l2WtO5JPMI7uBwoMt6htPafTOFzO/jBypogN7qINpet0B1NzT4i+yZqC2/k2PRkT2C0bhq6yFhy
        D7QN+A7TcxAxmWc/6elEV4kVKCnHNsMqI+bTS5IdlIUHeZstwEWA7Tg1oUvPNBdniqf6AKIbnJw3z
        +71+RYhYPoUtxfuzD8jsgQ/BXYOwwL5S6mBapQQudVV5A7184UrZOR9tyg8OAe0TkCmsmKCQOZJHX
        hsvAqKotEspjmhhnL321T3xkrrIeasruzrIu6cY+WQEtwUgY+nj+Ubv0I9sMnlsrTO/x0KY/xYBOy
        eypov2nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQCu0-00EwTG-Gg; Tue, 14 Sep 2021 18:11:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49AFC3001C7;
        Tue, 14 Sep 2021 20:11:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27FDB2D378DBA; Tue, 14 Sep 2021 20:11:27 +0200 (CEST)
Date:   Tue, 14 Sep 2021 20:11:27 +0200
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
Message-ID: <YUDlzxLjNsW+oYGC@hirez.programming.kicks-ass.net>
References: <20210908184905.163787-1-posk@google.com>
 <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
 <d656e605-4f89-4ea2-8baf-f7786f0630d9@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d656e605-4f89-4ea2-8baf-f7786f0630d9@www.fastmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 14, 2021 at 09:52:08AM -0700, Andy Lutomirski wrote:
> With a custom mapping, you don’t need to pin pages at all, I think.
> As long as you can reconstruct the contents of the shared page and
> you’re willing to do some slightly careful synchronization, you can
> detect that the page is missing when you try to update it and skip the
> update. The vm_ops->fault handler can repopulate the page the next
> time it’s accessed.

The point is that the moment we know we need to do this user-poke, is
schedule(), which could be called while holding mmap_sem (it being a
preemptable lock). Which means we cannot go and do faults.

> All that being said, I feel like I’m missing something. The point of
> this is to send what the old M:N folks called “scheduler activations”,
> right?  Wouldn’t it be more efficient to explicitly wake something
> blockable/pollable and write the message into a more efficient data
> structure?  Polling one page per task from userspace seems like it
> will have inherently high latency due to the polling interval and will
> also have very poor locality.  Or am I missing something?

The idea was to link the user structures together in a (single) linked
list. The server structure gets a list of all the blocked tasks. This
avoids having to a full N iteration (like Java, they're talking stupid
number of N).

Polling should not happen, once we run out of runnable tasks, the server
task gets ran again and it can instantly pick up all the blocked
notifications.
