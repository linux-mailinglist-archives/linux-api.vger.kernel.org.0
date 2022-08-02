Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00EC5882BB
	for <lists+linux-api@lfdr.de>; Tue,  2 Aug 2022 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiHBTn0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 2 Aug 2022 15:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBTn0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 2 Aug 2022 15:43:26 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1894645F5E
        for <linux-api@vger.kernel.org>; Tue,  2 Aug 2022 12:43:25 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10ee900cce0so6423392fac.5
        for <linux-api@vger.kernel.org>; Tue, 02 Aug 2022 12:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZujhYrVvvAmnwjraE3ShnaLiZzxSjfKysRrz6y6PpA=;
        b=ZSPJfxkVJtHKhnn6H5pieCDozzVCYNcABXzvLcAE9csfr57RgROVrF3BA/baeJeZZ/
         oQXwTvhG/F7lfTn4I0219O547Ud2OtEn5f+sTcNPJ0ItaauVo/leAMOHy2tUIcw4WaTe
         rka8BSFHq09cVAj/UQPnh+BDtMko299AVBX3Wg1ZiiWF2lOXvBZZdFdFuBphXz9WrG29
         v2FHor9/kYhbWK43j72XraVMG9RBiUm/zfBPBZC2tZG0PAmiwlbxo635QWX0HrXlNW9E
         IcxI6Dpti0lOmDOhpH8G9cZNNlwkH99gV7diguECiQNNQjWSJ+atsznDNssY9kUHn0qa
         fRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZujhYrVvvAmnwjraE3ShnaLiZzxSjfKysRrz6y6PpA=;
        b=01AIvgyQwj+z2yL4ha4idwPdegR2GplXbchJXGk2Dnva7bJ9T+4mA0pvpdu0VS+JEQ
         mVF7rMW10H0x/8ruNzUo7Rt1N7RhWIGMQwBRUB0tkp7+Cg2zwwdyaFLqmIyUENUC2Uof
         MyZzXkn2t+1XjCwkJ+IWwCx5JOWyYwWrJhKZ0ZbNXyQTf+5Supex2GMrfsrNYu6hVjuO
         no+ALJejAv7Fam55dK7lTl0NO0OydzCxVPPy34sXh4AC9qet+cRE1gpVl5fLyjMTo8Z/
         +3kcLcOl3MSnKw0LCCTpzXMRy3ypC9rYTuRnBB6G5z1tXU9QubTomUS1iPgNAly2GuOr
         JmuA==
X-Gm-Message-State: ACgBeo3leL74amrYNZKINX4AP+FUL7QrkrI3y0+AsMttDl7Y8GKBaPxN
        pscTzC1I/xDl/es1dedrRkJL+h7xqsIbYWYZ5iRcHg==
X-Google-Smtp-Source: AA6agR7yMFNZuea36Auv9bhp/MY6EQ4zBLvwrr6zBdwaahXs41PVfFBBbnF9DeonuwCyq/+nSdm9TBmXBeQiZbplKk4=
X-Received: by 2002:a05:6870:a91d:b0:10c:55e:3f64 with SMTP id
 eq29-20020a056870a91d00b0010c055e3f64mr426579oab.123.1659469404221; Tue, 02
 Aug 2022 12:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220801210946.3069083-1-zokeefe@google.com> <YujpzGKImMQsn8SM@dhcp22.suse.cz>
 <CAAa6QmS=VbsdvHgvFQCceV+pYHwSSj1pjhX3_voz12T4rJ-EBQ@mail.gmail.com> <YukSvpPRuus2bHOu@dhcp22.suse.cz>
In-Reply-To: <YukSvpPRuus2bHOu@dhcp22.suse.cz>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Tue, 2 Aug 2022 12:42:48 -0700
Message-ID: <CAAa6QmS2aAtJyWPFi1to99o=vHWFmiQRW72+3HdZ-4qGk2FT5Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement
 for process_madvise(MADV_COLLAPSE)
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Aug 2, 2022 at 5:04 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 02-08-22 02:48:33, Zach O'Keefe wrote:
> [...]
> > "mm/madvise: add MADV_COLLAPSE to process_madvise()" in the v7 series
> > ended with me mentioning a couple options, but ultimately I didn't
> > present a solution, and no consensus was reached[1]. After taking a
> > closer look, this is my proposal for what I believe to be the best
> > path forward. It should be squashed into the original patch. What do you think?
>
> If it is agreed that the CAP_SYS_ADMIN is too strict of a requirement
> then yes, this should be squashed into the original patch. There is no
> real reason to create a potential bisection headache by changing the
> permission model in a later patch.

Sorry about the confusion here. Assumed (incorrectly) that Andrew
would kindly squash this in mm-unstable since I added the Fixes: tag.
Next time I'll add some explicit verbiage saying it should be
squashed.

> From my POV, I would agree that CAP_SYS_ADMIN is just too strict of a
> requirement.
>
> I didn't really have time to follow recent discussions but I would argue
> that the operation is not really destructive or seriously harmful. All
> applications can already have their memory (almost) equally THP
> collapsed by khupaged with the proposed process_madvise semantic.
>
> NOHUGEMEM and prctl opt out from THP are both honored AFAIU and the only
> difference is the global THP killswitch behavior which I do not think
> warrants the strongest CAP_SYS_ADMIN capability (especially because it
> doesn't really control all kinds of THPs).

Ya. In fact, I don't think the ignoring the THP sysfs controls
warrants any additional capability (set alone CAPS_SYS_ADMIN), since a
malicious program can't really inflict any more damage than they would
with CAP_SYS_NICE and PTRACE_MODE_READ.

> If there is a userspace agent collapsing memory and causing problems
> then it can be easily fixed in the userspace. And I find that easier
> to do than putting the bar so high that userspace agents would be
> unfeasible because of CAP_SYS_ADMIN (which is nono in many cases as it
> would allow essentially full control of other stuff). So from practical
> POV, risking an extended RSS is really a negligible risk to lose a
> potentially useful feature for all others.
>

Agreed.

Thanks for taking the time, Michal!
Zach


> Just my 2c
>
> > Thanks again,
> > Zach
> >
> > [1] https://lore.kernel.org/linux-mm/Ys4aTRqWIbjNs1mI@google.com/
>
> --
> Michal Hocko
> SUSE Labs
