Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A892B6F9A
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 21:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgKQUHM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 15:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKQUHL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 15:07:11 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8AC0617A6
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 12:07:10 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id j205so31900054lfj.6
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 12:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rJlb0i1VGgaZ+hMXCpkpJ5hlER3U8nvvYW3fvVDgI/k=;
        b=J/YZ6h/OCZ5I/Llg6f76T474+2t8DYXpf9TaLe/UQTe9U546QNvmBmNEuXh8xRHatn
         x5dZoH3xvuvcTuHNbgryL58m+LGRM86j8ia2e8WeoVF1kEPl+sOvzsdfSdx3tahqHiRJ
         vkyAJSPq0gqZEyRGVyCbFka6jZ7H+yF7b4APw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rJlb0i1VGgaZ+hMXCpkpJ5hlER3U8nvvYW3fvVDgI/k=;
        b=QDMxFAsjLnFAUenx9lRBB0OdPRowrKlcv1hD9IlvqMykp/P+ewUE+kKi8oDzNsf1jK
         oeOmztnK5jVya2en5lZ/JgJkSUUfrI8qSp4d2TtUR6qQtOL8BCbhg8hlyypkp6CnRJwx
         qXWKXoH6yhFCQr6ZvAs7YwWjiVQqqL/LDYk5amtG1vnUcgKtdPXe87cUa03FUyXtB3r6
         pqZ/ovg58o2UML0MVefDO3GtZKZH2pDzmBWMcENcMgpYBzb3b6mk9YyyiVV9DfJwHO53
         eyB6xlAX4Am8JN0Qv1POZ4zgtIFwfCZ8FADUswJ2YzJev/2ospu53sUP6tGd4ezgAzv/
         3dDg==
X-Gm-Message-State: AOAM532PNwHgSRpxJAMuiQIG9KTqr6v+R1R8ynuVLNGruLDkVix6/lDc
        qif+UnGIrS67ZDnqdnHNvW0pOcrQvG2w4g==
X-Google-Smtp-Source: ABdhPJyXtEwLSxtZpQmp2PkgSvYrGJdg64pBNZW4HGnSGKw55JPxKQZ+D28iNdTMuI2e6hqDqY4KGg==
X-Received: by 2002:ac2:4543:: with SMTP id j3mr2141395lfm.511.1605643627850;
        Tue, 17 Nov 2020 12:07:07 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c6sm2952391ljj.140.2020.11.17.12.07.05
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 12:07:05 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id l11so19811041lfg.0
        for <linux-api@vger.kernel.org>; Tue, 17 Nov 2020 12:07:05 -0800 (PST)
X-Received: by 2002:ac2:598f:: with SMTP id w15mr2196881lfn.148.1605643624696;
 Tue, 17 Nov 2020 12:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20200901000633.1920247-1-minchan@kernel.org> <20200901000633.1920247-4-minchan@kernel.org>
 <20200921065633.GA8070@infradead.org> <20200921175539.GB387368@google.com>
 <a376191d-908d-7d3c-a810-8ef51cc45f49@gmail.com> <20201116155132.GA3805951@google.com>
In-Reply-To: <20201116155132.GA3805951@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 12:06:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTctybeY7GSc+f--FVLKKUQicTq-jfEmdku+cO_VdiVg@mail.gmail.com>
Message-ID: <CAHk-=whTctybeY7GSc+f--FVLKKUQicTq-jfEmdku+cO_VdiVg@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
To:     Minchan Kim <minchan@kernel.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        sj38.park@gmail.com, David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 16, 2020 at 7:51 AM Minchan Kim <minchan@kernel.org> wrote:
>
> Let me send a patch with your SoB if you don't mind.

Eric, can you ack this SoB and I'll apply it to me tree?

Or is it already queued up somewhere else?

             Linus
