Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304F934373
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfFDJnW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 05:43:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53964 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfFDJnW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 05:43:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so6387120wmb.3
        for <linux-api@vger.kernel.org>; Tue, 04 Jun 2019 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9zsBjqfFxDnK299EPt8HWTK+gFJutyEx94Q+WKO51eU=;
        b=aWootuo87lkA0fLMe02iMsBMN+6Wqgil2jMBTKo9HBgNee7yNm2q1+xrxYOhB7fc0E
         QdFIfeYWDIv9ZKgHFFdxdTncjeBcuwSUOHUtyAgqaMGrAlrXvyMEVCAY2HUDOhqjIw5h
         SxkBKH5LldMT+QhWcPWGEv4EwYGtj4BWNJCbDaZlb6RNLzX6iZFgojxKoo5aiJcLyhDo
         6qvz+hd1La+h9MLVdRDT8JF3qIjoSFa7v3LAG7jMi9ucZxPObzoqY4RbV/STLhEMcs6E
         AnB58Pyjt/Abe7IIgi7BiHELdpM0KM9WzSTWjHzDUItug42iiZjNUYgW2Tz/1bkV1q/u
         HVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9zsBjqfFxDnK299EPt8HWTK+gFJutyEx94Q+WKO51eU=;
        b=iSyCY7PjaxiKzMp/1gRtCR/lcjQ6HyEaPqBzoKZtN+MueETlFGKqujMBntXUywXG96
         GQmiDUoPRhZnOREzfv5R/5sKGng6A9JO4QoFKnQa9MbHlVuScs+qg1JWA7qLFy4xw1WJ
         1KULceU6VtX+zCKci3HSl7chMaf4yUnBinwBHBM5hLDUD8M/FJv4L4vMD8vXTxkkkniJ
         MsRuftolq2MvcBu8CIqmOr8kQWLFttjgcUuEHLwzH81rMIk7DPiX38SQlnAuep4Z3uVI
         cmigsyfX9dvYhZPMX5ddTomZbckqlZTJWgZkBTtZyjVG8zkAZoKlJ8IxVfNJRuBUpkjG
         iO0w==
X-Gm-Message-State: APjAAAVA/n+P5uqMdRJN8xQ9W2lB+hStvIJE2x5JvsWE9LMiGQ025SFl
        Q4lkMfJIwysik5JHwq8HKKcj5A==
X-Google-Smtp-Source: APXvYqwgwSue4d4xXG1eqyr2WgURWLA8qP2rB2INz9FuaOZWfmKlm2odEX/0SxywA21Yhne9QzL+xA==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr17669213wml.28.1559641400055;
        Tue, 04 Jun 2019 02:43:20 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id y132sm27296890wmd.35.2019.06.04.02.43.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 02:43:19 -0700 (PDT)
Date:   Tue, 4 Jun 2019 11:43:18 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, jannh@google.com,
        keescook@chromium.org, fweimer@redhat.com, oleg@redhat.com,
        arnd@arndb.de, Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fork: add clone3
Message-ID: <20190604094317.4wfelmbw4lgxzide@brauner.io>
References: <20190603144331.16760-1-christian@brauner.io>
 <4020.1559640492@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4020.1559640492@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 04, 2019 at 10:28:12AM +0100, David Howells wrote:
> Christian Brauner <christian@brauner.io> wrote:
> 
> > +#include <linux/compiler_types.h>
> 
> I suspect you don't want to include that directly.
> 
> Also, to avoid bloating linux/sched/task.h yet further, maybe put this in
> linux/sched/clone.h?

Yeah, not the worst idea.
Though I'd leave the flags where they are and just add struct
kernel_clone_args in there. But I assume that's what you meant anyway.

> 
> > -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> > +extern long _do_fork(struct kernel_clone_args *kargs);
> >  extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
> 
> Maybe these could move into linux/sched/clone.h too.

Meh, that could be a separate cleanup patch after clone3() has been
merged.

> 
> > +#define CLONE_MAX ~0U
> 
> Can you add a comment summarising the meaning?

Yes, can do.

> 
> > +	u64 clone_flags = args->flags;
> > +	int __user *child_tidptr = args->child_tid;
> > +	unsigned long tls = args->tls;
> > +	unsigned long stack_start = args->stack;
> > +	unsigned long stack_size = args->stack_size;
> 
> Some of these are only used once, so it's probably not worth sticking them in
> local variables.

[1]:
Ok, will double check.
This was just to minimize copy-paste erros for variables which were used
multiple times.

> 
> > -		if (clone_flags &
> > -		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
> > -			return ERR_PTR(-EINVAL);
> 
> Did this error check get lost?  I can see part of it further on, but the check
> on CLONE_PARENT_SETTID is absent.

No, it's only relevant for legacy clone() since it uses the
parent_tidptr argument to return the pidfd. clone3() has a dedicated
return argument for that in clone_args.
The check for legacy clone() is now done in legacy clone() directly.
copy_process() should only do generic checks for all version of
clone(),fork(),vfork(), etc.

> 
> > +	int __user *parent_tidptr = args->parent_tid;
> 
> There's only one usage remaining after this patch, so a local var doesn't gain
> a lot.

Yes, that leads back to [1].

> 
> >  pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
> >  {
> > -	return _do_fork(flags|CLONE_VM|CLONE_UNTRACED, (unsigned long)fn,
> > -		(unsigned long)arg, NULL, NULL, 0);
> > +	struct kernel_clone_args args = {
> > +		.flags = ((flags | CLONE_VM | CLONE_UNTRACED) & ~CSIGNAL),
> > +		.exit_signal = (flags & CSIGNAL),
> 
> Kernel threads can have exit signals?

Yes,

kernel/kthread.c:       pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
kernel/umh.c:   pid = kernel_thread(call_usermodehelper_exec_async, sub_info, SIGCHLD);

And even if they couldn't have. This is just to make sure that if they
ever would we'd be prepared.

> 
> > +static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
> > +				     struct clone_args __user *uargs,
> > +				     size_t size)
> 
> I would make this "noinline".  If it gets inlined, local variable "args" may
> still be on the stack when _do_fork() gets called.

Hm, can do.

Thanks!
Christian
