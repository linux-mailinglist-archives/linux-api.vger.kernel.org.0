Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D142F762DF
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfGZJ5q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Jul 2019 05:57:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34308 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJ5q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Jul 2019 05:57:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so52062515qtq.1;
        Fri, 26 Jul 2019 02:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iufb0TTF1GAeZGPOnqhrgxVKxrEycW/hHzn4npZ/Lk=;
        b=G722eRD8jWAb3CJJzKki0E0uH1a8sQkU4UrBTT9nwheBdXXZ/Zip0wP4BcLHBs0tqw
         F/j57OTGVO9vYXlShXw2Q2OSIoXkpTnL3b3gkZBoiCtFuJ8B0uEPjStXR10ewQgCD+T2
         fpe9SA36WLUDEbXfHfQDtmwDtOVaEVaz0mWH8Frh1zS51/PBkfTam/jCDBWOZvgVILlO
         Qz4Fwwjy9RdkVMyXSiZQk4A7bw/IDyBOQKEN3BC+VOZHT2V6uIsTG/GEiHS9p+quzQJP
         DFowklglHyEf/alNDoyEG2k+iAdyfO78TR9t+X0Vpu2ehcFXztyg21Vh7tfo/JDob1wf
         2iUA==
X-Gm-Message-State: APjAAAU8UFKSKF0VNmY/fKNuW++Y12Yc9nfGy9VAYVga0BBrb94EkYuf
        iQIR06EOCQ00twok+U3g6vQYWSYe9NYxzxXD6W88uYlB
X-Google-Smtp-Source: APXvYqx8077dqguPqEFI6+OlyN3ofw5NkRSHCv3ii7U127hZoYr0bYgeSV/phYbejddupJV+eJ/33u2deWUNPfAQvk8=
X-Received: by 2002:aed:33a4:: with SMTP id v33mr63995596qtd.18.1564135065054;
 Fri, 26 Jul 2019 02:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io>
 <CAK8P3a0+3wqCzQv-A-QmWTtioFRGjYUvq6QiLysqi9OFs3kJsw@mail.gmail.com> <20190726082413.n7srvcrqxmvk67z7@brauner.io>
In-Reply-To: <20190726082413.n7srvcrqxmvk67z7@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jul 2019 11:57:28 +0200
Message-ID: <CAK8P3a3VK77OvRPY-nozEGbcfHks6YdcyE7cY_2UEN9nfy=hRg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 26, 2019 at 10:24 AM Christian Brauner <christian@brauner.io> wrote:
>
> > It would be nice to introduce it in a separate patch, and then use it
> > to kill off
> > compat_sys_getrusage() and compat_sys_wait4(), and possibly even
> > compat_sys_waitid() in combination with your copy_siginfo_to_user_any().
> > That could be done as a cleanup patch afterwards, or as part of your series.
>
> Right, but we won't go the syscall route but instead go the P_PIDFD
> route for waitid(). :)

Ah, of course, nevermind then. It would still be a useful cleanup, but
many other things would be as well.

      Arnd
