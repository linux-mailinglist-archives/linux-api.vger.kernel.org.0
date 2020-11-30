Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B22C8D9A
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 20:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgK3TCJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 14:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbgK3TCJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 14:02:09 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AFFC0613D3
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 11:01:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id f190so515066wme.1
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfWeO4tbhTGJrN6AO+wZJR6KFcxbZZ5VZ2sCRkzWaLQ=;
        b=EABF8k2s1USjU9oYjO5iwqvFMSQ4Yhe8e6PUMCsy7Nv0n6mtBtxWhrl6sFE2b6aG1W
         oTjB3pd696431yT8mK6dpmQtnWW5tbT/uaKqLRuHdnRBQE+ahwJeRI5c3mJSF+EIM5hB
         bGjQuA3JayCi8/mY0PRoPsntKsgg1+j9i7RZKC21GT/lj2n6j4dnbUnj7sBzxYaMSU7B
         YkidQoecd4EC79njWzY+0q8L9wx0ONQiHtVje8VL4/JjQzTYQCZ7UKeYBdxla6zvI/Xz
         KrOZJGEXwbcJ8VBoQR1UlNPXTfTeDu8+zZfZ2veJqxMkfxUNXmQm60n+BmRAxrgFZe80
         i5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfWeO4tbhTGJrN6AO+wZJR6KFcxbZZ5VZ2sCRkzWaLQ=;
        b=Drpa/ISVfMBqFxMD3z7WsH83uYLPQGjKfr2NBczDh5ERjG2nVz6jB7buVaxJttBgyO
         rdmqccdTyxh90EK30d+zrW+NHIWrxi3Bm3xAXBI3IZ8kWGm5j53YwqD97EJ6ZNdhGUhc
         reoiwqGfkrWVrCDTqDtCQ09kqYjAePCtTJvXT1A4FDpuyj6tnf8n8iH6wcyx1CZx+eIO
         p+kdBe1jHeRtgdO8D85okuH3OWp4geWwZ7oYoNED4Auo4R8nWEGKlqersX5GYJasTRD9
         AhaNRuvXMdZMFcVNN8T/Rseg/66wpDAzKFZ8E+uO5YHOt+5kLc+oOlGTkV4JhXm+MtZi
         mrIw==
X-Gm-Message-State: AOAM530JEK11IS1xaWYZRPnBfIKqcCo2c2s+7KoN4xcZ8ZFKrSWS1dBB
        sFfhN02zNlNU8elVw6gVO+nBr2Mp40eHji07QbH5rA==
X-Google-Smtp-Source: ABdhPJz8qDhhOjxPi0TXmRcyG4hBncx7s7GIOpBZbwZSPQFLUYthnHyxlIQIX6g6jhkX8xW22CtzoRZi+0JV6bQFkdk=
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr292802wmh.88.1606762886790;
 Mon, 30 Nov 2020 11:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAJuCfpGCc49g5+T+V3SxZ6eVteLac6xVRx+1z6G2a8P4-Cr7bA@mail.gmail.com>
 <20201125234322.GG1484898@google.com>
In-Reply-To: <20201125234322.GG1484898@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 30 Nov 2020 11:01:15 -0800
Message-ID: <CAJuCfpFuWqMEXJij_qHhyGpuFXLuJ7-DcHgcc9760NhBHhuLHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 25, 2020 at 3:43 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Wed, Nov 25, 2020 at 03:23:40PM -0800, Suren Baghdasaryan wrote:
> > On Wed, Nov 25, 2020 at 3:13 PM Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> > > > process_madvise requires a vector of address ranges to be provided for
> > > > its operations. When an advice should be applied to the entire process,
> > > > the caller process has to obtain the list of VMAs of the target process
> > > > by reading the /proc/pid/maps or some other way. The cost of this
> > > > operation grows linearly with increasing number of VMAs in the target
> > > > process. Even constructing the input vector can be non-trivial when
> > > > target process has several thousands of VMAs and the syscall is being
> > > > issued during high memory pressure period when new allocations for such
> > > > a vector would only worsen the situation.
> > > > In the case when advice is being applied to the entire memory space of
> > > > the target process, this creates an extra overhead.
> > > > Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> > > > advise a memory range of the target process. For now, to keep it simple,
> > > > only the entire process memory range is supported, vec and vlen inputs
> > > > in this mode are ignored and can be NULL and 0.
> > > > Instead of returning the number of bytes that advice was successfully
> > > > applied to, the syscall in this mode returns 0 on success. This is due
> > > > to the fact that the number of bytes would not be useful for the caller
> > > > that does not know the amount of memory the call is supposed to affect.
> > > > Besides, the ssize_t return type can be too small to hold the number of
> > > > bytes affected when the operation is applied to a large memory range.
> > >
> > > Can we just use one element in iovec to indicate entire address rather
> > > than using up the reserved flags?
> > >
> > >         struct iovec {
> > >                 .iov_base = NULL,
> > >                 .iov_len = (~(size_t)0),
> > >         };
> > >
> > > Furthermore, it would be applied for other syscalls where have support
> > > iovec if we agree on it.
> > >
> >
> > The flag also changes the return value semantics. If we follow your
> > suggestion we should also agree that in this mode the return value
> > will be 0 on success and negative otherwise instead of the number of
> > bytes madvise was applied to.
>
> Well, return value will depends on the each API. If the operation is
> desruptive, it should return the right size affected by the API but
> would be okay with 0 or error, otherwise.

I'm fine with dropping the flag, I just thought with the flag it would
be more explicit that this is a special mode operating on ranges. This
way the patch also becomes simpler.
Andrew, Michal, Christian, what do you think about such API? Should I
change the API this way / keep the flag / change it in some other way?
