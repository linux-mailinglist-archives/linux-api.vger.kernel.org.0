Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 931E53115F
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaPco (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 11:32:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35259 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaPcn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 11:32:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so3292989wml.0
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGL6EqRvLB+NZa/jkmcp3go/mVh1h/1Q1GkUa9Q/sF4=;
        b=YeiseFldSN/5+crIbCEpQiudtO1RaplBzltFA4ASnVlWCmQ5W16mI5EqqeFw1Z3UKg
         chuiyCFEKBLndFf+WsXRKqU5M0jaPWk+Qo8tUXLgtYCXxT6pOezcfWx43g+SkwyNxlGp
         uMij9JgqtyU8jbzy5Mip8p9o83a0ss3Q2QaQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGL6EqRvLB+NZa/jkmcp3go/mVh1h/1Q1GkUa9Q/sF4=;
        b=lcBok2TztWQ0ag++hU3UeY2IraamCqN5s6xN18xiWAR5sB8rRefJGwa4Kx8AhWwxaQ
         yCRexGEzPYyEA6IX6xHP90YBbfMMLslEsq86YXDgWeTjmqg6HaKZU+eqPOkk7p+HE9Ff
         cV9MRpn3/iq3hpHV8RYlrpScY1Uxc3/ejQlrDmHm1v3aXCKziPrDyEU/TDdD/aVyPyA5
         qTxZu7CzXcGw7Zkb4cF42Y6pHr5bO5Ho8wzfZVqa0/WwfUuBE1ZZda/YoTcsdh9tFYbK
         9shkNze9S1fzUOrUmA/7d/MRmCSc31xXi3s063+agfF2C3pnhBaMpUmeLyojBWAT2uNS
         pJOw==
X-Gm-Message-State: APjAAAUl66Olr0VYgM1MjrPWcC1TKlnHKFroKzs7bz5C93mz6ADrgIEm
        LAyYHGknHdncROtQKIMJn5kEyv2V56jXp98alJHw9w==
X-Google-Smtp-Source: APXvYqyNRxhqo4AWL/lfKd/hj4rWl6fa+Jp4jN534MW6jCEZuWtdLzqLwGQqfEj5trBIQEyKlzPo6lqzNySqrOsiRrk=
X-Received: by 2002:a1c:ed07:: with SMTP id l7mr5803517wmh.148.1559316760517;
 Fri, 31 May 2019 08:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190531002633.128370-1-semenzato@chromium.org>
 <20190531060401.GA7386@dhcp22.suse.cz> <20190531062206.GD6896@dhcp22.suse.cz> <20190531062318.GE6896@dhcp22.suse.cz>
In-Reply-To: <20190531062318.GE6896@dhcp22.suse.cz>
From:   Luigi Semenzato <semenzato@chromium.org>
Date:   Fri, 31 May 2019 08:32:27 -0700
Message-ID: <CAA25o9TQYDCdLj-qGkwwNGDGSthX2yAtnqNWDkx-4WEe5TGxGQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: smaps: split PSS into components
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Yu Zhao <yuzhao@chromium.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 30, 2019 at 11:23 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 31-05-19 08:22:06, Michal Hocko wrote:
> > On Fri 31-05-19 08:04:01, Michal Hocko wrote:
> > > [Please always Cc linux-api mailing list (now added) when adding a new
> > > user visible API. Keeping the rest of the email intact for reference]
> > >
> > > On Thu 30-05-19 17:26:33, semenzato@chromium.org wrote:
> > > > From: Luigi Semenzato <semenzato@chromium.org>
> > > >
> > > > Report separate components (anon, file, and shmem)
> > > > for PSS in smaps_rollup.
> > > >
> > > > This helps understand and tune the memory manager behavior
> > > > in consumer devices, particularly mobile devices.  Many of
> > > > them (e.g. chromebooks and Android-based devices) use zram
> > > > for anon memory, and perform disk reads for discarded file
> > > > pages.  The difference in latency is large (e.g. reading
> > > > a single page from SSD is 30 times slower than decompressing
> > > > a zram page on one popular device), thus it is useful to know
> > > > how much of the PSS is anon vs. file.
> >
> > Could you describe how exactly are those new counters going to be used?

Yes.  We wish to gather stats of memory usage by groups of processes
on chromebooks: various types of chrome processes, android processes
(for ARC++, i.e. android running on Chrome OS), VMs, daemons etc.  See

https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/master/metrics/pgmem.cc

and related files. The stats help us tune the memory manager better in
different scenarios.  Without this patch we only have a global
proportional RSS, but splitting into components help us deal with
situations such as a varying ratio of file vs. anon pages, which can
result, for instance, by starting/stopping android.  (In theory the
"swappiness" tunable should help with that, but it doesn't seem
effective under extreme pressure, which is unfortunately rather common
on these consumer devices).

On older kernels, which we have to support for several years, we've
added an equivalent "totmaps" locally and we'd be super-happy if going
forward we can just switch to smaps_rollup.

> > I do not expect this to add a visible penalty to users who are not going
> > to use the counter but have you tried to measure that?

Right, if smaps or smaps_rollup is not used, this cannot have a
measurable impact (maybe more code->more TLB misses, but that's at
most tiny), so no, I haven't tried to measure that.

I have been measuring the cost of smaps_rollup for all processes in a
chromebook under load (about 400 processes) but those measurements are
too noisy to show change.

The code is shared between smaps and smaps_rollup, and some of the
results aren't used in smaps, only in smaps_rollup, so there's some
waste (a couple of extra conditional branches, and loads/stores), but
again I didn't think that reducing it is worth the trouble in terms of
code complexity.

> Also forgot to mention that any change to smaps should be documented in
> Documentation/filesystems/proc.txt.

Thank you, I'll fix that and send a v3 (and Cc linux-api).


> --
> Michal Hocko
> SUSE Labs
