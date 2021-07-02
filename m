Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E899E3BA5F4
	for <lists+linux-api@lfdr.de>; Sat,  3 Jul 2021 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGBW1a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 18:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhGBW1a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 18:27:30 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8F9C061765;
        Fri,  2 Jul 2021 15:24:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a127so10362279pfa.10;
        Fri, 02 Jul 2021 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TM6cjgF2amzNsWvXOB7KJYtX5jxhorxbWHwc1I9Rrtw=;
        b=SXpkEDNH/iGEKPGIGJQ+P9nX3dWAhgZii4Bd3EV5wTQhaQPy619uoJUzR6cjZbC18W
         DaWUT90O5ug/ThjjYGZKrEQ5FbNLyJsR99Llg4VFauOUfA8FctMxLzDMaeiFX4k+DDym
         Z7oH2IT72uD/htMxeHNaKWlYWzSQdjPg0za7exx5Qe55/paMiOhm3cHD0oNHcSmM8kIk
         B5HQVntDF5bVhJ/QwwDOQdthYHEJdbmqTbWIzwG5e6pX3/ClZz7sNwujTuCOAt5o6mSu
         3hwonR3hx7FE8Dz6w8K4fyghbz1zIkA+Bh/zoEI3JcIe7pFRESe6MGZq5gfOfVAiUV4t
         LBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TM6cjgF2amzNsWvXOB7KJYtX5jxhorxbWHwc1I9Rrtw=;
        b=aXECF90TfqgQEhCHOo4fBSBsuogaVNHYJsbmjgfl+B0eYGbEzzLtbh55qCuSgo9oJ9
         1tiHAZZsonpCKqYg7sxJmwDoBHEfTAdhND/eaQ+J80CuNwZzI0hHg4RW4weJm6+HevWB
         Ok+fKGZmoXbt5/fOqzubJSVwGWfyzktYdtczsAgFNUXvMH8tngqax/zY2hFum6Wl+Pak
         h3G9twp8VZSkaDW3NcVOb9kMJ4lDazm4YUnB4Hlp5SUvzp1fFsoqOfw4oUA8M/uIUiYv
         jzMh+7r2xScpcwXshbXihW5zNBJGWPgjZEqFh3jOclwavPEAFwMR6x9p7Rd995tXU1is
         tICg==
X-Gm-Message-State: AOAM533VpQE41DIXsG9s054/wILKwVBF6+cl2a6s2GB2R9rtwGLdpfih
        PCdZPQ7ERv39SrhgWh+LBzE=
X-Google-Smtp-Source: ABdhPJxuPQTSDKsRpxKijJCvdVGphsFcyH6VXS8A1u6xap6S4Lz36I5vBFbYaTsQeUU7SBLy12yqyA==
X-Received: by 2002:aa7:9727:0:b029:304:3644:2771 with SMTP id k7-20020aa797270000b029030436442771mr1682109pfg.73.1625264695987;
        Fri, 02 Jul 2021 15:24:55 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id y4sm5083312pfc.15.2021.07.02.15.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:24:55 -0700 (PDT)
Date:   Fri, 2 Jul 2021 15:21:22 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN+RYi5honrgjFAw@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <YN7TgV9RDJTRaY8R@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <YN7TgV9RDJTRaY8R@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 02, 2021 at 10:51:13AM +0200, Peter Zijlstra wrote:
> 
> I'm terrified of all of this...
> 
> On Tue, Apr 13, 2021 at 10:52:15PM -0700, Andrei Vagin wrote:
> 
> > +long swap_vm_exec_context(struct sigcontext __user *uctx)
> > +{
> > +	struct sigcontext ctx = {};
> > +	sigset_t set = {};
> > +
> > +
> > +	if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
> > +		return -EFAULT;
> > +	/* A floating point state is managed from user-space. */
> > +	if (ctx.fpstate != 0)
> > +		return -EINVAL;

Here, we check that ctx doesn't have an FPU state.

> > +	if (!user_access_begin(uctx, sizeof(*uctx)))
> > +		return -EFAULT;
> > +	unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
> > +	user_access_end();
> 
> But here you save the sigcontext without FPU state.
> 
> > +
> > +	if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
> > +		goto badframe;
> 
> And here you restore sigcontext, *with* FPU state.  At which point your
> FPU state is irrecoverably lost.

process_vm_exec doesn't change a process FPU state. Unlike signals, here
we can control it from a user-space. A process can set an FPU state
before process_vm_exec and then retore its FPU state after the
call.

This version of patches has a bug that I fixed in my tree when I
implemented the user-space part for gVisor. I didn't take into account
that restore_sigcontext(ctx) clears a process fpu state if ctx->fpstate
is zero. I moved fpu__restore_sig out from __restore_sigcontext to fix
this issue:

https://github.com/avagin/linux-task-diag/commit/55b7194d00ff

> 
> Also, I'm not at all convinced this can ever do the right thing when the
> tasks don't agree on what the FPU state is. I suppose in the best case
> the save will EFAULT.
> 
> > +
> > +	return 0;
> > +Efault:
> > +	user_access_end();
> > +badframe:
> > +	signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
> > +	return -EFAULT;
> > +}
