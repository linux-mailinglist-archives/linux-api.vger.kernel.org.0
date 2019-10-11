Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD8AD4775
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 20:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfJKSVI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 14:21:08 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38567 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfJKSVI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 14:21:08 -0400
Received: by mail-ot1-f65.google.com with SMTP id e11so8757493otl.5
        for <linux-api@vger.kernel.org>; Fri, 11 Oct 2019 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzPNFjQAnsNKPF9to6rHis9Bc+uXElpyCzjzqc3xUoA=;
        b=IvMSiekARullkWXq/ftFjAcZMOjhvs+6/3a4OtqHQasin2qPvykrRKbGv9Usd7sy12
         ulb1mILf15cAPtN3I1Lbzb5DoSzaj4lLXvjYOXl+AFJJFvuStN5KhZz958qQCHlX7mlK
         VzHJuU70gtQqiB3R6rIak9sy8QzqKM0ZqN+BCeDpDj0EbFbKWeSIaBU13d0ph7rPOpDu
         L+3GRaUTlBevjN29xui9vM2NZnUIvEgM01iz5UGGj7gdV/in5n/l7L23RrV0Xr5Sn/8j
         UqEkK4i8d6pyYcxEedHJ9Pl5viAr8XW64yXzmgQzO7iMzWXg9tCcbpaVCdLOYR3E7YjK
         tQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzPNFjQAnsNKPF9to6rHis9Bc+uXElpyCzjzqc3xUoA=;
        b=lsPGhOje2b82F/4JrHep1680OT7+a6gFSk6bb9vKXaC5oVnsIZVTmUFSZtY2rTeY6w
         0OzI4iZrk/Y+U+5+Fh76O8QtAhzhJJWnK90NK6vgnT7hjiJ8WXg0mgGLjvuBotmRy6Uf
         iWNeEpfmNnXPg93Iu6dC9iNx3krz6PpwxjEVfUP552fuGcGkXnTywXQ19XxoudEDaIXp
         /XfbiLbj6hDJ1h83Dj7JJFP0L2ABEIsdHMmoIKOCpGF0G+RbBXa6xSSohYkcMdkMnOU0
         dbSNP+M07iqXo+ViJIHI3LPbTvuzRoixDXh4zTqM3RsTTm/2ic2IHl/PkOwwjiCo0HWH
         222w==
X-Gm-Message-State: APjAAAXTV631+Lt9jYFLisql29mtEXJ0S8DT+4F9RKNoh5U30oZR55MS
        W7V8EIBclz9SsNQm7xoMDdEzPKx74Q0prXWhd/ewVw==
X-Google-Smtp-Source: APXvYqzdnyAgT/2B3EV+6PwhAKTjGeyVIet5s9sy4vmnfPUelbIpY/41Ijbdobh8yEQZadta3Qs7UMppdkBOA/JYl94=
X-Received: by 2002:a05:6830:10cc:: with SMTP id z12mr6088889oto.110.1570818066578;
 Fri, 11 Oct 2019 11:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20191009160532.20674-1-ckellner@redhat.com> <20191011122323.7770-1-ckellner@redhat.com>
 <CAG48ez1xNonmxwa3DRD44WJiComOHRxdHud5+LWea3OXzr4hkg@mail.gmail.com>
 <20191011151700.hdvztoxonpvogadv@wittgenstein> <CAG48ez2_YX0eXQP_YP2Ya20AxRGg9uGFjjkuSBxAV=hxvM9VZw@mail.gmail.com>
 <20191011165851.gf5i6qw2fwbunshr@wittgenstein>
In-Reply-To: <20191011165851.gf5i6qw2fwbunshr@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 11 Oct 2019 20:20:39 +0200
Message-ID: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] pidfd: show pids for nested pid namespaces in fdinfo
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christian Kellner <ckellner@redhat.com>,
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

On Fri, Oct 11, 2019 at 6:58 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Fri, Oct 11, 2019 at 05:30:03PM +0200, Jann Horn wrote:
> > On Fri, Oct 11, 2019 at 5:17 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > On Fri, Oct 11, 2019 at 04:55:59PM +0200, Jann Horn wrote:
> > > > On Fri, Oct 11, 2019 at 2:23 PM Christian Kellner <ckellner@redhat.com> wrote:
> > > > > The fdinfo file for a process file descriptor already contains the
> > > > > pid of the process in the callers namespaces. Additionally, if pid
> > > > > namespaces are configured, show the process ids of the process in
> > > > > all nested namespaces in the same format as in the procfs status
> > > > > file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> > > > > of the processes in nested namespaces.
> > > > [...]
> > > > >  #ifdef CONFIG_PROC_FS
> > > > > +static inline void print_pidfd_nspid(struct seq_file *m, struct pid *pid,
> > > > > +                                    struct pid_namespace *ns)
> > > >
> > > > `ns` is the namespace of the PID namespace of the procfs instance
> > > > through which the file descriptor is being viewed.
> > > >
> > > > > +{
> > > > > +#ifdef CONFIG_PID_NS
> > > > > +       int i;
> > > > > +
> > > > > +       seq_puts(m, "\nNSpid:");
> > > > > +       for (i = ns->level; i <= pid->level; i++) {
> > > >
> > > > ns->level is the level of the PID namespace associated with the procfs
> > > > instance through which the file descriptor is being viewed. pid->level
> > > > is the level of the PID associated with the pidfd.
> > > >
> > > > > +               ns = pid->numbers[i].ns;
> > > > > +               seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
> > > > > +       }
> > > > > +#endif
> > > > > +}
> > > >
> > > > I think you assumed that `ns` is always going to contain `pid`.
> > > > However, that's not the case. Consider the following scenario:
> > > >
> > > >  - the init_pid_ns has two child PID namespaces, A and B (each with
> > > > its own mount namespace and procfs instance)
> > > >  - process P1 lives in A
> > > >  - process P2 lives in B
> > > >  - P1 opens a pidfd for itself
> > > >  - P1 passes the pidfd to P2 (e.g. via a unix domain socket)
> > > >  - P2 reads /proc/self/fdinfo/$pidfd
> > > >
> > > > Now the loop will print the ID of P1 in A. I don't think that's what
> > > > you intended? You might want to bail out if "pid_nr_ns(pid, ns) == 0",
> > > > or something like that.
> > >
> > > I assumed the same thing happens when you pass around an fd for
> > > /proc/self/status and that's why I didn't object to this behavior.
> >
> > I don't see how /proc/$pid/status is relevant. In the
> > /proc/$pid/status case, the output is the list of PIDs starting at the
> > PID namespace the procfs is associated with; and the process is always
> > contained in that namespace, which also means that the first PID
> > listed is the one in the PID namespace of the procfs instance. In the
> > pidfd case, the process is not necessarily contained in that
> > namespace, and the output doesn't make sense.
>
> I might be misreading what you're saying.
> (Maybe I'm doing something obviously wrong.)
> If I compile the following two programs:
> b2: https://paste.ubuntu.com/p/xthMsCXy3s/
> c2: https://paste.ubuntu.com/p/y5HSzyMQJr/
>
> Then in shell1
> sudo unshare --mount --pid --fork --mount-proc
>
> and in shell2
> sudo unshare --mount --pid --fork --mount-proc
>
> and run b2 in shell1 and c2 in shell2 which sends around an fd for
> /proc/b2/status to c2. Now c2 reads b2's status file via the fd it
> received. The c2 will see the pid of b2 in b2's pid namespace even
> though the process is not contained in the pid namespace of c2.

Because the reader doesn't matter; the perspective you have on the
system is defined by which pidns the procfs instance you're looking
through is associated with, and here you're looking through shell1's
procfs. It's normal that when you look through another procfs, you see
PIDs differently.
