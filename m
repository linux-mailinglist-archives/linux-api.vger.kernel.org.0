Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EBA2B2AB4
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 02:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKNB5P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Nov 2020 20:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKNB5P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Nov 2020 20:57:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1EC0617A6
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 17:57:14 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p1so12241580wrf.12
        for <linux-api@vger.kernel.org>; Fri, 13 Nov 2020 17:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aAt0y4BONkE4qAf0vKXaFTXwB4ZFsnt5S+RuI0jP7I0=;
        b=ed7NqWQne82b4CGLxKKyy40f2AtEDak0uE2vEFG0Eg45fsFvqzucto15OoBmGMcffH
         eCmMx6p4CbPjbJNtXw4hA1XqGxNSWvKhZ3MUkh8mXF6oVpyK1k3jReyT19EPA2ytP5lx
         U5vvLq2u3KQZv0N4RU+9z0WSEEC8D0xmgmG8ltLYw2xPp/JAD/0V80adsjygNw7S6v8H
         uU9/TJsJohTb7QVz8fw8jXdBnk5xbNFrjX+6+64MjkDWrL6ibdOFH08eUnlaPTROXsTy
         ZRARIgSzlfxFT1+3g5kSqOD/eJPung8kpqou4ldSK3ZSY0e40DJiyXH9M7op5k8DWPJG
         +1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aAt0y4BONkE4qAf0vKXaFTXwB4ZFsnt5S+RuI0jP7I0=;
        b=ZzQB8zzthMmco5i3Ms8UVyVkPVKRQTK+xdzLJfjrQO2ALVHD1TvZrubf2DFl+XUMdg
         hsl75wA97G4+U7Q+SHee/OX/HosyDtg6xPHIWTGRc8GE9EyAx1pldJqD5rgstLJHH04f
         aJTESANwNBcWXF3bwtQa/B8PqxEnMIJQ2dT9V/FSazmxksw3ZZd/7SiDXge6uIRPhU8E
         3dI7zFgT1Az0VhQ7WRhwGqIn+qA83JmagGZ7uxgpPMbKMe220ctG3DAC+VL1xroWUNoK
         NnOQZGgpDc2EgAU5KpOxjWeIvKpOZ0wlX1OH9zAs6nanJ/K367kOU33BCyFYiDwtcK7v
         KzfA==
X-Gm-Message-State: AOAM531rfSGOq3PsPhGfd8v7bHAz97+p5Zd3bxnRlwho+IGjs5LWx7QJ
        kwdCnxo3PjmtV1/mhuLDKJwvM4POtfYKZ8k00vVfrg==
X-Google-Smtp-Source: ABdhPJwjEBEJE7QwHh8r8eJ/Dr/QpuyVP5uaIDwltg3aDAOCe0B4f3/m8hgpvfE9jUit9zlrGz89Vmb3ppScDtAYkS0=
X-Received: by 2002:adf:cf0b:: with SMTP id o11mr6715761wrj.162.1605319033090;
 Fri, 13 Nov 2020 17:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com> <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
In-Reply-To: <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 13 Nov 2020 17:57:02 -0800
Message-ID: <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 13, 2020 at 5:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 13 Nov 2020 17:09:37 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > > > Seems to me that the ability to reap another process's memory is a
> > > > > generally useful one, and that it should not be tied to delivering a
> > > > > signal in this fashion.
> > > > >
> > > > > And we do have the new process_madvise(MADV_PAGEOUT).  It may need a
> > > > > few changes and tweaks, but can't that be used to solve this problem?
> > > >
> > > > Thank you for the feedback, Andrew. process_madvise(MADV_DONTNEED) was
> > > > one of the options recently discussed in
> > > > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > > > . The thread describes some of the issues with that approach but if we
> > > > limit it to processes with pending SIGKILL only then I think that
> > > > would be doable.
> > >
> > > Why would it be necessary to read /proc/pid/maps?  I'd have thought
> > > that a starting effort would be
> > >
> > >         madvise((void *)0, (void *)-1, MADV_PAGEOUT)
> > >
> > > (after translation into process_madvise() speak).  Which is equivalent
> > > to the proposed process_madvise(MADV_DONTNEED_MM)?
> >
> > Yep, this is very similar to option #3 in
> > https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com
> > and I actually have a tested prototype for that.
>
> Why is the `vector=NULL' needed?  Can't `vector' point at a single iovec
> which spans the whole address range?

That would be the option #4 from the same discussion and the issues
noted there are "process_madvise return value can't handle such a
large number of bytes and there is MAX_RW_COUNT limit on max number of
bytes one process_madvise call can handle". In my prototype I have a
special handling for such "bulk operation" to work around the
MAX_RW_COUNT limitation.

>
> > If that's the
> > preferred method then I can post it quite quickly.
>
> I assume you've tested that prototype.  How did its usefulness compare
> with this SIGKILL-based approach?

Just to make sure I understand correctly your question, you are asking
about performance comparison of:

// approach in this RFC
pidfd_send_signal(SIGKILL, SYNC_REAP_MM)

vs

// option #4 in the previous RFC
kill(SIGKILL); process_madvise(vector=NULL, MADV_DONTNEED);

If so, I have results for the current RFC approach but the previous
approach was testing on an older device, so don't have
apples-to-apples comparison results at the moment. I can collect the
data for fair comparison if desired, however I don't expect a
noticeable performance difference since they both do pretty much the
same thing (even on different devices my results are quite close). I
think it's more a question of which API would be more appropriate.

>
