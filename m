Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AD1A423B
	for <lists+linux-api@lfdr.de>; Fri, 10 Apr 2020 07:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgDJF1a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Apr 2020 01:27:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41773 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgDJF1a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Apr 2020 01:27:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id v1so1087770edq.8;
        Thu, 09 Apr 2020 22:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LlDdAea3x0IKihwN1yTORaLoc6/uOWuph3FnFByeUE4=;
        b=WEslpSa7Lotgi8tuslXPuGnHHrhsmyS1bVjxgj2aThwpa7PP3FcNNxScc3QMG3Skoi
         DxtovvlXh2ey/AaHKbJS+eRdgCfGpCfGp+8ImBxpVetKfMsYeo+7majl0DK81MoQ8zm1
         3zmLDBAegpt2iWyIcHCSb+ZI+7oOL3MZfCNu9xPYMjIW7Yr/v8EjzSvOLp+LNmRvTeqw
         Bvk1gDKP6l6QYPT1ffGvdE2nSBSelfHviFUDPrwlF8HSvzWq2b6eDk9GL8Kvmv3axEJg
         Lk7A5zH3+yILMZTLybwgfR+ZQiLp2jhdyz550fHGFGdHt01m9gE1on2aS27T0/qahr57
         dULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LlDdAea3x0IKihwN1yTORaLoc6/uOWuph3FnFByeUE4=;
        b=j9LhrvogwQqtUQQJG9zZYWFQMRip68xfI08er9ytmO3nb+QEyHqIUHivSdv6Mb+EjQ
         wTctm8vFpNGaizKDFnMrtqRYDj7HdLXeGH/033z9A11eV8XsXMESWG+2TPY+E0Mffoav
         OMa+GgsjQWHtMJI5Bvri65hfbO/r+IaMr7gBPOneXGimC6kvBg6yd9uZxmnoZrbOoata
         oreMBg2MggV/rny8Pzr/uYS+c+KApoPMJU9IUIoQTzKDLQp2knm9vMC8yvBkVj/z3tJn
         bHgRKJL/QsCa60jUzTOuSQlcoTT2+FXoH8pmSiK2lybC9AgizbLhI360ZjqlG6YEB02S
         stHA==
X-Gm-Message-State: AGi0Pub/mJS3Xv0jAVmT6Kt7NcESEk1l6vFW2PrhVZ8OtwCL4lWtJCQR
        V2Fn4+n0K7As2KT8BB1KP1+c2doQa3tUAA/l45E=
X-Google-Smtp-Source: APiQypJwll6Dk2geVhuzjMN7XNGEvGrbpOdg4YOxX/5lNTX4dyNlgi7zyzP8xdYhb1sDDqGiVPmFzUmJublZJrGt6U8=
X-Received: by 2002:a17:906:4d4d:: with SMTP id b13mr2455439ejv.6.1586496447387;
 Thu, 09 Apr 2020 22:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <703440af-031c-16b5-c1ff-54fb4bb5e10c@gmail.com>
 <CANaxB-y0ZB223dQgvxvUHRzkn4f-_B2vTzYxe_mi=o+3SJ4yVw@mail.gmail.com>
 <87a73kny56.fsf@x220.int.ebiederm.org> <CANaxB-y2wWz9tnpoKfvoSOGW=WxeNkSgX+bvsFQO_79JqYMsZw@mail.gmail.com>
In-Reply-To: <CANaxB-y2wWz9tnpoKfvoSOGW=WxeNkSgX+bvsFQO_79JqYMsZw@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 10 Apr 2020 07:27:16 +0200
Message-ID: <CAKgNAkihD5j077QLABp67N9B3p-tsBL_+5PX1eXCPQB9VxoJxw@mail.gmail.com>
Subject: Re: A further though on /proc/PID/timens_offsets
To:     Andrey Vagin <avagin@openvz.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Andrei

On Fri, 10 Apr 2020 at 07:24, Andrey Vagin <avagin@openvz.org> wrote:
>
> On Thu, Apr 9, 2020 at 2:35 PM Eric W. Biederman <ebiederm@xmission.com> =
wrote:
> >
> > Andrey Vagin <avagin@openvz.org> writes:
> >
> > > On Tue, Apr 7, 2020 at 6:24 AM Michael Kerrisk (man-pages)
> > > <mtk.manpages@gmail.com> wrote:
> > >
> > >>        The  clock-id  identifies the clock whose offsets are being s=
hown.
> > >>        This field is either 1, for CLOCK_MONOTONIC, or 7, for CLOCK_=
BOOT=E2=80=90
> > >>        TIME.
> > >>
> > >> What was the reason for exposing numeric clock IDs in the
> > >> timens_offsets file? In API terms, that seems a little ugly.
> > >>
> > >> I think it would have been much nicer if the clocks were defined
> > >> symbolically in this file. I.e., that reading the file would have
> > >> shown something like
> > >>
> > >> monotonic    x    y
> > >> boottime     x    y
> > >>
> > >> And that records similarly with symbolic clock names could have
> > >> been written to the file. Was there a reason not to do this?
> > >
> > > No, there was not except that I haven't thought about this. I agree
> > > that symbolic clock names looks nicer for humans, but numeric clock
> > > IDs are a bit more convenient when we  need to set/read offsets from
> > > code. This interface is in the released kernel, so I think we can't
> > > change the format of the content of this file. But we can add support
> > > of symbolic clock names for setting clock offsets. What do you think?
> >
> > The rule is we can change things as long as userspace doesn't care.  Fo=
r
> > very new interfaces like this it is possible there are few enough
> > userspace programs that nothing cares.
> >
> > Do you know if someone is using this interface yet?
>
> CRIU has the support of time namespace, but these changes are in the
> devel branch and have not been released yet.
>
> I know two more project:
> * The util-linux (unshare and nsenter tools):
> https://github.com/karelzak/util-linux/commit/7f1f0584c24a77909a7c96e62e3=
0f63f4c1b10ad
> https://github.com/karelzak/util-linux/commit/ef0341c9be441b834848d260ba0=
dbeb47a20f7a3
>
> The last release of util-linux was at the end of January, so these
> changes have not been released.
>
> * crun
> https://github.com/containers/crun/commit/a669dc64f70f71423a0ee1bb977f2d7=
7e473649a
>
> These changes have been released in the crun v0.13.
>
> All these projects only set offsets, so I think following the rule
> that you described, we can start showing symbolic clock names and
> accept both variants for setting offsets. If everyone agrees with
> this, I can prepare a patch tomorrow.

That would be great! Thank you!

Cheers,

Michael



--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
