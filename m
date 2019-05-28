Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344982C950
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 16:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE1O4N (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 10:56:13 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46963 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1O4N (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 10:56:13 -0400
Received: by mail-yw1-f65.google.com with SMTP id x144so3872058ywd.13
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 07:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jTlIgeBI8R5oN3O3HQ99I++T6jlNEV+UFbvjja9ZAd4=;
        b=Dd/Xr8jAObDU6D9ZyHopPb9p2XU0aQy+5Dp2qCVlY5+K+u8uFPGUTNWtUA4uZvV1rC
         16K+8dmbWHg7ykKlo9+yfIW53zK9R59RzBfnjrrMrCAeaTsu713KYjTk26zl/L6/IFmO
         i2+Enq9iPO+4cZgVEPtNB1nLDfJHsnmfvUL4X2Ln3s03Mg2VuVxTixykG3PrRLA8VW/k
         QO996765hLFUmCg7+/LeKPJfMaUWpbaA+ZORbgDbpJevZEoYtO/cCP1ihhFOaidAU+LY
         F5iWtIC5dwHah+OTNRTs7i3EU+loD5SpSbSsBYl5Vr5rRpNnoh06+ecieHQO7YBc7rtA
         zZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jTlIgeBI8R5oN3O3HQ99I++T6jlNEV+UFbvjja9ZAd4=;
        b=jk12ZlAESoEifdSWT75BmTPxZEXxXN/Khbx4JQE9QCluSsaSsr8PFLszxuL+T75vU+
         2mk2upEEGsAgyzHPzSqX9LYF92ePFTI+Jg+igFJxFcHBi9EkncpMdW62pnYmbvSyizn/
         OQQ4ydPaqbLCCQNbLc9FHfjPZ25+Oem7kYCPo27gPGs+OV0VmGPVETf+kxG2XAf2t0sQ
         skOJX2vK8b9lsYfy+tL+HxF8iM/tKjisM9/4hwuwPo7yRt1hGSXVObJlOsZstSHjEQsP
         1vbKCrv5hec4CFbJO9gJTja2SnhPE4VAF0bIGCuigDM+GivB+BGsL1chQOnjl3Wi28+r
         3N9A==
X-Gm-Message-State: APjAAAVlU1+aPVJgrrugqjkInUHLxkntTaczXnuKGd+sww5Oaa1CPQAg
        0uV4AiDoJ4mY+oxIFdfk3aQ4PznqgEPs2KKV5uUI+Q==
X-Google-Smtp-Source: APXvYqw3Axo/+z3owEKgLL2LzIbxvY7WvXKmqyzQBHebVf3TKOElb4jbYm35ijLdq40mUgqSmfZZvLmPzTWeBVUYSJ4=
X-Received: by 2002:a81:5ec3:: with SMTP id s186mr61920764ywb.308.1559055372056;
 Tue, 28 May 2019 07:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <155895155861.2824.318013775811596173.stgit@buzz>
 <20190527141223.GD1658@dhcp22.suse.cz> <20190527142156.GE1658@dhcp22.suse.cz>
 <20190527143926.GF1658@dhcp22.suse.cz> <9c55a343-2a91-46c6-166d-41b94bf5e9c8@yandex-team.ru>
 <20190528065153.GB1803@dhcp22.suse.cz> <a4e5eeb8-3560-d4b4-08a0-8a22c677c0f7@yandex-team.ru>
 <20190528073835.GP1658@dhcp22.suse.cz> <5af1ba69-61d1-1472-4aa3-20beb4ae44ae@yandex-team.ru>
 <20190528084243.GT1658@dhcp22.suse.cz>
In-Reply-To: <20190528084243.GT1658@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 May 2019 07:56:00 -0700
Message-ID: <CALvZod4fZeQiARaMrw8eaw=9Tynb4x4quZx13nen22EwoC5epQ@mail.gmail.com>
Subject: Re: [PATCH RFC] mm/madvise: implement MADV_STOCKPILE (kswapd from
 user space)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 1:42 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 28-05-19 11:04:46, Konstantin Khlebnikov wrote:
> > On 28.05.2019 10:38, Michal Hocko wrote:
> [...]
> > > Could you define the exact semantic? Ideally something for the manual
> > > page please?
> > >
> >
> > Like kswapd which works with thresholds of free memory this one reclaims
> > until 'free' (i.e. memory which could be allocated without invoking
> > direct recliam of any kind) is lower than passed 'size' argument.
>
> s@lower@higher@ I guess
>
> > Thus right after madvise(NULL, size, MADV_STOCKPILE) 'size' bytes
> > could be allocated in this memory cgroup without extra latency from
> > reclaimer if there is no other memory consumers.
> >
> > Reclaimed memory is simply put into free lists in common buddy allocator,
> > there is no reserves for particular task or cgroup.
> >
> > If overall memory allocation rate is smooth without rough spikes then
> > calling MADV_STOCKPILE in loop periodically provides enough room for
> > allocations and eliminates direct reclaim from all other tasks.
> > As a result this eliminates unpredictable delays caused by
> > direct reclaim in random places.
>
> OK, this makes it more clear to me. Thanks for the clarification!
> I have clearly misunderstood and misinterpreted target as the reclaim
> target rather than free memory target.  Sorry about the confusion.
> I sill think that this looks like an abuse of the madvise but if there
> is a wider consensus this is acceptable I will not stand in the way.
>
>

I agree with Michal that madvise does not seem like a right API for
this use-case, a 'proactive reclaim'.

This is conflating memcg and global proactive reclaim. There are
use-cases which would prefer to have centralized control on the system
wide proactive reclaim because system level memory overcommit is
controlled by the admin. Decoupling global and per-memcg proactive
reclaim will allow mechanism to implement both use-cases (yours and
this one).

The madvise() is requiring that the proactive reclaim process should
be in the target memcg.  I think a memcg interface instead of madvise
is better as it will allow the job owner to control cpu resources of
the proactive reclaim. With madvise, the proactive reclaim has to
share cpu with the target sub-task of the job (or do some tricks with
the hierarchy).

The current implementation is polling-based. I think a reactive
approach based on some watermarks would be better. Polling may be fine
for servers but for power restricted devices, reactive approach is
preferable.

The current implementation is bypassing PSI for global reclaim.
However I am not sure how should PSI interact with proactive reclaim
in general.

thanks,
Shakeel
