Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556A4276A32
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgIXHL5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 03:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgIXHLD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 03:11:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1961C0613D4
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 00:11:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id bw23so1189896pjb.2
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 00:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mqsr49yCo2iSjf83d4dKwy3/hReLF+9ZnbvUsAtVECg=;
        b=fHf6+8JTZGz4OZkc5RmqWDmjG2fNb0kA8IZ9XG1XzWZ1L9jU/DFRoaUaQL3dguCzW1
         KXX48DwoGZNKKYWmcgQIrTNZc6mbItX/wyDrJs5ia9YGU+pRfubkzAvJYqXf+oFYv3h7
         Gdrct237K6JumwHGC7pwM7AuAmOiTK1HTe46A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mqsr49yCo2iSjf83d4dKwy3/hReLF+9ZnbvUsAtVECg=;
        b=SlpBUM8uN9gjAMXvydZkufV+n4x8EN3hBOx2Xln8tJGrax5YhZks2aerSTSH/QAxs9
         fzm8HhZdrxFQ+laiveS8KTbTUuej19WoZAacGLdjo7wKvNSPLoSHvqnAnx54VK/J0U/M
         H2iuWMa4dWQ6Zdl0/8vuAvNw+mubRmbh6xtpSbMG21x8Z3OD2ArKC8ADE3B6pN8O6eJq
         dNxA04Df38BHJaDFSt0+laBnHOIMeP8LNiw6kWga33w986KEASkSzDYLe8ZEqlYmps29
         no/zbxx4PygygNfgYXT2QVsiNgoqBtO41kwHhjk2bYGftr3dQ/kqQEbiD7kaXhTAoFYp
         658g==
X-Gm-Message-State: AOAM533nueKVm1TJu47njK276iR40uZQgDdq3lA+6+1jpIWawaElX+p2
        g8oJI6JAN73RBOSUb3tjW02vLg==
X-Google-Smtp-Source: ABdhPJzv4SGxNbsgD8BkFEnfQt1qQLIfqoihgRZX9/LQECsfJCm5UcKJwzmliMUvjnnGLYmBo5PfBw==
X-Received: by 2002:a17:902:ff07:b029:d1:e5fa:aa1d with SMTP id f7-20020a170902ff07b02900d1e5faaa1dmr3259173plj.84.1600931463013;
        Thu, 24 Sep 2020 00:11:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gn24sm1360225pjb.8.2020.09.24.00.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:11:02 -0700 (PDT)
Date:   Thu, 24 Sep 2020 00:11:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <yifeifz2@illinois.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] seccomp: Introduce SECCOMP_PIN_ARCHITECTURE
Message-ID: <202009232353.FD011DAA0@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-2-keescook@chromium.org>
 <CAG48ez17XK2Co+1LbUWTc4x_W7nza=TObNh2Kpz6P+ba3OKPsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez17XK2Co+1LbUWTc4x_W7nza=TObNh2Kpz6P+ba3OKPsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 24, 2020 at 02:41:36AM +0200, Jann Horn wrote:
> On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > For systems that provide multiple syscall maps based on audit
> > architectures (e.g. AUDIT_ARCH_X86_64 and AUDIT_ARCH_I386 via
> > CONFIG_COMPAT) or via syscall masks (e.g. x86_x32), allow a fast way
> > to pin the process to a specific syscall table, instead of needing
> > to generate all filters with an architecture check as the first filter
> > action.
> >
> > This creates the internal representation that seccomp itself can use
> > (which is separate from the filters, which need to stay runtime
> > agnostic). Additionally paves the way for constant-action bitmaps.
> 
> I don't really see the point in providing this UAPI - the syscall
> number checking will probably have much more performance cost than the
> architecture number check, and it's not like this lets us avoid the
> check, we're just moving it over into C code.

It's desirable for libseccomp and is a request from systemd (which is,
at this point, the largest seccomp user I know of), as they have no way
to force an arch without doing it in filters, which doesn't help much
with reducing filter runtime.

> 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/seccomp.h                       |  9 +++
> >  include/uapi/linux/seccomp.h                  |  1 +
> >  kernel/seccomp.c                              | 79 ++++++++++++++++++-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 33 ++++++++
> >  4 files changed, 120 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> > index 02aef2844c38..0be20bc81ea9 100644
> > --- a/include/linux/seccomp.h
> > +++ b/include/linux/seccomp.h
> > @@ -20,12 +20,18 @@
> >  #include <linux/atomic.h>
> >  #include <asm/seccomp.h>
> >
> > +#define SECCOMP_ARCH_IS_NATIVE         1
> > +#define SECCOMP_ARCH_IS_COMPAT         2
> 
> FYI, mips has three different possible "arch" values (per kernel build
> config; the __AUDIT_ARCH_LE flag can also be set, but that's fixed
> based on the config):
> 
>  - AUDIT_ARCH_MIPS
>  - AUDIT_ARCH_MIPS | __AUDIT_ARCH_64BIT
>  - AUDIT_ARCH_MIPS | __AUDIT_ARCH_64BIT | __AUDIT_ARCH_CONVENTION_MIPS64_N32
> 
> But I guess we can deal with that once someone wants to actually add
> support for this on mips.

Yup!

> 
> > +#define SECCOMP_ARCH_IS_MULTIPLEX      3
> 
> Why should X32 be handled specially? If the seccomp filter allows

Because it's a masked lookup into a separate table; the syscalls don't
map to x86_64's table; so for seccomp to correctly figure out which
bitmap to use, it has to do this decoding.

> specific syscalls (as it should), we don't have to care about X32.
> Only in weird cases where the seccomp filter wants to deny specific
> syscalls (a horrible idea), X32 is a concern, and in such cases, the
> userspace code can generate a single conditional jump to deal with it.

I feel like I must not understand what you mean. The x32-aware seccomp
filters are using syscall tests with 0x40000000 included in the values.
So seccomp's bitmap cannot handle this because it must know how many
syscalls to include in a linearly-allocated bitmap.

> And when seccomp is used properly to allow specific syscalls, the
> kernel will just waste time uselessly checking this X32 stuff.

It not measurable in my tests -- seccomp_data::nr is rather hot in the
cache. ;) That said, if it's unwanted, then CONFIG_X86_X32=n is the way
to go.

> [...]
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> [...]
> > +static long seccomp_pin_architecture(void)
> > +{
> > +#ifdef SECCOMP_ARCH
> > +       struct task_struct *task = current;
> > +
> > +       u8 arch = seccomp_get_arch(syscall_get_arch(task),
> > +                                  syscall_get_nr(task, task_pt_regs(task)));
> > +
> > +       /* How did you even get here? */
> 
> Via a racing TSYNC, that's how.

Yes; thanks. This will need to take &current->sighand->siglock.

> 
> > +       if (task->seccomp.arch && task->seccomp.arch != arch)
> > +               return -EBUSY;
> > +
> > +       task->seccomp.arch = arch;
> > +#endif
> > +       return 0;
> > +}
> 
> Why does this return 0 if SECCOMP_ARCH is not defined? That suggests
> to userspace that we have successfully pinned the ABI, even though
> we're actually unable to do so.

Yup; thanks for the catch. This is a logical leftover from the RFC. This
should be, I think:

+       task->seccomp.arch = arch;
+       return 0;
+#else
+	return -EINVAL;
+#endif


-- 
Kees Cook
