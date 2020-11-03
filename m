Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648772A5747
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 22:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732798AbgKCVkz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 16:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbgKCVky (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Nov 2020 16:40:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78187C0617A6
        for <linux-api@vger.kernel.org>; Tue,  3 Nov 2020 13:40:53 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s9so19975872wro.8
        for <linux-api@vger.kernel.org>; Tue, 03 Nov 2020 13:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UujFYQwrAMAwi1/OCKFtTp32QIC/tCBtqm1aq3KAJ18=;
        b=FdUvjbjLJoPJViFWAGZQTYBxNYPCG2lrEX+eW+1JbafAofaJfmaF34xRbhMStCu1bw
         Q8y8dUQmIvl4HybqP4JQ2sEemewRBCRFSV7WpefnD+epD106SUeDvcyPNvvMSuxqlAki
         eZy07p1662luyVqnaCsH8fMg+HsoFxrC3o3qXw4wGlXogHOm6XRfrRpwjkMHyttr4Pp9
         c+ohCfM4BXsHV41o1jEPT10BBk6ZBWClev2C+qrSzLNS3y0o4TsTxRr9skWqurJOH1z9
         3CAVCbPHbZkzJJeyW6Bkl2RQjSilQ/VXgfG0+nhgDaWQOq78Nm0zvZaB+n71rMEEQIDd
         rkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UujFYQwrAMAwi1/OCKFtTp32QIC/tCBtqm1aq3KAJ18=;
        b=iigeDO6G+91JXEkZ7t8hMFj+0PuRyjpkclqnTHaLeZMKcGhON6MzJ497hWthOIjHWe
         v0Pcj0ePPdHDQGP+jIRmOGFXF1cQGzQ3tmn0KeqslODqTYbnIadN31r0KLogKASpXSRZ
         iv0FbQIJCvbBJIqalF8xSXnQSdS5i6wUgQ+PJ2OFtfru7yKHidV1AsMP7CbaM9ci/Z8e
         pI9rq82RMfRMxld6jEJsi5E/AmeeS4A3tgEYHan0FcfQPw4cxbxyP5e3jRYUV7Hn/hfv
         pKDsW12eZQPd4Mnuy9K7HlFgAObjizGQZYywEJZk5M6MBucmvFSjqulArXtPIucbaIaX
         aeFQ==
X-Gm-Message-State: AOAM532Hr6TKgVk8CPmb66Ob83xoXDi0qERla4CP4BFCF9OvyiAHkTmn
        XbWUfO67FWcAIllNwS1NRwcjAf7EfwSyiAQyv1zHHQ==
X-Google-Smtp-Source: ABdhPJwwE5qbcx0FJgRwt8ysoKwO12F59BUj6qqo925IYvPZ1whgXvzlaDVmywWxSx45wVl1QcVcY4kSPyjBPA1lUQU=
X-Received: by 2002:adf:a501:: with SMTP id i1mr27790501wrb.162.1604439651996;
 Tue, 03 Nov 2020 13:40:51 -0800 (PST)
MIME-Version: 1.0
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz> <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz> <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz> <20201103213228.GB1631979@google.com>
In-Reply-To: <20201103213228.GB1631979@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 3 Nov 2020 13:40:41 -0800
Message-ID: <CAJuCfpELVYSNsjnXvg7pXQiwMBYpffcy5aNqj84t70-qN1XYiQ@mail.gmail.com>
Subject: Re: [RFC]: userspace memory reaping
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 3, 2020 at 1:32 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > [...]
> > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > which in addition to sending a kill signal would also reap the
> > > victim's mm in the context of the caller? Maybe having some code will
> > > get the discussion moving forward?
> >
> > Yeah, having a code, even preliminary, might help here. This definitely
> > needs a good to go from process management people as that proper is land
> > full of surprises...
>
> Just to remind a idea I suggested to reuse existing concept
>
>     fd = pidfd_open(victim process)
>     fdatasync(fd);
>     close(fd);
>

Yep, I just posted a comment about that. I think though your above
sequence is missing a pidfd_send_signal(fd, SIGKILL) before the
fdatasync(fd)...
Not sure if fdatasync(pidfd) or fsync(pidfd) would be more appropriate
for this but will use one and we can discuss details in the RFC with
the code.
Thanks!
