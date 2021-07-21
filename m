Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735E33D1877
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 22:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhGUUTV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGUUTU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 16:19:20 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CBFC061757
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 13:59:57 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t186so2323264ybf.2
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 13:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zev5RkUDntkX6kWICmg9oLGVZwQDp/V6CB2SFJXvlbM=;
        b=MbUup/f2IQ4e5MYXEyQSpJT9BA/5+K1mBDGxRAU/j8XHmKaNWC16053kMEmyaCPWU0
         6X5d7gRKAa/dn9sXGMMonqNVZSQYg+FgMrgm/oDLmrFHHR6ryPTk24OjWuqiUkf9JhlW
         PLjjQ9c7rg4CcEE7sbk2wPUqHfE4u7dcmZIHR68kECpIWmNrF1e+HavOLMMowGahLl1N
         kGlsYJAhDLNMrqMEj2DACIl6eethtxavpitbs31H1qNkaE1Gra0Ryy7rqC6tnXd9j2JL
         7GKz6SzksiLzhiITrFIqLM+x66LPrPtZYXLKfOTn1rDr0ivJKphsFhfY2vy2DTZWrCSf
         Kz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zev5RkUDntkX6kWICmg9oLGVZwQDp/V6CB2SFJXvlbM=;
        b=Bvj+MdE58V8Pbl2G5s4Wf64T7tDf/fzq+oqt92va4WPFRz7XvFsTvn0uHYEKzvt/Tt
         J7GpA11cK9nT7BSkXlTj7v9LGy8qqtoULM4l2sCfX0pCK33w03nwgmyIGyak/MK/r7lV
         yZeJy9c0//Aru0AOhNSJl+mBUIhkvleeWxEMjH6e2tNtPsNdqCdr+GBdUb/+gvOMtCWh
         OfvF9P69crwRFhDL15i69b6Gl1POe7JRdul+Ws1RvGzaf4GObKe2kjXSAzDOQ2OWTgzh
         eWkmvRy+vUuuH7A6ZRBVkrmeXdn0Ot+QvJ9QxB/+l41asqJz4qjlWF2aqHqz8gfjf4OG
         nxSA==
X-Gm-Message-State: AOAM5304hrnK6CeU9S4fUIbAZhLV9qMN/L3dRJeE9fMZad/JVQJKIQAH
        MNuCwTZHqkHdepolfUcIX72Wnd+1/ihq/SozpvAxaQ==
X-Google-Smtp-Source: ABdhPJxPA+1Lvr6r0Ah+Ih16Hp1gDj0q96HTIeJShNuvXV8XbMIS4BZvdwqDvpclVoKXHc0q16IfDXSgqc30JARLqDQ=
X-Received: by 2002:a25:d912:: with SMTP id q18mr44064581ybg.294.1626901195909;
 Wed, 21 Jul 2021 13:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
 <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
 <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com> <CAJuCfpEB994Xj3FcmzyH1p3yOdLVf6EwZaGaRj7NJi_c9hbsRQ@mail.gmail.com>
 <0ee6775b-589c-3243-1c01-aafad5eecb73@redhat.com> <CAJuCfpHtRzCNH6Cspu8ngjw+WLvZTMsVbmBu_F-z8YY_n=RbvA@mail.gmail.com>
 <20210721135056.84d12dd49c07adff7b0beffb@linux-foundation.org>
In-Reply-To: <20210721135056.84d12dd49c07adff7b0beffb@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 21 Jul 2021 13:59:44 -0700
Message-ID: <CAJuCfpGsSFccjV9Qd86PCdLHjRG9gdP7snfy-856pzmfxdGO1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 21, 2021 at 1:51 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Jul 2021 13:19:35 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > > This would not require moving other functions.
> > > > Would that be better than the current approach or the forward declaration?
> > >
> > > IMHO that could be an easy, possible alternative.
> >
> > Andrew, others? Should I follow this path instead?
>
> Whatever you prefer ;)

I understand David's concern too well to ignore it, so I prefer to
follow this middle-ground approach if you don't mind :)
