Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B349AD4443
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfJKPaa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 11:30:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41093 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfJKPaa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 11:30:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id w65so8319464oiw.8
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G65rnrPhLbwiKa12jxK6VsnV1tu58T/eP6dY6zrzvZM=;
        b=axMZJb56FTNco00uonEJke76cy2AQd2gHUV3BqSx2OB0U6z6GuUjQ/Xz6xiljm5g5Z
         lW6rWqLQwABKmQ3T7lwpMck0t6kyXZ5t7+incgZFUVfOJ76gcLCkthIk+XDFt9lHczAC
         nktxww/gmoLYI6OOJY4ZZRSwXdcoT/+Rp8la7qB1uV8Ir/rkNeVYs4rrDBatIyui1oQ0
         EebxyMVyHzNptgHHQHUH9c8utm6XDIp/POf1aKlASei1mcB37YHRw6a48R6YDxMiFyMM
         gyT8fjsL/3HGGKf84fttmBK6bz4mOXpQDT+vUlJJfYdBoc9ont8aU7zgzfPQZ5v1aaj3
         IL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G65rnrPhLbwiKa12jxK6VsnV1tu58T/eP6dY6zrzvZM=;
        b=FoFR3JY3/eeXIufTVv8uGXpC1oeZHSMueOUEoI4A560vCa0fNBuL/L+/pDx2tV6QUa
         QpjtJuDR6l9qbkyKQXuMv7bfeUXj7zFBSCXwev8EX/zjA5Yygt1u3q/JsyFfc70NOFzX
         glIf57j3cUPBqwBR/or776LB1+eXFRAKGS+l+UdJRnOHoU+oxVzHwOgdJ5bd3OmXB36t
         //YS/7GlDbx4XWB0pWG5DR8NrCeY8qu1ePP6sAHWuPuoOhDQcthbooHG/gF3G5mXKUSD
         BD1e9+RIYSulN5Int7iC5ELd1O9SlN44ZvXCnT5eIr611mpol7jJoZS09daZ330AbQmb
         uSNQ==
X-Gm-Message-State: APjAAAUI/3kIckThWIk7Q0XlRBeBgq+KfrdQdu8fPKmkK7h11e6/UX9S
        YDjYDUN1sn7O3cfnAhZMbXPdKsjvjs2ARe5iSnaO7w==
X-Google-Smtp-Source: APXvYqztJ6TtWV/CrITLOCN+D+HZbp0PNRoBL4ZgaP0aQOPkhKOlPy6vMt3rYNP9qXdAzUUGPhAq8/WORY/3Xm8vQzI=
X-Received: by 2002:aca:da41:: with SMTP id r62mr12192042oig.47.1570807829434;
 Fri, 11 Oct 2019 08:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191009160532.20674-1-ckellner@redhat.com> <20191011122323.7770-1-ckellner@redhat.com>
 <CAG48ez1xNonmxwa3DRD44WJiComOHRxdHud5+LWea3OXzr4hkg@mail.gmail.com> <20191011151700.hdvztoxonpvogadv@wittgenstein>
In-Reply-To: <20191011151700.hdvztoxonpvogadv@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Oct 2019 17:30:03 +0200
Message-ID: <CAG48ez2_YX0eXQP_YP2Ya20AxRGg9uGFjjkuSBxAV=hxvM9VZw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pidfd: show pids for nested pid namespaces in fdinfo
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Oct 11, 2019 at 5:17 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Oct 11, 2019 at 04:55:59PM +0200, Jann Horn wrote:
> > On Fri, Oct 11, 2019 at 2:23 PM Christian Kellner <ckellner@redhat.com> wrote:
> > > The fdinfo file for a process file descriptor already contains the
> > > pid of the process in the callers namespaces. Additionally, if pid
> > > namespaces are configured, show the process ids of the process in
> > > all nested namespaces in the same format as in the procfs status
> > > file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> > > of the processes in nested namespaces.
> > [...]
> > >  #ifdef CONFIG_PROC_FS
> > > +static inline void print_pidfd_nspid(struct seq_file *m, struct pid *pid,
> > > +                                    struct pid_namespace *ns)
> >
> > `ns` is the namespace of the PID namespace of the procfs instance
> > through which the file descriptor is being viewed.
> >
> > > +{
> > > +#ifdef CONFIG_PID_NS
> > > +       int i;
> > > +
> > > +       seq_puts(m, "\nNSpid:");
> > > +       for (i = ns->level; i <= pid->level; i++) {
> >
> > ns->level is the level of the PID namespace associated with the procfs
> > instance through which the file descriptor is being viewed. pid->level
> > is the level of the PID associated with the pidfd.
> >
> > > +               ns = pid->numbers[i].ns;
> > > +               seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
> > > +       }
> > > +#endif
> > > +}
> >
> > I think you assumed that `ns` is always going to contain `pid`.
> > However, that's not the case. Consider the following scenario:
> >
> >  - the init_pid_ns has two child PID namespaces, A and B (each with
> > its own mount namespace and procfs instance)
> >  - process P1 lives in A
> >  - process P2 lives in B
> >  - P1 opens a pidfd for itself
> >  - P1 passes the pidfd to P2 (e.g. via a unix domain socket)
> >  - P2 reads /proc/self/fdinfo/$pidfd
> >
> > Now the loop will print the ID of P1 in A. I don't think that's what
> > you intended? You might want to bail out if "pid_nr_ns(pid, ns) == 0",
> > or something like that.
>
> I assumed the same thing happens when you pass around an fd for
> /proc/self/status and that's why I didn't object to this behavior.

I don't see how /proc/$pid/status is relevant. In the
/proc/$pid/status case, the output is the list of PIDs starting at the
PID namespace the procfs is associated with; and the process is always
contained in that namespace, which also means that the first PID
listed is the one in the PID namespace of the procfs instance. In the
pidfd case, the process is not necessarily contained in that
namespace, and the output doesn't make sense.
