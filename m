Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A804042B3
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 03:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349094AbhIIBR6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 21:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhIIBRy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 21:17:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7E2C061757
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 18:16:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k13so273855lfv.2
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvLyT4+7Aiymn6gXzNE4oKTpQfZnma/CF9vdVIrLCj0=;
        b=loBPUFiJ17CJ4ZdjUsFhVmUZ8Cg018uO8pv3jVcFNEjIZVzht/g5phznAS6jMzVM7u
         1b960PykAURWK6R1WWuzYsw1WW/rLiiB1NxXWRiQWasxgYExBxCr0g++4OVjJSsjh3SR
         Atd5BJHlbFWfJE2Q91fduLBIh2jw6EkyO6aLkrNX5AOHzzR7mGXDFiy3btCQndztlZgc
         wMW4aso3DZSP1xVwh53RCmETvnWLjxKzqi4PG3MtfJ/mBoRtUYpvQt2QP9HbAAok0SgT
         j4GFArFfPaSYyAc0q8fUct1EMmVfzoYa1W89crrw9OsK17O+labUFu/nJOKRHk8tso4a
         mcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvLyT4+7Aiymn6gXzNE4oKTpQfZnma/CF9vdVIrLCj0=;
        b=m0/s7+7bRdRgHENnZMF5GdX6zvglUNnwFN2M4gckvqzM4o0zEekF5e/XzbmYIs7C83
         niXNZQjDTERrZK/U2NihToZabu7ZKFkSdszDRQ3M+cXZzksz8aLrtFV6nk0xFKqKdilK
         yoor/Pl5Uq2hm9ocm7N5AB5w3495ULJ2q9mFyXR1VViKzOEqL2V6MQnBIhycwLMhKWP7
         TMFVnFGnC/JkMt9gwcNkmGe3K0EEZjR67r/ogvzsipLHXIIgGWzKyw5XJHlEy00OaL7s
         Wxxg7G9PZmowVlH6DZkOx1jd3ZrNV/OCbLQpFEIe/JjwoGPEdU+X1/qwvuaB8ty1fvlP
         TVsA==
X-Gm-Message-State: AOAM5302g3OchJUQZcgF+XSsMjdYyv+Hm/7xFxSUyJukUgZCus3NE9dD
        NQLBy8Iq6Xur2+begoKUtf0GHwWANY4fq6aQveP8Dg==
X-Google-Smtp-Source: ABdhPJysB844wVmbqvrXWaqDyoi57lhNAEbQuTWxjHVgx5kqArBdJnl+Uo9biEAEfd2Ku+wq/XpmEh5qIkX6IKdkir4=
X-Received: by 2002:a05:6512:695:: with SMTP id t21mr365696lfe.157.1631150203757;
 Wed, 08 Sep 2021 18:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
In-Reply-To: <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Sep 2021 03:16:17 +0200
Message-ID: <CAG48ez3rRReCVpuhQu_-f_a0Yn=cUBqu1aNSG0JtHK8mjqzFsw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 9, 2021 at 1:38 AM Jann Horn <jannh@google.com> wrote:
> On Wed, Sep 8, 2021 at 8:49 PM Peter Oskolkov <posk@posk.io> wrote:
> > Add helper functions to work atomically with userspace 32/64 bit values -
> > there are some .*futex.* named helpers, but they are not exactly
> > what is needed for UMCG; I haven't found what else I could use, so I
> > rolled these.
[...]
> You of course won't be able to simply traverse userspace pointers in
> such a situation, only access the specific userspace object that
> you've prepared beforehand, but luckily it looks like:
>
>  * idle_server_tid_ptr is only accessed in get_idle_server()
>    -> which is used from process_waking_worker()
>      -> which runs in sleepable context
>  * idle_workers_ptr is accessed from:
>    -> enqueue_idle_worker
>      -> which is also used from process_waking_worker()

Ah, I guess I got that wrong: process_waking_worker() is sleepable,
but it might be holding the mmap lock, so it can't fault, right? Which
means this would actually be problematic...
