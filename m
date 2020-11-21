Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02222BC1D6
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 20:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgKUTul (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 14:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbgKUTul (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 14:50:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB11C0613CF
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 11:50:40 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605988239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksuRtwYUoC9XSfexsQ85ac+/JgTAQUEkyxgpWHXf3tw=;
        b=c/NBZVjJNIZxvSUCfpm18Apa1tbglN/S1nZzIoQdEXU1c0N3nE56suKJ8hvpZ0YhX9uZiG
        mzlZ2Lk8Fv2nJH6H6CUh+kjwFxyQKJmIyk5/cjpGaUMYP0PJgbn1sB6Le/7GZzv1+TcZ59
        Xn8osLAumfFbPPfSyUpXnBtLke8PbWDsJr3HbGw7Pm8u4Ed7rAOgwcfNtdsWCoRcz1bbwA
        e6IwiwAXfPHnV1MV+R/IZwnRlyN7UWVBO/Dplb0Ni9tsE/5JUe2yCIwwzqIVqXXzXgOZGT
        BJypcck/g7r9KTC5Kz8gcb3UgN4YWdxYC1H3vvCeoYKrlCJaSlD0lKaMDc173A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605988239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ksuRtwYUoC9XSfexsQ85ac+/JgTAQUEkyxgpWHXf3tw=;
        b=QTpd2B6D1qDlTsqPsn4iFng6ExIC4KRNG+IA0zxgiBdad8p7zyPvvDoofwJH6zMRDlBAun
        DSAMaN1mNJNogCDA==
To:     mtk.manpages@gmail.com, Mike Crowe <mac@mcrowe.com>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Problems with the new pthread clock implementations
In-Reply-To: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
References: <CAKgNAkgxxv2-A81bPV+6GPNXvcw6_FkP-Ajqe-6h83zbcEkmNA@mail.gmail.com>
Date:   Sat, 21 Nov 2020 20:50:38 +0100
Message-ID: <877dqeo5f5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 21 2020 at 07:59, Michael Kerrisk wrote:
> I've been taking a closer look at the the new pthread*clock*() APIs:
> pthread_clockjoin_np()
> pthread_cond_clockwait()
> pthread_mutex_clocklock()
> pthread_rwlock_clockrdlock()
> pthread_rwlock_clockwrlock()
> sem_clockwait()

Is there any at least rudimentary specification of these functions and
what they are supposed to do?

Thanks,

        tglx
