Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371843F092E
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 18:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbhHRQev (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 12:34:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42476 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhHRQen (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 12:34:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 744841F433CA
Subject: Re: [PATCH 2/4] futex2: Implement vectorized wait
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
 <20210805190405.59110-3-andrealmeid@collabora.com> <87v94310gm.ffs@tglx>
 <20210818162034.GA26408@worktop.programming.kicks-ass.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <42c6c37d-dd35-e797-9194-4619c1456f85@collabora.com>
Date:   Wed, 18 Aug 2021 13:34:00 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210818162034.GA26408@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 13:20 de 18/08/21, Peter Zijlstra escreveu:
> On Wed, Aug 18, 2021 at 01:00:57PM +0200, Thomas Gleixner wrote:
>>> +/**
>>> + * struct futex_waitv - A waiter for vectorized wait
>>> + * @val:   Expected value at uaddr
>>> + * @uaddr: User address to wait on
>>> + * @flags: Flags for this waiter
>>> + */
>>> +struct futex_waitv {
>>> +	__u64 val;
>>
>> Again. Why u64?
> 
> So I think the idea was that if we're going to do new syscalls, we
> should cater for future extentions, one of which was 64bit futexes (for
> 64bit archs) (along with u{8,16,32})
> 
> The previous set of patches implemented a more complete replacement ABI
> -- which I rather liked, however the implementation was completely
> disjoint from the existing futexes, which was a non-starter for me.
> 
> Anyway, yes, current futexes are u32, but if we want to ever do u64
> futexes, we should either do this syscall with a u64, or already plan to
> retire the whole syscall.
> 
> Obiously this would've made good Changelog material, but alas it wasn't
> there.
> 

Ops, I forgot to add the reasoning behind the 64 futexes. The idea is
that futex users want to be able to properly do 64bit atomic operations
on top of futex values:

[0]
https://lore.kernel.org/lkml/CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com/

[1]
https://lore.kernel.org/lkml/20210603195924.361327-1-andrealmeid@collabora.com/T/#m37bfbbd6ac76c121941defd1daea774389552674

[2] https://lists.boost.org/Archives/boost/2021/05/251508.php
