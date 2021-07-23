Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B03D3B51
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 15:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhGWNAf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 09:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbhGWNAe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 09:00:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E22C061575
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 06:41:07 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d18so2136378lfb.6
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 06:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IUOnTm1w1NEGAKUMKN9++OeCABD3VuZuK8Yv72862w=;
        b=gA0KTI9EjtWRrS83kMofDP16+r28w0JxI7MivS3NNKG3D7h0NX3kFG8jahIo/K4+j/
         InBy0eAqybKo30iUV2ObUz79y65QEqzuqfkNGtvlG9qDbovYf1u1un6Ke2X6l0BQcFu3
         q2ilMtGg0WxDs+eaJxTJ42jKEAk8ZC5FQCcKy9F9rN4zkZMmZAtFEsm862G3Sp4rfXt+
         bWn2TLAs2bbq/De8aok+VvnJvts2urLLECzI97u8kviZl9k23Vte7DZGLFmO1BEBPF5P
         xDFQ7wrG07ut5ziGOcjIEp43y+8WGHUOdB6/5aXhk06UdWjH2dL5UeZuP/j6p+J6uGi+
         INXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IUOnTm1w1NEGAKUMKN9++OeCABD3VuZuK8Yv72862w=;
        b=BueujwqwIOjBu1WU+IrIG6Txwx64Gbp6Ek/b9vWAWeAlUVtZRqt7/fcAboIa6NYBr4
         s2ItR7lBFRej5alABsr6AnxXH5TAiqpwtkV/Q1ywDnsmhVn2N4ryCGvdh9ilbiIpdugC
         o6Q5V/F18q3Q7KKCrBGUuY0XwPv/HzEn8AUXjpfyww5O8Zjn0ipKg68jDm5KMhBRKkms
         EgY52KFTfoPmgVLCkmJbgpohUT8x/wHb72unrNT8LvaFVCMWXc0DTYW24KAnejL+KYKx
         P+mu0M/56r/numH6sk/C4oYCHEAKLt4riwKHaZmwP9EoW2+4W6JZd/hdAjLgonpvJRQw
         ij3g==
X-Gm-Message-State: AOAM531nUBl6r06BkEYtzcvbJA5V3iWYF+gx3w6yagLbimCQEyYhQQfk
        ulDAZyiFUKWf5o6TkUxiE3mdVQLY3srzyw/bGhlB2g==
X-Google-Smtp-Source: ABdhPJw8jqOznbPrS2TBhfpe4BhYyrVrnm33Cq5MfitNfhmTtB11IoaLYUskZkWSJpsoHlUm0sPAcJR3h0yAR38JgHQ=
X-Received: by 2002:ac2:4d86:: with SMTP id g6mr3049839lfe.549.1627047665042;
 Fri, 23 Jul 2021 06:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com> <YPpfo2z8feq0vTlE@dhcp22.suse.cz>
In-Reply-To: <YPpfo2z8feq0vTlE@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 23 Jul 2021 06:40:53 -0700
Message-ID: <CALvZod470Q9yZzjRGZr5q3oZ2z7-EYc3fEGtoridk8MJu3k7jg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 22, 2021 at 11:20 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 22-07-21 21:47:56, Suren Baghdasaryan wrote:
> > On Thu, Jul 22, 2021, 7:04 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan <surenb@google.com>
> > > wrote:
> > > >
> > > [...]
> > > > +
> > > > +       mmap_read_lock(mm);
> > >
> > > How about mmap_read_trylock(mm) and return -EAGAIN on failure?
> > >
> >
> > That sounds like a good idea. Thanks! I'll add that in the next respin.
>
> Why is that a good idea? Can you do anything meaningful about the
> failure other than immediately retry the syscall and hope for the best?
>

Yes we can. Based on the situation/impact we can select more victims.
