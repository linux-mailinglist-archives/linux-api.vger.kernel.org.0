Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F6FDC2
	for <lists+linux-api@lfdr.de>; Tue, 30 Apr 2019 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3QY0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Apr 2019 12:24:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39002 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfD3QY0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Apr 2019 12:24:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id q10so13368927ljc.6
        for <linux-api@vger.kernel.org>; Tue, 30 Apr 2019 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zirBQvpMX9FN+xMGuy+YB2uuBWDRMNHlzh9gJjRPgVE=;
        b=hs+MMq9iB+eslb+cGLIpGLGbIv6EJP2l9mo6ehrV020sNd1PwGxPBGOEt2lJlTs3aX
         j5lQOg6lmmOjeQDX5ZISw6NeAcc9gXvyDHGfdKNNARf9UJs1P4nx3ChCR2owg+Zh2w30
         nFun/lkPvWMpDLpdDrhOj9zXwOjyW/YZ8hGXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zirBQvpMX9FN+xMGuy+YB2uuBWDRMNHlzh9gJjRPgVE=;
        b=DUNrtPJ/SCPF7fqA0UH6lvMw7yOalw+84ZyfuLVjVWS80KxBpsz1rfujhWC5Ellv8W
         0AmIAMysyRVKLDAIaDInHI8VcMBM2H5HYRpu9S0wZZKUcPz92iiTXg17JEPNcYNd0HPy
         byn2YXpzxTNwdYTyEukQE2Yj9bpenwAwQk1caAQgBaJp1Jw07KZx0lXbNM0ontuMCKKb
         onvk0nkgzIMBFZ6C81Jw++qP63wyF4y/blhOLQVtdc0bmzr6pQPLX0bEyh8VHP/hn/OU
         pLzwcPrRuZOzBIvSGG/QG00XgR4G4pm2f1l/Fa312o5S2D807JnNQmw2tnN8ClRHVgRz
         CRLQ==
X-Gm-Message-State: APjAAAWdKZT3AObiI7QHzYpId5SzTy1002ZDRXQVHVPt8V7p8S0qABwG
        7De5DYK0lvmozRJggSSp9eNwie9wsJE=
X-Google-Smtp-Source: APXvYqwdyQuQIlNltI78xXTizuKgyd/gEA+VR+B0KlecaCjwl/kt7aW/Ptwj/veb3LWx3subOHVuAg==
X-Received: by 2002:a2e:97d8:: with SMTP id m24mr614907ljj.192.1556641464055;
        Tue, 30 Apr 2019 09:24:24 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id h29sm3547468ljb.49.2019.04.30.09.24.22
        for <linux-api@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 09:24:23 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id k18so11197350lfj.13
        for <linux-api@vger.kernel.org>; Tue, 30 Apr 2019 09:24:22 -0700 (PDT)
X-Received: by 2002:ac2:4567:: with SMTP id k7mr36971631lfm.166.1556641462358;
 Tue, 30 Apr 2019 09:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <20190430123901.GD23020@redhat.com>
In-Reply-To: <20190430123901.GD23020@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 30 Apr 2019 09:24:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit1f_eARfgHYBQwjU2ndd_75OuHQurXNmrEHuhjQViJA@mail.gmail.com>
Message-ID: <CAHk-=wit1f_eARfgHYBQwjU2ndd_75OuHQurXNmrEHuhjQViJA@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 30, 2019 at 5:39 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Yes, but I am wondering if man vfork should clarify what "child terminates"
> actually means. I mean, the child can do clone(CLONE_THREAD) + sys_exit(),
> this will wake the parent thread up before the child process exits or execs.

That falls solidly into the "give people rope" category.

If the vfork() child wants to mess with the parent, it has many easier
ways to do it than create more threads.

As mentioned, the real problem with vfork() tends to be that the child
unintentionally messes with the parent because it just gets the stack
sharing wrong. No need to add intention there.

> I see nothing wrong, but I was always curious whether it was designed this
> way on purpose or not.

Oh, it's definitely on purpose. Trying to do some nested usage count
would be horrendously complex, and even a trivial "don't allow any
other clone() calls if we already have a vfork completion pending" is
just unnecessary logic.

Because at least in *theory*, there's actually nothing horribly wrong
with allowing a thread to be created during the vfork(). I don't see
the _point_, but it's not conceptually something that couldn't work
(you'd need a separate thread stack etc, but that's normal clone()).

So no, there's no safety or bogus "you can't do that". If you want to
play games after vfork(), go wild.

                   Linus
