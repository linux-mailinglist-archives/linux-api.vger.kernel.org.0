Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4FD45F79E
	for <lists+linux-api@lfdr.de>; Sat, 27 Nov 2021 01:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbhK0Aug (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 19:50:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34418 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344421AbhK0Asf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 19:48:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637973920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgzppMsiijavabR8bvW5suyEIFjxfrt3sP7id6758Ck=;
        b=NLKBnci0g+oqYme7XRqvk2sJHYGzyx3x3/Y7MH5F4qYjQYmUDsPZdySG7UXXtqamlSFPJm
        Rc/kZR6Et/C909GUve6d9q4WVUGnZA1irz4REtHB3S3X0HbgCX8jyyMruZ58mhVCIZYNhz
        h4y7MExC0SFcLva00n1ivIMDzelLC3rsON+tQQiYyU9pT+zM1+m2HkDG183ZW4v5XB9WTV
        5dYQHjV+t0ueQnglSMh/SVRogCWXMZGkL/qq9oJUposmUiLsi7e8+MY9n8tZj9iKLd3m+A
        XFWToWbYzbrSlInOHm+hxY1VsAxd+AHBc/5kgV8yau+NgR/xhRL/wH7Oh5AAmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637973920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgzppMsiijavabR8bvW5suyEIFjxfrt3sP7id6758Ck=;
        b=NEucaHVpQjoXPK0mmv9QRxCDi6eKvv+fZu/8SI7/O+H7rAa6MWvc2aPeN98OkFIRoqdUV4
        XHYijCtV96T88mDQ==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
In-Reply-To: <YaFY0KqfPhmZjK7n@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net> <87a6hqhbgh.ffs@tglx>
 <YaFY0KqfPhmZjK7n@hirez.programming.kicks-ass.net>
Date:   Sat, 27 Nov 2021 01:45:20 +0100
Message-ID: <87tufyfmu7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26 2021 at 22:59, Peter Zijlstra wrote:
> On Fri, Nov 26, 2021 at 10:08:14PM +0100, Thomas Gleixner wrote:
>> > +		if (timo)
>> > +			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
>> > +
>> > +		freezable_schedule();
>> 
>> You can replace the whole hrtimer foo with
>> 
>>                 if (!schedule_hrtimeout_range_clock(timo ? &timo : NULL,
>>                                                     tsk->timer_slack_ns,
>>                                                     HRTIMER_MODE_ABS,
>>                                                     tsk->umcg_clock)) {
>>                 	ret = -ETIMEOUT;
>>                         break;
>>                 }
>
> That seems to loose the freezable crud.. then again, since we're
> interruptible, that shouldn't matter. Lemme go do that.

We could add a freezable wrapper for that if necessary.

Thanks,

        tglx
