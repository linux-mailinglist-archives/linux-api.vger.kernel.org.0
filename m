Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA338CAEF
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 18:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhEUQ2C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 12:28:02 -0400
Received: from mail-ej1-f52.google.com ([209.85.218.52]:34507 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhEUQ2B (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 12:28:01 -0400
Received: by mail-ej1-f52.google.com with SMTP id p24so30099599ejb.1;
        Fri, 21 May 2021 09:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmnJlJJivkksjDLx2Lgi9UeaAfE6lSqBa1f4XbYR5DM=;
        b=TppP9wyr5m62m2f5d0qA05iiLsOCZncjscb9Iaaj9I8EgmCk6e+fC+HncCrhR9g8PU
         32nwyLj6LXetjIpSEW+4EDz1dE/oIOXr7HB0vM5ybunruWEDgBZTbXZx0lWhtoVCpO3Q
         qfcL8u2GjywDy5qVsozYG+Y3xKTu4/xynhZCVyG0hKEA+AuPUDKUSO1i4GAOx3ErKU67
         unXq3MYYY2PeEDNEp4Nm/pg4xfDouDGLR2y9eWEPrQNjERU/FIDkMZYu87vtdy9zzWWf
         GYRERF3LuZwvDD336Jy6EmVO0OVBX3xp+Bd74/UBzyGeKLlrmvkJHndAJVmcFsDtEZZf
         E0Hg==
X-Gm-Message-State: AOAM531vhs4vL4DR0jFWRUmCEumh7SbZDRaMAwInLKve+j6CTU6xyTq/
        kNY2IyvMHccNsElowrRB/4ZJT0cJhMoUBTPmZt8RoDNx
X-Google-Smtp-Source: ABdhPJxz+dKx/EgTqHJREKd6K0s+yqNUvC5CmqZcyaTmfjAn3iOLHqTwmCxlpzBPU4/TP+lsuymzSUcqXdEhob3PDwU=
X-Received: by 2002:a17:906:4f91:: with SMTP id o17mr11042518eju.219.1621614396758;
 Fri, 21 May 2021 09:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com> <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com> <87r1i06ow2.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87r1i06ow2.fsf@oldenburg.str.redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 May 2021 12:26:25 -0400
Message-ID: <CAJvTdKkw-ZUHmH3_ctmpXV0gLjR2GnmgDCRxaUZ+kZN9Ti7X5g@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 12:19 PM Florian Weimer <fweimer@redhat.com> wrote:

> I see.  So essentially the hardware wants to offer transparent
> initialize-on-use, but Linux does not seem to want to implement it this
> way.

That is a reasonable summary.

> Is there still a chance to bring the hardware and Linux into alignment?

The hardware was done some time ago, so this is a Linux decision.

The current trajectory is that for user space to use TMUL it must
1. query CPUID to see if the instructions exist
2. query xgetbv(XCR0) to see if the OS supports the state
3. Tell Linux that this thread wants to use the state.

The original proposal required just #1 and #2.
It is clear that Linux can not support that, and so #3 is being added.

Of course, if #2 is false, then Linux will return failure for #3,
so technically you could skip that check and just make this new syscall.
Probably user-space will still need to query CPUID for the instructions,
since there will be a many-to-one mapping of instructions to state.

Len Brown, Intel Open Source Technology Center
