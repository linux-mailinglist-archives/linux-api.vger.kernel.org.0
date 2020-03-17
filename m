Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2894B187C5F
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2020 10:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCQJkO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Mar 2020 05:40:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33464 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgCQJkN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Mar 2020 05:40:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id z65so25528161ede.0;
        Tue, 17 Mar 2020 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Z+fnHPmjTvYVaCbry35HAxtdpXdWo4RD3OIz+px6SGc=;
        b=Wd8arqk+ky/rUkkIYXPsVMQ1m9DliRq56vGPcryGaIl9nl1q7/V2snm5rdly3z8Oec
         iRXiFwNg1xdkDZi7oiR4VIA1SaAr1V6j9pCvbgvBv+Mt+AH4XCxUrEh7hK2rs5WHKIHt
         qFW3M59FVVbcG6mZWmCFljtEzMWJblCi6pydhLeZQptGynR2kJqWicJBBXNUGDUBKcW6
         9vWGH1JBpfXGwBstUKPHgLrYHHvTwP8Zj1h+MiD01ebw/DmvPg5VBGO8kMeVBpIYnxuK
         qrXtZak/ruwGq0wAvfVSunWfIVZBw4lsSPAk5ijYvTogzCCFsahhqd7aJPK7KVG3RPgt
         f8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Z+fnHPmjTvYVaCbry35HAxtdpXdWo4RD3OIz+px6SGc=;
        b=UxPsa/21QrvfcMOxopvOuRo1fWpaA2L/nbbht3xXFzrXqFpC/Rz3lpUnpYwqhlBpB/
         gwRVKCgZplewCxNaihjf6TyCu8nI64u06W3uZHgkn4FxVhxzQZ3X5wZHM2qwXdlOXLSi
         EUivFJkak02930ry7d1Tfo1/nkNzDPc/QKm6yjYTf7Nc8t7pZazQwkIN/OFJUn7dJh9d
         +85vEQD/NSw0skAADXaO3m5gtm2vY+QzzoJzu2ryWzk554lcTAl2/CzH5IshOwfebtoK
         eCYLZ2tzlNCHVnBcG0BvzxI4iSxji2uJHoniRStBphV3Jxn5lW0uP+K/pXXO02+q0vcU
         v/zA==
X-Gm-Message-State: ANhLgQ2qIN3lEiG4QMZI2M5KJ6vYyx66U8YlLTYcWVbHmExO3SsP6YrE
        R/898AoYShIRLwezjsLMG7bQghV5TD7fSmoaa+8=
X-Google-Smtp-Source: ADFU+vvei8gNf0aOLwxNV7tM+antMLxB/49Sgt3hcAwiXwanufRDe6jH1Jpeb5CgdbhLdyycQMV4+IisSCsMoEVfNSQ=
X-Received: by 2002:a17:906:70c9:: with SMTP id g9mr3284339ejk.243.1584438011180;
 Tue, 17 Mar 2020 02:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200317083043.226593-1-areber@redhat.com>
In-Reply-To: <20200317083043.226593-1-areber@redhat.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Tue, 17 Mar 2020 10:40:00 +0100
Message-ID: <CAKgNAkh7=2Noyn0o3880xbbi4w5oiwqs9ibTYLtheqzxne3mbQ@mail.gmail.com>
Subject: Re: clone3: allow creation of time namespace with offset
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[CC += linux-api; please CC on future versions]

On Tue, 17 Mar 2020 at 09:32, Adrian Reber <areber@redhat.com> wrote:
>
> This is an attempt to add time namespace support to clone3(). I am not
> really sure which way clone3() should handle time namespaces. The time
> namespace through /proc cannot be used with clone3() because the offsets
> for the time namespace need to be written before a process has been
> created in that time namespace. This means it is necessary to somehow
> tell clone3() the offsets for the clocks.
>
> The time namespace offers the possibility to set offsets for
> CLOCK_MONOTONIC and CLOCK_BOOTTIME. My first approach was to extend
> 'struct clone_args` with '__aligned_u64 monotonic_offset' and
> '__aligned_u64 boottime_offset'. The problem with this approach was that
> it was not possible to set nanoseconds for the clocks in the time
> namespace.
>
> One of the motivations for clone3() with CLONE_NEWTIME was to enable
> CRIU to restore a process in a time namespace with the corresponding
> offsets. And although the nanosecond value can probably never be
> restored to the same value it had during checkpointing, because the
> clock keeps on running between CRIU pausing all processes and CRIU
> actually reading the value of the clocks, the nanosecond value is still
> necessary for CRIU to not restore a process where the clock jumps back
> due to CRIU restoring it with a nanonsecond value that is too small.
>
> Requiring nanoseconds as well as seconds for two clocks during clone3()
> means that it would require 4 additional members to 'struct clone_args':
>
>         __aligned_u64 tls;
>         __aligned_u64 set_tid;
>         __aligned_u64 set_tid_size;
> +       __aligned_u64 boottime_offset_seconds;
> +       __aligned_u64 boottime_offset_nanoseconds;
> +       __aligned_u64 monotonic_offset_seconds;
> +       __aligned_u64 monotonic_offset_nanoseconds;
>  };
>
> To avoid four additional members to 'struct clone_args' this patchset
> uses another approach:
>
>         __aligned_u64 tls;
>         __aligned_u64 set_tid;
>         __aligned_u64 set_tid_size;
> +       __aligned_u64 timens_offset;
> +       __aligned_u64 timens_offset_size;
>  };
>
> timens_offset is a pointer to an array just as previously done with
> set_tid and timens_offset_size is the size of the array.
>
> The timens_offset array is expected to contain a struct like this:
>
> struct set_timens_offset {
>        int clockid;
>        struct timespec val;
> };
>
> This way it is possible to pass the information of multiple clocks with
> seconds and nanonseconds to clone3().
>
> To me this seems the better approach, but I am not totally convinced
> that it is the right thing. If there are other ideas how to pass two
> clock offsets with seconds and nanonseconds to clone3() I would be happy
> to hear other ideas.
>
>                 Adrian
>
>


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
