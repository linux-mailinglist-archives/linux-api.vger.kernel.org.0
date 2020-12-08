Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581192D244B
	for <lists+linux-api@lfdr.de>; Tue,  8 Dec 2020 08:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgLHHYi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Dec 2020 02:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLHHYi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 Dec 2020 02:24:38 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF547C061793
        for <linux-api@vger.kernel.org>; Mon,  7 Dec 2020 23:23:57 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id g185so1421793wmf.3
        for <linux-api@vger.kernel.org>; Mon, 07 Dec 2020 23:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwnZcJKOltLC78EdCJTTIZysg34xmbCEL+7ZUfnNors=;
        b=AZufqmYyhIhiIjIXjTNyh2J9tNPyJ/WjQvSjd60viGbcy6GE4yOkipfzzs3Yd3nGrK
         zzdEigae73Y3oNfJfTSEIGxTOKW0g7mSZpzCX+B1KhzUnNvuEVi21ujVjlN7uj8LZQ5/
         CxhTuiDmpGfWSIVaLeECasOAflAsFj2jM7M125qmr1N+8dP/rD28XmdRHK/WrRyEz1Rl
         Lvxva7DN7Cd94jq7XnSe/3DBFF2Gy3MvH8ArnQVryjdrMF1sJ4/JORUiWCHX+4tYQt8H
         R4f+uolTnhOINvG6Jc+hTUauTim4L/AKv8xWP/4pnjJRZEaSybGonIFRIXggYWpclFCQ
         ucHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwnZcJKOltLC78EdCJTTIZysg34xmbCEL+7ZUfnNors=;
        b=aWbr6dgEojpJoom0YQeYnHvC7DvDCmx96I6zMLO9XtgT+jQZWF5o4ZVXTG73DdqBeH
         5AN8gXHklrEMRiMx3TJ3axBPYrYQN+iE2Flthr6VO1NnH/khw0GwqjH+1D7z8YO3qQ6M
         rFxJ1NQv3IxWTiwYNFAq7hW7DWmZY8iTJM/tRyFWV+sETcTfMTKuYCe1aaXU/oezeIjP
         UEAN2J36bEx+GEk6iskj4LmjZGcdkwNxA65ixKA32uF3DLK+FbyDehTjGT3IWhtx1FY4
         UYChKQ12Fnoso0Q3knRlW1PBzkwcmIiPpbnTji7eiKi6P9xfpJNWIpD9Avag8nnBIHyn
         RP9A==
X-Gm-Message-State: AOAM532tb+kzv4JNvWoYTuDe1RgZc+L6/uMWeH8xGirODgA2ZV0gm+gD
        sYp324wvWfJrbPfQj6jR5UD1SVpxUMVD1norsUIq3g==
X-Google-Smtp-Source: ABdhPJxr4+o94bHYhKcEmobnJ9PgmKWvNErqCzXT8KkYnhyRDLin/XHz0bPr2OLcOhJnyokzuUQFUb9zkQ0GKOQ0ZTM=
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr2415823wmg.37.1607412236344;
 Mon, 07 Dec 2020 23:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAJuCfpGCc49g5+T+V3SxZ6eVteLac6xVRx+1z6G2a8P4-Cr7bA@mail.gmail.com>
 <20201125234322.GG1484898@google.com> <CAJuCfpFuWqMEXJij_qHhyGpuFXLuJ7-DcHgcc9760NhBHhuLHw@mail.gmail.com>
In-Reply-To: <CAJuCfpFuWqMEXJij_qHhyGpuFXLuJ7-DcHgcc9760NhBHhuLHw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 7 Dec 2020 23:23:45 -0800
Message-ID: <CAJuCfpFW=ruDA-FX6Uj7P8__J7RcbQuWwdQfhSuXm6SUWZeCXQ@mail.gmail.com>
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

On Mon, Nov 30, 2020 at 11:01 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Nov 25, 2020 at 3:43 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Wed, Nov 25, 2020 at 03:23:40PM -0800, Suren Baghdasaryan wrote:
> > > On Wed, Nov 25, 2020 at 3:13 PM Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 23, 2020 at 09:39:42PM -0800, Suren Baghdasaryan wrote:
> > > > > process_madvise requires a vector of address ranges to be provided for
> > > > > its operations. When an advice should be applied to the entire process,
> > > > > the caller process has to obtain the list of VMAs of the target process
> > > > > by reading the /proc/pid/maps or some other way. The cost of this
> > > > > operation grows linearly with increasing number of VMAs in the target
> > > > > process. Even constructing the input vector can be non-trivial when
> > > > > target process has several thousands of VMAs and the syscall is being
> > > > > issued during high memory pressure period when new allocations for such
> > > > > a vector would only worsen the situation.
> > > > > In the case when advice is being applied to the entire memory space of
> > > > > the target process, this creates an extra overhead.
> > > > > Add PMADV_FLAG_RANGE flag for process_madvise enabling the caller to
> > > > > advise a memory range of the target process. For now, to keep it simple,
> > > > > only the entire process memory range is supported, vec and vlen inputs
> > > > > in this mode are ignored and can be NULL and 0.
> > > > > Instead of returning the number of bytes that advice was successfully
> > > > > applied to, the syscall in this mode returns 0 on success. This is due
> > > > > to the fact that the number of bytes would not be useful for the caller
> > > > > that does not know the amount of memory the call is supposed to affect.
> > > > > Besides, the ssize_t return type can be too small to hold the number of
> > > > > bytes affected when the operation is applied to a large memory range.
> > > >
> > > > Can we just use one element in iovec to indicate entire address rather
> > > > than using up the reserved flags?
> > > >
> > > >         struct iovec {
> > > >                 .iov_base = NULL,
> > > >                 .iov_len = (~(size_t)0),
> > > >         };
> > > >
> > > > Furthermore, it would be applied for other syscalls where have support
> > > > iovec if we agree on it.
> > > >
> > >
> > > The flag also changes the return value semantics. If we follow your
> > > suggestion we should also agree that in this mode the return value
> > > will be 0 on success and negative otherwise instead of the number of
> > > bytes madvise was applied to.
> >
> > Well, return value will depends on the each API. If the operation is
> > desruptive, it should return the right size affected by the API but
> > would be okay with 0 or error, otherwise.
>
> I'm fine with dropping the flag, I just thought with the flag it would
> be more explicit that this is a special mode operating on ranges. This
> way the patch also becomes simpler.
> Andrew, Michal, Christian, what do you think about such API? Should I
> change the API this way / keep the flag / change it in some other way?


Friendly ping to get some feedback on the proposed API please.
