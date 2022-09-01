Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387CB5A89C9
	for <lists+linux-api@lfdr.de>; Thu,  1 Sep 2022 02:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiIAAZK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Aug 2022 20:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIAAZC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Aug 2022 20:25:02 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D161CB3B
        for <linux-api@vger.kernel.org>; Wed, 31 Aug 2022 17:25:01 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11f4e634072so13815233fac.13
        for <linux-api@vger.kernel.org>; Wed, 31 Aug 2022 17:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nV+O9jf55oixM+6AGfx52F5v7MeqVDuOJA9SYJg4WI0=;
        b=BeTVkSvDa94jTy0w9blvas3UxsdD23eTLAMSH0WQ5szJgqhob34K0kSDX0sWBd+bUn
         UiR4EYth1l5lpP/1JjHV5Q7J49hcmHdsofCEG2xBLOUxngiOMWmdhzLbshmyLttu+C1f
         /LJ8PORku5+VSpW6JfV0//6c8HJNcPDuJfcvDol6nvuXyMKYKvjvLiVcLfFWc3IghuYX
         ETLUDUYbVO4s1Zz5SjzvjDF91gKrYmu0WLtIxzexAp2pVRcbbkI/4MUwga4IngYJoFwq
         DrSUAHKRx0jXhYo5hMU7m3Q5LUOgXhSlCmIraAnhiQIE9Wi7rldotrQm9Ud0FuTPNoTM
         8rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nV+O9jf55oixM+6AGfx52F5v7MeqVDuOJA9SYJg4WI0=;
        b=EeSAvB9sqjA4n0p8sQ+XrW6mtPaCYLhBpfDW3NwRNV5hBpUGwyBf8jBmKoZr0RtEhi
         wR8V7b0BxveD92m5obo9b08hFbawWZFqWS3bMcAJpsN9BqLtI15XNIXNndKrAz05SQXE
         UxPpmb8LnvUBSj7acbi2fTBvPeya5j6N1X3ZXz8sUZzTMTWum2e2g5kJRnkEJx5uwMii
         X5e6xVnWI1PHGTfjPsVj02uthY9bHtwiftNLb08/GIwbybdopJzgtjxsvTKEz5wm1bb2
         jG+eMWjb7PD0JROmrGcLDxLn6rCD7SvbscLWGaxQ6Kdmp81r5DCHSg4vdvz7wwuAC8BH
         JxPQ==
X-Gm-Message-State: ACgBeo33UwlgdAxkP1Qj1OcFa2sQiHn8zYpIfFLaCaJ1f1/g3nm/DqWY
        FwqJ+uMfe6CX7VhkJOzKZK6TAJu0lEMf2d39WwdLXA==
X-Google-Smtp-Source: AA6agR54WiMaGOvgjXog7NH6CW4M374JseRWiry+ajcvGi8z4jTTVXhvZVCP8VTCvpUfJNuQa6JGi11fIgUgawalm3M=
X-Received: by 2002:a05:6871:9c:b0:11d:ca1b:dca9 with SMTP id
 u28-20020a056871009c00b0011dca1bdca9mr2703689oaa.123.1661991899436; Wed, 31
 Aug 2022 17:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com> <CAHbLzkr4GP409ONt-ivPH14rd-doQ5CoSr5WR=P4Sfk44pXEjw@mail.gmail.com>
In-Reply-To: <CAHbLzkr4GP409ONt-ivPH14rd-doQ5CoSr5WR=P4Sfk44pXEjw@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 31 Aug 2022 17:24:23 -0700
Message-ID: <CAAa6QmRr4oxxVQP2PCh-pnaMJ19rmC3R83k=M5VXcQHkgKO5_A@mail.gmail.com>
Subject: Re:
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 31, 2022 at 2:47 PM Yang Shi <shy828301@gmail.com> wrote:
>
> Hi Zach,
>
> I did a quick look at the series, basically no show stopper to me. But
> I didn't find time to review them thoroughly yet, quite busy on
> something else. Just a heads up, I didn't mean to ignore you. I will
> review them when I find some time.
>
> Thanks,
> Yang

Hey Yang,

Thanks for taking the time to look through, and thanks for giving me a
heads up, and no rush!

In the last day or so, while porting this series around, I encountered
some subtle edge cases I wanted to clean up / address - so it's good
you didn't do a thorough review yet. I was *hoping* to have a v3 out
last night (which evidently did not happen) and it does not seem like
it will happen today, so I'll leave this message as a request for
reviewers to hold off on a thorough review until v3.

Thanks for your time as always,
Zach
