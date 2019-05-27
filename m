Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD992B25C
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 12:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0Kmw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 06:42:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41297 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfE0Kmw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 May 2019 06:42:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so4284465pgp.8
        for <linux-api@vger.kernel.org>; Mon, 27 May 2019 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ERVRXKsqmnKXfrmJkGcm1DU4KLG93ZEHecPMHvbPaa4=;
        b=Qa3xD0B7C0+pyWgwHjfuDTXaH2LB8P9uUwXLoEHd6I0+ogFv2WrvTcb1JWRi802FYI
         GQQJOrM0EUBGGbmq+XjVUsls3htswYS5xhXI+E6FkQGnhQLuEo46Aq6wuCWXzuYNuFhu
         RjY+Z3W488Vo+JnNu0NDyuHVtdUP9Q9yXKOFdnGeXTvj+MHHyeRffG0nWrb3bJSv4l05
         VftZycInZMR1C+mjooTc7gyIrQwsWeMXPHU+5jfTTPkD1kI6NZwEVJ2/E1rYtXmuU0AD
         Y32WlfygILB51GCdN502ECp6JDS0ZNYLf5yoDUP/HoKZICzBN0VdC9rwunNNQRwCaMDV
         678w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ERVRXKsqmnKXfrmJkGcm1DU4KLG93ZEHecPMHvbPaa4=;
        b=bARPwHhJ0YI6GvAzn/FCv370VOrAxH6JX9rEshm7a5p8C5EQeh/w6dKkWIciL82kI+
         ORMxxgwJOBtvZVPpqk3HFgTSAn9ZuhjDuIKRRB9qmiQ9a6ptzpCIJJ2CnyXl/Ubh+www
         cLeuIVWxYgNXqzeStaoUY1Hefnish1OH+XDQgJBLQZXWeKqWe+urDQaoJIYZ0PMyakLY
         6VSB/lP4X6n/OiNzglazW5d7cM5FFwPwfxhRQfbQeluFfEAvCOX0iGPcgI7g4TU9pcWL
         hb3Dv2ux3YvnaqQqXciNNAmgVzDfy+YiyhOBmlH8Q5HUAe60EWLN+NG7JEajkJSPSgdn
         XTzw==
X-Gm-Message-State: APjAAAUzNwPEaBgEXRyRCf41Xv3FuFO5sQUCsqJ2MHPiathVEypgUHCF
        lNZusRyDmIKwhTDxlhzJjVaLJA==
X-Google-Smtp-Source: APXvYqyiDhK8oPYmB/16CL0gPctaTpDzz0GpxiW2YPXPUnQFe9bEDRNMMi6Wg1JQasGAkQZBLEp6Fg==
X-Received: by 2002:a62:ea04:: with SMTP id t4mr132349040pfh.47.1558953771549;
        Mon, 27 May 2019 03:42:51 -0700 (PDT)
Received: from brauner.io ([208.54.39.129])
        by smtp.gmail.com with ESMTPSA id s137sm11750882pfc.119.2019.05.27.03.42.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 03:42:50 -0700 (PDT)
Date:   Mon, 27 May 2019 12:42:41 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/2] fork: add clone6
Message-ID: <20190527104239.fbnjzfyxa4y4acpf@brauner.io>
References: <20190526102612.6970-1-christian@brauner.io>
 <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Moin,

Wasn't near a computer yesterday so sorry for the late reply. :) I
(I should note that this was supposed to be prefixed with RFC. But *shrug*.)

On Sun, May 26, 2019 at 09:50:32AM -0700, Linus Torvalds wrote:
> On Sun, May 26, 2019 at 3:27 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > This adds the clone6 system call.
> 
> No, this is not acceptable.
> 
> > +       struct clone6_args args = {
> 
> First of all, we don't pass in "clone6_args" to the actual implementation.
> 
> Passing in lots of args as a structure is fine. But it damn well isn't
> a "clone6" structure. It's just a "clone_args" inside the kernel, and
> there should be a separate clone_uapi_args for the user/kernel
> interface.

Yeah, that makes sense. This is similar to what we recently did for
signals, i.e. kernel_siginfo_t as the kernel internal struct and only
expose siginfo_t to userspace.

> 
> The user interface (in the uapi file) may be called "clone6_args", but
> that is *not* then what we pass around inside the kernel.
> 
> But even for the uapi version, the "clone6" name doesn't make any
> sense as a name to begin with. It's not the sixth revision of clone,

Ok, no argument about the argument struct.

But for the name of the actual syscall itself we originally used
the revision number aka clone3() (because of clone2 on ia64).
We chose clone6() after we asked around what the current convention is:
revision number or argument number. And we were told that it is common
to use the arg number. And from the syscall list it looked like people
were right:
- accept4(/* 4 args */)
- dup2(/* 2 args */)
- dup3(/* 3 args */)
- eventfd2(/* 2 args */)
- pipe2(/* 2 args */)
- pselect6(/* 6 args, including structs */)
- signalfd4(/* 4 args, one of them a struct */)
- umount2(/* 2 args */)
- wait3(/* 3 args, one of them a struct */)
- wait4(/* 4 args, one of them a struct */)

Anyway, we can name it clone3() for the next revision.
(The "argument number" naming scheme struck us as kind of odd. Jann
 pointed out that if we ever have to have another syscall that already
 takes 6 arguments what would it be named "pselect6.1"?)

> and that clone6 structure isn't even "six arguments", because it has
> lots of other arguments (with the extra flags registers you did, but
> I'll get to that later).
> 
> Finally, the actual definition of that thing is wrong for a uapi interface too:
> 
>    struct clone6_args {
>           __s32 pidfd;
>           __aligned_u64 parent_tidptr;
>           __aligned_u64 child_tidptr;
>           ...
> 
> because now it has a hole in that structure definition because of
> alignment issues. So make "pidfd" be 64-bit too. You clearly tried to
> make this be compat-aware etc, but we really don't want to have parts
> of user structures with random padding that we then don't check.

Noted.

> 
> So the *user* visible structure should be full of those __aligned_u64
> to make sure everything is aligned and doesn't care about compat
> models.
> 
> But the *kernel* structure that we use should be nice and tailored for
> kernel use, and use proper kernel types.

Noted.

> 
> And related to that disgusting thing:
> 
> > -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> > +extern long _do_fork(u64 clone_flags, struct clone6_args *uargs);
> 
> This is the correct thing to do (except for the "clone6" name), but:
> 
> >  static __latent_entropy struct task_struct *copy_process(
> > -                                       unsigned long clone_flags,
> > -                                       unsigned long stack_start,
> > -                                       unsigned long stack_size,
> > -                                       int __user *parent_tidptr,
> > -                                       int __user *child_tidptr,
> > +                                       u64 clone_flags,
> >                                         struct pid *pid,
> >                                         int trace,
> > -                                       unsigned long tls,
> > -                                       int node)
> > +                                       int node,
> > +                                       struct clone6_args *args,
> > +                                       bool is_clone6)
> 
> But this is absolutely wrong.
> 
> That "bool is_clone6" is garbage.
> 
> The in-kernel "struict clone_args" should just be everything that
> clone needs to know.

This goes back to the missing split between an in-kernel struct and uapi
struct, but sure.

> 
> So the in-kernel "struct clone_args" should never ever need some
> "is_clone6" boolean to specify how you then treat the arguments.
> 
> Stuff like this:
> 
> > +       int __user *child_tidptr = u64_to_user_ptr(args->child_tidptr);
> 
> should have been done in the stubs that set up the "struct clone_args"
> thing, not in copy_process().

Noted.

> 
> So all those
> 
>         if (is_clone6) ...
> 
> things need to go away, and it just needs to be the caller (who knows
> what kind of clone call it is) setting up the clone_args properly,
> depending on the *different* user interfaces.

Right.

> 
> And no, we don't do crazy stuff like this either:
> 
> +SYSCALL_DEFINE6(clone6, struct clone6_args __user*, uargs,
> +                       unsigned int, flags1,
> +                       unsigned int, flags2,
> +                       unsigned int, flags3,
> +                       unsigned int, flags4,
> +                       unsigned int, flags5)
> 
> where this is wrong because it randomly just decides that everything
> is flags (BS), and then doubles down on stupidity by making them
> "unsigned int", so that the tests of the flags actually don't test the

For all system calls that use flag arguments so far "unsigned int" was
the way to go because of 32bit and because of prior convention.
We debated having this be a 64 bit. But honestly, this is one of those
junctions where it becomes a matter of: "have you been around long
enough to simply ignore prior conventions?".

> upper bits anyway.
> 
> Why would you reserve 5 words of flags for future use when you have a
> whole structure in user space that you _didn't_ reserve anything in?
> 
> So remove all those random flags, put ONE of them in the structure you
> already have (as a "__aligned_u64", so that you actually get 64 bits,
> not the 32 in "unsigned int"), and then perhaps you can add *one*
> other register argument, which is the *size* of the structure that
> user space is passing in.

Sure, that was what I originally had in mind but the valid point was
made that passing all flags arguments in registers makes it easy for
seccomp to filter them.
It is a cleaner design to do it in the struct, sure. I don't have
quarrels with moving the flags into the struct itself.

> 
> That way, if we ever expand things, we'll just add new flags to the
> end of the in-memory structure we have, but old binaries that don't
> know about the size will continue to pass in the old size, and we'll
> be all good.

Right, that's the way the commit message outlines what we would've
wanted to do once we run out of flags in the register arguments.

> 
> So I hate the whole patch with a passion. It does absolutely
> everything wrong from an interface standpoint.

He, fair enough. Let's see how fast we can fix this then. :)

> 
> I don't hate the notion of just adding flags. But do it cleanly, not
> with random "is_clone6" bits.
> 
> And no, the structure we pass in from user space must *NOT* be the
> same structure that we just copy blindly around as a kernel structure.
> We've done that mistake before, and it is *always* a mistake. Think
> "struct stat" and friends. No, we have a "struct kstat" for the kernel
> version, and then we convert at the system call boundary. Let's not
> repeat traditional mistakes.
> 
> And part of the conversion is exactly that
> 
>   Make everybody use the same in-kernel interface, so that the
> lower-down routines don't have those kinds of "if it's this system
> call, do this, otherwise, do that"
> 
> kind of horrible nasty mis-designs.
> 
> So to summarize:
> 
>  (a) make a separate kernel-only "clone_args" structure that is
> unified and works for every single version of clone/fork/vfork, and
> that has pointers and types in the kernel native format.
> 
>      So this will have things like "int __user *parent_tidptr" etc,
> and something like *one* u64 flag field.
> 
>  (b) have the new system call have a nice compat-safe but
> _independent_ format ("struct clone_uapi_struct")
> 
>  (c) you can now make the new system-call interface be something like
> 
> int clone_ext(struct clone_uapi_struct __user *uargs, size_t size);
> {
>         struct clone_uapi_struct kargs;
>         struct clone_args args;
> 
>         // The API is defined as a stucture of 64-bit words
>         if (size & 7)
>                 return -EINVAL;
>         if (!access_ok(uargs, size))
>                 return -EFAULT;
> 
>         // If the user passes in new flags we don't
>         // know about (because it was compiled against
>         // a newer kernel than what is runn ing), make
>         // sure they are zero
>         if (size > sizeof(kargs)) {
>                 size_t n = (size - sizeof(kargs))>>3;
>                 u64 __user *ptr = (u64 __user *)(uargs+1)
> 
>                 if (n > 10)
>                         return -EINVAL;
>                 do {
>                         u64 val;
>                         if (get_user(val, ptr++))
>                                 return -EFAULT;
>                         if (val)
>                                 return -EINVAL;
>                 } while (--n);
> 
>                 // Ok, everything else was zero, we use
>                 // the part we know about
>                 size = sizeof(kargs);
>         }
>         memset(&kargs, 0, sizeof(kargs));
>         memcpy_from_user(&kargs, uargs, size);
> 
>         .. now convert 'kargs' to 'args' ..
> 
> See? The above may be a bit *unnecessarily* anal about the whole
> checking etc, but it's actually fairly simple in the end. And it means
> that we have that "convert to internal format" in just one place - the
> place where it makes sense. And it's a lot cleaner interface to user
> mode, and allows for easy expansion later.
> 
> NOTE! By all means make "clone_ext()" take some of the other arguments
> as part of the argument registers, not everything has to be part of
> "struct clone_uapi_struct". But none of this "flag1..5" stuff. That's
> what a struct is for.
> 
> Maybe the basic ":u64 clone_flags" could be the first argument (but
> 64-bit arguments can be a bit nasty for compat layers, so it's
> probably not even worth it - once you have to copy an argument
> structure from user space, you might as well put everything there).

Hm, still pondering whether having one unsigned int argument passed
through registers that captures all the flags from the old clone() would
be a good idea. But I'll call that once the other code is written and if
I *should* think it is a good idea and people hate it they can just yell
and we can remove it.

Thanks the pointers!
Christian
