Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A493CC725
	for <lists+linux-api@lfdr.de>; Sun, 18 Jul 2021 03:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhGRBlX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Jul 2021 21:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhGRBlX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Jul 2021 21:41:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3EC061762;
        Sat, 17 Jul 2021 18:38:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x16so7626676plg.3;
        Sat, 17 Jul 2021 18:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WEdBd0twgdRTUN6zbU42jso5KNi/Ttb0Ghjj44rsXrs=;
        b=WEkUZCnkeLGPvpSAl90lA8V4IZev7XrxWgU8z+ZZ3KkFUF8rK4e9lJRwMsVqk/rgDk
         ORNlmoVAHX9zuz7DJZbh1TsBzlQvPnlHZ+qVPg4lbXEcDWCUiQb7a2ecQkI28DzArToL
         9fikyeV20oE1Vc4AUlp2+U+64ANu3oOG3K9/NLrgRzGUcirNQMdYUhjCobwQ26sgeEL2
         ppEUkLQ6xCDzAo1Fq8sFf93lhHl0zmzQPLcwxvm3m0ZkRdwcSScVoAcf92Vdxdo3PM0j
         t3x+IYlrynoaymyLDVjWdgG/iUAgaAgJbqyIDkTZzJhuQW3lT/rJyBy4pBqyY8U3k++8
         sI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WEdBd0twgdRTUN6zbU42jso5KNi/Ttb0Ghjj44rsXrs=;
        b=B1OiGc2W4NdPSKSVSz1Ciep4ORfJFG/QDanJJD+nNj06sFHZkCBBXcu4qs6JHcwYZ4
         w3EFyJjGK78FJMoHuUl/oDUx8K24SHfakh3ZZBr+H3m+6wllBOHpkKKXl85nqPNppUDH
         PIJ/Jra3KOL0ymZnkQmyG8nY8hZXVoahL1ry7/GL1uYeyjuJwEy3ItI1zz8X6K9QQ1Gk
         piyrzY+Za4qu+HWjTCwaqoHeb5ZjLUqkDWUbHofX/8+r08u42vVfiq3ObDFBCuo0wsnd
         TL4PDerIxhT+Eh97e9zq1ir2nVjtgVUSkd92hj4UV2rAEPR1osW+Gx9oOi//YTBlw0Kz
         qOVA==
X-Gm-Message-State: AOAM5323lluOwmzPjSRMF9PPcvFvQm9QW76xWr4IwBHHgURBdwiLlHZM
        Lr1gtUx62nJdWd38hil1WxQ=
X-Google-Smtp-Source: ABdhPJzXist5OPRGItTQ3oVS05KQC1wCjZ/gM0LnpufPstiTA6CQfKmzmJbNaY/pSIeyZXB/vNX8JQ==
X-Received: by 2002:a17:902:f549:b029:12b:4d26:c7e1 with SMTP id h9-20020a170902f549b029012b4d26c7e1mr13385910plf.45.1626572304140;
        Sat, 17 Jul 2021 18:38:24 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id r10sm14440229pff.7.2021.07.17.18.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 18:38:23 -0700 (PDT)
Date:   Sat, 17 Jul 2021 18:34:39 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
Message-ID: <YPOFL6QHZl2pq+cb@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <6073e4c6-6fe8-0448-4586-5d04d7154164@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6073e4c6-6fe8-0448-4586-5d04d7154164@kernel.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 02, 2021 at 03:44:41PM -0700, Andy Lutomirski wrote:
> On 4/13/21 10:52 PM, Andrei Vagin wrote:
> 
> > process_vm_exec has two modes:
> > 
> > * Execute code in an address space of a target process and stop on any
> >   signal or system call.
> 
> We already have a perfectly good context switch mechanism: context
> switches.  If you execute code, you are basically guaranteed to be
> subject to being hijacked, which means you pretty much can't allow
> syscalls.  But there's a lot of non-syscall state, and I think context
> switching needs to be done with extreme care.
> 
> (Just as example, suppose you switch mms, then set %gs to point to the
> LDT, then switch back.  Now you're in a weird state.  With %ss the plot
> is a bit thicker.  And there are emulated vsyscalls and such.)
> 
> If you, PeterZ, and the UMCG could all find an acceptable, efficient way
> to wake-and-wait so you can switch into an injected task in the target
> process and switch back quickly, then I think a much nicer solution will
> become available.

I know about umcg and I even did a prototype that used fuxet_swap (the
previous attempt of umcg). Here are a few problems and maybe you will
have some ideas on how to solve them.

The main question is how to hijack a stub process where a guest code is
executing. We need to trap system calls, memory faults, and other
exceptions and handle them in the Sentry (supervisor/kernel). All
interested events except system calls generate signals. We can use
seccomp to get signals on system calls too. In my prototype, a guest
code is running in stub processes. One stub process is for each guest
address space. In a stub process, I set a signal handler for SIGSEGV,
SIGBUS, SIGFPE, SIGSYS, SIGILL, set an alternate signal stack, and set
seccomp rules. The signal handler communicates with the Sentry
(supervisor/kernel) via shared memory and uses futex_swap to make fast
switches to the Sentry and back to a stub process.

Here are a few problems. First, we have a signal handler code, its
stack, and a shared memory region in a guest address space, and we need
to guarantee that a guest code will not be able to use them to do
something unexpected.

The second problem is performance. It is much faster if we compare it
with the ptrace platform, but it is still a few times slower than
process_vm_exec. Signal handling is expensive. The kernel has to
generate a signal frame, execute a signal handler, and then it needs to
call rt_sigreturn. Futex_swap makes fast context switches, but it is
still slower than process_vm_exec. UMCG should be faster because it
doesn’t have a futex overhead.

Andy, what do you think about the idea to rework process_vm_exec so that
it executes code and syscalls in the context of a target process?
Maybe you see other ways how we can “hijack” a remote process?

Thanks,
Andrei

> 
> > 
> > * Execute a system call in an address space of a target process.
> 
> I could get behind this, but there are plenty of cans of worms to watch
> out for.  Serious auditing would be needed.
