Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB61412BFC2
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 01:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfL2ALI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Dec 2019 19:11:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43518 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfL2ALI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Dec 2019 19:11:08 -0500
Received: by mail-ed1-f66.google.com with SMTP id dc19so28885691edb.10
        for <linux-api@vger.kernel.org>; Sat, 28 Dec 2019 16:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vvh824TZBnegJvSkK9xRvfwQduMxT+onfQ7CGqFsH/0=;
        b=Flo9H/byGBYPx88NBrUk0p/S0kSMWqsqM20WhXB+e8Gs4ezuPPD6d5/sRxYjir/GdL
         qQtvdeJVpjFwAZA46/fvMNCnVIH+1g3wJjEybGdrC4kN3wkR0LA6w0TP6Lj8G4iJsVbm
         5BEKgNETR7pEOOQNEQ/1FZoIwXB15hLxbGZeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vvh824TZBnegJvSkK9xRvfwQduMxT+onfQ7CGqFsH/0=;
        b=Oy9Bm9dUHlt1AqvSOmW7E8Tyxt9WXZUnxA06+ppDfOhLk49NoBeIUD63kZ28Lkb7jw
         XhglhFoZSrnj/6e5CythogsyGT1PZho7/E41kUCkzy3+DeM/B8uK+T1h/kE/YKQqJhDn
         mHBoj4D6P33RqNk+dAPPMPVoqC/WSF5CoVKydfu2hK7ixBo4XQaR+YH92n4FkF+bY7Nv
         keq+S1naQbZc6CuGfmJrZc+bVXQ5YZFP8w1HBQAG22g2bvqx+5xDhRgo2XaLOWd5E9RW
         eXxtZwwq0Upyc1cc5FmkEeRbI+i8tMXWueKyLDDkOIikKLlXbgK4ev5ytrARTs109ZLd
         4sWA==
X-Gm-Message-State: APjAAAVJQWX8crjc6lS2HwNLsPLkFxu0rV50fPtlpJxLk6U31cyWRq00
        tGM/YBXXq5fvaPLvwme9i3AQY4f3Ky9lvdCiE51zhA==
X-Google-Smtp-Source: APXvYqzOB5yH7dZk4bwrTsn7INBIkA6k8Lm79RJV2L22B4Ra+1C3I+kKbxUBH9HEmK/i+WEbfdRW24yd7NwQjfB2oCw=
X-Received: by 2002:aa7:d714:: with SMTP id t20mr63876652edq.93.1577578265781;
 Sat, 28 Dec 2019 16:11:05 -0800 (PST)
MIME-Version: 1.0
References: <20191228014837.GA31774@ircssh-2.c.rugged-nimbus-611.internal> <20191228181825.GB6746@cisco>
In-Reply-To: <20191228181825.GB6746@cisco>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sat, 28 Dec 2019 19:10:29 -0500
Message-ID: <CAMp4zn91GoB=1eTbc_ux4eNs2-QFm+JocodgFQYUiiXL7H4m9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] samples, selftests/seccomp: Zero out seccomp_notif
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Dec 28, 2019 at 1:18 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Sat, Dec 28, 2019 at 01:48:39AM +0000, Sargun Dhillon wrote:
> > The seccomp_notif structure should be zeroed out prior to calling the
> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
> > whether these structures were zeroed out or not, so these worked.
> >
> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > Cc: Kees Cook <keescook@chromium.org>
> > ---
> >  samples/seccomp/user-trap.c                   | 2 +-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
> > index 6d0125ca8af7..0ca8fb37cd79 100644
> > --- a/samples/seccomp/user-trap.c
> > +++ b/samples/seccomp/user-trap.c
> > @@ -298,7 +298,6 @@ int main(void)
> >               req = malloc(sizes.seccomp_notif);
> >               if (!req)
> >                       goto out_close;
> > -             memset(req, 0, sizeof(*req));
> >
> >               resp = malloc(sizes.seccomp_notif_resp);
> >               if (!resp)
> > @@ -306,6 +305,7 @@ int main(void)
> >               memset(resp, 0, sizeof(*resp));
>
> I know it's unrelated, but it's probably worth sending a patch to fix
> this to be sizes.seccomp_notif_resp instead of sizeof(*resp), since if
> the kernel is older this will over-zero things. I can do that, or you
> can add the patch to this series, just let me know which.

I was thinking about this, and initially, I chose to make the smaller
change. I think it might make more sense to combine the patch,
given that the memset behaviour is "incorrect" if we do it based on
sizeof(*req), or sizeof(*resp).

I'll go ahead and respin this patch with the change to call memset
based on sizes.

>
> But in any case, this patch is:
>
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>
>
> Cheers,
>
> Tycho
