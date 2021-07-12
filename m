Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CF03C5A7B
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 13:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhGLKB0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 06:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbhGLKBX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 06:01:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66592C0613EE;
        Mon, 12 Jul 2021 02:58:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k16so21791140ios.10;
        Mon, 12 Jul 2021 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfXfxBn/LMALhO/QRtXtl1w3RykDKGRYzzYrieSX3bA=;
        b=iesh2DIAw8sK/vK2UkjHoJXXvvkhgEv/w7Ytg0MGfdN1P2o3rBkqtn30+J0jCLWXOt
         Ol1IvXzkdbVgU6+u7xwRKBkBkBG8qspdQnGRJcuuk09ziLYdEaYWCDjd045QRyaonDYt
         YxGtSlOPpquQ7AtDHEv+CfIo9MHh6yR43RUzC8v7nCy43vF6fAP4qBtn5YvN0Xk9ecXA
         X7u0HLHu16n7rFQWnlkQbp0EEed3sesVNBB1QCYpgiV7EQowvMliXfVXzgWLKUB53Qmq
         iYQ4yOSgY3nzsJ+n5k2oNVovmt0BZjwmA+SN3l4QqGGm3HkRFaSRNaoVh9rkSr98j8uB
         y5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfXfxBn/LMALhO/QRtXtl1w3RykDKGRYzzYrieSX3bA=;
        b=Xy3htoPS4IdbAQct63dhZcxhiutFQ3Uhsd1wb24VBCTw0VB1Y1lC5DtpTPLtoeYnPy
         BXX9NvDBNnO0Kr8rrSEsplkrsdVlRtFGNFt4ehxX6ifJ+cvaIMrg84NY6QICpFD1zRWF
         hJcowmSzdm4i+iIjpwSkk/+qPvlYuR9l2WgTt0SzRm/hj1ifAhpvtMA3OF/kNM97J98f
         Q++fbzjtWGgERZT+XgWKrvLewGOrfyxK0TqSYMsTOPtsldwl8GJTb7Om+q0TKpL59fWV
         d3YTrjjyrPTFyFKsMlB0aJSq4g4irm4PTGj8iOVvgoyyVdcDF7q+BXNpRwG6WY4BA0O3
         V8AQ==
X-Gm-Message-State: AOAM532dJX8W+o/3j4JrypMyZZo8YIP7QMWz1k+FAlucWdxkwAaQacNh
        Hyft2H5SPgH9+3H9qu5qSizLUZm1HMa2W3iGYsk=
X-Google-Smtp-Source: ABdhPJwVQ8WpiYF0gs+hCoHtfyZZ6n5cvQGDNVvk6u49AcWUcZqoUwcTk8rZQYFcIMzBe5sQFZWyIwRIMuPzzkykidI=
X-Received: by 2002:a02:a98d:: with SMTP id q13mr37044878jam.124.1626083911883;
 Mon, 12 Jul 2021 02:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210712083917.16361-1-david@redhat.com>
In-Reply-To: <20210712083917.16361-1-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 12 Jul 2021 11:58:20 +0200
Message-ID: <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
Subject: Re: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and MADV_POPULATE_WRITE
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
>
> Let's document the behavior and error conditions of these new madvise()
> options.
>
> Cc: Alejandro Colomar <alx.manpages@gmail.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  man2/madvise.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/man2/madvise.2 b/man2/madvise.2
> index f1f384c0c..3ec8c53a7 100644
> --- a/man2/madvise.2
> +++ b/man2/madvise.2
> @@ -469,6 +469,59 @@ If a page is file-backed and dirty, it will be written back to the backing
>  storage.
>  The advice might be ignored for some pages in the range when it is not
>  applicable.
> +.TP
> +.BR MADV_POPULATE_READ " (since Linux 5.14)
> +Populate (prefault) page tables readable for the whole range without actually
> +reading. Depending on the underlying mapping, map the shared zeropage,
> +preallocate memory or read the underlying file; files with holes might or
> +might not preallocate blocks.
> +Do not generate
> +.B SIGBUS
> +when populating fails, return an error instead.
> +.IP
> +If
> +.B MADV_POPULATE_READ
> +succeeds, all page tables have been populated (prefaulted) readable once.
> +If
> +.B MADV_POPULATE_READ
> +fails, some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_READ
> +cannot be applied to mappings without read permissions
> +and special mappings marked with the kernel-internal
> +.B VM_PFNMAP
> +and
> +.BR VM_IO .
> +.IP
> +Note that with
> +.BR MADV_POPULATE_READ ,
> +the process can be killed at any moment when the system runs out of memory.
> +.TP
> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)
> +Populate (prefault) page tables writable for the whole range without actually
> +writing. Depending on the underlying mapping, preallocate memory or read the

Is this read or write?
just reading and trying to understand :)

> +underlying file; files with holes will preallocate blocks.
> +Do not generate
> +.B SIGBUS
> +when populating fails, return an error instead.
> +.IP
> +If
> +.B MADV_POPULATE_WRITE
> +succeeds, all page tables have been populated (prefaulted) writable once.
> +If
> +.B MADV_POPULATE_WRITE
> +fails, some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_WRITE
> +cannot be applied to mappings without write permissions
> +and special mappings marked with the kernel-internal
> +.B VM_PFNMAP
> +and
> +.BR VM_IO .
> +.IP
> +Note that
> +.BR MADV_POPULATE_WRITE ,
> +the process can be killed at any moment when the system runs out of memory.
>  .SH RETURN VALUE
>  On success,
>  .BR madvise ()
> @@ -533,6 +586,17 @@ or
>  .BR VM_PFNMAP
>  ranges.
>  .TP
> +.B EINVAL
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +but the specified address range includes ranges with insufficient permissions,
> +.B VM_IO
> +or
> +.BR VM_PFNMAP.
> +.TP
>  .B EIO
>  (for
>  .BR MADV_WILLNEED )
> @@ -548,6 +612,14 @@ Not enough memory: paging in failed.
>  Addresses in the specified range are not currently
>  mapped, or are outside the address space of the process.
>  .TP
> +.B ENOMEM
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +but populating (prefaulting) page tables failed.
> +.TP
>  .B EPERM
>  .I advice
>  is
> @@ -555,6 +627,14 @@ is
>  but the caller does not have the
>  .B CAP_SYS_ADMIN
>  capability.
> +.TP
> +.B EHWPOISON
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and a HW poisoned page is encountered.
>  .SH VERSIONS
>  Since Linux 3.18,
>  .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
> --
> 2.31.1
>
>
