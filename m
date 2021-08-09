Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2523E484A
	for <lists+linux-api@lfdr.de>; Mon,  9 Aug 2021 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhHIPE2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 11:04:28 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:42690 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhHIPE1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 11:04:27 -0400
Received: by mail-ua1-f51.google.com with SMTP id m39so1883060uad.9;
        Mon, 09 Aug 2021 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WVMYOqEa/bLtuXQ6WMOZh3F4v9HS1yFs7MrmGYYVUc=;
        b=HmnC0WIVazwQ6nhvLaz9JWNnR3JKueiwHpbLS3p1AsIsmISF/mR9J+falMrlTdV0wd
         irHa/+sveSz8A4chUUm7v3Id3ezK/LCOZ2gQGEVFwlBik5JZ3YVOpr70rszHKOAmhtSa
         XOYqHppA57yWOQ/+Hc3rB4FGEzd6M2aksEjR3b0Eye7kqEJkQ2wLbGi5M8saoNbfNlo4
         MbJgFZmo0MwrcaSfltF3mV3OeW2s4lsMDYCogRv5LEjZD6RVp3PJJ+2hkiQTPuBgWumn
         itvSn2ds6/UziN4mvdP/hGGkqMQGbK7zFigwawgqcovbSJxYuuc3c3UkpWJHP+qtnIJG
         Y0/g==
X-Gm-Message-State: AOAM531h3XxDVEc8n6QA3rTXJaPD3rsjjiLUDfvdb+S7nyoppBavKbrO
        d1H8kdcbBO1Ugs6dUQfzAdLauQsDaWAZDsYQaek=
X-Google-Smtp-Source: ABdhPJxZA2LpZiU8DOllIwZGZvqRRctpyutcM8ui5lDbadGe9QWO10AogpNXRHIIp09OCdbbh1DuGYgr2ki/2pYlsTo=
X-Received: by 2002:a9f:2341:: with SMTP id 59mr15759589uae.4.1628521446744;
 Mon, 09 Aug 2021 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210808160823.3553954-1-surenb@google.com> <20210808160823.3553954-2-surenb@google.com>
In-Reply-To: <20210808160823.3553954-2-surenb@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 17:03:55 +0200
Message-ID: <CAMuHMdX7YyBRmKNkQJ0k0chaHrziPa=OfKOXStEgXjZNfgg5Nw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] mm: wire up syscall process_mrelease
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>, shakeelb@google.com,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>, jengelh@inai.de,
        timmurray@google.com, Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Aug 8, 2021 at 6:23 PM Suren Baghdasaryan <surenb@google.com> wrote:
> Split off from prev patch in the series that implements the syscall.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

>  arch/m68k/kernel/syscalls/syscall.tbl       | 2 ++

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
