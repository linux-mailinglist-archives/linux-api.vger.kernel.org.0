Return-Path: <linux-api+bounces-2426-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DA899F767
	for <lists+linux-api@lfdr.de>; Tue, 15 Oct 2024 21:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A01C2352A
	for <lists+linux-api@lfdr.de>; Tue, 15 Oct 2024 19:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676711B6D13;
	Tue, 15 Oct 2024 19:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gxAziQd4"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAC1B6CF7
	for <linux-api@vger.kernel.org>; Tue, 15 Oct 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729021257; cv=none; b=WK1IPGBYec4/APgmYnb9y2TBEU4HSBmKSMqsN6GqUYM/Xj9iSLBh3dxGKm/82TtvRZjLJSacHWGPvjR4t7H9bNNvIanzBvf0Hgiiph0SLjADr644K2wy8zgjZ1COlFFdS1S3gxqqp8mt4sZtcx8XXSIW8kSIWalO2ThrVxqJa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729021257; c=relaxed/simple;
	bh=Bqfpb+t4WNi8V2vZPnnl3epLNOJ5tJQSg9QSd+ycL9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPGYIqWAValQB05Uu4FjtuUeWSl+d/gxp5N/4KaDqjtGA7KvYzTTUmwfduvR8XTmrcHPwdFXYGdl1tyTA16PoTzdNaLghbLk2L5gf+6+ZLIsUUopMa0HK0LXZikhYATh9EU21mZr1BwI7eM4WXAU2wyezbcvLYFP1lWxZS4SFRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gxAziQd4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca03687fdso602635ad.0
        for <linux-api@vger.kernel.org>; Tue, 15 Oct 2024 12:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729021255; x=1729626055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceSrgwFmVnFYDMnDeioPXKsc+zj1mu3wINeJBmSiYkI=;
        b=gxAziQd4umNZt6XD+TkNHYt2MwpjTfsM9EmVQY44Z6cSCDE8rt1SNbGtIlzi66zyox
         9UbfG1068IiVhU4QWDNXUKKLJQ1XQEwMDHU24dSCF83J13MgriZGDR8Bl8Y+tbVYc05G
         v0PCy0YUuZFEhXoPlBkRlU2c/gGmWSxHxpzadaLwARl8U72tjl9Huwr4eXI9bn/U1H3J
         HdPInAxoSH1IXk1kI3K4U8+yn/ZDlUx0py73ulk/teYzJpCzT1pZU4IP4vCIehtgmTbC
         Va7GeAAz81r/GN2DDNjYG39rC7cT1WNmjn6aIicMU3Xq+OGCr8rpmWSCExRWHVDfy1nf
         RNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729021255; x=1729626055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceSrgwFmVnFYDMnDeioPXKsc+zj1mu3wINeJBmSiYkI=;
        b=G16mtkeBikfPtxZjR2vKNEy8c8ziq36zg1gNSgmSLrVNslYaONJHdb6f2f4ttz68sR
         6ayCrwWPechZ0t6EvwFGSqYOOkhFVk8yEmTcPlBcOStVMhhwEocXfsOdlAJryoexpW1p
         Zpl8xloV3Y3CkF/f1d32wpuu8vYLGdb/lmU7r5amEgLbQq5kvtPu+Dq8CXadc4HxyIC2
         q9IIPORSFM608/6UcQ//0JIP8UNUsNNmd/mFpwqGgMmzTLBg6vqCQTJly6hpPujGPBnI
         HzneyvpOYxQqufWKvMXoG+/Afipl4kXmqjN+sfB6SzDqEzPKWoKJ/dvvLd5Nee9DzQjq
         NFHg==
X-Forwarded-Encrypted: i=1; AJvYcCW0GjVcz7WrmeguLkA/Rc/fg9nyTOWhhcgMR1lOWTQvlWoGRAbP4eptkIXtro0g8BlhfQcEtJHPSWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YynC10YqJtrodBcADYXt6KzfyP0wfX1rwhPW4ucaQ18YxrPyNy6
	MIM88WO7BeXIBOZdZsvOJo0ysPhJsOpPb6Mt2ZP972YgsthnJGr24bF+PD2yY41BeGZJM/AInps
	3/v48Wde4SjECpnZXfFmmrbbnHUUsIXJkwr59
X-Google-Smtp-Source: AGHT+IHxCAq4eZcP1OzyDqLt5O4MIrDNock6f5an6pNRsDIMwufvJRat1zbWgpWXbP0gwK1J8tBn2vAWiTLIW7GCC6g=
X-Received: by 2002:a17:902:f552:b0:202:3a49:ace7 with SMTP id
 d9443c01a7336-20d2d05cba5mr517545ad.20.1729021254327; Tue, 15 Oct 2024
 12:40:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728643714.git.lorenzo.stoakes@oracle.com> <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <8e7edaf2f648fb01a71def749f17f76c0502dee1.1728643714.git.lorenzo.stoakes@oracle.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 12:40:41 -0700
Message-ID: <CAJuCfpHLGyrBWZ9JyJ5FdJQtGO1-tuUqHawjKX_mtwnAhSY6Ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] pidfd: extend pidfd_get_pid() and de-duplicate pid lookup
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:06=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> The means by which a pid is determined from a pidfd is duplicated, with
> some callers holding a reference to the (pid)fd, and others explicitly
> pinning the pid.
>
> Introduce __pidfd_get_pid() which abstracts both approaches and provide
> optional output parameters for file->f_flags and the fd (the latter of
> which, if provided, prevents the function from decrementing the fd's
> refernce count).
>
> Additionally, allow the ability to open a pidfd by opening a /proc/<pid>
> directory, utilised by the pidfd_send_signal() system call, providing a
> pidfd_get_pid_proc() helper function to do so.
>
> Doing this allows us to eliminate open-coded pidfd pid lookup and to
> consistently handle this in one place.
>
> This lays the groundwork for a subsequent patch which adds a new sentinel
> pidfd to explicitly reference the current process (i.e. thread group
> leader) without the need for a pidfd.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/pid.h | 42 +++++++++++++++++++++++++++++++-
>  kernel/pid.c        | 58 ++++++++++++++++++++++++++++++---------------
>  kernel/signal.c     | 22 ++++-------------
>  3 files changed, 84 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index a3aad9b4074c..68b02eab7509 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_PID_H
>  #define _LINUX_PID_H
>
> +#include <linux/file.h>
>  #include <linux/pid_types.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> @@ -72,8 +73,47 @@ extern struct pid init_struct_pid;
>
>  struct file;
>
> +
> +/**
> + * __pidfd_get_pid() - Retrieve a pid associated with the specified pidf=
d.
> + *
> + * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> =
file if
> + *              @alloc_proc is also set.
> + * @pin_pid:    If set, then the reference counter of the returned pid i=
s
> + *              incremented. If not set, then @fd should be provided to =
pin the
> + *              pidfd.
> + * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed i=
nstead
> + *              of a pidfd, and this will be used to determine the pid.
> + * @flags:      Output variable, if non-NULL, then the file->f_flags of =
the
> + *              pidfd will be set here.
> + * @fd:         Output variable, if non-NULL, then the pidfd reference w=
ill
> + *              remain elevated and the caller will need to decrement it
> + *              themselves.
> + *
> + * Returns: If successful, the pid associated with the pidfd, otherwise =
an
> + *          error.
> + */
> +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> +                           bool allow_proc, unsigned int *flags,
> +                           struct fd *fd);
> +
> +static inline struct pid *pidfd_get_pid(unsigned int pidfd, unsigned int=
 *flags)
> +{
> +       return __pidfd_get_pid(pidfd, /* pin_pid =3D */ true,
> +                              /* allow_proc =3D */ false,
> +                              flags, /* fd =3D */ NULL);
> +}
> +
> +static inline struct pid *pidfd_to_pid_proc(unsigned int pidfd,
> +                                           unsigned int *flags,
> +                                           struct fd *fd)
> +{
> +       return __pidfd_get_pid(pidfd, /* pin_pid =3D */ false,
> +                              /* allow_proc =3D */ true,
> +                              flags, fd);
> +}
> +
>  struct pid *pidfd_pid(const struct file *file);
> -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
>  struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags);
>  int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret=
);
>  void do_notify_pidfd(struct task_struct *task);
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..25cc1c36a1b1 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -36,6 +36,7 @@
>  #include <linux/pid_namespace.h>
>  #include <linux/init_task.h>
>  #include <linux/syscalls.h>
> +#include <linux/proc_fs.h>
>  #include <linux/proc_ns.h>
>  #include <linux/refcount.h>
>  #include <linux/anon_inodes.h>
> @@ -534,22 +535,46 @@ struct pid *find_ge_pid(int nr, struct pid_namespac=
e *ns)
>  }
>  EXPORT_SYMBOL_GPL(find_ge_pid);
>
> -struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
> +struct pid *__pidfd_get_pid(unsigned int pidfd, bool pin_pid,
> +                           bool allow_proc, unsigned int *flags,
> +                           struct fd *fd)
>  {
> -       struct fd f;
> +       struct file *file;
>         struct pid *pid;
> +       struct fd f =3D fdget(pidfd);
>
> -       f =3D fdget(fd);
> -       if (!fd_file(f))
> +       file =3D fd_file(f);
> +       if (!file)
>                 return ERR_PTR(-EBADF);
>
> -       pid =3D pidfd_pid(fd_file(f));
> -       if (!IS_ERR(pid)) {
> -               get_pid(pid);
> -               *flags =3D fd_file(f)->f_flags;
> +       pid =3D pidfd_pid(file);
> +       /* If we allow opening a pidfd via /proc/<pid>, do so. */
> +       if (IS_ERR(pid) && allow_proc)
> +               pid =3D tgid_pidfd_to_pid(file);
> +
> +       if (IS_ERR(pid)) {
> +               fdput(f);
> +               return pid;
>         }
>
> -       fdput(f);
> +       if (pin_pid)
> +               get_pid(pid);
> +       else
> +               WARN_ON_ONCE(!fd); /* Nothing to keep pid/pidfd around? *=
/
> +
> +       if (flags)
> +               *flags =3D file->f_flags;
> +
> +       /*
> +        * If the user provides an fd output then it will handle decremen=
ting
> +        * its reference counter.
> +        */
> +       if (fd)
> +               *fd =3D f;
> +       else
> +               /* Otherwise we release it. */
> +               fdput(f);
> +
>         return pid;
>  }

There is an EXPORT_SYMBOL_GPL(pidfd_get_pid) right after this line. It
should also be changed to EXPORT_SYMBOL_GPL(__pidfd_get_pid),
otherwise __pidfd_get_pid() will not be exported. A module calling
pidfd_get_pid() now inlined in the header file will try to call
__pidfd_get_pid() and will have trouble resolving this symbol.

>
> @@ -747,23 +772,18 @@ SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
>                 unsigned int, flags)
>  {
>         struct pid *pid;
> -       struct fd f;
>         int ret;
>
>         /* flags is currently unused - make sure it's unset */
>         if (flags)
>                 return -EINVAL;
>
> -       f =3D fdget(pidfd);
> -       if (!fd_file(f))
> -               return -EBADF;
> -
> -       pid =3D pidfd_pid(fd_file(f));
> +       pid =3D pidfd_get_pid(pidfd, NULL);
>         if (IS_ERR(pid))
> -               ret =3D PTR_ERR(pid);
> -       else
> -               ret =3D pidfd_getfd(pid, fd);
> +               return PTR_ERR(pid);
>
> -       fdput(f);
> +       ret =3D pidfd_getfd(pid, fd);
> +
> +       put_pid(pid);
>         return ret;
>  }
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 4344860ffcac..868bfa674c62 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3875,17 +3875,6 @@ static int copy_siginfo_from_user_any(kernel_sigin=
fo_t *kinfo,
>         return copy_siginfo_from_user(kinfo, info);
>  }
>
> -static struct pid *pidfd_to_pid(const struct file *file)
> -{
> -       struct pid *pid;
> -
> -       pid =3D pidfd_pid(file);
> -       if (!IS_ERR(pid))
> -               return pid;
> -
> -       return tgid_pidfd_to_pid(file);
> -}
> -
>  #define PIDFD_SEND_SIGNAL_FLAGS                            \
>         (PIDFD_SIGNAL_THREAD | PIDFD_SIGNAL_THREAD_GROUP | \
>          PIDFD_SIGNAL_PROCESS_GROUP)
> @@ -3908,10 +3897,11 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, in=
t, sig,
>                 siginfo_t __user *, info, unsigned int, flags)
>  {
>         int ret;
> -       struct fd f;
>         struct pid *pid;
>         kernel_siginfo_t kinfo;
>         enum pid_type type;
> +       unsigned int f_flags;
> +       struct fd f;
>
>         /* Enforce flags be set to 0 until we add an extension. */
>         if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
> @@ -3921,12 +3911,8 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int=
, sig,
>         if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
>                 return -EINVAL;
>
> -       f =3D fdget(pidfd);
> -       if (!fd_file(f))
> -               return -EBADF;
> -
>         /* Is this a pidfd? */
> -       pid =3D pidfd_to_pid(fd_file(f));
> +       pid =3D pidfd_to_pid_proc(pidfd, &f_flags, &f);
>         if (IS_ERR(pid)) {
>                 ret =3D PTR_ERR(pid);
>                 goto err;
> @@ -3939,7 +3925,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int,=
 sig,
>         switch (flags) {
>         case 0:
>                 /* Infer scope from the type of pidfd. */
> -               if (fd_file(f)->f_flags & PIDFD_THREAD)
> +               if (f_flags & PIDFD_THREAD)
>                         type =3D PIDTYPE_PID;
>                 else
>                         type =3D PIDTYPE_TGID;
> --
> 2.46.2
>

