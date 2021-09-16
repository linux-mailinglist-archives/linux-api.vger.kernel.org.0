Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1840DD36
	for <lists+linux-api@lfdr.de>; Thu, 16 Sep 2021 16:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhIPOup (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Sep 2021 10:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhIPOup (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Sep 2021 10:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90355C061574;
        Thu, 16 Sep 2021 07:49:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631803761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYKdI5AQx0UIdmFogKaBa5wIbcy1J8qgQFTO/dSJlvY=;
        b=jusvQV+UrZf9umKAi8WLOwRAUw8F+0SyoEdSjScAbzTVc4ha3cxWOev2W80S/pJ1TFUm0c
        N+oDDjJfvyKIKWKh8UA3/3DnmYFLA9uaLv0OmSUDKVHgb13ZovOg7V6G1GEXzbSoUOwGto
        vlhbc6UNAfl/KLf37pwDm8zvam2bXOQTznaMvtThJwZXnbF9iHShY2GC6K2ScMdk1D0LrQ
        7n5BPOBjdDQSRhyGNcfwWcDIUoJmCYgt6MYVHW9o3QVEoaQJQ6kA0D9Xp20+tJEEZBR3Ur
        TyVMqkcCZ8JdnZi5XFJZM/T/U+e9g0IAJ5wTwAAJSiS6/vo3T80D7qQcCYIMpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631803761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jYKdI5AQx0UIdmFogKaBa5wIbcy1J8qgQFTO/dSJlvY=;
        b=zD4Kis/djKpAJG7OI9RzP5aed/KL0qJ6+DSOiuL3VGw2odLUXeynKNwKzG+qkfN/sUMq81
        Uehc/ZlWhZW9TnDA==
To:     Paul Eggert <eggert@cs.ucla.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        andrealmeid@collabora.com, mingo@redhat.com, dvhart@infradead.org,
        rostedt@goodmis.org, bigeasy@linutronix.de
Cc:     dave@stgolabs.net, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mtk.manpages@gmail.com, kernel@collabora.com, krisman@collabora.com
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
In-Reply-To: <bdeb5453-e019-7c5b-1bf0-7a225401d358@cs.ucla.edu>
References: <20210915140710.596174479@infradead.org>
 <20210915141525.621568509@infradead.org>
 <YUITUXbnzAK98DEl@hirez.programming.kicks-ass.net>
 <bdeb5453-e019-7c5b-1bf0-7a225401d358@cs.ucla.edu>
Date:   Thu, 16 Sep 2021 16:49:21 +0200
Message-ID: <87tuika83y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15 2021 at 10:34, Paul Eggert wrote:

> On 9/15/21 8:37 AM, Peter Zijlstra wrote:
>> I utterly detest timespec.. it makes no sense what so ever.
>>=20
>> Can't we just, for new syscalls, simply use a s64 nsec argument and call
>> it a day?
>
> This would stop working in the year 2262. Not a good idea.

Make it u64 and it stops in 2552, i.e. 584 years from now which is
plenty. Lot's of the kernel internal timekeeping will stop working at
that point, so that interface is the least of my worries. And TBH, my
worries about the Y2552 problem are extremly close to zero.

> Any improvements on struct timespec should be a strict superset, not a=20
> subset. For example, you could advocate a signed 128-bit argument=20
> counting in units of attoseconds (10=E2=81=BB=C2=B9=E2=81=B8 s), the high=
est power-of-1000=20
> resolution that does not lose info when converting from struct
> timespec.

Which requires a 128bit division on every syscall for no value at all.

Thanks,

        tglx
