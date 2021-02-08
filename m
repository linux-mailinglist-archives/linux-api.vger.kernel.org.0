Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2CA313D9F
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhBHSfX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Feb 2021 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbhBHSeD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 8 Feb 2021 13:34:03 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A256C061788;
        Mon,  8 Feb 2021 10:33:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fa16so62087pjb.1;
        Mon, 08 Feb 2021 10:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mEJZ0ZpLe5V+Hwesxu2Q7j9S4ixMQFc1RZqNUqFzFw0=;
        b=fzTC5UF811/9wmC0owcaUofLPqmABFbU2HydH3c5dfuWew7zwmzX4zc0EYdNyZnO5L
         vbEB1n4XNqx7cUrlUR+p4DDrYTYp4rorJL5m9DFH34aMBQC9IiXzcPskcySSBpkYn5o2
         BPV9J7cm+O3flSeBj+pnYEGVkbCzzWN5iye/mof0BtJ7yHYHpVU7Rd648IYeJsEKffeF
         zpCYn2c6M0vIxLfLkIaLlAIGVUKUm4ejUZgFybMVkHqiJsqgmDRvHNSgNROrhzyKc/gh
         ik760cUSzTlZP8Mj7ek9IHdtjpR3Zeq9a+wPAXxq14mcQQ4hT2w3sHOFs7xHhRH/mCvO
         w7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mEJZ0ZpLe5V+Hwesxu2Q7j9S4ixMQFc1RZqNUqFzFw0=;
        b=NWlUa4KdpAaNliX5iladw+L44p+of8/WDDGIVJIMM08gaS5xTlJhRnofPhMafms5OL
         p+HqDABuB9cHiyA16LCpvSe/CCLun0iPVHt4y7N1ihInlgsd/VKmUuoDGNNFTr/nLEI4
         6SKP7tljsb7UOlYYLuZgeksNp0x6ut7zgOHWT8U8ZxewU4sMOpitqjFqQCX2HavhrWco
         4B5OaZAa3bnGZS6r3kHNf2T8WAFup+QgqBgXM7hxj8cLfemJEvVKXn+oLWsXvw3hQyfm
         CwPDN2fE1QGaQ3JFuMGtpNlVBZGMS0WFi63TA+F+SHMtjrNasqlnDRHZsLvSTBv7T/aG
         OaUw==
X-Gm-Message-State: AOAM531zWr/jbuFtRgU2/TAmG9Q9NvKiJk7XU+gGfmL1SeRrOELoKXi+
        AYnltBztIULumE1a9ob6A+I=
X-Google-Smtp-Source: ABdhPJy8N84AH5SAi2pdUHvIMNYnC4ZAFk5GTjflBAq30S3MPfq2xZRFfBZOKxED1jVC0D473VSkdg==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr130289pjb.62.1612809202930;
        Mon, 08 Feb 2021 10:33:22 -0800 (PST)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id np7sm29272pjb.10.2021.02.08.10.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:33:22 -0800 (PST)
Date:   Mon, 8 Feb 2021 10:31:35 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        Keno Fischer <keno@juliacomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>
Subject: Re: [PATCH 2/3] arm64/ptrace: introduce PTRACE_O_ARM64_RAW_REGS
Message-ID: <20210208183135.GA559391@gmail.com>
References: <20210201194012.524831-1-avagin@gmail.com>
 <20210201194012.524831-3-avagin@gmail.com>
 <20210204153615.GB21058@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210204153615.GB21058@willie-the-truck>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 04, 2021 at 03:36:15PM +0000, Will Deacon wrote:
> On Mon, Feb 01, 2021 at 11:40:11AM -0800, Andrei Vagin wrote:
> > We have some ABI weirdness in the way that we handle syscall
> > exit stops because we indicate whether or not the stop has been
> > signalled from syscall entry or syscall exit by clobbering a general
> > purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
> > and restoring its old value after the stop.
> > 
> > This behavior was inherited from ARM and it isn't common for other
> > architectures. Now, we have PTRACE_GET_SYSCALL_INFO that gives all
> > required information about system calls, so the hack with clobbering
> > registers isn't needed anymore.
> > 
> > This change adds the new ptrace option PTRACE_O_ARM64_RAW_REGS.  If it
> > is set, PTRACE_GETREGSET returns values of all registers without
> > clobbering r12 or x7 and PTRACE_SETREGSE sets all registers even if a
> > process has been stopped in syscall-enter or syscall-exit.
> > 
> > Signed-off-by: Andrei Vagin <avagin@gmail.com>
> > ---
> >  arch/arm64/include/uapi/asm/ptrace.h |  4 ++
> >  arch/arm64/kernel/ptrace.c           | 70 ++++++++++++++++------------
> >  include/linux/ptrace.h               |  1 +
> >  include/uapi/linux/ptrace.h          |  9 +++-
> >  4 files changed, 52 insertions(+), 32 deletions(-)
> 
> Please split this up so that the arm64-specific changes are separate to
> the core changes.

ok

> 
> > diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> > index 83ee45fa634b..bcc8c362ddd9 100644
> > --- a/include/uapi/linux/ptrace.h
> > +++ b/include/uapi/linux/ptrace.h
> > @@ -7,6 +7,7 @@
> >  /* has the defines to get at the registers. */
> >  
> >  #include <linux/types.h>
> > +#include <asm/ptrace.h>
> >  
> >  #define PTRACE_TRACEME		   0
> >  #define PTRACE_PEEKTEXT		   1
> > @@ -137,8 +138,14 @@ struct ptrace_syscall_info {
> >  #define PTRACE_O_EXITKILL		(1 << 20)
> >  #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
> >  
> > +/* (1<<28) is reserved for arch specific options. */
> > +#ifndef _PTRACE_O_ARCH_OPTIONS
> > +#define _PTRACE_O_ARCH_OPTIONS 0
> > +#endif
> 
> It seems a bit fragile to rely on a comment here to define the user ABI;
> why not define _PTRACE_O_ARCH_OPTIONS to the right value unconditionally?

We don't want to allow setting options that are not supported.
_PTRACE_O_ARCH_OPTIONS is added to PTRACE_O_MASK and then
ptrace_setoptions checks whether all specified options is supported or
not.

> 
> Also, it seems as though we immediately burn this bit on arm64, so if we
> ever wanted another option we'd have to come back here and allocate another
> bit. Could we do better, e.g. by calling into an arch hook
> (arch_ptrace_setoptions()) and passing the 'addr' parameter?

I am not sure that I understand the idea. Do you suggest to have
PTRACE_O_ARCH_OPTION and pass arch-specific options in addr? In this
case, I think it could be more cleaner to introduce a new ptrace
command. If this is the idea, I think it worth doing this only if we
expect to have more than one,two,three options.

As for my solution, we need to come back to allocate a new bit
to be sure that we don't intersect with non-arch specific options.
And those who add a non-arch option should see that they don't use bits
of arch-specific options.

Let's decide what interface we want to use to solve the problem and then
if we will stop on a ptrace option I will figure out how to improve
this code.

> 
> How do other architectures manage this sort of thing? I'm wondering whether
> a separate regset containing just "real x7" and orig_x0 would be preferable
> after all...

Yeah, it might be a good idea. We will need to do one extra ptrace
system call, but in comparison with ptrace context-switches, this is
nothing.

Dave, Keno, what do you think about this?

> 
> Will
