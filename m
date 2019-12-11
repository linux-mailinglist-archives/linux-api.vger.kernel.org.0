Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94F511BE0E
	for <lists+linux-api@lfdr.de>; Wed, 11 Dec 2019 21:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfLKUim (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Dec 2019 15:38:42 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41650 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKUim (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Dec 2019 15:38:42 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so217541ioo.8;
        Wed, 11 Dec 2019 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=js6RVN7j31/GZRIwpW6XAyIVVSgpszrUnhZR4AgZ4yE=;
        b=KBDqTVadjplSXvCM2S86+WTP7Y7TWI4QaZi2Y4hiulMVCDpjFy525FnKsnhC+tQHMn
         Qm89vJPIv7ua7tN1LSb51wRo6CpgCF/t12v3sZ9BhA/vGvvLWBxHHLugbd+o74h+ZSCM
         3EWNEF2ZQZdjHGbN1IlHwH3QilNyMFTTAbt23QQkrRt9DBlMdSeXn1kQqVQGmcCpA2p7
         11a+grgG/AJJO6RqVQwQcqqJxFGBc6dq+OgShyn1m2k5Vwdf6y+nkch0GW2ryOK09KH1
         TGEALHLhPn/D+VNY5qH09UA4EGO1I9MuNe4cPSsq2QXwuZC/1DJ7Fi8yYnDLscDk72mi
         blGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=js6RVN7j31/GZRIwpW6XAyIVVSgpszrUnhZR4AgZ4yE=;
        b=JBVpMF7CeEoOz/x/nJ0aXHx1rBjKNZCjcUwEYiZDJdPRoKxQbdLNqRiVjpANaWb+74
         +CIyeYodWBq21WSs6Cp+dqyXoZ5/kh9Ng8tTFMpSG+uEHuieyvKRPC4VI85fxsKlAShD
         CVAjyZLVB1J3notnuzb5/+qvUbZwqWVhZzLBlsbJv6fbUNVzb9xOaCP34giwdvcFBBfI
         BD91g7OcTRSoeGi1GJvFyjrULX+UOya1BQd2pQ6QDICM1TKfhnFRvs9PSnZYkIDuQhOT
         r8EHt56IpbXb8dg68zfvDzHIGhrtQ7dhI7WfFUiZXd7mNBNpy3L2HHFeKW9fMGALaYUN
         C/AA==
X-Gm-Message-State: APjAAAWFEonEAfFi6leChRIvfAQfhx5l6hOLSfGtKsFMpwvrUHUD5B+0
        7TvHo+NJTHx0sPbD7XO//vrZbl/iOKd7J+UuftI=
X-Google-Smtp-Source: APXvYqwQeKbO/dYcrquPZ+NylZ+Iftd8dHKvUxFqZqGzmOWsz4cA0DN70p2YTHWuQO/mWHyZO8fVIy8IS6BiN6x2r48=
X-Received: by 2002:a05:6638:a2c:: with SMTP id 12mr4977856jao.60.1576096721721;
 Wed, 11 Dec 2019 12:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20191112012724.250792-1-dima@arista.com> <20191121180555.GA440967@gmail.com>
In-Reply-To: <20191121180555.GA440967@gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Wed, 11 Dec 2019 20:38:30 +0000
Message-ID: <CAJwJo6ahGVHHgwFsPyjbY1PgmHs+D+A2Cma03ogvQGr+mPqYAw@mail.gmail.com>
Subject: Re: [PATCHv8 00/34] kernel: Introduce Time Namespace
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        crml <criu@openvz.org>, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Gentle ping, in case you have time to look at this.

On Thu, 21 Nov 2019 at 18:05, Andrei Vagin <avagin@gmail.com> wrote:
>
> Hi Thomas,
>
> What is your plan on this series? We know you are probably busy with
> the next merge window. We just want to check that this is still in your
> TODO list.
>
> On Tue, Nov 12, 2019 at 01:26:49AM +0000, Dmitry Safonov wrote:
> >
> > v7..v8 Changes:
> > * Fix compile-time errors:
> >   - on architectures without the support of time namespaces.
> >   - when CONFIG_POSIX_TIMERS isn't set.
> > * Added checks in selftests for CONFIG_POSIX_TIMERS.
> > * Inline do_hres and do_coarse.
> >   (And added Tested-by Vincenzo - thanks!)
> > * Make TIME_NS depends on GENERIC_VDSO_TIME_NS and set it per-arch.
> >
> > [v1..v7 Changelogs is at the very bottom here]
> >
> > Our performance measurements show that the price of VDSO's clock_gettime()
> > in a child time namespace is about 8% with a hot CPU cache and about 90%
>
> Here is a typo. The price of VDSO's clock_gettime() in a child time
> namespace is about 12% with a cold CPU cache. The table with
> measurements for a cold CPU cache contains correct data.
>
> > with a cold CPU cache. There is no performance regression for host
> > processes outside time namespace on those tests.
> >
>
> ....
>
> >
> > Cold CPU cache (lesser tsc per cycle - the better):
> >
> >            | before    | CONFIG_TIME_NS=n | host      | inside timens
> > --------------------------------------------------------------
> > tsc        | 476       | 480              | 487       | 531
> > stdev(tsc) | 0.6       | 1.3              | 4.3       | 5.7
> > diff (%)   | 100       | 100.9            | 102       | 112
> >

Thanks,
             Dmitry
