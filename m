Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEFB40EA4D
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 20:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbhIPS4U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Sep 2021 14:56:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345117AbhIPS4E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Sep 2021 14:56:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E6F371F44239
Message-ID: <ea73969e-529f-b1af-9d47-ccaf0696ff0f@collabora.com>
Date:   Thu, 16 Sep 2021 15:54:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     dave@stgolabs.net, libc-alpha@sourceware.org, dvhart@infradead.org,
        mingo@redhat.com, Paul Eggert <eggert@cs.ucla.edu>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtk.manpages@gmail.com, kernel@collabora.com,
        krisman@collabora.com, rostedt@goodmis.org, bigeasy@linutronix.de,
        Arnd Bergmann <arnd@arndb.de>
References: <20210915140710.596174479@infradead.org>
 <20210915141525.621568509@infradead.org>
 <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
 <bdeb5453-e019-7c5b-1bf0-7a225401d358@cs.ucla.edu> <87tuika83y.ffs@tglx>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <87tuika83y.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 11:49 de 16/09/21, Thomas Gleixner escreveu:
> On Wed, Sep 15 2021 at 10:34, Paul Eggert wrote:
> 
>> On 9/15/21 8:37 AM, Peter Zijlstra wrote:
>>> I utterly detest timespec.. it makes no sense what so ever.
>>>
>>> Can't we just, for new syscalls, simply use a s64 nsec argument and call
>>> it a day?
>>
>> This would stop working in the year 2262. Not a good idea.
> 
> Make it u64 and it stops in 2552, i.e. 584 years from now which is
> plenty. Lot's of the kernel internal timekeeping will stop working at
> that point, so that interface is the least of my worries. And TBH, my
> worries about the Y2552 problem are extremly close to zero.
> 

What do we win by using u64 instead of timespec?

Or what's so bad about timespec?
