Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865703764CA
	for <lists+linux-api@lfdr.de>; Fri,  7 May 2021 14:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhEGMBZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 7 May 2021 08:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235649AbhEGMBZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 7 May 2021 08:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620388825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xE5gyBAP7XXvwmcVdD/ZatFOGgEM/dN4lyKwStNP9II=;
        b=EJUpf/os4s2t2WJlI5O4O7Zg2KioWcpddqr7ywOnQvC8tpu800hYUUOTtglb3XYiN+//2f
        yVwXitaxQfWaSVY94KH5CLEx018aDRjkwqvQO/m3cuB2bzRvwVT0ybH46GoEHJ2u+eniYw
        trDran7R813w4wr6bB78qRncPSymO6M=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-b43905p7NMyyULuYsIxCVA-1; Fri, 07 May 2021 08:00:23 -0400
X-MC-Unique: b43905p7NMyyULuYsIxCVA-1
Received: by mail-yb1-f200.google.com with SMTP id c9-20020a2580c90000b02904f86395a96dso4024370ybm.19
        for <linux-api@vger.kernel.org>; Fri, 07 May 2021 05:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xE5gyBAP7XXvwmcVdD/ZatFOGgEM/dN4lyKwStNP9II=;
        b=fsoAjmVwVLQzbjEEmmfeJe1Ozn9DJm9KM/aDmhWp7ClbVNvJM0e8OKNJugcJPBGTR7
         LF2XmTDKzBebk5AWZlZrrnhf+zStRELXhxHAzl51TcUXJdrmZsbpEXp5RkR+h4ZQgBtu
         25kaNjRGY6wFNoKLgygQMBeH6kQ2q5GMBljUuf5vhwSturiEAvUt5k2IztZRGjBIZJ2Y
         4gSSaOa8SM9DxehzLUCwLc3N99D58GXVqEEHEsPzUS3g5WO2g0/1MagvXDJ9NCK8D38S
         xzoL4v8URHeOPwoIqrao71Bd4lI6/ALH/m1PB5rA7LA2AsFRnJKeMquG8B+UYZKHsi6I
         3bYA==
X-Gm-Message-State: AOAM531DRz4dlwWkv2XHI2vxf6cmjcg8q4C24C7djxUSknnNhPiX51yi
        XBa6Vizc/vHD9FOMpH1OVKGH7QYWFUYCyw6GhzByRh3rZf0nGwYO3Gfr9qv+xvQ/SrQpuHhx7zF
        D/tolCyISPXB8S1Ued3syfeFXL6lYypY2mfYU
X-Received: by 2002:a25:6886:: with SMTP id d128mr12852957ybc.227.1620388822834;
        Fri, 07 May 2021 05:00:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJzFoLmM53HRRPTS8+L1NFo6C4N4lbmA/5cKumgX6lQWkw3hZSH5NVRI0R1lv1CH4GMXBTdIxM8bWjoat1/WU=
X-Received: by 2002:a25:6886:: with SMTP id d128mr12852927ybc.227.1620388822601;
 Fri, 07 May 2021 05:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191012005747.210722465@goodmis.org> <20191012005921.580293464@goodmis.org>
 <CAFqZXNs4eRC6kjFRe6CdwA-sng-w6bcJZf5io+hoLKwM98TVSA@mail.gmail.com>
In-Reply-To: <CAFqZXNs4eRC6kjFRe6CdwA-sng-w6bcJZf5io+hoLKwM98TVSA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 7 May 2021 14:00:09 +0200
Message-ID: <CAFqZXNuxs-h1KKjNfGuZVP4s5MiwRVCWj2E+pDA4PoqxuTrndQ@mail.gmail.com>
Subject: Re: [PATCH 7/7 v2] tracing: Do not create tracefs files if tracefs
 lockdown is in effect
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Herton Krzesinski <hkrzesin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 13, 2021 at 10:13 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Sat, Oct 12, 2019 at 2:59 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >
> > If on boot up, lockdown is activated for tracefs, don't even bother creating
> > the files. This can also prevent instances from being created if lockdown is
> > in effect.
> >
> > Link: http://lkml.kernel.org/r/CAHk-=whC6Ji=fWnjh2+eS4b15TnbsS4VPVtvBOwCy1jjEG_JHQ@mail.gmail.com
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  fs/tracefs/inode.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index eeeae0475da9..0caa151cae4e 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/tracefs.h>
> >  #include <linux/fsnotify.h>
> > +#include <linux/security.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/parser.h>
> >  #include <linux/magic.h>
> > @@ -390,6 +391,9 @@ struct dentry *tracefs_create_file(const char *name, umode_t mode,
> >         struct dentry *dentry;
> >         struct inode *inode;
> >
> > +       if (security_locked_down(LOCKDOWN_TRACEFS))
> > +               return NULL;
> > +
> >         if (!(mode & S_IFMT))
> >                 mode |= S_IFREG;
> >         BUG_ON(!S_ISREG(mode));
> > --
> > 2.23.0
>
> Hi all,
>
> sorry for coming back to an old thread, but it turns out that this
> patch doesn't play well with SELinux's implementation of the
> security_locked_down() hook, which was added a few months later (so
> not your fault :) in commit 59438b46471a ("security,lockdown,selinux:
> implement SELinux lockdown").
>
> What SELinux does is it checks if the current task's creds are allowed
> the lockdown::integrity or lockdown::confidentiality permission in the
> policy whenever security_locked_down() is called. The idea is to be
> able to control at SELinux domain level which tasks can do these
> sensitive operations (when the kernel is not actually locked down by
> the Lockdown LSM).
>
> With this patch + the SELinux lockdown mechanism in use, when a
> userspace task loads a module that creates some tracefs nodes in its
> initcall SELinux will check if the task has the
> lockdown::confidentiality permission and if not, will report denials
> in audit log and prevent the tracefs entries from being created. But
> that is not a very logical behavior, since the task loading the module
> is itself not (explicitly) doing anything that would breach
> confidentiality. It just indirectly causes some tracefs nodes to be
> created, but doesn't actually use them at that point.
>
> Since it seems the other patches also added security_locked_down()
> calls to the tracefs nodes' open functions, I guess reverting this
> patch could be an acceptable way to fix this problem (please correct
> me if there is something that this call catches, which the other ones
> don't). However, even then I can understand that you (or someone else)
> might want to keep this as an optimization, in which case we could
> instead do this:
> 1. Add a new hook security_locked_down_permanently() (the name is open
> for discussion), which would be intended for situations when we want
> to avoid doing some pointless work when the kernel is in a "hard"
> lockdown that can't be taken back (except perhaps in some rescue
> scenario...).
> 2. This hook would be backed by the same implementation as
> security_locked_down() in the Lockdown LSM and left unimplemented by
> SELinux.
> 3. tracefs_create_file() would call this hook instead of security_locked_down().
>
> This way it would work as before relative to the standard lockdown via
> the Lockdown LSM and would be simply ignored by SELinux. I went over
> all the security_locked_down() call in the kernel and I think this
> alternative hook could also fit better in arch/powerpc/xmon/xmon.c,
> where it seems to be called from interrupt context (so task creds are
> irrelevant, anyway...) and mainly causes some values to be redacted.
> (I also found a couple minor issues with how the hook is used in other
> places, for which I plan to send patches later.)
>
> Thoughts?

In the meantime I found some other places where the SELinux check
should be skipped, so I went ahead and sent this patch:
https://lore.kernel.org/lkml/20210507114048.138933-1-omosnace@redhat.com/T/

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

