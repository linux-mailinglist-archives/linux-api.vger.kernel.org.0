Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438E440D237
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 06:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhIPELw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 16 Sep 2021 00:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhIPELv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Sep 2021 00:11:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0530C061574;
        Wed, 15 Sep 2021 21:10:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:f4d2:afff:fe2b:18b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 161211F435AC;
        Thu, 16 Sep 2021 05:10:28 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/6] futex2: Implement vectorized wait
Organization: Collabora
References: <20210913175249.81074-1-andrealmeid@collabora.com>
        <20210913175249.81074-3-andrealmeid@collabora.com>
        <875yv4ge83.fsf@collabora.com>
        <58536544-e032-1954-ce30-d131869dc95e@collabora.com>
Date:   Thu, 16 Sep 2021 00:10:25 -0400
In-Reply-To: <58536544-e032-1954-ce30-d131869dc95e@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Tue, 14 Sep 2021 14:18:58 -0300")
Message-ID: <8735q5dutq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

>>> +/**
>>> + * struct futex_waitv - A waiter for vectorized wait
>>> + * @val:	Expected value at uaddr
>>> + * @uaddr:	User address to wait on
>>> + * @flags:	Flags for this waiter
>>> + * @__reserved:	Reserved member to preserve data alignment. Should be 0.
>>> + */
>>> +struct futex_waitv {
>>> +	__u64 val;
>>> +	__u64 uaddr;
>>> +	__u32 flags;
>>> +	__u32 __reserved;
>>> +};
>> 
>> why force uaddr  to be __u64, even for 32-bit?  uaddr could be a (void*) for
>> all we care, no?  Also, by adding a reserved field, you are wasting 32
>> bits even on 32-bit architectures.
>> 
>
> We do that to make the structure layout compatible with both entry
> points, remove the need for special cast and duplicated code, as
> suggested by Thomas and Arnd:
>
> https://lore.kernel.org/lkml/87v94310gm.ffs@tglx/
>
> https://lore.kernel.org/lkml/CAK8P3a0MO1qJLRkCH8KrZ3+=L66KOsMRmcbrUvYdMoKykdKoyQ@mail.gmail.com/

I find this weird.  I'm not even juts talking about compat, but even on
native 32-bit. But also, 32 applications on 64, which is a big use
case for games.

The structure is mandating a 64 bit uaddr field and has an unnecessary
pad.  You are wasting 20% of the space, which is gonna be elements of a
vector coming from user space.  Worst case, you are doing copy_from_user
of an extra 1k bytes in the critical path of futex_waitv for no good
reason.

Also, if I understand correctly, Arnd suggestion, at least, was to have
two parser functions and a single syscall entry point, that would do the
translation:

if (in_compat_syscall())
   futex_parse_waitv_compat(futexv, waiters, nr_futexes);
else
   futex_parse_waitv(futexv, waiters, nr_futexes);

-- 
Gabriel Krisman Bertazi
