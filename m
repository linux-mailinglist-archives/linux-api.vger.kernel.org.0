Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2E2B8532
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 20:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKRT6e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 14:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgKRT6d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 14:58:33 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E851C0613D4
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:58:33 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so3382370wrc.8
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 11:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0R930kNYjqnavMF/KBPQVusHU1NjslAYSOCWdpyJ04=;
        b=HSfuIYzTTaTm27qs+m3sYY0AB2lkoYN+yZmn3aYs/SNgCxiRCa8OfVemFUCsnEfJ3G
         gzmGaAY1Ah9ppsUIaq4UB+yFR7OcgT2UqbZ1FJHHctPpLw/vwXfQKVpk41362nHk/dfz
         Z2inWgK+Vb//4DMknD0TXOgo6bnJLZ+CmZHPvRGtBsDo2n0XBnbSMmA4KSibgFIHhHdQ
         sYk7dJUIDCmgjS90IMCXUeJDtlaCSip6BaPk9ff6ITwi0frdDNddUBgnS5FfQEOOAMHU
         iEQ2hQQ+2Qc1ID3BKdIYTQviazP6xZH7WLAVkqSW3b0UlgFI3i3MZdzdCyYRo7DUziX7
         /Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0R930kNYjqnavMF/KBPQVusHU1NjslAYSOCWdpyJ04=;
        b=fRZd2zo2/BS/chqtFYKzMVBAuS6pVJL0akcIa2QhWjT0b6opsALAbLd+8aLWn+vXPK
         4sxxg3xmCLAniIUNX7uqZWW9QNUNpcIbjDQDP3a7WI9hAeOURTsoSsbgXMijmMDbi6qk
         BiJMlvBQw0buO/aioq37hbtK9hdIdAWegs24+iVsD5LQRlQrM6SOGfSgNUJG1JO5HvdK
         EiSbEmT6HnurzBjowZg2aeqr8RVFDyQiGXnYhVXRf3QHifoYyrqe+h08fxC4tD5SwvZq
         bFsvSE7ic0vKBzIs/cBpg3I0/10wxOCWRS8ltgrxGRqlQ6s/xA1f3gkKW8877qNKYd5x
         ELvQ==
X-Gm-Message-State: AOAM530pFJOQzAxR/3xf8GMOYFAMp41hb2DbGikg0QHnDG/gUUoEkkVJ
        GkG3DiVgrcRGXxoufVuODa/GY/4cBeWkrdYAy3mX+lD853wrBw==
X-Google-Smtp-Source: ABdhPJwN1+sRNrKHv4pWi7GszYiUiM0BqmVDZTAlh1f1JsdOfBzXgX31DLoX4X6KxSYKVFVZx4YHKaRz4n08K+i0vM0=
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr6536380wrs.106.1605729100247;
 Wed, 18 Nov 2020 11:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20201113173448.1863419-1-surenb@google.com> <20201113155539.64e0af5b60ad3145b018ab0d@linux-foundation.org>
 <CAJuCfpGJkEUqUWmo_7ms66ZqwHfy+OGsEhzgph+a4QfOWQ32Yw@mail.gmail.com>
 <20201113170032.7aa56ea273c900f97e6ccbdc@linux-foundation.org>
 <CAJuCfpHS3hZi-E=JCp257u0AG+RoMAG4kLa3NQydONGfp9oXQQ@mail.gmail.com>
 <20201113171810.bebf66608b145cced85bf54c@linux-foundation.org>
 <CAJuCfpH-Qjm5uqfaUcfk0QV2zC76uL96FQjd88bZGBvCuXE_aA@mail.gmail.com>
 <20201113181632.6d98489465430a987c96568d@linux-foundation.org>
 <20201118154334.GT12284@dhcp22.suse.cz> <CAJuCfpGC1Kv2rC7oq-TT2dX1soy5J_R+y6DU8xEzVuJgOqHKAw@mail.gmail.com>
 <20201118193233.GV12284@dhcp22.suse.cz>
In-Reply-To: <20201118193233.GV12284@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 18 Nov 2020 11:51:29 -0800
Message-ID: <CAJuCfpGucpqxOzGhteFrtv-0HrSbAmZjLbA2=NCy-5UEx04mJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] RFC: add pidfd_send_signal flag to reclaim mm while
 killing a process
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Nov 18, 2020 at 11:32 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 18-11-20 11:22:21, Suren Baghdasaryan wrote:
> > On Wed, Nov 18, 2020 at 11:10 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 13-11-20 18:16:32, Andrew Morton wrote:
> > > [...]
> > > > It's all sounding a bit painful (but not *too* painful).  But to
> > > > reiterate, I do think that adding the ability for a process to shoot
> > > > down a large amount of another process's memory is a lot more generally
> > > > useful than tying it to SIGKILL, agree?
> > >
> > > I am not sure TBH. Is there any reasonable usecase where uncoordinated
> > > memory tear down is OK and a target process which is able to see the
> > > unmapped memory?
> >
> > I think uncoordinated memory tear down is a special case which makes
> > sense only when the target process is being killed (and we can enforce
> > that by allowing MADV_DONTNEED to be used only if the target process
> > has pending SIGKILL).
>
> That would be safe but then I am wondering whether it makes sense to
> implement as a madvise call. It is quite strange to expect somebody call
> a syscall on a killed process. But this is more a detail. I am not a
> great fan of a more generic MADV_DONTNEED on a remote process. This is
> just too dangerous IMHO.

Agree 100%

>
> > However, the ability to apply other flavors of
> > process_madvise() to large memory areas spanning multiple VMAs can be
> > useful in more cases.
>
> Yes I do agree with that. The error reporting would be more tricky but
> I am not really sure that the exact reporting is really necessary for
> advice like interface.

Andrew's suggestion for this special mode to change return semantics
to the usual "0 or error code" seems to me like the most reasonable
way to deal with the return value limitation.

>
> > For example in Android we will use
> > process_madvise(MADV_PAGEOUT) to "shrink" an inactive background
> > process.
>
> That makes sense to me.
> --
> Michal Hocko
> SUSE Labs
