Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E91CB765
	for <lists+linux-api@lfdr.de>; Fri,  8 May 2020 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgEHSd1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 May 2020 14:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727857AbgEHSdZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 May 2020 14:33:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87647C061A0C;
        Fri,  8 May 2020 11:33:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so4655923pjt.4;
        Fri, 08 May 2020 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ooZGrU/pnbIoyJLUF18yRkK3wWAFFjEYvg7xmQiEw+8=;
        b=MVNHBnA41kiJe781ksiv/qXuTfCI/U6/T7PmMZvUMQdBMCcFIi0wYRKD4e7lbJlPAB
         SlsWK/alRrE3at2tjtFl4NX974OBFYke4eRvaTimRkqTrP+TWhkA96sweLnHTzOhF9zo
         I0JdlZ6T2qGK6a8XL67khBup/xQ8iwpRxxSwCHstz39aJNHsG96D9zJLPsINWgNVMcd+
         iacjcHu7yEa/926cccyS+dBTY31tKsEXw8fRQX41yVgDzp4K42Q1TXqoMHajTNn1P7cb
         FM0EX9hMUVnmpm5cKlDXFNS7Hq4nV0q5gs3MSxyYg5W2clcxHSeWTt5qX3AWCoF8ij5s
         58oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ooZGrU/pnbIoyJLUF18yRkK3wWAFFjEYvg7xmQiEw+8=;
        b=Kb8fpCkZwH6LlLqTUQUydK0DY5K7aNI8SuZH8vT2bAfnH5F9BJbp9FAn7039guWGkx
         8MIQv6tzLihvHiEaft7lkbIBRbdEGAJF3NSe5dS1jJ2xN/HVBaDkAdIUt805XYqoUaEa
         ZhiNJ+eigwcjtsdu29u9Myq1qnDd54nQDvXV/yQjrFZQzRtZFzjtE/G6sYmdPqbHtvck
         PO6rtAKfSTBiIo58hwrEv62xZU3wuTeQ6rKZekNapt0E+1MlTlW/abbQErXBL07RxzYc
         hN61NkBj1cvxZBSEBHflQlohQVgjpJUTrlN02V03WCo3bitv58NE7zALAvwsazcwKd8Q
         uuRA==
X-Gm-Message-State: AGi0PuZx/HEQLIw/z39TIFRnjtHzvaQMEBrqnTs8te/Hpq6BUFqMa0aE
        7Ngn3Cll8NaxKFlSNF2dqMQ=
X-Google-Smtp-Source: APiQypIztmEMg0o3LVAhuv2fbTJmjLUIa6rJWtkMdrBM28HhydSU2zvxHk4uRqK1oRhgORW/tx1OHg==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr7605881pjb.107.1588962803820;
        Fri, 08 May 2020 11:33:23 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id gm3sm2947977pjb.49.2020.05.08.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:33:22 -0700 (PDT)
Date:   Fri, 8 May 2020 11:33:20 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
Subject: Re: [PATCH v7 2/7] mm: introduce external memory hinting API
Message-ID: <20200508183320.GA125527@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-3-minchan@kernel.org>
 <bc3f6bd5-f032-bcf5-a09f-556ab785c587@suse.cz>
 <20200310222008.GB72963@google.com>
 <07109fb3-dcf3-0252-4515-7e476fadc259@suse.cz>
 <20200312202339.GB68817@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312202339.GB68817@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 12, 2020 at 01:23:39PM -0700, Minchan Kim wrote:
> On Thu, Mar 12, 2020 at 01:40:26PM +0100, Vlastimil Babka wrote:
> > On 3/10/20 11:20 PM, Minchan Kim wrote:
> > > On Thu, Mar 05, 2020 at 07:15:10PM +0100, Vlastimil Babka wrote:
> > >> On 3/2/20 8:36 PM, Minchan Kim wrote:
> > >> > There is usecase that System Management Software(SMS) want to give
> > >> > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > >> > in the case of Android, it is the ActivityManagerService.
> > >> > 
> > >> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > >> 
> > >> You mean MADV_DONTNEED?
> > > 
> > > Mean to DONT_NEED's future version.
> > 
> > What's that exactly?
> 
> For zapping timing point of view, dontneed acts immediately so it's very
> strong hint. However, MADV_COLD and MADV_PAGEOUT does lazily depending
> on the future. For example, the page never discarded if it's touched
> before the tail of LRU. If other process which shared the page has
> touched the page, never paging out.
> 
> > 
> > >> 
> > >> > required to make the reclaim decision is not known to the app.
> > >> 
> > >> This seems to be mixing up the differences between MADV_DONTNEED and
> > >> COLD/PAGEOUT and self-imposed vs external memory hints?
> > > 
> > > Sorry, I don't understand what you want here.
> > 
> > You say that process_madvise(MADV_[COLD|PAGEEOUT]) is similar to
> > madvise(MADV_WONTNEED) but the difference is that the information
> > required to make the reclaim decision is not known to the app.
> > 
> > I see two differences. One is madvise vs process_madvise, which is explained by
> > "reclaim decision is not known to the app."
> > The other is MADV_WONTNEED vs MADV_[COLD|PAGEEOUT], which is... I'm not sure
> > until you say what's "DONT_NEED's future version" :D
> > 
> > Anyway I assume this part is from the versions where the new COLD and PAGEOUT
> > flags were introduced together with external memory hinting API?
> 
> Exactly. Maybe it would be better to remove the part once we merged the
> COLD and PAGEOUT now.
> 
> Thanks for the review, Vlastimil!

Hi Andrew,

Per Vlastimil's review, I removed unnecessary part and changed syscall
argument name "advise and flag" to "advice and flags" in description.

Could you replace the description with this one? Code part is same so
no need to be changed.

Thanks.

From fdb29014c84aebcca4737de735993e87d43ebbbf Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 6 May 2020 13:54:39 +0000
Subject: [PATCH] mm/madvise: introduce process_madvise() syscall: an external
 memory hinting API

There is usecase that System Management Software(SMS) want to give a
memory hint like MADV_[COLD|PAGEEOUT] to other processes and in the case
of Android, it is the ActivityManagerService.

The information required to make the reclaim decision is not known to
the app. Instead, it is known to the centralized userspace
daemon(ActivityManagerService), and that daemon must be able to initiate
reclaim on its own without any app involvement.

To solve the issue, this patch introduces a new syscall process_madvise(2). 
It uses pidfd of an external process to give the hint.

 int process_madvise(int pidfd, void *addr, size_t length, int advice,
			unsigned long flags);

Since it could affect other process's address range, only privileged
process(CAP_SYS_PTRACE) or something else(e.g., being the same UID) gives
it the right to ptrace the process could use it successfully.  The flag
argument is reserved for future use if we need to extend the API.

I think supporting all hints madvise has/will supported/support to
process_madvise is rather risky.  Because we are not sure all hints make
sense from external process and implementation for the hint may rely on
the caller being in the current context so it could be error-prone.  Thus,
I just limited hints as MADV_[COLD|PAGEOUT] in this patch.

If someone want to add other hints, we could hear hear the usecase and
review it for each hint.  It's safer for maintenance rather than
introducing a buggy syscall but hard to fix it later.

Q.1 - Why does any external entity have better knowledge?

Quote from Sandeep

"For Android, every application (including the special SystemServer) are
forked from Zygote.  The reason of course is to share as many libraries
and classes between the two as possible to benefit from the preloading
during boot.

After applications start, (almost) all of the APIs end up calling into
this SystemServer process over IPC (binder) and back to the application.

In a fully running system, the SystemServer monitors every single process
periodically to calculate their PSS / RSS and also decides which process
is "important" to the user for interactivity.

So, because of how these processes start _and_ the fact that the
SystemServer is looping to monitor each process, it does tend to *know*
which address range of the application is not used / useful.

Besides, we can never rely on applications to clean things up themselves.
We've had the "hey app1, the system is low on memory, please trim your
memory usage down" notifications for a long time[1].  They rely on
applications honoring the broadcasts and very few do.

So, if we want to avoid the inevitable killing of the application and
restarting it, some way to be able to tell the OS about unimportant memory
in these applications will be useful.

- ssp

Q.2 - How to guarantee the race(i.e., object validation) between when
giving a hint from an external process and get the hint from the target
process?

process_madvise operates on the target process's address space as it
exists at the instant that process_madvise is called.  If the space target
process can run between the time the process_madvise process inspects the
target process address space and the time that process_madvise is actually
called, process_madvise may operate on memory regions that the calling
process does not expect.  It's the responsibility of the process calling
process_madvise to close this race condition.  For example, the calling
process can suspend the target process with ptrace, SIGSTOP, or the
freezer cgroup so that it doesn't have an opportunity to change its own
address space before process_madvise is called.  Another option is to
operate on memory regions that the caller knows a priori will be unchanged
in the target process.  Yet another option is to accept the race for
certain process_madvise calls after reasoning that mistargeting will do no
harm.  The suggested API itself does not provide synchronization.  It also
apply other APIs like move_pages, process_vm_write.

The race isn't really a problem though.  Why is it so wrong to require
that callers do their own synchronization in some manner?  Nobody objects
to write(2) merely because it's possible for two processes to open the
same file and clobber each other's writes --- instead, we tell people to
use flock or something.  Think about mmap.  It never guarantees newly
allocated address space is still valid when the user tries to access it
because other threads could unmap the memory right before.  That's where
we need synchronization by using other API or design from userside.  It
shouldn't be part of API itself.  If someone needs more fine-grained
synchronization rather than process level, there were two ideas suggested
- cookie[2] and anon-fd[3].  Both are applicable via using last reserved
argument of the API but I don't think it's necessary right now since we
have already ways to prevent the race so don't want to add additional
complexity with more fine-grained optimization model.

To make the API extend, it reserved an unsigned long as last argument so
we could support it in future if someone really needs it.

Q.3 - Why doesn't ptrace work?

Injecting an madvise in the target process using ptrace would not work for
us because such injected madvise would have to be executed by the target
process, which means that process would have to be runnable and that
creates the risk of the abovementioned race and hinting a wrong VMA.
Furthermore, we want to act the hint in caller's context, not the
callee's, because the callee is usually limited in cpuset/cgroups or even
freezed state so they can't act by themselves quick enough, which causes
more thrashing/kill.  It doesn't work if the target process are
ptraced(e.g., strace, debugger, minidump) because a process can have at
most one ptracer.

[1] https://developer.android.com/topic/performance/memory"

[2] process_getinfo for getting the cookie which is updated whenever
    vma of process address layout are changed - Daniel Colascione -
    https://lore.kernel.org/lkml/20190520035254.57579-1-minchan@kernel.org/T/#m7694416fd179b2066a2c62b5b139b14e3894e224

[3] anonymous fd which is used for the object(i.e., address range)
    validation - Michal Hocko -
    https://lore.kernel.org/lkml/20200120112722.GY18451@dhcp22.suse.cz/

Link: http://lkml.kernel.org/r/20200302193630.68771-3-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Daniel Colascione <dancol@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Dias <joaodias@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: <linux-man@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
