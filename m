Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D8640E2A9
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 19:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbhIPQlJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Sep 2021 12:41:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56038 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbhIPQhu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Sep 2021 12:37:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 70F0D1F440DA
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Collabora kernel ML <kernel@collabora.com>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 2/6] futex2: Implement vectorized wait
Organization: Collabora
References: <20210913175249.81074-1-andrealmeid@collabora.com>
        <20210913175249.81074-3-andrealmeid@collabora.com>
        <875yv4ge83.fsf@collabora.com>
        <58536544-e032-1954-ce30-d131869dc95e@collabora.com>
        <8735q5dutq.fsf@collabora.com>
        <YUMofqnG6zE4BrnR@hirez.programming.kicks-ass.net>
        <CAK8P3a3Bka5R4dmHE_+xuKTCtMaSZEYvT9jAz7QbgnF_CkeoNQ@mail.gmail.com>
Date:   Thu, 16 Sep 2021 12:36:21 -0400
In-Reply-To: <CAK8P3a3Bka5R4dmHE_+xuKTCtMaSZEYvT9jAz7QbgnF_CkeoNQ@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 16 Sep 2021 13:50:14 +0200")
Message-ID: <874kak8ol6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Sep 16, 2021 at 1:22 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Sep 16, 2021 at 12:10:25AM -0400, Gabriel Krisman Bertazi wrote:
>>
>> > I find this weird.  I'm not even juts talking about compat, but even on
>> > native 32-bit. But also, 32 applications on 64, which is a big use
>> > case for games.
>>
>> Seriously, people still make 32bit applications today? And for legacy
>> games, I would think the speed increase of modern CPUs would far offset
>> this little inefficiency.
>
> There are 32-bit Windows games apparently, because it's easier to build it
> that way than having both 32-bit and 64-bit versions.

Yes, many modern, recently released, tiple-A Windows games running over
Proton/Wine are published only in 32-bit.  We also keep a 32-bit Proton
for that reason.

> There may be native 32-bit games built for Linux from the same sources when
> that is not written portably, not sure if that's a thing.
>
> One important reason to use compat mode is for cost savings when you can
> ship an embedded system with slightly less RAM by running 32-bit user space
> on it. We even still see people running 32-bit kernels on Arm boxes that have
> entry-level 64-bit chips, though I hope that those will migrate the
> kernel to arm64
> even when they ship 32-bit user space.
>
> Similar logic applies to cloud instances or containers. Running a 32-bit
> Alpine Linux in a container means you can often go to a lower memory
> instance on the host compared to a full 64-bit distro.
>
>         Arnd

-- 
Gabriel Krisman Bertazi
