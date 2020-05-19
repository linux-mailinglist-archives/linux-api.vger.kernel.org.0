Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999C81D9DD3
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgESRXJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 13:23:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52360 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729001AbgESRXI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 13:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589908986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xr0IWkc5cd9RFwz8LsU7++TtyuSvnhVK7nv8eOr0z7U=;
        b=KDuBvM5maDQYd2yaYAoVB9cOJoQ+7PBrLYFocEyHxFiUatoUxx59wdYR+DIgnSdVS2naiO
        0XcEHDWZcRGehznei2dODhplFa1I2EApw+aqD2Z8nODGGcwWuWF6Ztxk6pYop2qZm/Kll9
        F0CiDrsnfuOWjUNI0SRvgJcUypEzbMg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-Cuwind2IOq6aLQDLkGBfsA-1; Tue, 19 May 2020 13:23:02 -0400
X-MC-Unique: Cuwind2IOq6aLQDLkGBfsA-1
Received: by mail-ed1-f69.google.com with SMTP id bs5so13800edb.18
        for <linux-api@vger.kernel.org>; Tue, 19 May 2020 10:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr0IWkc5cd9RFwz8LsU7++TtyuSvnhVK7nv8eOr0z7U=;
        b=C1QGfj5bUhtuWBU//VTCYbTch2E0wq6aV7kzS1zbRrb/lnYk8ZfSs2MRNyrwLn7jF/
         ipz1tBvjQugh0e092nX05O2wwaxiMxvXexyyIepcIm79xytbnI4cTRvVJzHdYgDdjwGE
         tYBoqtCvqeXPXFM8gp07qURZZS3Xui93EUmqBhCfxe5P140TkblDiPvGM9Wvcw5GE9xc
         h2w66vIJLDp2qqUzrHrIHjKJxnxQQ+5IfhW0Bt8AybtKgfxlrq92WgR3URaN8S/Gxfur
         OPiTrXXwDUdw6rVQyhDX9/uNJEceaTokRtNTMJ2ChTZp9lZyFH03Asf+ckfWel8QoxbC
         tsyw==
X-Gm-Message-State: AOAM533SA0UF5Yo0j1gB/BxU8OHVQqaXGyFrDmrLmcMKOCY2tO7NttE6
        s0h3TQYJ+HtRL5AvKjzkJad73qQLDUfVbykJ28ExBLtnF3TRIssUs16hxegwsmgdUi9pZtcnweF
        Oy3F5Ig+AdiEquCIreeRfWPnSF6r6FvUn7n/f
X-Received: by 2002:a05:6402:68f:: with SMTP id f15mr28539edy.89.1589908980858;
        Tue, 19 May 2020 10:23:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhliVX54qC9F8tVH/Uxlkhcajof6VHEtCuyT4Y7J/8+Qf6Szuk4QIj8ZglKda578e6zYVbHGherzcpsBKGMzY=
X-Received: by 2002:a05:6402:68f:: with SMTP id f15mr28523edy.89.1589908980585;
 Tue, 19 May 2020 10:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <158955700764.647498.18025770126733698386.stgit@buzz>
 <20200515162707.GI2978@hirez.programming.kicks-ass.net> <403cc691-4ec5-8b3f-382c-4820736da41d@redhat.com>
In-Reply-To: <403cc691-4ec5-8b3f-382c-4820736da41d@redhat.com>
From:   "Carlos O'Donell" <carlos@redhat.com>
Date:   Tue, 19 May 2020 13:22:48 -0400
Message-ID: <CAEMqeSqr9D6uj2OB0_5uT03c_au3906z_oyhX3zfg4OempTJVw@mail.gmail.com>
Subject: Re: [PATCH] futex: send SIGBUS if argument is not aligned on a
 four-byte boundary
To:     Peter Zijlstra <peterz@infradead.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 15, 2020 at 1:50 PM Carlos O'Donell <carlos@redhat.com> wrote:
> This isn't fixed because this is the older code in pthread_mutex_lock
> which we haven't ported to futex-internal.h yet, otherwise we would abort
> the process.

I filed this upstream as a QoI issue so I don't forget to port the existing code
to the newer internal interfaces for futex handling.

"Bug 25997 - pthread_mutex_lock QoI issue for unaligned futex."
https://sourceware.org/bugzilla/show_bug.cgi?id=25997

I checked that -Wcast-align=strict does warn about this case, but it's
rarely used
in production code that I've worked with. I'm following up with the
compiler people
to see if we can consistently warn in these cases and so avoid this kind of code
existing in the first place.

Cheers,
Carlos.

