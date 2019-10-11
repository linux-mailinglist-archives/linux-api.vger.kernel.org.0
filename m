Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80AECD43FC
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJKPRI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 11:17:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfJKPRI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 11:17:08 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIwf8-0002I7-Kc; Fri, 11 Oct 2019 15:17:02 +0000
Date:   Fri, 11 Oct 2019 17:17:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Kellner <ckellner@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Kellner <christian@kellner.me>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v3 1/2] pidfd: show pids for nested pid namespaces in
 fdinfo
Message-ID: <20191011151700.hdvztoxonpvogadv@wittgenstein>
References: <20191009160532.20674-1-ckellner@redhat.com>
 <20191011122323.7770-1-ckellner@redhat.com>
 <CAG48ez1xNonmxwa3DRD44WJiComOHRxdHud5+LWea3OXzr4hkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1xNonmxwa3DRD44WJiComOHRxdHud5+LWea3OXzr4hkg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 11, 2019 at 04:55:59PM +0200, Jann Horn wrote:
> On Fri, Oct 11, 2019 at 2:23 PM Christian Kellner <ckellner@redhat.com> wrote:
> > The fdinfo file for a process file descriptor already contains the
> > pid of the process in the callers namespaces. Additionally, if pid
> > namespaces are configured, show the process ids of the process in
> > all nested namespaces in the same format as in the procfs status
> > file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> > of the processes in nested namespaces.
> [...]
> >  #ifdef CONFIG_PROC_FS
> > +static inline void print_pidfd_nspid(struct seq_file *m, struct pid *pid,
> > +                                    struct pid_namespace *ns)
> 
> `ns` is the namespace of the PID namespace of the procfs instance
> through which the file descriptor is being viewed.
> 
> > +{
> > +#ifdef CONFIG_PID_NS
> > +       int i;
> > +
> > +       seq_puts(m, "\nNSpid:");
> > +       for (i = ns->level; i <= pid->level; i++) {
> 
> ns->level is the level of the PID namespace associated with the procfs
> instance through which the file descriptor is being viewed. pid->level
> is the level of the PID associated with the pidfd.
> 
> > +               ns = pid->numbers[i].ns;
> > +               seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
> > +       }
> > +#endif
> > +}
> 
> I think you assumed that `ns` is always going to contain `pid`.
> However, that's not the case. Consider the following scenario:
> 
>  - the init_pid_ns has two child PID namespaces, A and B (each with
> its own mount namespace and procfs instance)
>  - process P1 lives in A
>  - process P2 lives in B
>  - P1 opens a pidfd for itself
>  - P1 passes the pidfd to P2 (e.g. via a unix domain socket)
>  - P2 reads /proc/self/fdinfo/$pidfd
> 
> Now the loop will print the ID of P1 in A. I don't think that's what
> you intended? You might want to bail out if "pid_nr_ns(pid, ns) == 0",
> or something like that.

I assumed the same thing happens when you pass around an fd for
/proc/self/status and that's why I didn't object to this behavior.

Christian
