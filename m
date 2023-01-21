Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499C2676384
	for <lists+linux-api@lfdr.de>; Sat, 21 Jan 2023 04:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjAUDor (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Jan 2023 22:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAUDom (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Jan 2023 22:44:42 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543D4F378
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 19:44:32 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id q125so7770373vsb.0
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 19:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i+Q3NrGpoV7GTe996deDPMHtEIxVtagrWegu0XOvq8M=;
        b=jEb/UjRtJOQEVO6iBKcBXyG0PWPILL+xdZ3LKRQ2jB3uds9nER53CGZQfJaUQkxWN6
         yX9UuASVggOc2lP63XLBQUd/UY/vUJnhwewKj6Y7ZcSubrEa1HRpr89WQ6bqXnmocE4T
         QTxkhXGduOWPtALVkfMhiWeR5rPQMFvNCdQuRK4UUfp6wDnd/DzWeh9T5GYflZriMsn2
         vJ2CuUeQtFFccnST5Cg2wpTgwiSoCHUWm5x+sUd0/utPop/U75nGh+X5JunMPs0Ze2Ic
         /eXCdyRgSCh001lPMZBaOEIPTtaiVUikm2YAebgsGtSUmTSl20ZiZEhzOlOPzpM6imzG
         i3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+Q3NrGpoV7GTe996deDPMHtEIxVtagrWegu0XOvq8M=;
        b=fGY5OmWBMIml7X9FgCJlspeT/cvhv1g3AeNWMtbNkqEJtTBrObcuQYXeYUy8BKjp2r
         hrTLxpVLymu5ff8Mz91gHF7CpCIWtk9PqXhr+4ODjRJfSe29L6J7n+dN9YZS+3/LasIJ
         Rtu+cknhD3s9blpJgoLF5aC0OlF4PAJzQFl4TTWEMe2si5wLzlE91E/QnLaNxUS8X66P
         YPxMCNYL5mhwPDHr40gNPNvQM9kyc3VcmW0tVBySxNxoCVjonUhT0g65bRKMpsNBgJ4Z
         mCpbmYDmf2/o6ZQl2SwCJeXxdBkaeXhIYCD6P4TfpLR6OB+QhqgQ2r35SkmG9IymM+Jp
         zTEw==
X-Gm-Message-State: AFqh2koM8MDJ8vfLNOQOrFjZ40ZZSkLiRdHPZcpWD5P17t7MaG7IYret
        nOlMoETAdVZNTuNC+Ky52PNY1obtmdpkVDidMSclTQ==
X-Google-Smtp-Source: AMrXdXtvPZMjN5JFsFrMAa4NboPBAbiuJwVDzcdTGkr/+iM1QBYFkb6OdCvT312SR9yaXrnhP1PcsBitL6RSTT9L0XM=
X-Received: by 2002:a67:c387:0:b0:3d2:3577:2d05 with SMTP id
 s7-20020a67c387000000b003d235772d05mr2208218vsj.9.1674272671893; Fri, 20 Jan
 2023 19:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20230117195959.29768-1-nphamcs@gmail.com> <20230117195959.29768-2-nphamcs@gmail.com>
 <Y8qmaqpAFko+gI3h@bfoster> <Y8rA4C6qnT5InHGc@cmpxchg.org>
In-Reply-To: <Y8rA4C6qnT5InHGc@cmpxchg.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 20 Jan 2023 20:43:55 -0700
Message-ID: <CAOUHufYYMDxHPFEAKaXbvse8bjSVJp51hmHBG+3u9mTTstjFow@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] workingset: refactor LRU refault to expose refault
 recency check
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Brian Foster <bfoster@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-api@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 20, 2023 at 9:26 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Jan 20, 2023 at 09:34:18AM -0500, Brian Foster wrote:
> > On Tue, Jan 17, 2023 at 11:59:57AM -0800, Nhat Pham wrote:
> > > +   int memcgid;
> > > +   struct pglist_data *pgdat;
> > > +   unsigned long token;
> > > +
> > > +   unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
> > > +   eviction_memcg = mem_cgroup_from_id(memcgid);
> > > +
> > > +   lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> > > +   lrugen = &lruvec->lrugen;
> > > +
> > > +   min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > +   return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> >
> > I think this might be more readable without the double negative.
> >
> > Also it looks like this logic is pulled from lru_gen_refault(). Any
> > reason the caller isn't refactored to use this helper, similar to how
> > workingset_refault() is modified? It seems like a potential landmine to
> > duplicate the logic here for cachestat purposes and somewhere else for
> > actual workingset management.
>
> The initial version was refactored. Yu explicitly requested it be
> duplicated [1] to cut down on some boiler plate.
>
> I have to agree with Brian on this one, though. The factored version
> is better for maintenance than duplicating the core logic here. Even
> if it ends up a bit more boiler plate - it's harder to screw that up,
> and easier to catch at compile time, than the duplicates diverging.
>
> [1] https://lore.kernel.org/lkml/CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com/

No objections to either way. I'll take a look at the final version and
we are good as long as it works as intended.
