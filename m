Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6931E8DFC
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 07:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgE3FWn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 May 2020 01:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgE3FWn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 May 2020 01:22:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87FBC08C5CA
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 22:22:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so2039666plt.5
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 22:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fjf8hmDqJIojxT3nGa3YLDxLqUzBCgpmNXNwU1GHXcw=;
        b=Qxjbd0gA7K0cZxfT1oEnXcWuM5WEpVNrRQkEbIm5j8VgzEjHxQL9Z6Xa5Ow/U8W9Ea
         EY/FK4MS0uiTPKyekupYVR2OL5fau2dywLiwgmrT7WLaMH71pMtDpGf+8tBB1Hhy2qn1
         IMbTRrhDvC6eW2kwG7lqyGzoscIEji+3JuT+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fjf8hmDqJIojxT3nGa3YLDxLqUzBCgpmNXNwU1GHXcw=;
        b=m2NH1yOUOLtJ1OOnk6rumNDLiUId8x41K40Ul9aFZFQVir8IotW3k5mUqx/hstWQRM
         mkz7Q6p1DQ0PNr7NKMkXQIpulBdpK+MbFeZI98UI7rp8amPtZ4B3g78hZMuqv8GQAvvO
         CNUukW6/hFgeBwiQgZHrk6leyyndl0Xj3E5Bw97ILuNh4NhVcyJ1XN5hAj+IVqSRxDj8
         CHK7Yz2d5cFnKqisgT4wc7Ts42NVqQIFpr5KzJvdKXYzkuShClx/kXJEpKFNaTC8lom9
         M2sqVQy7PyAXouJ6o0B9UbPsUPpusrW/sZ0UjJHGmIJoGAsuhP0iBah7YzT5FHK+6ZoF
         ev3w==
X-Gm-Message-State: AOAM531WPepc9UZB9N/f/oL6+KzJMymncUe0xdBiGtCOpc+HutU2Jdfb
        UzJisPv0BBuvB7EwkRtHmLYYC6cJzP9kqQ==
X-Google-Smtp-Source: ABdhPJz0RkbeYGkndAO8RTLZOM8xglaVjOPljyI/OfAgz8fencfYnm4uLgujP8gCUia+QodC8fRY7w==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr11675754pls.290.1590816162350;
        Fri, 29 May 2020 22:22:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q44sm986162pja.29.2020.05.29.22.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 22:22:41 -0700 (PDT)
Date:   Fri, 29 May 2020 22:22:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005292219.C9B1BF33@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 05:17:24AM +0200, Jann Horn wrote:
> On Sat, May 30, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> > I mean, yes, that's certainly better, but it just seems a shame that
> > everyone has to do the get_unused/put_unused dance just because of how
> > SCM_RIGHTS does this weird put_user() in the middle.
> >
> > Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> > move the put_user() after instead?
> 
> Honestly, I think trying to remove file descriptors and such after
> -EFAULT is a waste of time. If userspace runs into -EFAULT, userspace
> is beyond saving and can't really do much other than exit immediately.
> There are a bunch of places that will change state and then throw
> -EFAULT at the end if userspace supplied an invalid address, because
> trying to hold locks across userspace accesses just in case userspace
> supplied a bogus address is kinda silly (and often borderline
> impossible).

Logically, I agree. I'm more worried about the behavioral change -- if
we don't remove the fd on failure, the fd is installed with no
indication to the process that it exists (it won't know the close it --
if it keeps running -- and it may survive across exec). Before, it never
entered the file table.

> You can actually see that even scm_detach_fds() currently just
> silently swallows errors if writing some header fields fails at the
> end.

Yeah, and it's a corner case. But it should be possible (trivial, even)
to clean up on failure to retain the original results.

-- 
Kees Cook
