Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D67A4EDF6
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 02:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfD3AjE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 20:39:04 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38346 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbfD3AjE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 20:39:04 -0400
Received: by mail-ot1-f68.google.com with SMTP id t20so10407095otl.5
        for <linux-api@vger.kernel.org>; Mon, 29 Apr 2019 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgTZ/3K30VQ7Yy+pkC8aq78l5d1oLQkhIepKaWoCAis=;
        b=hDbhNhUUvtz91pYUFmj6nfFXK8CKr5RbKdQxwq4t9TgTcelkeWGGBkCFCVn1roCGTY
         5gCaEeHjrUe+44R/9CUFSnxJsPyMbN5Yedvj+K0BJcQoz7xv9AK4lWxoXOjtD7txq1FR
         IszJWlRcxRV66h+r/Q1aUkJur2mIkSYoeRYsk2r9OkuYs0zmliDeHL1b2PKeL/oj+E+k
         SF55kopRV66yIgAmst000r/FAqTIuVGN7MDzN/5QyzEK9PpLIe59lTC21+Nh1T4XDCBL
         7Gm2HOK/pKO+Eq6hW+L1OokwwwjUfFbbrqHdUo/bWpsB2Sj1fjd0KHaYbnHcocOicwY9
         WlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgTZ/3K30VQ7Yy+pkC8aq78l5d1oLQkhIepKaWoCAis=;
        b=sm4AMkVMr0yxsUyoLiKZpZ55XrNdwmKsN1Kll6ZiU9jGjcGdR132x68CgpGbvTp0Ce
         eHOOJ0XpMz2AV8szdQqoK0CWSmhyUymnKnVEm/SgXbULQWJi67OtYl8d6Ih7BYbKdLH/
         yjXa/tyPTBW0u68avIr2Hc127zzmtYDDBMBtCum90C59llvjHyldeiebGmwXn/Yt6v9y
         J+TapKwd8awJxrnkgkZ7T4+k6VXlquoSv7+q+Ux7Znk8vramyacifYcY2q3+3qwRwR58
         f2mKN3zfGTc6hzQ9scj7PtttrYaG7dsrffWuo9+mf1ZEZd9wzOq0EvgV79Sj9F6OPcAV
         hmBQ==
X-Gm-Message-State: APjAAAXq0L10RBRgsjtK9IIC9axl3MraNOJu0Pk6DqGGay9RE0wOzYZJ
        VPoWu9uhL95KXCQ7B+kU4EJ2w/BZXZUIuPCayVqsRw==
X-Google-Smtp-Source: APXvYqwWLXmgw6LO0TQOApqsoDQCT6J8Fxw3fh5GCqCZu3eyL9N9e5DL2d3J/0PsdjmDC+DNw2jfN8I4xhhddyTXqlk=
X-Received: by 2002:a9d:6748:: with SMTP id w8mr6113811otm.198.1556584743486;
 Mon, 29 Apr 2019 17:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com> <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
In-Reply-To: <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 29 Apr 2019 20:38:36 -0400
Message-ID: <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 29, 2019 at 4:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 29, 2019 at 12:55 PM Jann Horn <jannh@google.com> wrote:
> >
> > ... I guess that already has a name, and it's called vfork(). (Well,
> > except that the Linux vfork() isn't a real vfork().)
>
> What?
>
> Linux vfork() is very much a real vfork(). What do you mean?

... uuuh, whoops. Turns out I don't know what I'm talking about.
Nevermind. For some reason I thought vfork() was just
CLONE_VFORK|SIGCHLD, but now I see I got that completely wrong.
