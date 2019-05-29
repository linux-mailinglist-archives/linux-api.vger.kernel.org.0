Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FF62DA05
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 12:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbfE2KIr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 06:08:47 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46888 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfE2KIp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 06:08:45 -0400
Received: by mail-vs1-f68.google.com with SMTP id l125so1316074vsl.13
        for <linux-api@vger.kernel.org>; Wed, 29 May 2019 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JqrLgxA4AciEivrwCOum3XhYhFc14FWOXrSGbHtn8l4=;
        b=XvJCcOWlfI2cAhepwsVATWYEeMXjuPGe36MHEYZY73iUGWkDtfiutI6POmJ9WBgnS5
         7Zc+MH34Bcng8GBK5pAcN4+/ymPXCE+cXwGYB27pb6fpcm7JJpWRObHmiVtzA72kO7Vt
         9+YOcI2Zw1oJR4UQfSqS3YY8SCLdrxar3eA2YXi5fviMqALw30QBbOqvt5re4j9bK06T
         MxXx7a5LVP5i0xbfny+YkspK2cwfOCnZBTAt3WnFtwFkd4xGRcuYSn0qZjjDGgjxXAFp
         q1ZvaHN3BjJcwWhnr0OVqYGhnNyVRVJJJjOo2VP9Y1mgoPIvFrPK79bYI9MyJL/gQWXB
         lB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JqrLgxA4AciEivrwCOum3XhYhFc14FWOXrSGbHtn8l4=;
        b=Z0nHmkBtQA9bQJxpi6hwMgdjAymG6buK9zOWq94Sg3SmAtZhSwKMv1H/XGJSSQ4ZYw
         XYGRgSLNo5a6IArUT4qlbr+BckksQwqjTQJytR1xiMb5mP9t1Hi9K25WTSZGg5NADIHo
         ay+D0PzDTXU1Ovfh68avfErSSdcYoJvAQndQmBHnXjLPqelRf8wwY9fpWJ3XXj/GIDeR
         AYX4ZNgZaGP3WGCodNQGu3k0BSzjecGbn02/kwa8f2wQXS6dWbFWAsSVCrp+YTcKmFfD
         AJmozuMsE+PmB5XqYQ/GYEVjNob8K2nZf0A8wylZ5S74yjCroFoMjCZksyhrYrD1x9Dj
         Kc5g==
X-Gm-Message-State: APjAAAUPnEgGKkGuwFzwWr4c7Qjcc6j2EmZ9Sq5gWdz1PJNgXo5W6pg6
        pc0+ISWTo98ThgTCMu9vKPBoyiUc4gYQwvL5/EWS4Q==
X-Google-Smtp-Source: APXvYqzSCE0z59kl4Upmp3wn1FWiwFbydqjXU+SBtt9efM9Z8jZQTMXLALdpKllyD+vumjd3lYW8613GvLhWpIBE3/g=
X-Received: by 2002:a67:e90f:: with SMTP id c15mr3517797vso.9.1559124523923;
 Wed, 29 May 2019 03:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190520035254.57579-7-minchan@kernel.org>
 <20190520092258.GZ6836@dhcp22.suse.cz> <20190521024820.GG10039@google.com>
 <20190521062421.GD32329@dhcp22.suse.cz> <20190521102613.GC219653@google.com>
 <20190521103726.GM32329@dhcp22.suse.cz> <20190527074940.GB6879@google.com>
In-Reply-To: <20190527074940.GB6879@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 29 May 2019 03:08:32 -0700
Message-ID: <CAKOZuesK-8zrm1zua4dzqh4TEMivsZKiccySMvfBjOyDkg-MEw@mail.gmail.com>
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector arrary
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 27, 2019 at 12:49 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, May 21, 2019 at 12:37:26PM +0200, Michal Hocko wrote:
> > On Tue 21-05-19 19:26:13, Minchan Kim wrote:
> > > On Tue, May 21, 2019 at 08:24:21AM +0200, Michal Hocko wrote:
> > > > On Tue 21-05-19 11:48:20, Minchan Kim wrote:
> > > > > On Mon, May 20, 2019 at 11:22:58AM +0200, Michal Hocko wrote:
> > > > > > [Cc linux-api]
> > > > > >
> > > > > > On Mon 20-05-19 12:52:53, Minchan Kim wrote:
> > > > > > > Currently, process_madvise syscall works for only one address range
> > > > > > > so user should call the syscall several times to give hints to
> > > > > > > multiple address range.
> > > > > >
> > > > > > Is that a problem? How big of a problem? Any numbers?
> > > > >
> > > > > We easily have 2000+ vma so it's not trivial overhead. I will come up
> > > > > with number in the description at respin.
> > > >
> > > > Does this really have to be a fast operation? I would expect the monitor
> > > > is by no means a fast path. The system call overhead is not what it used
> > > > to be, sigh, but still for something that is not a hot path it should be
> > > > tolerable, especially when the whole operation is quite expensive on its
> > > > own (wrt. the syscall entry/exit).
> > >
> > > What's different with process_vm_[readv|writev] and vmsplice?
> > > If the range needed to be covered is a lot, vector operation makes senese
> > > to me.
> >
> > I am not saying that the vector API is wrong. All I am trying to say is
> > that the benefit is not really clear so far. If you want to push it
> > through then you should better get some supporting data.
>
> I measured 1000 madvise syscall vs. a vector range syscall with 1000
> ranges on ARM64 mordern device. Even though I saw 15% improvement but
> absoluate gain is just 1ms so I don't think it's worth to support.
> I will drop vector support at next revision.

Please do keep the vector support. Absolute timing is misleading,
since in a tight loop, you're not going to contend on mmap_sem. We've
seen tons of improvements in things like camera start come from
coalescing mprotect calls, with the gains coming from taking and
releasing various locks a lot less often and bouncing around less on
the contended lock paths. Raw throughput doesn't tell the whole story,
especially on mobile.
