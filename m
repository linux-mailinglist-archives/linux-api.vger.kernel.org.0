Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F304D1E8D7B
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 05:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgE3DR4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 23:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE3DRz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 23:17:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05AC03E969
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 20:17:52 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so1648293ljo.5
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAzzi6iT/99Kzep9I6N6vUOQSaglX3NMEqv/R35zMzg=;
        b=kMEJZWXTCuXXpMzPmI1oXS8B+nPKTCFTFJeWDNanOkoeAWo0NajeLc14NLFwtXu7TD
         T1esDDSnFxgbWr9UHpuKYsKhwIEfcbW9guLsK7BEC3IU1PHw7e8Jo8W9QMRKDPcmexGH
         2pL6zks1ywxdNUYWD9luZ3HodypdOe4QbDbeH054DV9+nVJURp47JX23CbAY9mms1WZy
         g32iddYT4guKgxTH6aECpechaohc+xsEXkXZUyd85nhD+Vu89iXgz5aTQwnUfQ0MGMTt
         KAucywSTUO+PUvGYPObqYElbCE7OapYyow/1m6glLRIq0ZYLtkXvHirthic91m514SKm
         oT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAzzi6iT/99Kzep9I6N6vUOQSaglX3NMEqv/R35zMzg=;
        b=HK00DBJqj3gzvxY+XqNxYHqsCdIg0XnwXhpMexALHEvG4NunNdDJ69vl+yeCJXgKun
         VPp5ol19CIZ/MNt3gEqkzuXxWp68Q+couapmRlEbgugSXoQ5h3gtpz4h9eJsbHLjnOwN
         HkD2X7myOKBJFOcQQQ/hHppN0gmhU1b1Ih5wGjDPPvTk2mSvq1ms6F4DStE5keUGPssT
         XVZApVtKRyR4j5sKBVyb0B3uhzSv/S9RKbzp0D8o/oYptL67nbqWBLF97++F0BpjgE+b
         mGqgSXukLuAxPgeJOg3Z8V3HWGlh6hpy9IzQN8/cHaueND91cEbftDtI+lGBftag967l
         adhA==
X-Gm-Message-State: AOAM532Wb7ajQlLk21stCn7mfpk6ak7vzZAvHDBP6MyiWKznzXa6f5nK
        RTNsU2tP6h9Ca47mpSmE5UlY4zrwxJsDyZCS6XEWEQ==
X-Google-Smtp-Source: ABdhPJwVr1MLXqp8e8epUu6GNQxDXbxAvK0QuUf9kOz8L3PrS50T9ROfiZz8JKiyr98eRsYs/2ctRWjx1pcKrAK9R9M=
X-Received: by 2002:a2e:1f02:: with SMTP id f2mr5178479ljf.156.1590808671140;
 Fri, 29 May 2020 20:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110858.3265-1-sargun@sargun.me> <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook> <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
In-Reply-To: <202005291926.E9004B4@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 30 May 2020 05:17:24 +0200
Message-ID: <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Kees Cook <keescook@chromium.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> I mean, yes, that's certainly better, but it just seems a shame that
> everyone has to do the get_unused/put_unused dance just because of how
> SCM_RIGHTS does this weird put_user() in the middle.
>
> Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> move the put_user() after instead?

Honestly, I think trying to remove file descriptors and such after
-EFAULT is a waste of time. If userspace runs into -EFAULT, userspace
is beyond saving and can't really do much other than exit immediately.
There are a bunch of places that will change state and then throw
-EFAULT at the end if userspace supplied an invalid address, because
trying to hold locks across userspace accesses just in case userspace
supplied a bogus address is kinda silly (and often borderline
impossible).

You can actually see that even scm_detach_fds() currently just
silently swallows errors if writing some header fields fails at the
end.
