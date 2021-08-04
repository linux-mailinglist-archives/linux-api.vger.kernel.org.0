Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051F93E0AD6
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 01:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhHDXae (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 19:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhHDXad (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 19:30:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C024DC0613D5
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 16:30:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f42so7341159lfv.7
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 16:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHtPEclDrK7WzfT08VRfok96f4EFF4H9682lU5YgG5s=;
        b=Ik7HwoYbaw0A0wuENWLbxNnHG1SR/P6ZYN5/96bCC0AEigb7RjDkwFJea9oEQFOSCP
         da/jc6fHhKRaGXbonvww5Pq9rpDujnwTvjyHT72mUyZqDjDPGyRMG2pBeS4iFOtI2H0s
         bnjVsLdLv6kcgDh4nRfGbrx9h3scUuIPKzVSprkoEaa8jabEvBpqvgNAIRvc6zCec9x/
         7RO0opQy8FAS1C5Vt3geV4/94z0pmaL9zV4iB4Nwrqwr5rKycSxEvQ1h5XOfieqFrU5Z
         e7QF5znPP2VNxhJxCEqyzIfFNWheN5Zta2XYOHX1FAv0STI0YKcrftmSCWiHBoXc2Vk3
         i8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHtPEclDrK7WzfT08VRfok96f4EFF4H9682lU5YgG5s=;
        b=QAarmejJLYSK0QtXj38QIiw8ZZB3LGz7lklsQDOh83xg6x3N9ZBc7oxQBOZu1Ivrph
         XGRB2bAlJil1hw8L9u4Lq+xINvJEXsvqY/XL6MZwlKduWuEQXeVL36RV0H75B0OCvr9i
         0hLlYdUfPJ+lvGzxpKDceIdaFZW98PbdmexoWAzr84p3Dy5iLyadmBA0bII33M0Z2h0r
         qtndfG7c2DsbONbhFMIMzXr90LXumiUbj8w/Af7cyxXAz5BeHgQDBSBJtXvhtJnIeEas
         FZUJSUFgxvd3LT+czL+2DzVzU/IP3WS8NLuLiTFYMlboDI4EPPq5311mQFM33qdSk1k8
         0itA==
X-Gm-Message-State: AOAM533lDjFmwJpQ21MMeuBmFZGKOYDexJOP9WlJj1IXnD5fxbtxGZsf
        ODYbXP2q9dahKevYJPsXOEU9Jp6fliXlEnXaOa2fRg==
X-Google-Smtp-Source: ABdhPJw/BC7SYt/yq3Hmv3SjF2oaeXhckHMpYk5Am5Udn+/mSARm9PiS3mnOBesbqnRdtiFlPoMC8EgmB5GhXfscY+g=
X-Received: by 2002:a05:6512:2618:: with SMTP id bt24mr1242912lfb.180.1628119816966;
 Wed, 04 Aug 2021 16:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210801200617.623745-5-posk@google.com> <3530714d-125b-e0f5-45b2-72695e2fc4ee@uwaterloo.ca>
In-Reply-To: <3530714d-125b-e0f5-45b2-72695e2fc4ee@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 4 Aug 2021 16:30:05 -0700
Message-ID: <CAPNVh5cokv9un3TAxFfYEkRkA_EM68_2YSCaY_-z+wKzHWY+kw@mail.gmail.com>
Subject: Re: [PATCH 4/4 v0.4] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     posk@posk.io, avagin@google.com, bsegall@google.com,
        jannh@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pjt@google.com, tglx@linutronix.de,
        Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 4, 2021 at 3:05 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> I have attached an atomic stack implementation I wrote. I believe it would
> be applicable here. It is very similar except the kernel side no longer
> needs a retry loop, the looping is moved to the user-space after the pop.
> Using it instead of the code you have in enqueue_idle_worker means the
> timeout is no longer needed.

Thanks, Thierry! Your implementation seems reasonable - I'll test it
and will use it in the future versions of the patchset if everything
is OK.

>
>  > - ``uint64_t idle_server_tid_ptr``: points to a pointer variable in the
>  >   userspace that points to an idle server, i.e. a server in IDLE
> state waiting
>  >   in sys_umcg_wait(); read-only; workers must have this field set;
> not used
>  >   in servers.
>  >
>  >   When a worker's blocking operation in the kernel completes, the kernel
>  >   changes the worker's state from ``BLOCKED`` to ``IDLE``, adds the
> worker
>  >   to the list of idle workers, and checks whether
>  >   ``*idle_server_tid_ptr`` is not zero. If not, the kernel tries to
> cmpxchg()
>  >   it with zero; if cmpxchg() succeeds, the kernel will then wake the
> server.
>  >   See `State transitions`_ below for more details.
>
> In this case, I believe cmpxchg is not necessary and xchg suffices.

Right! I'll need to roll another atomic_xchg helper for this and the
atomic stack above...
