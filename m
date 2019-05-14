Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5743D1CAE3
	for <lists+linux-api@lfdr.de>; Tue, 14 May 2019 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfENOvY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 May 2019 10:51:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfENOvY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 May 2019 10:51:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 520E3AF94;
        Tue, 14 May 2019 14:51:23 +0000 (UTC)
Date:   Tue, 14 May 2019 16:51:22 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH RFC v2 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190514145122.GG4683@dhcp22.suse.cz>
References: <20190514131654.25463-1-oleksandr@redhat.com>
 <20190514144105.GF4683@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514144105.GF4683@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Forgot Hugh]

On Tue 14-05-19 16:41:05, Michal Hocko wrote:
> [This is adding a new user visible interface so you should be CCing
> linux-api mailing list. Also CC Hugh for KSM in general. Done now]
> 
> On Tue 14-05-19 15:16:50, Oleksandr Natalenko wrote:
> > By default, KSM works only on memory that is marked by madvise(). And the
> > only way to get around that is to either:
> > 
> >   * use LD_PRELOAD; or
> >   * patch the kernel with something like UKSM or PKSM.
> > 
> > Instead, lets implement a sysfs knob, which allows marking VMAs as
> > mergeable. This can be used manually on some task in question or by some
> > small userspace helper daemon.
> > 
> > The knob is named "force_madvise", and it is write-only. It accepts a PID
> > to act on. To mark the VMAs as mergeable, use:
> > 
> >    # echo PID > /sys/kernel/mm/ksm/force_madvise
> > 
> > To unmerge all the VMAs, use the same approach, prepending the PID with
> > the "minus" sign:
> > 
> >    # echo -PID > /sys/kernel/mm/ksm/force_madvise
> > 
> > This patchset is based on earlier Timofey's submission [1], but it doesn't
> > use dedicated kthread to walk through the list of tasks/VMAs. Instead,
> > it is up to userspace to traverse all the tasks in /proc if needed.
> > 
> > The previous suggestion [2] was based on amending do_anonymous_page()
> > handler to implement fully automatic mode, but this approach was
> > incorrect due to improper locking and not desired due to excessive
> > complexity.
> > 
> > The current approach just implements minimal interface and leaves the
> > decision on how and when to act to userspace.
> 
> Please make sure to describe a usecase that warrants adding a new
> interface we have to maintain for ever.
> 
> > 
> > Thanks.
> > 
> > [1] https://lore.kernel.org/patchwork/patch/1012142/
> > [2] http://lkml.iu.edu/hypermail/linux/kernel/1905.1/02417.html
> > 
> > Oleksandr Natalenko (4):
> >   mm/ksm: introduce ksm_enter() helper
> >   mm/ksm: introduce ksm_leave() helper
> >   mm/ksm: introduce force_madvise knob
> >   mm/ksm: add force merging/unmerging documentation
> > 
> >  Documentation/admin-guide/mm/ksm.rst |  11 ++
> >  mm/ksm.c                             | 160 +++++++++++++++++++++------
> >  2 files changed, 137 insertions(+), 34 deletions(-)
> > 
> > -- 
> > 2.21.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
