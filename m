Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E79A15AE99
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 18:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgBLRT4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 12:19:56 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47013 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLRT4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 12:19:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id z26so2131118lfg.13
        for <linux-api@vger.kernel.org>; Wed, 12 Feb 2020 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rU6txhFTKspoGX/U60ruYSaeQNuMHsYzoocjIcC782c=;
        b=OZ1hvEGkFd12rHeAi8ci4EjhJ8sPzGLXm4kc5nQ6qyUcizK9ENQhNNUnvZNl6ipOwD
         X9/zMjh4tdfENQwQU0gI8zznCTzlp1lj2LCgDOVRQRX/FGEwV12zZJ1PDeaQ0DW2Ore/
         sCJkl+boumG/aT6Gpv4hmw5MMk5fqQyX6YT4+kpF9FUgWcp0LHmEGpmAF6UFfh5aQgp4
         Fz5d6HvzmwF7R6BLbzai/AiDoEmBkjRbsgIABWxHaBUR8wFnHAkNBOdECeovaSeS8yIt
         pD9sdydhVmJOz6uCU/xoZbmCQITmHKZjotwyNvLWBMyfKWoyNP02qX4ZHyDCEo7KJy+w
         3haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rU6txhFTKspoGX/U60ruYSaeQNuMHsYzoocjIcC782c=;
        b=f8CHsziID0qverJurCbkaxLt6motvDkJZCuyP1Ym5B1gnwBUA6z5wZIlxKv5Mex5uP
         otK1STEK+swMGE/koFC/IyZYGP5qlVHNjCs43jP64SnwbLkJncXG9YffFEP9GRGh9Yis
         2GU2lMkrC5lG4IAL51TL7C5xF1vtEEqykKjjHdXSsoWIUmlFTbTKDhQk07IyOzauqcis
         0xwHvryecMEVl2W4fQ+bQOAirtrvz1tFyXQj9KrZZNfZLd0UDY/V5sL4wltlI0j0Mvkr
         Y26pc5DlAkzIPZL5mZl4SETrmNhvAKKV6LxrPmkz6Y4RkP6WHX7pVgqWCYy4O/rQjuDn
         UNEQ==
X-Gm-Message-State: APjAAAXVXnTaLhivnrd7UtXyKrzW+r3galDnqAPtKJhOpKkETi3ASKSu
        /bNWGI840vBPBsBvxA+aY1TRK9s0rndZUyoLtqQMtQ==
X-Google-Smtp-Source: APXvYqw9k3f7e9kNkAqI6YaXNA3yxCHADb9+dIrru9lZjroVzKlLAvIc7iQVCvQ3XTCCBSqw34OZAuqivhMsrW/2i4w=
X-Received: by 2002:ac2:5f59:: with SMTP id 25mr7042133lfz.193.1581527992964;
 Wed, 12 Feb 2020 09:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com> <20200211225547.235083-4-dancol@google.com>
 <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov>
In-Reply-To: <ef13d728-9f1e-5e38-28a1-7ed7134840e4@tycho.nsa.gov>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 12 Feb 2020 09:19:16 -0800
Message-ID: <CAKOZuesUVSYJ6EjHFL3QyiWKVmyhm1fLp5Bm_SHjB3_s1gn08A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] Teach SELinux about a new userfaultfd class
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Tim Murray <timmurray@google.com>, Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks for taking a look.

On Wed, Feb 12, 2020 at 9:04 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/11/20 5:55 PM, Daniel Colascione wrote:
> > Use the secure anonymous inode LSM hook we just added to let SELinux
> > policy place restrictions on userfaultfd use. The create operation
> > applies to processes creating new instances of these file objects;
> > transfer between processes is covered by restrictions on read, write,
> > and ioctl access already checked inside selinux_file_receive.
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
>
> (please add linux-fsdevel and viro to the cc for future versions of this
> patch since it changes the VFS)
>
> > ---
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 1659b59fb5d7..e178f6f40e93 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2915,6 +2919,69 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >       return 0;
> >   }
> >
> > +static int selinux_inode_init_security_anon(struct inode *inode,
> > +                                         const char *name,
> > +                                         const struct file_operations *fops)
> > +{
> > +     const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +     struct common_audit_data ad;
> > +     struct inode_security_struct *isec;
> > +
> > +     if (unlikely(IS_PRIVATE(inode)))
> > +             return 0;
>
> Seems like this is precluded by the caller and would be a bug?  If
> needed at all, take it to the security_inode_init_security_anon() so it
> doesn't have to be repeated in each security module.
>
> > +
> > +     /*
> > +      * We shouldn't be creating secure anonymous inodes before LSM
> > +      * initialization completes.
> > +      */
> > +     if (unlikely(!selinux_state.initialized))
> > +             return -EBUSY;
>
> I don't think this is viable; any arbitrary actions are possible before
> policy is loaded, and a Linux distro can be brought up fully with
> SELinux enabled and no policy loaded.  You'll just need to have a
> default behavior prior to initialization.

We'd have to fail open then, I think, and return an S_PRIVATE inode
(the regular anon inode).

> > +
> > +     isec = selinux_inode(inode);
> > +
> > +     /*
> > +      * We only get here once per ephemeral inode.  The inode has
> > +      * been initialized via inode_alloc_security but is otherwise
> > +      * untouched, so check that the state is as
> > +      * inode_alloc_security left it.
> > +      */
> > +     BUG_ON(isec->initialized != LABEL_INVALID);
> > +     BUG_ON(isec->sclass != SECCLASS_FILE);
>
> I think the kernel discourages overuse of BUG_ON/BUG/...

I'm not sure what counts as overuse.

> > +
> > +#ifdef CONFIG_USERFAULTFD
> > +     if (fops == &userfaultfd_fops)
> > +             isec->sclass = SECCLASS_UFFD;
> > +#endif
>
> Not sure we want or need to introduce a new security class for each user
> of anonymous inodes since the permissions should be the same as for
> file.

The purpose of this change is to apply special policy to userfaultfd
FDs in particular. Isn't having a UFFD security class the best way to
go about that? (There's no path.) Am I missing something?

> Also not sure we want to be testing fops for each such case.

I was also thinking of just providing some kind of context string
(maybe the name), which might be friendlier to modules, but the loose
coupling kind of scares me, and for this particular application, since
UFFD is always in the core and never in a module, checking the fops
seems a bit more robust and doesn't hurt anything.

> We
> were looking at possibly leveraging the name as a key and using
> security_transition_sid() to generate a distinct SID/context/type for
> the inode via type_transition rules in policy.  We have some WIP along
> those lines.

Where? Any chance it would be ready soon? I'd rather not hold up this
work for a more general mechanism.

> > +
> > +     if (isec->sclass == SECCLASS_FILE) {
> > +             printk(KERN_WARNING "refusing to create secure anonymous inode "
> > +                    "of unknown type");
> > +             return -EOPNOTSUPP;
> > +     }
> > +     /*
> > +      * Always give secure anonymous inodes the sid of the
> > +      * creating task.
> > +      */
> > +
> > +     isec->sid = tsec->sid;
>
> This doesn't generalize for other users of anonymous inodes, e.g. the
> /dev/kvm case where we'd rather inherit the SID and class from the
> original /dev/kvm inode itself.

I think someone mentioned on the first version of this patch that we
could make it more flexible if the need arose. If we do want to do it
now, we could have the anon_inode security hook accept a "parent" or
"context" inode that modules could inspect for the purposes of forming
the new inode's SID. Does that make sense to you?
