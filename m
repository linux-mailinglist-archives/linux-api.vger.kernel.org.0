Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD04220839
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 15:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfEPNcd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 09:32:33 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33184 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfEPNcd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 09:32:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id m204so2540406oib.0
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 06:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+8Dc+8NQkNb3/Q1ARB2w0BPiehxHFy6DByP8EfeHyE=;
        b=SYjE/ozBIlk8Fx5sGYi6WTZimcARTlAHPPEaELxcs6u17YAQfVwz99WhY0CA7x7cml
         b4Cbzvdp8D4NHP23ztKo/w3yjKTb6vite0InwNqCh9vwMas7ZY5DZACFYyoKryN+jMoV
         NyjJVH4U+KBZh2WxuP67pee+2CWg+DVK+qrBguGtLysuan0h4KqHqlWLuJXrjYjddiTS
         urPSTTaLVGMYc8qvdvqRVf/kNHorlEc45l0DrLwMjryCebhvK2KjtGwCcLCUUeSttn4X
         CZIbEe5ZiInHuQP0yaoUgNKXgkMbz8IOp3sMzWpkjg/O0QLy/mCw2/ZKl8KC6OVEqqUx
         fA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+8Dc+8NQkNb3/Q1ARB2w0BPiehxHFy6DByP8EfeHyE=;
        b=lJbLn10NlpHahFi68t18GC0z22tKEYvg91H7hPsg65GlIiEP0iss4Tb6+fsPuXOS3w
         At/IOPhV6xAu/C1M5mb6NZk0+6z6L2Dr8RU/JzfV6eb2xdAF96MnkzTWidtAzjW38Ymh
         JEY/pDZCO2T2aLibzIAIuUfxcrIXtxlTIvDZG6f8BemF0Qs4gv9W6oBFSv+WS7l4jr8U
         HMV41mocwr7WvxZjhonOSN9LOkYYK7wi+APlLAa9SaQohWMorFJlU/W9dXKorNSq+v+J
         oJtOqvJFvZQKWICMIyzKasiiZevR12Oin+BbQNq6Goa4NVJIQewndHkgOe/MvtavAFdn
         cq3Q==
X-Gm-Message-State: APjAAAW/ysmuzzBmz9zWJGx1/26WycUIfWUzPLUJDluSCgidutLMVdtg
        JnA1ZABPoNH4nzYuz8W7wnp0b1vdG7nPNoa9bZySDA==
X-Google-Smtp-Source: APXvYqyWTgxVAAT8JN7ctKRABfXdndp8feo5VLLNabYJZjH3z3RmiG0/e3+2ydfvO0aV6qZBGpe1mgmkhH0lQKZq3HI=
X-Received: by 2002:aca:180d:: with SMTP id h13mr10065721oih.39.1558013552764;
 Thu, 16 May 2019 06:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
In-Reply-To: <155793276388.13922.18064660723547377633.stgit@localhost.localdomain>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 May 2019 15:32:06 +0200
Message-ID: <CAG48ez3EOwLd8A6Ku53vKLdofmZAh1ZYfkK4rVgSgM8ZfcR4zg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/5] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>, keith.busch@intel.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        pasha.tatashin@oracle.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        ira.weiny@intel.com, Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>, hannes@cmpxchg.org,
        npiggin@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 15, 2019 at 5:11 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> This patchset adds a new syscall, which makes possible
> to clone a mapping from a process to another process.
> The syscall supplements the functionality provided
> by process_vm_writev() and process_vm_readv() syscalls,
> and it may be useful in many situation.
[...]
> The proposed syscall aims to introduce an interface, which
> supplements currently existing process_vm_writev() and
> process_vm_readv(), and allows to solve the problem with
> anonymous memory transfer. The above example may be rewritten as:
>
>         void *buf;
>
>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
>         recv(sock, buf, n * PAGE_SIZE, 0);
>
>         /* Sign of @pid is direction: "from @pid task to current" or vice versa. */
>         process_vm_mmap(-pid, buf, n * PAGE_SIZE, remote_addr, PVMMAP_FIXED);
>         munmap(buf, n * PAGE_SIZE);

In this specific example, an alternative would be to splice() from the
socket into /proc/$pid/mem, or something like that, right?
proc_mem_operations has no ->splice_read() at the moment, and it'd
need that to be more efficient, but that could be built without
creating new UAPI, right?

But I guess maybe your workload is not that simple? What do you
actually do with the received data between receiving it and shoving it
over into the other process?
