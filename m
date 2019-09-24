Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52D90BD40E
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 23:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfIXVJL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 17:09:11 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43738 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731588AbfIXVJL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 17:09:11 -0400
Received: by mail-ot1-f66.google.com with SMTP id o44so2810183ota.10
        for <linux-api@vger.kernel.org>; Tue, 24 Sep 2019 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VQkB7bi48akuclIATQVoqE958M+eJ2QEZpzqC72+kvg=;
        b=qdJGCc/WSkznfzlwqEskmqvJju3gOGUfVjauS0N+JVZEaAyPF8n3QPZEqfNP0Ht8Lb
         KZoxRgUVzOL0weQuqoPo8LqdgBh+A4BZd5gPb73MmGmaCa2kLIAci39BIDKvNjdQfizl
         1epob1IAq07xx5/zes1kgFY4ekHvhNAKKIBHDzAqopnuZI658CV8BdR3QXojvSLdPZja
         dvXOm8eHEkMp1aLUuP3cu/g/0lX8ioUPolPYQccvHBPuB0VPm5dlvuyRQMW7Yq1YpfSS
         NSsuVTEvHRKbQcO0Z/OZL7X2IVGS9pItCyqD1fs6ET9zMgjHEvci+hfRw73ajZDFSbmN
         YnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VQkB7bi48akuclIATQVoqE958M+eJ2QEZpzqC72+kvg=;
        b=jelvjIkMRmhQpF3mvBQ587B4NqSk3QriS+jTA2UH4U3sdzUYqlbC289eV3r8W0jEuL
         3z03sfPWulvucwAMo5JKhkiSn8jcoQ/Iya9O51yPjZa7MaIn8aEJQ75NJ4I3hR01Q1Jh
         JWQD3EXnhi8u/cDtkiCFiEF1w1/0dlWtd6QF6M/RO4IdvEzJ/plinghzxa4BOtvWYxd/
         tI1y84FyEOR3HNfJFE5dqBgbZLwNz3dC/ATLyA43hFi/nAOJLBtRUMuoXPj6ma0MGHtP
         E0SYI1MTF5f/RWLFLOeS4hnFAgCnmulMtdVjxm9ooCbh0o8CkNY0a59laugOAnZIo1yL
         KKpg==
X-Gm-Message-State: APjAAAWZ6E0wjZp5qgj1rPaJeK3ylJtFr2KCms3feFI/bzRXZFNSZtSh
        oUu1van5cpYLazzOHBF+B4u22FLH8cGsNoTG60xTiQ==
X-Google-Smtp-Source: APXvYqyaBNsjkpbQ2c9tp8Ci8G41mH0vJifEkwcyIGvvW3+IVOVzCVg+ZK2RuqRwelZ35Ng/sl8rW7aKTvFOZvGKKws=
X-Received: by 2002:a9d:7a98:: with SMTP id l24mr3747315otn.311.1569359349938;
 Tue, 24 Sep 2019 14:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <87pnjr9rth.fsf@mid.deneb.enyo.de> <20190923142325.jowzbnwjw7g7si7j@wittgenstein>
 <90dd38d5-34b3-b72f-8e5a-b51f944f22fb@gmail.com> <20190924195701.7pw2olbviieqsg5q@wittgenstein>
 <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
In-Reply-To: <b76adb4c-826b-6493-ba75-a9863066d3b1@gmail.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 24 Sep 2019 14:08:33 -0700
Message-ID: <CAKOZueuJ=En9=mtFvhpmsnjqMAOjVmffaVwwzpe=ieHemxH3mw@mail.gmail.com>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 24, 2019 at 2:00 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hello Christian,
>
> >>> If you're the parent of the process you can do this without CLONE_PID=
FD:
> >>> pid =3D fork();
> >>> pidfd =3D pidfd_open();
> >>> ret =3D pidfd_send_signal(pidfd, 0, NULL, 0);
> >>> if (ret < 0 && errno =3D=3D ESRCH)
> >>>     /* pidfd refers to another, recycled process */
> >>
> >> Although there is still the race between the fork() and the
> >> pidfd_open(), right?
> >
> > Actually no and my code is even too complex.
> > If you are the parent, and this is really a sequence that obeys the
> > ordering pidfd_open() before waiting:
> >
> > pid =3D fork();
> > if (pid =3D=3D 0)
> >       exit(EXIT_SUCCESS);
> > pidfd =3D pidfd_open(pid, 0);
> > waitid(pid, ...);
> >
> > Then you are guaranteed that pidfd will refer to pid. No recycling can
> > happen since the process has not been waited upon yet (That is,
>
> D'oh! Yes, of course.

You still have a race if you're the parent and you have SIGCHLD set to
SIG_IGN though.

> > excluding special cases such as where you have a mainloop where a
> > callback reacts to a SIGCHLD event and waits on the child behind your
> > back and your next callback in the mainloop calls pidfd_open() while th=
e
> > pid has been recycled etc.).

That's a pretty common case though, especially if you're a library.

> > A race could only appear in sequences where waiting happens before
> > pidfd_open():
> >
> > pid =3D fork();
> > if (pid =3D=3D 0)
> >       exit(EXIT_SUCCESS);
> > waitid(pid, ...);
> > pidfd =3D pidfd_open(pid, 0);
> >
> > which honestly simply doesn't make any sense. So if you're the parent
> > and you combine fork() + pidfd_open() correctly things should be fine
> > without even having to verify via pidfd_send_signal() (I missed that in
> > my first mail.).
>
> Thanks for the additional detail.
>
> I added the following to the pidfd_open() page, to
> prevent people making the same thinko as me:
>
>        The following code sequence can be used to obtain a file  descrip=
=E2=80=90
>        tor for the child of fork(2):
>
>            pid =3D fork();
>            if (pid > 0) {     /* If parent */
>                pidfd =3D pidfd_open(pid, 0);
>                ...
>            }
>
>        Even  if  the  child process has already terminated by the time of
>        the pidfd_open() call, the returned file descriptor is  guaranteed
>        to refer to the child because the parent has not yet waited on the
>        child (and therefore, the child's ID has not been recycled).

I'd prefer that sample code be robust in all cases.
