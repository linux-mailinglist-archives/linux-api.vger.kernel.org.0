Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB86638D1D5
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 01:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhEUXKA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 19:10:00 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:46825 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhEUXJ7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 19:09:59 -0400
Received: by mail-ej1-f54.google.com with SMTP id u21so32632907ejo.13;
        Fri, 21 May 2021 16:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=42bMK2z1Scf6IgRWuylgcFySbLCvSYw2RhDSwWVP40Y=;
        b=pL4Zgjfx/XZ4cZAPi3fc6E2X2c2KSaqGQJ97offb+62dsYEMxVwbiaCGT0eg6KFuoF
         ShFbTCq6tPs/v2/s48RA5UNMG/1WG/AFnbZUCeHMaEeZpghunofN4lJ7aKcNqUCLdpo2
         EJbFQ0tIoUMUaWQ1xH65oLqEl57TzT94zhkEnrtRJYEi7vow2T2X8RCT1CwpMiubps5M
         9jKDvzJal4c79TKeYLT+yVGfK6nibjFfVXizcXFd/1h1cv6FJ/unpW1tKHKR/J2jtEvy
         R/hKm+eJLOF4AneIaOJzHdGXnvo/Q4nkwBjEVHIshMav5w5LYMvK1Zavi4BkWfpEFkWq
         oUTg==
X-Gm-Message-State: AOAM532nONoELnok1PJsTGvh5UZ/ivrwy00+Ms+/IVGMGZ+dva9wptAJ
        Q3KixvyWqMsowcgNtRtpqXzAQq4i+inn6GobtIMkMmWM
X-Google-Smtp-Source: ABdhPJz59tFl2JedBJdKQuvAxGnRnXSbBKjuAYr4ZJ+ZGgcO0cKxoWDx1nXECGA/WM7zSzC5xh31AtBS1GAUhdLE/ro=
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr12709200ejz.501.1621638514252;
 Fri, 21 May 2021 16:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com> <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com> <87r1i06ow2.fsf@oldenburg.str.redhat.com>
 <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com> <87k0nraonu.ffs@nanos.tec.linutronix.de>
 <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com> <06705386-8c7c-d705-9f89-1d894aa0878f@intel.com>
In-Reply-To: <06705386-8c7c-d705-9f89-1d894aa0878f@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 May 2021 19:08:23 -0400
Message-ID: <CAJvTdK=VqyJ9io7bFeQDWfUtnG_iF=MqxVzPYDzEB8BJESgkyA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 7:06 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/21/21 3:07 PM, Len Brown wrote:
> > My concern about synchronous allocation is that it will be very easy
> > to abuse.  programs and threads can ask for buffers they will never
> > use.  With on-demand allocation, we allocate buffers only if they are
> > actually needed.
>
> If someone wants to abuse the on-demand allocation, they will simply
> write a single bit to an AMX register.  That does *NOT* mean they will
> actually execute an instruction that actually uses AMX to do something
> meaningful.
>
> In the face of abuse, I think the two approaches are very similar.

I didn't mean "abuse" in terms of malicious resource hogging.
I meant "abuse" in terms of unnecessarily using resources out of laziness.
