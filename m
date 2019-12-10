Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C283A118D41
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2019 17:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLJQIX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Dec 2019 11:08:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39854 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfLJQIX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Dec 2019 11:08:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id v16so16446051edy.6
        for <linux-api@vger.kernel.org>; Tue, 10 Dec 2019 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6trYcoHmNF55DJKEZoSP3sORTafU70ubqpo6VTXimk=;
        b=PKmIyaMCl+YDFo8WSYlp7M/Aezgp7PzTLo/BE17x5sa+uME6zCTHydOQcDvM01zJju
         umUcaAg/M1OJOdJXaZFjOeCLJHXUdgATLyg7kQZzhq3cF75xvcjvWAm3EP+kWA9JqjwN
         7NEG7VSHVsswDicQCKImpdcmCrTRrY0D7KLck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6trYcoHmNF55DJKEZoSP3sORTafU70ubqpo6VTXimk=;
        b=qYpu+VHe4po89htJ8+6pErAyt8a0AF0X213q+WU0ES0GfK9KLM/hxelHuhX/lnhtm2
         uXoyTAeRVAJ7XpXldnSJzMMvfrYC3qbkSbb/qIha4FR4WLPN4qMR1u9PTOaAoE02PSUo
         QnQ9KPWpEPJCfOowLLciyybYmKe9XwilQhLmupBofmf+a4IneSRoOMm88/FUtT2PusOV
         8auBFv8TlnrYHTuxBeVIun56k7S+5xfGw7fZuKDopLNr/q4OKH5FW8ADCb2W4Q5PQqpd
         tsdKQC+mpPQEIaI9hgsSCUK6WPUIgZJ8flHdoi7wRdbdoXhfFwCpuctWb4+tWDtOX+Mo
         2gKw==
X-Gm-Message-State: APjAAAVG2iD1ZzHBZpOeE1azMmutsdi3RmQPYdi0vW6AsxlNz1DUVf9H
        0tKARif2dNuCHygsi3o6F0eA4y/whEfJgfWSQotNFA==
X-Google-Smtp-Source: APXvYqx1dm9j72BHWkL1jb/WiemMUApbYMr8bO3NM6TlIP4e89CZxusAbFKpeSGq4S9qDVsX4L3PdShvUj2RaUWBdQw=
X-Received: by 2002:a17:906:6d52:: with SMTP id a18mr4567499ejt.52.1575994101055;
 Tue, 10 Dec 2019 08:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal>
 <20191209192959.GB10721@redhat.com> <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
 <20191209204635.GC10721@redhat.com> <20191210111051.j5opodgjalqigx6q@wittgenstein>
In-Reply-To: <20191210111051.j5opodgjalqigx6q@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Tue, 10 Dec 2019 08:07:45 -0800
Message-ID: <CAMp4zn84YQHz62x-nxZFBgMEW9AiMt75q_rO83uaGg=YtyKV-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in
 conjunction with user trap
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Jann Horn <jannh@google.com>, cyphar@cyphar.com,
        Andy Lutomirski <luto@amacapital.net>, viro@zeniv.linux.org.uk,
        Jed Davis <jld@mozilla.com>,
        Gian-Carlo Pascutto <gpascutto@mozilla.com>,
        =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <ealvarez@mozilla.com>,
        Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 10, 2019 at 3:10 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> [I'm expanding the Cc to a few Firefox and glibc people since we've been
>  been talking about replacing SECCOMP_RET_TRAP with
>  SECCOMP_RET_USER_NOTIF for a bit now because the useage of
>  SECCOMP_RET_TRAP in the broker blocks desirable core glibc changes.
>  Even if just for their lurking pleasure. :)]
>
> On Mon, Dec 09, 2019 at 09:46:35PM +0100, Oleg Nesterov wrote:
> > On 12/09, Christian Brauner wrote
> >
> > I agree, and I won't really argue...
> >
> > but the changelog in 2/4 says
> >
> >       The requirement that the tracer has attached to the tracee prior to the
> >       capture of the file descriptor may be lifted at a later point.
> >
> > so may be we should do this right now?
>
> I think so, yes. This doesn't strike me as premature optimization but
> rather as a core design questions.
>
> >
> > plus this part
> >
> >       @@ -1265,7 +1295,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
> >               }
> >
> >               ret = ptrace_check_attach(child, request == PTRACE_KILL ||
> >       -                                 request == PTRACE_INTERRUPT);
> >       +                                 request == PTRACE_INTERRUPT ||
> >       +                                 request == PTRACE_GETFD);
> >
> > actually means "we do not need ptrace, but we do not know where else we
> > can add this fd_install(get_task_file()).
>
> Right, I totally get your point and I'm not a fan of this being in
> ptrace() either.
>
> The way I see is is that the main use-case for this feature is the
> seccomp notifier and I can see this being useful. So the right place to
> plumb this into might just be seccomp and specifically on to of the
> notifier.
> If we don't care about getting and setting fds at random points of
> execution it might make sense to add new options to the notify ioctl():
>
> #define SECCOMP_IOCTL_NOTIF_GET_FD      SECCOMP_IOWR(3, <sensible struct>)
> #define SECCOMP_IOCTL_NOTIF_SET_FD      SECCOMP_IOWR(4, <sensible struct>)
>
> which would let you get and set fds while the supervisee is blocked.
>
> Christian
Doesn't SECCOMP_IOCTL_NOTIF_GET_FD have some ambiguity to it?
Specifically, because
multiple processes can have the same notifier attached to them? If we
choose to go down the
route of introducing an ioctl (which I'm not at all opposed to), I
would rather do it on pidfd. We
can then plumb seccomp notifier to send pidfd instead of raw pid. In
the mean time, folks
can just open up /proc/${PID}, and do the check cookie dance.

Christian,
As the maintainer of pidfd, what do you think?
