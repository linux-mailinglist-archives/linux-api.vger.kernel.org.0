Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057D11EAFE3
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2020 22:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgFAT7h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jun 2020 15:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgFAT7h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jun 2020 15:59:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BA8C03E96F
        for <linux-api@vger.kernel.org>; Mon,  1 Jun 2020 12:59:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so3983666pgn.4
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2020 12:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ODX5Ijz16QtBmZcvs8Sw5gVm8csvu2kr6ZBZyPx21Y=;
        b=Z+kO0TqjatiyHbw5hfuBT9IkC+93DFVLHHgYsiaDDt0rwy0nUqdauKdDsONuLtQaza
         ihVUdqQ2tiGXgPHAkV349CZsv0tYJ2Fvb4rCSNhJ+vmPFkNR/ZlmQ0zFOv0i3pBCNwqH
         klWKXblqHUNUy1gqq8CydGMqxhbAPA5B/INsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ODX5Ijz16QtBmZcvs8Sw5gVm8csvu2kr6ZBZyPx21Y=;
        b=T0LTQN702mIrK8mVnNPQn0sOWiFaaI6NHEBnHj0wJPQ3EHDBex3fPhuR1qqUd+nWLN
         aGpIWfg27cyJsfHdSolMy3VBLFtqri65RMlVVpIpctax0/1aRnCTtnonoN4gBwLargW6
         161AjXct98poP/97sZLCtmhpJENJyPOK2EeOzeoCyhB5Pw46/T/U2eNRUMmlgA9CLPvA
         HuU8ekygPmmVndMZdOPmr5LvYYCY/BEmP53HQzxBJ+ubdSs3Z/QnoFLGIH14vfb5ggiw
         J4DUrQzTzN9jpt32eJhuCqZWqkDmsT4zqtS0nFzqvoLdCX3TOpdha2gaA678FxJ30nOP
         8+bA==
X-Gm-Message-State: AOAM530Ud5b/Hfh+E0eq6xZb7jKX4wtew5gpwjKRgGjo0qo0VVctAB9P
        Z7eVWxkfuqmwe+9KaEeQCjr8Bw==
X-Google-Smtp-Source: ABdhPJxrEQLuZ1/KCzkfx7bv9ugLFw4ywO5Q4IymFJcw28Jw/7xnEycKw9GiJDjeg0ch7bMSxzi+Pw==
X-Received: by 2002:a65:6810:: with SMTP id l16mr19827256pgt.390.1591041576555;
        Mon, 01 Jun 2020 12:59:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm256763pjw.15.2020.06.01.12.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:59:35 -0700 (PDT)
Date:   Mon, 1 Jun 2020 12:59:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202006011259.07FAF4AA@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <20200530140837.GM23230@ZenIV.linux.org.uk>
 <202005300834.6419E818A7@keescook>
 <CAMp4zn88ZKwKJyp+ekZnbVsjbTceHCM7d5yTqsR63BNP1QMv7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn88ZKwKJyp+ekZnbVsjbTceHCM7d5yTqsR63BNP1QMv7Q@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 01, 2020 at 12:02:10PM -0700, Sargun Dhillon wrote:
> On Sat, May 30, 2020 at 9:07 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, May 30, 2020 at 03:08:37PM +0100, Al Viro wrote:
> > > On Fri, May 29, 2020 at 07:43:10PM -0700, Kees Cook wrote:
> > >
> > > > Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> > > > move the put_user() after instead? I think cleanup would just be:
> > > > replace_fd(fd, NULL, 0)
> > >
> > > Bollocks.
> > >
> > > Repeat after me: descriptor tables can be shared.  There is no
> > > "cleanup" after you've put something there.
> >
> > Right -- this is what I was trying to ask about, and why I didn't like
> > the idea of just leaving the fd in the table on failure. But yeah, there
> > is a race if the process is about to fork or something.
> >
> > So the choice here is how to handle the put_user() failure:
> >
> > - add the put_user() address to the new helper, as I suggest in [1].
> >   (exactly duplicates current behavior)
> > - just leave the fd in place (not current behavior: dumps a fd into
> >   the process without "agreed" notification).
> > - do a double put_user (once before and once after), also in [1].
> >   (sort of a best-effort combo of the above two. and SCM_RIGHTS is
> >   hardly fast-pth).
> >
> > -Kees
> >
> > [1] https://lore.kernel.org/linux-api/202005282345.573B917@keescook/
> >
> > --
> > Kees Cook
> 
> I'm going to suggest we stick to the approach of doing[1]:
> 1. Allocate FD
> 2. put_user
> 3. "Receive" and install file into FD
> 
> That is the only way to preserve the current behaviour in which userspace
> is notified about *every* FD that is received via SCM_RIGHTS. The
> scm_detach_fds code as it reads today does effectively what is above,
> in that the fd is not installed until *after* the put user. Therefore
> if put_user
> gets an EFAULT or ENOMEM, it falls through to the MSG_CTRUNC bit.
> 
> The approach suggested[2] has a "change" in behaviour, in that (all in
> file_receive):
> 1. Allocate FD
> 2. Receive file
> 3. put_user
> 
> Based on what Al Viro said, I don't think we can simply add step #4,
> being "just" uninstall the FD.
> 
> [1]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2179418.html
> [2]: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2179453.html

Agreed. Thanks!

-- 
Kees Cook
