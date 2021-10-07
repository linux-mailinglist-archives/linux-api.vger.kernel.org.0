Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F56424FBA
	for <lists+linux-api@lfdr.de>; Thu,  7 Oct 2021 11:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhJGJK6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Oct 2021 05:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhJGJK4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Oct 2021 05:10:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6573CC061746;
        Thu,  7 Oct 2021 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Y5xMk8StgC57MyBQhfGnYcEdOD5+0ggmDgCWfSVFI3g=; b=Eucoetdp2M0/xpchTWen3ZtRVB
        kxQH5aB2Eqe2IZHL0TQg82/FgvAA1hMr5ZAKC9WjWRz7hCS7wR9l9S0B406gRcTtfuekLhx4ROKyf
        P76bJUFvhRXzLgZTV5vFvqOkU94RskhT0QMKPOp8rq7FyAadipK7m9w3FtfTQFaNESqjsAcMQsPxV
        4W9qBQBeV+dE85uHjTgR3Vd7HRRr3vsjnvqxHXKqgq7s+Ak0BjPm9TOZH17IkM5VmF+gBguegR5u5
        cyQeR/kZZLH1qQfO7Qf+c/7UaRG8OtHR6qSGYdCp8YNF66UdUDyjdtoj9evs459Drh7Fdmj28aJMf
        oEkBPq/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYPOI-008RlV-HZ; Thu, 07 Oct 2021 09:08:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1125498623C; Thu,  7 Oct 2021 11:08:38 +0200 (CEST)
Date:   Thu, 7 Oct 2021 11:08:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zack Weinberg <zack@owlfolio.org>
Cc:     libc-alpha@sourceware.org,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 16/22] futex: Implement sys_futex_waitv()
Message-ID: <20211007090837.GQ174703@worktop.programming.kicks-ass.net>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
 <20210923171111.300673-17-andrealmeid@collabora.com>
 <20211006115022.GH174703@worktop.programming.kicks-ass.net>
 <47b13460-27a4-474c-879b-ed1c668e5923@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b13460-27a4-474c-879b-ed1c668e5923@www.fastmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Hi Zack,

Please use reply-all; I've restored the Cc's

On Wed, Oct 06, 2021 at 09:48:43AM -0400, Zack Weinberg wrote:
> On Wed, Oct 6, 2021, at 7:50 AM, Peter Zijlstra wrote:
> > On Thu, Sep 23, 2021 at 02:11:05PM -0300, André Almeida wrote:
> >> Returns the array index of one of the awakened futexes. There’s no given
> >> information of how many were awakened, or any particular attribute of it
> >> (if it’s the first awakened, if it is of the smaller index...).
> >
> > As per some native speakers on IRC, awaken isn't the right word. I've
> > changed it like the below.
> 
> "woken" and "awoken" are also not the right word (my brain flags both
> as spelling errors).  Suggestions below:
> 
> > - * Returns the array index of one of the awaken futexes. There's no given
> > - * information of how many were awakened, or any particular attribute of it (if
> > - * it's the first awakened, if it is of the smaller index...).
> > + * Returns the array index of one of the woken futexes. There's no given
> > + * information of how many were woken, or any particular attribute of it (if
> > + * it's the first woken, if it is of the smaller index...).
> 
> "awakened" was the correct word in all three places here.  The
> sentences are awkward, I might suggest

Afaict it's a bit of a mess. I googled the thing and there's apparently
2 verbs with identical meaning but different inflections:

  awake (irregular): awake, awoke (awaked), awoken (awaken)
  awaken (regular):  awaken, awakened, awakened.

Now the thing is, the futex operation is FUTEX_WAKE, not FUTEX_AWAKEN,
therefore I think we should be going with the first (irregular) verb,
which then gets me 'woken'.

( also, 'awaked' gets me the mental image of a hillbilly, but that might
  just be me -- the forms were all suggested by meriam-webster:

  https://www.merriam-webster.com/words-at-play/usage-awaken-awoken-awakened

  for further confusion also see:

  https://www.grammar.com/awake-awaken-wake-waken
)

> # Returns the array index of one of the awakened futexes.
> # No further information is provided: any number of other
> # futexes may also have been awakened by the same event, and
> # if more than one futex was awakened, the returned index may
> # refer to any one of them.  (It is not necessarily the futex
> # with the smallest index, nor the one most recently awakened,
> # nor ...)

Aside of the whole wake mess, I do like that better, let me go make that
happen.

> > -	 * absorb any awake events, which cannot be done before the
> > +	 * loose any wake events, which cannot be done before the
> 
> 'wake events' is correct here, but you introduced an unrelated error:
> 'loose' is the opposite of 'tight', you want 'lose' with only one O.

I shall forever make that mistake :-(
