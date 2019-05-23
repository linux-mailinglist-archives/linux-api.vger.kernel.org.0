Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3B282BA
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2019 18:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfEWQTS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 May 2019 12:19:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbfEWQTR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 23 May 2019 12:19:17 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE31B2187F
        for <linux-api@vger.kernel.org>; Thu, 23 May 2019 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558628356;
        bh=Wv0O6tMsqxBwrYSLzxmAH+HjOtWLDhHqgQXa2NMoUIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TuemYF7pwTGUNdSGgCgUifbJfHdysesRp/aeb/uCsj2lSWwQPgpigWnPKsRhzZ3Ny
         aMj7ToyPso1jf1ZXp+sQzdorMOyRWxi/v1tCG99aYNd3Y6uPwHihCzAUmNg1HG4r6M
         7v0h+fpBde90VlqNm0oSpBFzWHQrfm9PULABF5JA=
Received: by mail-wr1-f49.google.com with SMTP id f10so6956716wre.7
        for <linux-api@vger.kernel.org>; Thu, 23 May 2019 09:19:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUqMZV1OeEClJBKw6+wFmgTx8701LS4Ur4GVGzKUp+BR6bhyGNJ
        FbiIfzrpxCaUiQY+hIxMDywRVv1SBeqnTpNr6EJ9Ug==
X-Google-Smtp-Source: APXvYqxJ9cxvpQ95yya8qpavKNpqTd10CO30B7bHS2mBUkOpNhogJ1RkrwPQlmFMEfwJOzNxSeCDw2Nl2Dls9GVaNWg=
X-Received: by 2002:adf:e90b:: with SMTP id f11mr4069510wrm.291.1558628353521;
 Thu, 23 May 2019 09:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
 <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com> <CALCETrUMDTGRtLFocw6vnN___7rkb6r82ULehs0=yQO5PZL8MA@mail.gmail.com>
 <67d1321e-ffd6-24a3-407f-cd26c82e46b8@virtuozzo.com>
In-Reply-To: <67d1321e-ffd6-24a3-407f-cd26c82e46b8@virtuozzo.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 23 May 2019 09:19:01 -0700
X-Gmail-Original-Message-ID: <CALCETrWzuH3=Uh91UeGwpCj28kjQ82Lj2OTuXm7_3d871PyZSA@mail.gmail.com>
Message-ID: <CALCETrWzuH3=Uh91UeGwpCj28kjQ82Lj2OTuXm7_3d871PyZSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        alexander.h.duyck@linux.intel.com, Weiny Ira <ira.weiny@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com, Jann Horn <jannh@google.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 10:44 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 21.05.2019 19:43, Andy Lutomirski wrote:
> > On Tue, May 21, 2019 at 8:52 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >> On 21.05.2019 17:43, Andy Lutomirski wrote:

> > Do you mean that the code you sent rejects this case?  If so, please
> > document it.  In any case, I looked at the code, and it seems to be
> > trying to handle MAP_SHARED and MAP_ANONYMOUS.  I don't see where it
> > would reject copying a vDSO.
>
> I prohibit all the VMAs, which contain on of flags: VM_HUGETLB|VM_DONTEXPAND|VM_PFNMAP|VM_IO.
> I'll check carefully, whether it's enough for vDSO.

I think you could make the new syscall a lot more comprehensible bg
restricting it to just MAP_ANONYMOUS, by making it unmap the source,
or possibly both.  If the new syscall unmaps the source (in order so
that the source is gone before the newly mapped pages become
accessible), then you avoid issues in which you need to define
sensible semantics for what happens if both copies are accessed
simultaneously.


--Andy
