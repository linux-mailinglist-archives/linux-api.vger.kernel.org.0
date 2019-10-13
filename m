Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F51CD53A0
	for <lists+linux-api@lfdr.de>; Sun, 13 Oct 2019 02:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfJMAwX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 20:52:23 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33478 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfJMAwX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 20:52:23 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so8669983vso.0
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 17:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R5eLvgxkhMTM6Z6M0/xeh9aqoTuK/FOVyWP+PWhzyFI=;
        b=wDv2/sDFtFCZ0qf0FQS91LgHZaW5C55FXSSnWqAwxjlWgr6JXvB+4YXyUiSltNbnhR
         giqrnMTNCoMx2aRM4d8+b1PCrpxndi4YIWJXZK0vkRhwDENBh8UpW8YlwqxQl+CYL0zv
         iBUCo4nmyxueL0kV7TlsjbaeM1aR3n+BHSII2tQY51/E3GpRcahfdv+Jo5RK/LIDEy8o
         Dhs/OgFqw0Kqb7YV1GXLTMk68ELRhjzcbFKF8H4r6Kkint0V5waqc6iZeb7hj//7W9KW
         LJ/X08b0tJkUvH4vnvRO8D2v1bpbw01axctz3nB59BqN3uOUVjz13kSY7uh+bvg5T+/C
         NyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R5eLvgxkhMTM6Z6M0/xeh9aqoTuK/FOVyWP+PWhzyFI=;
        b=iktTQWI6XwjWNv8BNd2bTlWCGjDciBz9NOeS7+BGhNxusRd0ocThCOo7J58GjCTxpi
         8modNc1pl+6LekUlIY/0jaNLKexTgopiFPgjxu6BNHJrQbGTT48ntsPcrnLQ/nJN4WVT
         kvgGYEgeeXeHUvOhLFQglWUMdRZNR3XNSXcQ6N1DldW2tF6WfjEh71k05x4oHyxmZrs8
         FBuouzgcK+Xjit6ur/SjqOH6bWhnQUM9Hm4wG/OUsgFtbr6vpf9SwkqpeAooa/+vO0pN
         F+2sNoWc6/AFDI+5JVUGTFzocAgr4TFH01nBDWKSo7CZakZeTr1Wnb5k24+mC2VhtRBe
         9ePg==
X-Gm-Message-State: APjAAAV9kBjMS9w0Rtj36rKEMtGNCACovK5HsqTXud9mSLNBtgxEA7h0
        l52mdh0FhysKZS5sJvY38iDjSIQhVw+vpjeiS4wbHA==
X-Google-Smtp-Source: APXvYqxs6kVDjjt6a1xBpon88gD7+xICWPwBsx/iTC0IOVKh2le624ksZuee1yKmCzFhjbwBKnPowL6/stK8Wrza1pU=
X-Received: by 2002:a05:6102:125c:: with SMTP id p28mr7682472vsg.114.1570927941763;
 Sat, 12 Oct 2019 17:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
In-Reply-To: <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 12 Oct 2019 17:51:45 -0700
Message-ID: <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 4:10 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
> >
> > The new secure flag makes userfaultfd use a new "secure" anonymous
> > file object instead of the default one, letting security modules
> > supervise userfaultfd use.
> >
> > Requiring that users pass a new flag lets us avoid changing the
> > semantics for existing callers.
>
> Is there any good reason not to make this be the default?
>
>
> The only downside I can see is that it would increase the memory usage
> of userfaultfd(), but that doesn't seem like such a big deal.  A
> lighter-weight alternative would be to have a single inode shared by
> all userfaultfd instances, which would require a somewhat different
> internal anon_inode API.

I'd also prefer to just make SELinux use mandatory, but there's a
nasty interaction with UFFD_EVENT_FORK. Adding a new UFFD_SECURE mode
which blocks UFFD_EVENT_FORK sidesteps this problem. Maybe you know a
better way to deal with it.

Right now, when a process with a UFFD-managed VMA using
UFFD_EVENT_FORK forks, we make a new userfaultfd_ctx out of thin air
and enqueue it on the message queue for the parent process. When we
dequeue that context, we get to resolve_userfault_fork, which makes up
a new UFFD file object out of thin air in the context of the reading
process. Following normal SELinux rules, the SID attached to that new
file object would be the task SID of the process *reading* the fork
event, not the SID of the new fork child. That seems wrong, because
the label we give to the UFFD should correspond to the label of the
process that UFFD controls.

To try to solve this problem, we can move the file object creation to
the fork child and enqueue the file object itself instead of just the
userfaultfd_ctx, treating the dequeue as a file-descriptor-receive
operation just like a recvmsg of an AF_UNIX socket with SCM_RIGHTS.
(This approach seems more elegant anyway, since it reflects what's
actually going on.) The trouble the early-file-object-creation
approach is that the fork child may not be allowed to create UFFD file
objects on its own and an LSM can't tell the difference between
UFFD_EVENT_FORK handling creating the file object and the fork child
just calling userfaultfd(), meaning an LSM could veto the creation of
the file object for the fork event. We can't just create a
non-ANON_INODE_SECURE file object instead: that would defeat the whole
purpose of supervising UFFD using SELinux.

But maybe we can go further: let's separate authentication and
authorization, as we do in other LSM hooks. Let's split my
inode_init_security_anon into two hooks, inode_init_security_anon and
inode_create_anon. We'd define the former to just initialize the file
object's security information --- in the SELinux case, figuring out
its class and SID --- and define the latter to answer the yes/no
question of whether a particular anonymous inode creation should be
allowed. Normally, anon_inode_getfile2() would just call both hooks.
We'd add another anon_inode_getfd flag, ANON_INODE_SKIP_AUTHORIZATION
or something, that would tell anon_inode_getfile2() to skip calling
the authorization hook, effectively making the creation always
succeed. We can then make the UFFD code pass
ANON_INODE_SKIP_AUTHORIZATION when it's creating a file object in the
fork child while creating UFFD_EVENT_FORK messages.

Granted, UFFD fork processing doesn't actually occur in the fork
child, but in copy_mm, in the parent --- but the right thing should
happen anyway, right?

I'm open to suggestions. In the meantime, I figured we'd just define a
UFFD_SECURE and make it incompatible with UFFD_EVENT_FORK.

> In any event, I don't think that "make me visible to SELinux" should
> be a choice that user code makes.

Right. The new unprivileged_userfaultfd setting is ugly, but it at
least removes the ability of unprivileged users to opt out of SELinux
supervision.
