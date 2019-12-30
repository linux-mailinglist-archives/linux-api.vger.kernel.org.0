Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0925412D363
	for <lists+linux-api@lfdr.de>; Mon, 30 Dec 2019 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfL3S3Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Dec 2019 13:29:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37572 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfL3S3Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Dec 2019 13:29:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so5031985oia.4
        for <linux-api@vger.kernel.org>; Mon, 30 Dec 2019 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KiuU6QfyPfgeZowlNQTGQlJqj0W3IrWFK8NOM0+/Dbc=;
        b=dIsjKUO8jwOYmjmzfRVZxYUSytqiMQYo3gJZWVHQtJFhn6N3ZSUv1kat9sE2i+i8mi
         8KIKOpD5jtW5Cq99fKKyoELxhD7gEnG7pAyYoQJRieZuxjhOtyPFB3f6DyLb6fwn8qWk
         0BOUKi1bu/3B0pT4CBLt1wVoq1E5G8I39Edio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KiuU6QfyPfgeZowlNQTGQlJqj0W3IrWFK8NOM0+/Dbc=;
        b=ka7vjdzuvJmCUC+MvZJBfIFh6yexyKEQLtKd1CZg82QUFdyGEfEBIoGBc3zsImV6+9
         VLMbeXzkwFw701HqsreDSZImbo6wkU645eEFaVEhJWFidnC4p9qHqKfa0VbnryjLBGh1
         ilgCu5HowuGQEJEsB3VakdSXVUZfSZxjSrEgsAU+3U7UaNblLbNFNhslN6SGLsHaqoT9
         ckDghK1xwhgqcK/vUrCZJDZnD+6jmRf6IOS0oGgf7+owcyqSv/CLUg3xz5CF4YlTFfFC
         tj9N0RzAWhtpGgQUa9m6RrHqf8RyuzCm5SLjjgVfEJx6jm9NBSz4MFg1mxIe0GvFyKd0
         2UMw==
X-Gm-Message-State: APjAAAUDQO+vcTJb0pKyx2H+3ROe4vdM3fONIQvaXsY7RwA1tS0U9AtC
        lcakoejNDfWaF5IDM8Zg8Nl8/hu82qM=
X-Google-Smtp-Source: APXvYqz+h2+kkSRzzgvvCkbDGl3d8KnJ2jY/361guwVk3w9/RgiruB2G7mNEi3JrCu+UdHAk+m5cxw==
X-Received: by 2002:aca:ba46:: with SMTP id k67mr209161oif.38.1577730555748;
        Mon, 30 Dec 2019 10:29:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s24sm7749395oic.31.2019.12.30.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:29:14 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:29:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <201912301023.CEBE3A5@keescook>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229062451.9467-3-sargun@sargun.me>
 <20191229171441.fxif7q32mv2hl3y4@wittgenstein>
 <CAMp4zn_4dN+5U2RxkpYp+m4=X9w2Wef1TuLZ2hRW+g+nK1cXGA@mail.gmail.com>
 <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
 <CAMp4zn_39bsyZo6BeZ6b+c_EeAHdWmqcJus6qD2xYp84cEcZaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn_39bsyZo6BeZ6b+c_EeAHdWmqcJus6qD2xYp84cEcZaA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Dec 29, 2019 at 03:42:17PM -0800, Sargun Dhillon wrote:
> On Sun, Dec 29, 2019 at 11:43 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sun, Dec 29, 2019 at 11:06:25AM -0800, Sargun Dhillon wrote:
> > > On Sun, Dec 29, 2019 at 12:14 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > > Does that even work if no dup() syscall has been made and trapped?
> > > Yes, the first check that occurs is the check which checks if
> > > seccom_notif has been
> > > zeroed out. This happens before any of the other work.
> >
> > Ah, then sure I don't mind doing it this way. Though plumbing it
> > directly into TEST(user_notification_basic) like I did below seems
> > cleaner to me.
> >
> > >
> > > > This looks like it would give you ENOENT...
> > > This ioctl is a blocking ioctl. It'll block until there is a wakeup.
> > > In this case, the wakeup
> > > will never come, but that doesn't mean we get an ENOENT.
> >
> > Yeah, but that wold mean the test will hang weirdly if it bypasses the
> > check. Sure it'll timeout but meh. I think I would prefer to have this
> > done as part of the basic test where we know that there is an event but
> > _shrug_.

I'd like to design the tests to not _depend_ on the timeout to catch bad
behaviors. The timeout is there for us to not break a test runner when
we forget weird corner cases.

> My one worry about this is that the behaviour should be if the input
> (seccomp_notif) is invalid, it should immediately bail out, whether
> or not there is an event waiting. If we add it to basic_test, then
> it would hide the erroneous behaviour if bailout isn't immediate.

I'm not following this paragraph. The ioctl's zero check is immediate,
so this test should fail the EXPECT (but continue to the next "correct"
ioctl) -- it's not an ASSERT (which would stop the test). I think
Christian's test might be a cleaner approach, unless I'm still missing
something here?

-- 
Kees Cook
