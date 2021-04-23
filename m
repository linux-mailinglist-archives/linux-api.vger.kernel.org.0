Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5B0368D85
	for <lists+linux-api@lfdr.de>; Fri, 23 Apr 2021 09:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhDWHCd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Apr 2021 03:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHCc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Apr 2021 03:02:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5741EC061574;
        Fri, 23 Apr 2021 00:01:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j7so25169062pgi.3;
        Fri, 23 Apr 2021 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iR04QyRnmu5wEXEE6wM7+aMFMLtZ8Zhvq8vbG05BPrs=;
        b=CnEwX0wiZJDXMUjybp0vJt6OSKilTaK8SUbCh2Z7VN0jFhppEgE1jILT3h7LEp3i2F
         FVvXcsdWP0oNqBALdy0YY//yHhSDNalPYlif2PQoq84tyO+jffky/ShIk3PwsKJBWN3D
         c1h3rdCkODVeaz54jDO0001i411M4PtisKj2fBatWuUtqBrq6bJvbvUzJAlNPbfWJEIr
         1Gh2CUwl6P/0hRP0KOKADs6ZfXIaRxXuZBHw7rbZzy+AX2WnVQs8rzjFIEJ6JAyU937a
         1vUzOI6cZnqqGEzNNmmdgYBLuB9pXSNcfCpuwhV5L7rgCHSNNJrF8eg4CmmNeBGhITXw
         B4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iR04QyRnmu5wEXEE6wM7+aMFMLtZ8Zhvq8vbG05BPrs=;
        b=SL9xUqO3vSVNOSpOGq6+4BLCA0NfsG1f55MXpSpXSAUDR0c0z5iEaV+eCVLgKCkRN0
         c1ULa886vkMqQo+UBYSF7xxkTsaSI6ROE9EvtEI/ruizc41A74t5Pc9vaU4G8ZTdHwC8
         6iUB8eC1+5wmnmKWm7gfn5/EfXoCPE+w0mdKlFWRgf0Az/reoTCz/zMrcgWl+gDF5xo8
         gVgoKKzWbIDquT3t8F7j4D1ejfIkhK7zPRyKZFYzv2mjcMzpApDWDNdqG9n95TovTU3X
         UVvDyQ04+jer5VN0ZvUf/CIE5yZfMe3EMECL19hIjyr/w91MxcprDRTSHSDUsxL844DB
         AwhQ==
X-Gm-Message-State: AOAM533i4Kw24bJU4OoWFs7QmgYdZBbxAX0K+SpxlZdpBMrrbIUdlH9g
        Eq9yHTbn5kYIiNBSm9nm7oA=
X-Google-Smtp-Source: ABdhPJwJLGXDtvvPq5MYMgWv94xYQVKgsvTTkmk6unpZZXoRlCWkxw97MYvUeef51H1cj3qDV1rmcw==
X-Received: by 2002:a63:2211:: with SMTP id i17mr2402206pgi.431.1619161315742;
        Fri, 23 Apr 2021 00:01:55 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id f19sm3988160pga.71.2021.04.23.00.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 00:01:55 -0700 (PDT)
Date:   Thu, 22 Apr 2021 23:59:15 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
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
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YIJwQ4brDIbKKiyZ@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <20210414170915.GB22294@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210414170915.GB22294@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 07:09:15PM +0200, Oleg Nesterov wrote:
> On 04/13, Andrei Vagin wrote:
> >
> > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> > +{
> > +	struct task_struct *tsk = current;
> > +	struct mm_struct *active_mm;
> > +
> > +	task_lock(tsk);
> > +	/* Hold off tlb flush IPIs while switching mm's */
> > +	local_irq_disable();
> > +
> > +	sync_mm_rss(prev_mm);
> > +
> > +	vmacache_flush(tsk);
> > +
> > +	active_mm = tsk->active_mm;
> > +	if (active_mm != target_mm) {
> > +		mmgrab(target_mm);
> > +		tsk->active_mm = target_mm;
> > +	}
> > +	tsk->mm = target_mm;
> > +	switch_mm_irqs_off(active_mm, target_mm, tsk);
> > +	local_irq_enable();
> > +	task_unlock(tsk);
> > +#ifdef finish_arch_post_lock_switch
> > +	finish_arch_post_lock_switch();
> > +#endif
> > +
> > +	if (active_mm != target_mm)
> > +		mmdrop(active_mm);
> > +}
> 
> I think this should be unified with kthread_use_mm() somehow...

I agree.

> 
> And does it really need the "prev_mm" argument? It must be tsk->mm, no?

No, it doesn't. It is leftover of unuse_mm. BTW why do we pass mm to kthread_unuse_mm?

Thanks,
Andrei.
