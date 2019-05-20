Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1023BB4
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbfETPI6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 11:08:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39095 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732596AbfETPI5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 May 2019 11:08:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so13010510wmk.4
        for <linux-api@vger.kernel.org>; Mon, 20 May 2019 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9y3c6/pdf3tbErI0Do1diigP58TG78CE1J0hIezm6I=;
        b=je0V+f8q316pSmPHnXBh0zlNCIMMIf0OTbOsKzKgqpiT5HJoGx7mgp0OmmrbCA6ypD
         T+8lsnJPKUBVQTt2YUj4Hjldoscaw/3gfqWtUsK/glWrq5k2hsbzgoAW58zf0vxCqogH
         GOdrfDuW/v5LxD5eTjNRHz5sknGLMr+DWSpm8/Fy7P5AsMxnI53jQ8fTyN5GuUIlLR9Z
         S0up4Y3meHZxSb07WX1pbkLBgwWdNf3po14WBinDKeARTl6purwLBpNsNE3KYHuS+6c8
         zfd6w/dQFy7+34oXkA4FVEGxYMhLqFuhoC9SyGvSo65ZV86AJ746EGnz1oC6vjAbDD+i
         QqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9y3c6/pdf3tbErI0Do1diigP58TG78CE1J0hIezm6I=;
        b=tm52c0OKYVLP/05uBGDV4iXyJZ7u7BTdf0m1wFqBf++7oSUPRmmMM6ZMx+LZvKv/nT
         hQ8+OzdJX87mS6/9eRKDzJhV9aVUnaQ1v8QUkjpL9AoWD3bsS8Q3vfOchAjavEF2bTko
         vjMoJGR1W1AnShHSojQ7XVxfdGyQ9C2UmclY5Dq/AkeX5xMG7aUn3uKTIzwuWTh3T4JZ
         YoJJLMOXW41PrPSFBILrmY8PUKOI+Pns+zYvvQZn6Dq18XYd7QeebVfz2CyeB9JqOFRq
         7cRLjMeoTTcIUhtAm3tPrGfoymMaL9w8IbKLWCtfesil8syEy7uU8gptad7j8RHyLzoq
         mZTA==
X-Gm-Message-State: APjAAAUNnI1Dr64SBo290jvRv1eDb2gukGgyV/fGCYBXpv+ajnXwXsxw
        qzKumRgdYuR/ryftHETdrRtxoNI0rNhA+wMDhajs3w==
X-Google-Smtp-Source: APXvYqwTvkGu1GK/0tSXG4iFUHM6unRNHVZf1lF2nENMPjqEy8F0XxkWnj/B1GwuSNTjbSbtEZH2Wip0AFBPNQmrDik=
X-Received: by 2002:a1c:dcc2:: with SMTP id t185mr11431100wmg.143.1558364935763;
 Mon, 20 May 2019 08:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190520035254.57579-2-minchan@kernel.org>
 <20190520081621.GV6836@dhcp22.suse.cz> <20190520081943.GW6836@dhcp22.suse.cz>
In-Reply-To: <20190520081943.GW6836@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 20 May 2019 08:08:45 -0700
Message-ID: <CAJuCfpE60ZOcpFfE6MpF0PBujK9sfeRjbkhUa243Bo9QmOoARg@mail.gmail.com>
Subject: Re: [RFC 1/7] mm: introduce MADV_COOL
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 1:19 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 20-05-19 10:16:21, Michal Hocko wrote:
> > [CC linux-api]
> >
> > On Mon 20-05-19 12:52:48, Minchan Kim wrote:
> > > When a process expects no accesses to a certain memory range
> > > it could hint kernel that the pages can be reclaimed
> > > when memory pressure happens but data should be preserved
> > > for future use.  This could reduce workingset eviction so it
> > > ends up increasing performance.
> > >
> > > This patch introduces the new MADV_COOL hint to madvise(2)
> > > syscall. MADV_COOL can be used by a process to mark a memory range
> > > as not expected to be used in the near future. The hint can help
> > > kernel in deciding which pages to evict early during memory
> > > pressure.
> >
> > I do not want to start naming fight but MADV_COOL sounds a bit
> > misleading. Everybody thinks his pages are cool ;). Probably MADV_COLD
> > or MADV_DONTNEED_PRESERVE.
>
> OK, I can see that you have used MADV_COLD for a different mode.
> So this one is effectively a non destructive MADV_FREE alternative
> so MADV_FREE_PRESERVE would sound like a good fit. Your MADV_COLD
> in other patch would then be MADV_DONTNEED_PRESERVE. Right?
>

I agree that naming them this way would be more in-line with the
existing API. Another good option IMO could be MADV_RECLAIM_NOW /
MADV_RECLAIM_LAZY which might explain a bit better what they do but
Michal's proposal is more consistent with the current API.

> --
> Michal Hocko
> SUSE Labs
