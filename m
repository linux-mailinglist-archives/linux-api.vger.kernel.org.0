Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01F98333CF
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfFCPoM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 11:44:12 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35366 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfFCPoM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 11:44:12 -0400
Received: by mail-ua1-f68.google.com with SMTP id r7so6653987ual.2
        for <linux-api@vger.kernel.org>; Mon, 03 Jun 2019 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pxr2tsBIRKskeHWPSwMDss/AepFRvbtFu+kFFRUCb+Q=;
        b=FeiRgsweRwTNxjLQEZKDRVMSsebGvhERPWsd1c7KGoMTjJVDnHHl1PLX97BQ+pii77
         hXtgyY75bU/8TkqS3pgzN5I5hTHdt4eK7NIYTXesu+y8UAKBHgjB0t9mjdZt3w+naCKT
         rM9EkwPnii6j9iaJgVUuZV9kmbIImg2XC97jJMlaEswKCY5ECylPsSlPW/geZgkeQ6uC
         dSkTIW8/omAz6+vXCb/USUR0sqDwhsiGnB6pp2PyqiyEsckbAVuvNkDzmpDyALKbtt/p
         PfvvZJYgSqX83KJQk1Sl9u3JzNGJUxILFZ7nxCKabg0SZXDzVVCf5/7Tg4QlIB3fGbEx
         ZYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pxr2tsBIRKskeHWPSwMDss/AepFRvbtFu+kFFRUCb+Q=;
        b=k7qWN2ruNx7Qzo6NJ+ly4XMZEqZErVCyvkx3wUBlePjIWrbzMIBzxtm2XkuVq2ECkn
         uU/S+SqJt575Z6gqPKlEvCoos6jBCny8SOf+UzuF2b8WnvaQWCGVq1KM3F1+EuhdgbRb
         JakG/H+IKhBgMccCjy7Jd0U8ibm3tuV9BJXES/MN2HbBCbRRY1igje8B7oHTtWzUkK5H
         mL5NBl713met6PJA1FTZHJanIrsEiCnMw57kNBNiKB7+ccEcK0p25zlM2rg0DgxFkFcJ
         oBxiOHeQRh/RsCVRuOL3z+myYmRpUwJNyw9DNd7PVLABPDcAvSZsf8OJALySx0SV2FIS
         kOtw==
X-Gm-Message-State: APjAAAWZdNivQlHZ1O3rXbFcAnqWTJo/4CZMYT37YGxXFL6peh8yAomn
        VzIpcMuqTd0a4aKYhE91y7723+HxMtnxe+D3VnXDtQ==
X-Google-Smtp-Source: APXvYqzC/biQeMQwwnleohw9UkPA9qCfiYB7Q+NAS71L23R0SboHrt/PF2NrayEW15/9pMefLmUdej7+yCs2uAGXatU=
X-Received: by 2002:ab0:6198:: with SMTP id h24mr3159945uan.41.1559576651190;
 Mon, 03 Jun 2019 08:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190531064313.193437-1-minchan@kernel.org> <20190531064313.193437-2-minchan@kernel.org>
 <20190531084752.GI6896@dhcp22.suse.cz> <20190531133904.GC195463@google.com>
 <20190531140332.GT6896@dhcp22.suse.cz> <20190531143407.GB216592@google.com> <20190603071607.GB4531@dhcp22.suse.cz>
In-Reply-To: <20190603071607.GB4531@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 3 Jun 2019 08:43:59 -0700
Message-ID: <CAKOZuetW1UsPP3fDm-zTBOiO_oWkkDwADu+Apy53abWNs-UcUA@mail.gmail.com>
Subject: Re: [RFCv2 1/6] mm: introduce MADV_COLD
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>, oleksandr@redhat.com,
        hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 3, 2019 at 12:16 AM Michal Hocko <mhocko@kernel.org> wrote:
> On Fri 31-05-19 23:34:07, Minchan Kim wrote:
> > On Fri, May 31, 2019 at 04:03:32PM +0200, Michal Hocko wrote:
> > > On Fri 31-05-19 22:39:04, Minchan Kim wrote:
> > > > On Fri, May 31, 2019 at 10:47:52AM +0200, Michal Hocko wrote:
> > > > > On Fri 31-05-19 15:43:08, Minchan Kim wrote:
> > > > > > When a process expects no accesses to a certain memory range, it could
> > > > > > give a hint to kernel that the pages can be reclaimed when memory pressure
> > > > > > happens but data should be preserved for future use.  This could reduce
> > > > > > workingset eviction so it ends up increasing performance.
> > > > > >
> > > > > > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > > > > > MADV_COLD can be used by a process to mark a memory range as not expected
> > > > > > to be used in the near future. The hint can help kernel in deciding which
> > > > > > pages to evict early during memory pressure.
> > > > > >
> > > > > > Internally, it works via deactivating pages from active list to inactive's
> > > > > > head if the page is private because inactive list could be full of
> > > > > > used-once pages which are first candidate for the reclaiming and that's a
> > > > > > reason why MADV_FREE move pages to head of inactive LRU list. Therefore,
> > > > > > if the memory pressure happens, they will be reclaimed earlier than other
> > > > > > active pages unless there is no access until the time.
> > > > >
> > > > > [I am intentionally not looking at the implementation because below
> > > > > points should be clear from the changelog - sorry about nagging ;)]
> > > > >
> > > > > What kind of pages can be deactivated? Anonymous/File backed.
> > > > > Private/shared? If shared, are there any restrictions?
> > > >
> > > > Both file and private pages could be deactived from each active LRU
> > > > to each inactive LRU if the page has one map_count. In other words,
> > > >
> > > >     if (page_mapcount(page) <= 1)
> > > >         deactivate_page(page);
> > >
> > > Why do we restrict to pages that are single mapped?
> >
> > Because page table in one of process shared the page would have access bit
> > so finally we couldn't reclaim the page. The more process it is shared,
> > the more fail to reclaim.
>
> So what? In other words why should it be restricted solely based on the
> map count. I can see a reason to restrict based on the access
> permissions because we do not want to simplify all sorts of side channel
> attacks but memory reclaim is capable of reclaiming shared pages and so
> far I haven't heard any sound argument why madvise should skip those.
> Again if there are any reasons, then document them in the changelog.

Whether to reclaim shared pages is a policy decision best left to
userland, IMHO.
