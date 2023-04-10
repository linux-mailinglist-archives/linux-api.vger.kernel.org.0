Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955916DCE32
	for <lists+linux-api@lfdr.de>; Tue, 11 Apr 2023 01:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDJXi7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Apr 2023 19:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjDJXi6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Apr 2023 19:38:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638DF1BC7
        for <linux-api@vger.kernel.org>; Mon, 10 Apr 2023 16:38:57 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f188so38092949ybb.3
        for <linux-api@vger.kernel.org>; Mon, 10 Apr 2023 16:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681169936; x=1683761936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJm4buOt7tmvkrimdORhOYlnRTzDu1Cd6rPAt2wUCzg=;
        b=XRNeVL9xJP2Jfw6szw8XUT0/AKYcSFLPiIyIuWmer3A5bYZcmLe6SFswnnGDzmKX7J
         jvhqY/2GRqUPK1V0BvgETmcJL9sCB58FdhnyANZcbBiYKL1gphzf4mutNJ9vdH94U6d4
         XFD3BGwRPkN72t92mb7z4HgcfaqBUVBkh1z/T+1B+NkvUNgjZMvcwvYR2UiQnxKlazuZ
         cPzvjnlN+Iui+cX9ZeEsoYW6YpzyyAlC8MvckGyCOu/2DZjw8Rv6F4F+F0GimSp3JQSJ
         MfgZjSPrOPZ5aWGZ9tv+CotOSHRQs/F7K5zUwKAQO0Mj0ve41X3asGwUpWGM5vRvH8+T
         Ms5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169936; x=1683761936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJm4buOt7tmvkrimdORhOYlnRTzDu1Cd6rPAt2wUCzg=;
        b=zsnLoBFOaqOg65YjJBSWaBzb1IeVw9LzgnfnaaUVNqfmMvkiEAYoEE+8GYNXmM4zRp
         gHP42bdWmLSZ0Qp7qGs0lQ2r+8DQDW0jr0ibhmb/j6hwUyP/qqYhrbarUlrPoXK3BsZk
         AOPdokdtCgHk6VJPGjxZAkgHSuOqQYJQTe2YcZDyHZYJ6GAjYMOitqa98GwE8DtrPsVU
         2fU9GgtKyGAhzXe76viVb8Ew13a4ufu9lbe63tmTDj7+pzsiegl+zW1kq//wfO/8kP2/
         WPhwvw3K8Xc90AMlE4jdj3kRZfzLcOybnPPuXdUuRBGQw2HN0C3TWYOVcD5yAZpqh4os
         ywoQ==
X-Gm-Message-State: AAQBX9dIreKyUR/ol1/uhbi43+uNfhBK72D1fLOUnSbA6ahVzNCrJv4I
        plAqJwLcYYQjy0/edgV4SUIma+Ao2AbE3aCzSiTe
X-Google-Smtp-Source: AKy350bEmtU6DLBIvu6UeM6zO2dV43jzco2vViu5GOenddcQ5YDizSjkUMcoVIkBtRe+lAcDU2TWELovDivRyOA7VY4=
X-Received: by 2002:a25:d70d:0:b0:b68:7a4a:5258 with SMTP id
 o13-20020a25d70d000000b00b687a4a5258mr7880379ybg.3.1681169936525; Mon, 10 Apr
 2023 16:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230315224704.2672-1-casey@schaufler-ca.com> <20230315224704.2672-6-casey@schaufler-ca.com>
 <80cd055f-3bd9-b89a-029b-7a63924b5bde@digikod.net> <CAHC9VhTs=cHcsi15qFsMqtGZxm2bkTb2AOsbrERePwUT3N0uJQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTs=cHcsi15qFsMqtGZxm2bkTb2AOsbrERePwUT3N0uJQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Apr 2023 19:38:45 -0400
Message-ID: <CAHC9VhS+oJ_9yy_UMV3_-J_3rtcd-KxQXMxZHv3u0CynXkx7AQ@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] LSM: Create lsm_list_modules system call
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 10, 2023 at 7:37=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Mon, Apr 3, 2023 at 8:04=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
> >
> > It looks like you missed my preview reviews on these patches.
>
> For reference, I believe this is Micka=C3=ABl's review of the associated =
v6 patch:
>
> https://lore.kernel.org/linux-security-module/1ca41f67-ffa1-56c2-b4ee-f5d=
eece95130@digikod.net/

My apologies, I hit send too soon ... Micka=C3=ABl, if there are a specific
points you feel have not been addressed, but should be, it would be
helpful if you could list them in this thread.

> > On 15/03/2023 23:46, Casey Schaufler wrote:
> > > Create a system call to report the list of Linux Security Modules
> > > that are active on the system. The list is provided as an array
> > > of LSM ID numbers.
> > >
> > > The calling application can use this list determine what LSM
> > > specific actions it might take. That might include chosing an
> > > output format, determining required privilege or bypassing
> > > security module specific behavior.
> > >
> > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > >   Documentation/userspace-api/lsm.rst |  3 +++
> > >   include/linux/syscalls.h            |  1 +
> > >   kernel/sys_ni.c                     |  1 +
> > >   security/lsm_syscalls.c             | 39 ++++++++++++++++++++++++++=
+++
> > >   4 files changed, 44 insertions(+)
> > >
> > > diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/user=
space-api/lsm.rst
> > > index b45e402302b3..a86e3817f062 100644
> > > --- a/Documentation/userspace-api/lsm.rst
> > > +++ b/Documentation/userspace-api/lsm.rst
> > > @@ -63,6 +63,9 @@ Get the specified security attributes of the curren=
t process
> > >   .. kernel-doc:: security/lsm_syscalls.c
> > >       :identifiers: sys_lsm_get_self_attr
> > >
> > > +.. kernel-doc:: security/lsm_syscalls.c
> > > +    :identifiers: sys_lsm_list_modules
> > > +
> > >   Additional documentation
> > >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > >
> > > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > > index 3feca00cb0c1..f755c583f949 100644
> > > --- a/include/linux/syscalls.h
> > > +++ b/include/linux/syscalls.h
> > > @@ -1063,6 +1063,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned =
int attr, struct lsm_ctx *ctx,
> > >                                     size_t *size, __u64 flags);
> > >   asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm=
_ctx *ctx,
> > >                                     __u64 flags);
> > > +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 fla=
gs);
> > >
> > >   /*
> > >    * Architecture-specific system calls
> > > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > > index d03c78ef1562..ceb3d21a62d0 100644
> > > --- a/kernel/sys_ni.c
> > > +++ b/kernel/sys_ni.c
> > > @@ -265,6 +265,7 @@ COND_SYSCALL(mremap);
> > >   /* security/lsm_syscalls.c */
> > >   COND_SYSCALL(lsm_get_self_attr);
> > >   COND_SYSCALL(lsm_set_self_attr);
> > > +COND_SYSCALL(lsm_list_modules);
> > >
> > >   /* security/keys/keyctl.c */
> > >   COND_SYSCALL(add_key);
> > > diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> > > index feee31600219..6efbe244d304 100644
> > > --- a/security/lsm_syscalls.c
> > > +++ b/security/lsm_syscalls.c
> > > @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, a=
ttr, struct lsm_ctx __user *,
> > >   {
> > >       return security_getselfattr(attr, ctx, size, flags);
> > >   }
> > > +
> > > +/**
> > > + * sys_lsm_list_modules - Return a list of the active security modul=
es
> > > + * @ids: the LSM module ids
> > > + * @size: size of @ids, updated on return
> > > + * @flags: reserved for future use, must be zero
> > > + *
> > > + * Returns a list of the active LSM ids. On success this function
> > > + * returns the number of @ids array elements. This value may be zero
> > > + * if there are no LSMs active. If @size is insufficient to contain
> > > + * the return data -E2BIG is returned and @size is set to the minimu=
m
> > > + * required size. In all other cases a negative value indicating the
> > > + * error is returned.
> > > + */
> > > +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *=
, size,
> > > +             u32, flags)
> > > +{
> > > +     size_t total_size =3D lsm_active_cnt * sizeof(*ids);
> > > +     size_t usize;
> > > +     int i;
> > > +
> > > +     if (flags)
> > > +             return -EINVAL;
> > > +
> > > +     if (get_user(usize, size))
> > > +             return -EFAULT;
> > > +
> > > +     if (put_user(total_size, size) !=3D 0)
> > > +             return -EFAULT;
> > > +
> > > +     if (usize < total_size)
> > > +             return -E2BIG;
> > > +
> > > +     for (i =3D 0; i < lsm_active_cnt; i++)
> > > +             if (put_user(lsm_idlist[i]->id, ids++))
> > > +                     return -EFAULT;
> > > +
> > > +     return lsm_active_cnt;
> > > +}
>
> --
> paul-moore.com



--=20
paul-moore.com
