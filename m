Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0093B862A
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhF3PX3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 11:23:29 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:35416 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbhF3PX2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 11:23:28 -0400
Received: by mail-ed1-f41.google.com with SMTP id df12so3826129edb.2;
        Wed, 30 Jun 2021 08:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sz1XXHWZ7zn1WpHe2P7mcJtnwjKt4l13a3EOZTMRPAo=;
        b=YlJwaIFd1dvboak11sCCPkFvUblbcUhH4kkHmQYGjUVWfk65TxvrBEt3cCGh+IVcVl
         8ODa4KqRakqWmt3uZE3F49SGGVCbErtfiTt+g84X5UXmgxbZ037nVlsu+ExO/aWoBk52
         111Zhb8jlW8C3Weq5wYA3RoodWLhah9WuX3gGk6j/L6BoGNLxduOIyGLBlQ4ICAoo9w4
         LDjCobAYkNWcaPBgQz3uoH3gW9/fQcfjnKZrUq5EQyjbn/NFPKAfHYRS784TAzn+7WZu
         bb9EOxCB/Rajo3LNixyGPyqQqPrhPCQhtSphEQPCTO7u4s6JG5aZcWCTDL6lHeJO2a4Q
         hlbg==
X-Gm-Message-State: AOAM5311U9VaUcf3hPA0gBg5cenadp1b2siKA3GG6NWZtDXnjTBx0ijw
        264XFwIr9QdAgMp6Jq+CtYvkGv+ro8YBgbUxzmnBDMe2O/A=
X-Google-Smtp-Source: ABdhPJxTzFTAllAFF5dh/zsKE885gd2rn3QWQvuP9AHb6vrfEx/T/lgKjt1C+F/rqfHw6PNi6YS86cztvhpC7hViPEs=
X-Received: by 2002:a05:6402:31b4:: with SMTP id dj20mr48326007edb.186.1625066458480;
 Wed, 30 Jun 2021 08:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com> <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net> <87wnqkzklg.fsf@oldenburg.str.redhat.com>
 <CAJvTdKkBTD62GTi=GW0+y0_1qc2JxfpfkNbXKWniWWOEmZZmUw@mail.gmail.com>
 <93e3b500-5992-a674-18e6-445d1db7b1f0@metux.net> <87tulirw5y.fsf@oldenburg.str.redhat.com>
 <84be3cfd-e825-ae75-bbae-2bbd3360daa7@metux.net> <0978e79c-33ad-c05b-3897-99334c381396@linux.intel.com>
In-Reply-To: <0978e79c-33ad-c05b-3897-99334c381396@linux.intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 30 Jun 2021 11:20:47 -0400
Message-ID: <CAJvTdKkwSxUzyUjTMKUUpaFRz49AoxtxTDYAPfAFPQtRmA_87w@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The latest proposal for kernel AMX support (updated today) is here:

https://lore.kernel.org/lkml/20210630060226.24652-1-chang.seok.bae@intel.com/

The main challenge for AMX is not context switch performance.
Hardware recognizes INIT state (the common case) and skips that data
transfer when it is not needed.

The main challenge for AMX is compatibility.  Specifically, user
signal stack growth.
The legacy ABI is that we put an uncompacted XSTATE image on the signal stack.
In the default stack case, this isn't a problem, but when a user
allocates an alternative signal stack,
the 8K of XSTATE growth that AMX can exceed what the user allocated.
The new system call tells the kernel that the application can handle it.
(it can do this by not using altsigstack, or by using the updated
stack size advertised
 by glibc 2.34 and later, or some other means)
