Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8A38D7D9
	for <lists+linux-api@lfdr.de>; Sun, 23 May 2021 01:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhEVX5X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 May 2021 19:57:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhEVX5X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 22 May 2021 19:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F39B60238
        for <linux-api@vger.kernel.org>; Sat, 22 May 2021 23:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621727758;
        bh=6dXbeile7lzsbpeK/x/mWQ+Zr2cMohG3GFCCGvZUMNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t2dtZYHN4jh0HJtjGL9PAqNUzbTubKtHgUnjKOMeNKvll0rGjq+uk2A0wZbdmyj9y
         WqvTgKrk4NdcBHxcDIBhCvSarLpFmGF7RzbXCzugFR9Kx8Acgy+lNd10nsb48I6vSQ
         IzQwSmcLXwu1AqyAk27BtDGeWtrEsFicsPp+vWObkdVLtqQQkrXwvYWPd94VOjQkfi
         EIQls3REdhYS3+NRof0yu4Lc4XO8M6CLAwnQefbysKWpD51ecrNKoOe2SM28jKFKb5
         IYnn571R5veecTo1tC2uSpVOUTLwmLfKDEw/8eL1ntnFmorFUswG6wLpWCVTg1A+SM
         nfr3XqBQoZHhA==
Received: by mail-ej1-f48.google.com with SMTP id b9so831411ejc.13
        for <linux-api@vger.kernel.org>; Sat, 22 May 2021 16:55:58 -0700 (PDT)
X-Gm-Message-State: AOAM532BCy+MslwnbrjUwo3a6HTkFMlW5/eDYaGDa7aV5ZPU5gn8M0K1
        2fhbu/Y7ftVs2B+BTjocJFPp10AR/GVlkv2vV5TE6g==
X-Google-Smtp-Source: ABdhPJxJkfTVZX1D7O/qi5DCkclvDa1gfvKJMw3NcfhZGA89F9ozJOuPevIQdleeWUC5lmn1dO2QP7wG/n5rEjVIIns=
X-Received: by 2002:a17:906:c010:: with SMTP id e16mr16823348ejz.214.1621727756732;
 Sat, 22 May 2021 16:55:56 -0700 (PDT)
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
 <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com>
 <878s47aeni.ffs@nanos.tec.linutronix.de> <CAJvTdK=Ws1QvBvdx50OSmAi0vBX49KZZHUoiMFbhUUEPmjGmBw@mail.gmail.com>
 <877djr5jc3.fsf@oldenburg.str.redhat.com>
In-Reply-To: <877djr5jc3.fsf@oldenburg.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 22 May 2021 16:55:45 -0700
X-Gmail-Original-Message-ID: <CALCETrX+g+G4m4ZDe+DME+EdG0ZROGP+EPvQrX5=RcMFOZBiRA@mail.gmail.com>
Message-ID: <CALCETrX+g+G4m4ZDe+DME+EdG0ZROGP+EPvQrX5=RcMFOZBiRA@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> On May 22, 2021, at 12:17 AM, Florian Weimer <fweimer@redhat.com> wrote:
>
> =EF=BB=BF* Len Brown:
>
>> A. per-task.  If we do it this way, then we will likely wind up
>> mandating a GET at the start of every routine in every library that
>> touches AMX, and potentially also a PUT.  This is because the library
>> has no idea what thread called it.  The plus is that this will address
>> the "used once and sits on a buffer for the rest of the process
>> lifetime' scenario.  The minus is that high performance users will be
>> executing thousands of unnecessary system calls that have zero value.
>
> We could revive the KTLS proposal (userspace donates memory for use by
> the kernel & vDSO), and the thread could reserve (on-stack) buffer space
> for kernel use for the duration of the AMX computation.  There would be
> a pointer to that space in the KTLS area, set upon entry of the AMX
> region, and cleared upon exit.  It's not extremely cheap (unbounded
> alloca has a stack probing loop nowadays).  But no system call is
> required.
>

Making this work well would be very nasty. The memory *must* be
available at context switch out time, which means it would need to be
pinned at context switch in time, which is not great.

But also Intel, in its infinite wisdom, decided to mix =E2=80=9Csupervisor=
=E2=80=9D
states in which the state that user space is permitted to directly
access. Putting the supervisor state on the stack would be
problematic.
