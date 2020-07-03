Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68522139E0
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGCMSD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 08:18:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37490 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgGCMSC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 08:18:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id 12so19844391oir.4;
        Fri, 03 Jul 2020 05:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oi7KCmisZZOxbTNZth57zE50NPkwGb8qPSfZLePIfnw=;
        b=Y+NvKN5ccU2sn/d+k/0WXGvEzvWhySF5BtgGmEJjc159Nr9LmZo82gW5E/SG8hAGxM
         AyfPFeckLIdRvUsWYLZB0FBfCKH/QixoiYK3vQCiGDMq3uEZaVZYpaSyr6x44+w8YsWo
         IfeHaQR0cqoeKciSB15jtcJOaMunN/Q/fXi50hEJZUpZ15IbBieUM2mvxnSWujLI+019
         z54Zf8uqU2OtbUJ5aF1bCGbo132DPeRp+jvSXTDjoopWwqxZxtgkd7qDCC7mhs1QUZyH
         vkScK8HMhcmvWrS5mtUFNU9C6Y97+lPaL9dszEhJmbwKmvSb2sPgVLHKQETQC7DTqYW/
         yb8Q==
X-Gm-Message-State: AOAM532pTkiUtkWmW7D6b3lpFn2QwrHrziRKGefYBLt3/6XZB9cEFFdw
        vBRsgD5jKGfdgdUlPvAfvOuI1MrlUXzyM5i73pg=
X-Google-Smtp-Source: ABdhPJxm1iEh0OWPmzqlUOmdOGmVD+UuYAFKeFz4ataM8y7DQH47+7k+7QSzTHoKyaeMab0wApcKrHwBwSbc13PGcPk=
X-Received: by 2002:aca:e188:: with SMTP id y130mr9572140oig.110.1593778681863;
 Fri, 03 Jul 2020 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com> <20200703113026.GT18446@dhcp22.suse.cz>
In-Reply-To: <20200703113026.GT18446@dhcp22.suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 3 Jul 2020 14:17:50 +0200
Message-ID: <CAJZ5v0g+ip-EuUsoK646W-jVSSUhbnvHKsWmFH0+F1w0oYSmGw@mail.gmail.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 3, 2020 at 1:30 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > This patch adds logic to the kernel power code to zero out contents of
> > all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > known as S3.
>
> How does the application learn that its memory got wiped? S2disk is an
> async operation and it can happen at any time during the task execution.
> So how does the application work to prevent from corrupted state - e.g.
> when suspended between two memory loads?

This doesn't affect hibernation AFAICS, but system suspend
(suspend-to-RAM or suspend-to-idle, or standby) is async too.

I guess this calls for an interface to notify user space (that opted
in to receive such notifications) on system-wide suspend start and
finish.

Thanks!
