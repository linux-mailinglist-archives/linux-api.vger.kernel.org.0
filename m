Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 016792AB50
	for <lists+linux-api@lfdr.de>; Sun, 26 May 2019 18:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfEZQ6U (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 26 May 2019 12:58:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40977 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbfEZQ6T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 26 May 2019 12:58:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id q16so4271874ljj.8
        for <linux-api@vger.kernel.org>; Sun, 26 May 2019 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwWdQnmq8yASPrv2cFHrDQaqBgqtmSmbYfjT2af0Acs=;
        b=UXAoISgQjf1jQmsrwHd12UAUvhD6bf1H5d4w3/6UVxx1RAozQIy7yc+RrEsARJDzoR
         K1BNPe1jPjl5Z3yMoxGsaOGzTOj1A035x4xcNiPp17tsaBS9HrmfLWpUaJSdRTJB95CQ
         lGTpp6xg251xIEiGguzO4NBvatZ9DuEMxtP5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwWdQnmq8yASPrv2cFHrDQaqBgqtmSmbYfjT2af0Acs=;
        b=VMvV6jadX+HJ1f4jGs9FFSofDMGcPkI23aizuNfgwPkFZbEFZh6EgTRvVnq6JtE6FW
         MJAa7Qe3ricJEVsa7jJEQeq8zoNbYr5AKwUFB8qTmdNKUbWGr/7TJNqBYHTuYhlmA6jZ
         mJ1bZJlRdnTE6bf0kMgZqFHliw6XDYHGWWYRg4gBC9hkYFMSKBMwCv38La70VF9QoVwQ
         EX3dT20WNhauLA5EI7SYHjRREfLiMla/9UOtiUFJAGXfXsntbk7mmyIrOEAN5Eiy8fcr
         A+CuU6i8Fa8X3VtcyGkcJb0U4I/6xhcN8k/AI8PSzTkm+8pq4Uapq9CCsjMtfoe7wmfJ
         jRVw==
X-Gm-Message-State: APjAAAUpcQwlfgFMNXTq9Hcvu7m5xslMFedTbxpbIevi77ZUWaCFqUGi
        fZw1kbu/00M76naNHw1OkPam0Iy6PLs=
X-Google-Smtp-Source: APXvYqxLR37lidWSjNXHWReAwEnFn4Vmrw7jX4pFEd+7//egAzgCTK28JVp8uJ3G2QGvfgIxAqX0pg==
X-Received: by 2002:a2e:8516:: with SMTP id j22mr28759683lji.119.1558889896911;
        Sun, 26 May 2019 09:58:16 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k21sm2041650lji.81.2019.05.26.09.58.16
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 09:58:16 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v18so10405761lfi.1
        for <linux-api@vger.kernel.org>; Sun, 26 May 2019 09:58:16 -0700 (PDT)
X-Received: by 2002:ac2:4565:: with SMTP id k5mr1557648lfm.170.1558889448623;
 Sun, 26 May 2019 09:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190526102612.6970-1-christian@brauner.io>
In-Reply-To: <20190526102612.6970-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 May 2019 09:50:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
Message-ID: <CAHk-=wieuV4hGwznPsX-8E0G2FKhx3NjZ9X3dTKh5zKd+iqOBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: add clone6
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 26, 2019 at 3:27 AM Christian Brauner <christian@brauner.io> wrote:
>
> This adds the clone6 system call.

No, this is not acceptable.

> +       struct clone6_args args = {

First of all, we don't pass in "clone6_args" to the actual implementation.

Passing in lots of args as a structure is fine. But it damn well isn't
a "clone6" structure. It's just a "clone_args" inside the kernel, and
there should be a separate clone_uapi_args for the user/kernel
interface.

The user interface (in the uapi file) may be called "clone6_args", but
that is *not* then what we pass around inside the kernel.

But even for the uapi version, the "clone6" name doesn't make any
sense as a name to begin with. It's not the sixth revision of clone,
and that clone6 structure isn't even "six arguments", because it has
lots of other arguments (with the extra flags registers you did, but
I'll get to that later).

Finally, the actual definition of that thing is wrong for a uapi interface too:

   struct clone6_args {
          __s32 pidfd;
          __aligned_u64 parent_tidptr;
          __aligned_u64 child_tidptr;
          ...

because now it has a hole in that structure definition because of
alignment issues. So make "pidfd" be 64-bit too. You clearly tried to
make this be compat-aware etc, but we really don't want to have parts
of user structures with random padding that we then don't check.

So the *user* visible structure should be full of those __aligned_u64
to make sure everything is aligned and doesn't care about compat
models.

But the *kernel* structure that we use should be nice and tailored for
kernel use, and use proper kernel types.

And related to that disgusting thing:

> -extern long _do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *, unsigned long);
> +extern long _do_fork(u64 clone_flags, struct clone6_args *uargs);

This is the correct thing to do (except for the "clone6" name), but:

>  static __latent_entropy struct task_struct *copy_process(
> -                                       unsigned long clone_flags,
> -                                       unsigned long stack_start,
> -                                       unsigned long stack_size,
> -                                       int __user *parent_tidptr,
> -                                       int __user *child_tidptr,
> +                                       u64 clone_flags,
>                                         struct pid *pid,
>                                         int trace,
> -                                       unsigned long tls,
> -                                       int node)
> +                                       int node,
> +                                       struct clone6_args *args,
> +                                       bool is_clone6)

But this is absolutely wrong.

That "bool is_clone6" is garbage.

The in-kernel "struict clone_args" should just be everything that
clone needs to know.

So the in-kernel "struct clone_args" should never ever need some
"is_clone6" boolean to specify how you then treat the arguments.

Stuff like this:

> +       int __user *child_tidptr = u64_to_user_ptr(args->child_tidptr);

should have been done in the stubs that set up the "struct clone_args"
thing, not in copy_process().

So all those

        if (is_clone6) ...

things need to go away, and it just needs to be the caller (who knows
what kind of clone call it is) setting up the clone_args properly,
depending on the *different* user interfaces.

And no, we don't do crazy stuff like this either:

+SYSCALL_DEFINE6(clone6, struct clone6_args __user*, uargs,
+                       unsigned int, flags1,
+                       unsigned int, flags2,
+                       unsigned int, flags3,
+                       unsigned int, flags4,
+                       unsigned int, flags5)

where this is wrong because it randomly just decides that everything
is flags (BS), and then doubles down on stupidity by making them
"unsigned int", so that the tests of the flags actually don't test the
upper bits anyway.

Why would you reserve 5 words of flags for future use when you have a
whole structure in user space that you _didn't_ reserve anything in?

So remove all those random flags, put ONE of them in the structure you
already have (as a "__aligned_u64", so that you actually get 64 bits,
not the 32 in "unsigned int"), and then perhaps you can add *one*
other register argument, which is the *size* of the structure that
user space is passing in.

That way, if we ever expand things, we'll just add new flags to the
end of the in-memory structure we have, but old binaries that don't
know about the size will continue to pass in the old size, and we'll
be all good.

So I hate the whole patch with a passion. It does absolutely
everything wrong from an interface standpoint.

I don't hate the notion of just adding flags. But do it cleanly, not
with random "is_clone6" bits.

And no, the structure we pass in from user space must *NOT* be the
same structure that we just copy blindly around as a kernel structure.
We've done that mistake before, and it is *always* a mistake. Think
"struct stat" and friends. No, we have a "struct kstat" for the kernel
version, and then we convert at the system call boundary. Let's not
repeat traditional mistakes.

And part of the conversion is exactly that

  Make everybody use the same in-kernel interface, so that the
lower-down routines don't have those kinds of "if it's this system
call, do this, otherwise, do that"

kind of horrible nasty mis-designs.

So to summarize:

 (a) make a separate kernel-only "clone_args" structure that is
unified and works for every single version of clone/fork/vfork, and
that has pointers and types in the kernel native format.

     So this will have things like "int __user *parent_tidptr" etc,
and something like *one* u64 flag field.

 (b) have the new system call have a nice compat-safe but
_independent_ format ("struct clone_uapi_struct")

 (c) you can now make the new system-call interface be something like

int clone_ext(struct clone_uapi_struct __user *uargs, size_t size);
{
        struct clone_uapi_struct kargs;
        struct clone_args args;

        // The API is defined as a stucture of 64-bit words
        if (size & 7)
                return -EINVAL;
        if (!access_ok(uargs, size))
                return -EFAULT;

        // If the user passes in new flags we don't
        // know about (because it was compiled against
        // a newer kernel than what is runn ing), make
        // sure they are zero
        if (size > sizeof(kargs)) {
                size_t n = (size - sizeof(kargs))>>3;
                u64 __user *ptr = (u64 __user *)(uargs+1)

                if (n > 10)
                        return -EINVAL;
                do {
                        u64 val;
                        if (get_user(val, ptr++))
                                return -EFAULT;
                        if (val)
                                return -EINVAL;
                } while (--n);

                // Ok, everything else was zero, we use
                // the part we know about
                size = sizeof(kargs);
        }
        memset(&kargs, 0, sizeof(kargs));
        memcpy_from_user(&kargs, uargs, size);

        .. now convert 'kargs' to 'args' ..

See? The above may be a bit *unnecessarily* anal about the whole
checking etc, but it's actually fairly simple in the end. And it means
that we have that "convert to internal format" in just one place - the
place where it makes sense. And it's a lot cleaner interface to user
mode, and allows for easy expansion later.

NOTE! By all means make "clone_ext()" take some of the other arguments
as part of the argument registers, not everything has to be part of
"struct clone_uapi_struct". But none of this "flag1..5" stuff. That's
what a struct is for.

Maybe the basic ":u64 clone_flags" could be the first argument (but
64-bit arguments can be a bit nasty for compat layers, so it's
probably not even worth it - once you have to copy an argument
structure from user space, you might as well put everything there).

                Linus
