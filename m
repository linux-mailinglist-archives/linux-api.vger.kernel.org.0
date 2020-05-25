Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759301E042A
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 02:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbgEYA2g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 20:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388642AbgEYA2g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 20:28:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9860AC05BD43
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 17:28:35 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id s21so18897199ejd.2
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwykEdM3SyRomohU3e5rjyCqJmUudG4184nZb0VuwGU=;
        b=aJ49HXpD8xoJymFOGHw1Nc6cTn41t6yYceBnCnsfkEqmu3aJ27VyozXfpO/GoSZC/R
         UJ3yEwYnBWMl9OKyjjI9EdX90Lxbf6cWAp4os/Ue1Q8oVNySS2a/98rceH1q0GTQbg9B
         nP4GgcY/CUptu5HoHw/M/CetsHczAvdav/BPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwykEdM3SyRomohU3e5rjyCqJmUudG4184nZb0VuwGU=;
        b=TdxEcLBeJnHq+Vb4jN21S7951kuWcPBySk+6HlF7nuARHyfudOd9psiWiqePWgDMeN
         4Ls0ajI5r8VqQZHcXZr/j6GZSCZb4Eb5QUWqsjBt9ZaJRqA9UWOhaZJEOUlF33de4Fs0
         9PcdjimHftAst0rz6/ETpYr26iJu4JG2ZD1mUETLHQ61Qa2aIfxZGvIY3UaO3ujnOwWJ
         olqrEYma/mDqIIfE/r6D+r9JXMAi2J+cNzXhv25lZABCCb8altXA6zulsuYnIDuS+JJF
         NHcoyvExj6wpc9Jr/wkNfEjRTYZKFWiGLBvLmAX9/1nJs9TMXNNHdvm29UGbfdAJa1an
         51vQ==
X-Gm-Message-State: AOAM532qi3M3PWBakcedE07T0S6FTHSsoH5HREwQPtwuEAH2pQxHJ5o2
        ANrKj2mq7+Ipu7Sxx1vpr1D3Bb3Ng5TMcketCrDG4A==
X-Google-Smtp-Source: ABdhPJycfYQqMDOhoxG3T5+gzE+Rmy00QjGgDHzGZQDgo60Ypn25+O9Pk4JaxLFwqVLwUISA9KAsAIHoohWFwCKAGh8=
X-Received: by 2002:a17:906:2cc2:: with SMTP id r2mr16329022ejr.269.1590366514113;
 Sun, 24 May 2020 17:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200524233942.8702-1-sargun@sargun.me> <20200524233942.8702-3-sargun@sargun.me>
 <20200525000537.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200525000537.GB23230@ZenIV.linux.org.uk>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 24 May 2020 17:27:58 -0700
Message-ID: <CAMp4zn-F3b8Z4ZDjgnJM1Fbban2oVtCm_rZkhBhDKs6fw2_=rg@mail.gmail.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Jann Horn <jannh@google.com>, Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, May 24, 2020 at 5:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
>
> Bad refcounting rules.  *IF* we go with anything of that sort (and I'm not
> convinced that the entire series makes sense), it's better to have more
> uniform rules re reference consumption/disposal.
>
> Make the destructor of addfd *ALWAYS* drop its reference.  And have this
> function go
Are you suggesting the in both the error, and non-error cases the ioctl
invoker side is responsible for fput'ing the final reference in both the
success and non-success cases? Would we take an extra reference
prior to fd_install?
>
>         if (addfd->fd >= 0) {
>                 ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
>         } else {
>                 ret = get_unused_fd_flags(addfd->flags);
>                 if (ret >= 0)
>                         fd_install(ret, get_file(addfd->file));
>         }
>
Wouldn't this result in consumption of reference in one case (fd_install),
and the fd still having a reference in the replace_fd case?
