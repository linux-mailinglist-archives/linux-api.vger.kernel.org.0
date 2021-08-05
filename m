Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3A93E1A24
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 19:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhHERLm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 13:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbhHERLl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 13:11:41 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E4AC0613D5
        for <linux-api@vger.kernel.org>; Thu,  5 Aug 2021 10:11:27 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z5so8431884ybj.2
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ERQbtS+fnxY/GTjgoyN4o7LqbVRRH79OP2qmymgXTb4=;
        b=GLD06EgaLKGHSCBxOJTN/DXGjec2pkyyzJTY1leEDGCcziiVUca3XMjOep8ny+eZPl
         WwIBrHwTE4pJCWUvcgQTu1EurBleqeX/YGIb5fcy9nYAyjYgzfaRK/ZAkersLxI+yYLh
         qS0Iq6/OYOwoevzPH22Dur+oqnmICw5w8d5erIyvyYQqF73KcnK2obR0w4QqyRHCuDsB
         2DZHlUt5JUAU28ukvUN8+pzbZjjHps5wuctG26TSCLmXYZq911yb9fgVcH9tHkbVxM9n
         bnudqaSbSeT0djOQBO0+BZkRwBwHLhM9XRYALf8fnwVbK6GnN2kHEWqbjpCza+U8qpIu
         Fpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ERQbtS+fnxY/GTjgoyN4o7LqbVRRH79OP2qmymgXTb4=;
        b=rpkKX7k08lTanR47b5q2/cWOCti8+kr5bdMrDDgax2yQrsOfre0byhkj27Ml6kY74m
         rLD4PLQB6ZBinlHiKipIVMiyVTCInd2xZqdmsoYTSQ14RNjn87FFE1Pjj/mCTOXjHwRr
         TiS1wHgym0aL4lY5p80WnlN1QHYw4bVhMkHhAAxlYqwZiNbqYKcq+XfcNkmVrZGdM36r
         Uy3cwdQLrLkG2wYjAkTKF/fjhlJ/HQhMJSKSxs7PvGkb2SuaylpX9tMvgQHEo3yrxiB5
         qYwzm1Z/n2IxO6EFmq2BIVre/7x5abyZrox5jk+hLGiku/G3ZACU1AMMDZwBOwu/T96f
         AZ3g==
X-Gm-Message-State: AOAM532twvWmmWF6kAu7TeyI4CfpBL8yue8blmcs4GNJ5IU9A2JOpvTS
        DINS1SX4IPHLR8SY3fHyw1WCJ5C0Bh/WhiW7Jdyj0Q==
X-Google-Smtp-Source: ABdhPJzHLim3LivVZpBBq/WtrI2aeZb4sR+FqouWvGBUQtNrYWNyFBLCGhpPrixUmUXh2NvNijcm64R0KOQ7Agi9/Eo=
X-Received: by 2002:a25:49c2:: with SMTP id w185mr6617021yba.294.1628183486539;
 Thu, 05 Aug 2021 10:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210804185004.1304692-1-surenb@google.com> <YQuO36AeQUwsAyU1@dhcp22.suse.cz>
 <CAJuCfpF1JSTSRu5v8s9wG0J-S+-p57tMO+0dUF+P16_6yYV7Mg@mail.gmail.com> <c67c89a2-02b3-a226-97ae-897f704b337e@redhat.com>
In-Reply-To: <c67c89a2-02b3-a226-97ae-897f704b337e@redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Aug 2021 10:11:15 -0700
Message-ID: <CAJuCfpFMZU2mJL1s9S6Fn9q-L6SKBfoqYc8Z8X1NQ2UQww1Pjg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 5, 2021 at 8:31 AM David Hildenbrand <david@redhat.com> wrote:
>
> >
> > I see. Let me update the patch and will ask Andrew to remove the
> > previous version from mm tree.
>
> No need to ask. Just resend and Andrew will (usually) replace the old
> version automatically :)

Done: https://lore.kernel.org/linux-mm/20210805170859.2389276-1-surenb@google.com
Thanks!

>
>
> --
> Thanks,
>
> David / dhildenb
>
