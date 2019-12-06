Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85F9E114C4F
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 07:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLFGQl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 01:16:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38317 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfLFGQl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 01:16:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id i6so3728988edr.5
        for <linux-api@vger.kernel.org>; Thu, 05 Dec 2019 22:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aU5igi+hXGEOG2QjkV3GIlWqJAN3Fk8A4HK4+I3f2QM=;
        b=fk1qCuSPIEKRmrNCoOSyQZj7+0A2CtGnQ9degU7je+6lu69n6L5g/5TRM4wuDbJ7gd
         l97vL0uEkTz0Y+rTnfCtmXvC6hF4Qwx5Foj6ph90icCTw6CcdSam2W46RTjWwWcVt1G2
         GwsIFD0gQJmDFEKBJPNCv4dO4FhByExQjZoQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aU5igi+hXGEOG2QjkV3GIlWqJAN3Fk8A4HK4+I3f2QM=;
        b=ae7W7Ytl08m31E0ia6eQk0Dwk0szHOf8hPIM7aPXIwFkKmeF6L8RwrphGCAI0Joc/q
         87kBVsiyolF7F07of8n3doTbxahw0hlgg4Q1VpS5rUxZqOYNp1VW+CbKuG6vySLj9HGk
         JSOsu6f+r56R0awEhg53CW8k8mbpjE34mfMsAI0jQWJQ3B8W23njrDxCKmqFzDoxm6yI
         zT8/NAY51yLOJN1jIFj71lmzHIIkP34xTAitI/PHXnCVfv7n1Fp+wodWUOml7C3X5xXs
         n9MdyvJuV/bryGDbiJcFrs7/N9LEyHlXsBNa4ELugodTEIvOC9YpRgVBJ+rSHBKJJnrk
         KkEQ==
X-Gm-Message-State: APjAAAU5ZdkmqgTRDfSE0R4LCttRmWLTfTGRPevQDVRA3YVhZhSKbvYR
        k40XJn582ibuLAs1d4LLfUTXv87he6rv4qmERARG8g==
X-Google-Smtp-Source: APXvYqyjiWil2byS3GcEgja3dADVlQBjxrbvyeDpuzEEo9CQ/+ZU7R5Ibo3TWSgf0BFaRBHmF5nJesWNC1Xj9+JCCiM=
X-Received: by 2002:a50:fa06:: with SMTP id b6mr1170960edq.231.1575612999059;
 Thu, 05 Dec 2019 22:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal> <CAG48ez0_CCxO=stFvK=4G4Og=xe9Rtws8PEVy-cSmLqcxfE2Zw@mail.gmail.com>
In-Reply-To: <CAG48ez0_CCxO=stFvK=4G4Og=xe9Rtws8PEVy-cSmLqcxfE2Zw@mail.gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 5 Dec 2019 22:16:03 -0800
Message-ID: <CAMp4zn85sz_y8EvXUULVY0a0fAmg91pFkYX5zZSXDz6Q-EiUoA@mail.gmail.com>
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Dec 5, 2019 at 6:38 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Dec 6, 2019 at 12:44 AM Sargun Dhillon <sargun@sargun.me> wrote:
> > PTRACE_GETFD is a generic ptrace API that allows the tracer to
> > get file descriptors from the traceee.
>
> typo: tracee
>
> > The primary reason to use this syscall is to allow sandboxers to
> > take action on an FD on behalf of the tracee. For example, this
> > can be combined with seccomp's user notification feature to extract
> > a file descriptor and call privileged syscalls, like binding
> > a socket to a privileged port.
> [...]
> > +/* This gets a file descriptor from a running process. It doesn't require the
> > + * process to be stopped.
> > + */
> > +#define PTRACE_GETFD   0x420f
> [...]
> > +static int ptrace_getfd(struct task_struct *child, unsigned long fd)
>
> I'd make the "fd" parameter of this function an "unsigned int", given
> that that's also the argument type of fcheck_files().
>
> > +{
> > +       struct files_struct *files;
> > +       struct file *file;
> > +       int ret = 0;
> > +
> > +       files = get_files_struct(child);
> > +       if (!files)
> > +               return -ENOENT;
> > +
> > +       spin_lock(&files->file_lock);
> > +       file = fcheck_files(files, fd);
> > +       if (!file)
> > +               ret = -EBADF;
> > +       else
> > +               get_file(file);
> > +       spin_unlock(&files->file_lock);
> > +       put_files_struct(files);
> > +
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret = get_unused_fd_flags(0);
>
> You're hardcoding the flags for the fd as 0, which means that there is
> no way for the caller to enable O_CLOEXEC on the fd in a way that is
> race-free against a concurrent execve(). If you can't easily plumb
> through an O_CLOEXEC flag from userspace to here, you should probably
> hardcode O_CLOEXEC here.
>
I thought about making addr used for flags. It seems a little weird, given the
name, but it'll do the job. Alternatively, it could be a point to an
options struct.
If we introduce options, one of the nice things we could add is add the ability
to cleanse the FD of certain information, like cgroups.

> > +       if (ret >= 0)
> > +               fd_install(ret, file);
> > +
> > +       fput(file);
>
> Annoyingly, this isn't how fd_install() works. fd_install() has
> slightly weird semantics and consumes the reference passed to it, so
> this should be:
>
>   if (ret >= 0)
>     fd_install(ret, file);
>   else
>     fput(file);
>
> > +out:
> > +       return ret;
> > +}
