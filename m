Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165852195AB
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 03:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGIBav (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jul 2020 21:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgGIBau (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jul 2020 21:30:50 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334ABC061A0B
        for <linux-api@vger.kernel.org>; Wed,  8 Jul 2020 18:30:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so478727ljn.4
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2020 18:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPNtScbUbSRtloFQsQJiTlDDQ8S8R6akF2kOh4+CkmE=;
        b=QFefWuReDB6ARXYxjV3aJULDqLueCAYxDEuvLKmcmD0M9Z38VCD2AZR6NgqOko90Bn
         qZSN2Ps6VpOLK+1zRUOx9NbBh9sSblnQp7mITAtH6qi9NSGiRbM6v+niJ0LZyPHUCYDw
         kTBaELhyttAwZ4CTFfo8P5B51A8UYlc+d8lnQnIFT5ns9IG/BK9ytR5GyLmztutj4CIT
         Z7q4UwHTG5j5xlMObjZvmybnvDF3d/nvgBYAYHEK9KI4VKTK3WpGhAg5c/7+ALUhZ1FX
         Yj6zUKf85x9p5HQot5FiMnSK9SyC1wp/q1FGrbHKnNioEEykyUvnDqCMIZNTQKWzYhnQ
         PeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPNtScbUbSRtloFQsQJiTlDDQ8S8R6akF2kOh4+CkmE=;
        b=RurOdRgJZzG1m/5MTowyPn4GWHWpkupCkYnYW2i1DlXJQmIF97Y+qIwYVKD06VaioO
         vDTpLL8GEObRyVe0paOI9mCR4pnYPLqRFTGYxn5s+61TPGjS72O5eDFsI5QylZNeFPRC
         lWianb5FUN8bhVeza0Xcue/mfKS4aCtv9iKTjk1n/HerAvryIFYSGduD85G6jToQCnlv
         qXBGfSMJT/kQLSyOG/xd2yXoWY9AZX5S3jlsyhYdAnVzCczb7h6GjYiWEz8HC865QtqT
         tDUC0PcmiTIysL+DqHCc9ueoOjMPMm6aQfV85Y4QdjM9pqU0PIwFQZT7Ce0+XuqllSfU
         IYpA==
X-Gm-Message-State: AOAM532o9PN9GUaHv3ly2f7QyK38XEEyLA5eguj5ueD3XbCpheOh6iG/
        jUsZaBuclfh5q+lIVOrmmssoeOhNyTtqXpUwG7bqqKDRh5g=
X-Google-Smtp-Source: ABdhPJw5iEpHZ7bFZQ5RpaIleEL++5aG0ddfsKQt+UFadBtBJKZajidd/I5GT4jN3gkA0zuWJcxXJON2a5i+go8mvpI=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr13339981ljb.265.1594258248264;
 Wed, 08 Jul 2020 18:30:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200709001234.9719-1-casey@schaufler-ca.com> <20200709001234.9719-23-casey@schaufler-ca.com>
In-Reply-To: <20200709001234.9719-23-casey@schaufler-ca.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Jul 2020 03:30:21 +0200
Message-ID: <CAG48ez36_+0k4ubaHRq=9gVDQspUh6yXkAeMRV=cEy-oyOr-sg@mail.gmail.com>
Subject: Re: [PATCH v18 22/23] LSM: Add /proc attr entry for full LSM context
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 9, 2020 at 2:42 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> Add an entry /proc/.../attr/context which displays the full
> process security "context" in compound format:
>         lsm1\0value\0lsm2\0value\0...
> This entry is not writable.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: linux-api@vger.kernel.org
[...]
> diff --git a/security/security.c b/security/security.c
[...]
> +/**
> + * append_ctx - append a lsm/context pair to a compound context
> + * @ctx: the existing compound context
> + * @ctxlen: size of the old context, including terminating nul byte
> + * @lsm: new lsm name, nul terminated
> + * @new: new context, possibly nul terminated
> + * @newlen: maximum size of @new
> + *
> + * replace @ctx with a new compound context, appending @newlsm and @new
> + * to @ctx. On exit the new data replaces the old, which is freed.
> + * @ctxlen is set to the new size, which includes a trailing nul byte.
> + *
> + * Returns 0 on success, -ENOMEM if no memory is available.
> + */
> +static int append_ctx(char **ctx, int *ctxlen, const char *lsm, char *new,
> +                     int newlen)
> +{
> +       char *final;
> +       int llen;

Please use size_t to represent object sizes, instead of implicitly
truncating them and assuming that that doesn't wrap. Using "int" here
not only makes it harder to statically reason about this code, it
actually can also make the generated code worse:


$ cat numtrunc.c
#include <stddef.h>

size_t my_strlen(char *p);
void *my_alloc(size_t len);

void *blah_trunc(char *p) {
  int len = my_strlen(p) + 1;
  return my_alloc(len);
}

void *blah_notrunc(char *p) {
  size_t len = my_strlen(p) + 1;
  return my_alloc(len);
}
$ gcc -O2 -c -o numtrunc.o numtrunc.c
$ objdump -d numtrunc.o
[...]
0000000000000000 <blah_trunc>:
   0: 48 83 ec 08          sub    $0x8,%rsp
   4: e8 00 00 00 00        callq  9 <blah_trunc+0x9>
   9: 48 83 c4 08          add    $0x8,%rsp
   d: 8d 78 01              lea    0x1(%rax),%edi
  10: 48 63 ff              movslq %edi,%rdi    <<<<<<<<unnecessary instruction
  13: e9 00 00 00 00        jmpq   18 <blah_trunc+0x18>
[...]
0000000000000020 <blah_notrunc>:
  20: 48 83 ec 08          sub    $0x8,%rsp
  24: e8 00 00 00 00        callq  29 <blah_notrunc+0x9>
  29: 48 83 c4 08          add    $0x8,%rsp
  2d: 48 8d 78 01          lea    0x1(%rax),%rdi
  31: e9 00 00 00 00        jmpq   36 <blah_notrunc+0x16>
$

This is because GCC documents
(https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html) that
for integer conversions where the value does not fit into the signed
target type, "the value is reduced modulo 2^N to be within range of
the type"; so the compiler has to assume that you are actually
intentionally trying to truncate the more significant bits from the
length, and therefore may have to insert extra code to ensure that
this truncation happens.


> +       llen = strlen(lsm) + 1;
> +       newlen = strnlen(new, newlen) + 1;

This strnlen() call seems dodgy. If an LSM can return a string that
already contains null bytes, shouldn't that be considered a bug, given
that it can't be displayed properly? Would it be more appropriate to
have a WARN_ON(memchr(new, '\0', newlen)) check here and bail out if
that happens?

> +       final = kzalloc(*ctxlen + llen + newlen, GFP_KERNEL);
> +       if (final == NULL)
> +               return -ENOMEM;
> +       if (*ctxlen)
> +               memcpy(final, *ctx, *ctxlen);
> +       memcpy(final + *ctxlen, lsm, llen);
> +       memcpy(final + *ctxlen + llen, new, newlen);
> +       kfree(*ctx);
> +       *ctx = final;
> +       *ctxlen = *ctxlen + llen + newlen;
> +       return 0;
> +}
> +
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> @@ -2109,6 +2145,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
>                                 char **value)
>  {
>         struct security_hook_list *hp;
> +       char *final = NULL;
> +       char *cp;
> +       int rc = 0;
> +       int finallen = 0;
>         int display = lsm_task_display(current);
>         int slot = 0;
>
[...]
>                 return -ENOMEM;
>         }
>
> +       if (!strcmp(name, "context")) {
> +               hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
> +                                    list) {
> +                       rc = hp->hook.getprocattr(p, "context", &cp);
> +                       if (rc == -EINVAL)
> +                               continue;
> +                       if (rc < 0) {
> +                               kfree(final);
> +                               return rc;
> +                       }

This means that if SELinux refuses to give the caller PROCESS__GETATTR
access to the target process, the entire "context" file will refuse to
show anything, even if e.g. an AppArmor label would be visible through
the LSM-specific attribute directory, right? That seems awkward. Can
you maybe omit context elements for which the access check failed
instead, or embed an extra flag byte to signal for each element
whether the lookup failed, or something along those lines?

If this is an intentional design limitation, it should probably be
documented in the commit message or so.

> +                       rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
> +                                       cp, rc);
> +                       if (rc < 0) {
> +                               kfree(final);
> +                               return rc;
> +                       }

Isn't there a memory leak here? `cp` points to memory that was
allocated by hp->hook.getprocattr(), and you're not freeing it after
append_ctx(). (And append_ctx() also doesn't free it.)

> +               }
> +               if (final == NULL)
> +                       return -EINVAL;
> +               *value = final;
> +               return finallen;
> +       }
> +
>         hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
>                 if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
>                         continue;
