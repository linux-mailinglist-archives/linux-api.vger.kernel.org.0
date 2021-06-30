Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BDF3B7CFD
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 07:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhF3FZi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 01:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhF3FZh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 01:25:37 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E763C061767
        for <linux-api@vger.kernel.org>; Tue, 29 Jun 2021 22:23:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m26so1085224pgb.8
        for <linux-api@vger.kernel.org>; Tue, 29 Jun 2021 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkgX/l6nyVHOkHtVICWEWlZsAs77Eh7E8vZnP+04cZU=;
        b=Ozuu7aPncD/CMLJza+F4JwA5PsKvNqi55YrM7STSKGqVfTpUR6pNiqkih8C4Yej/UI
         pX+laWJdYLjpLb9flbG3+U2C2Ptmg+Az4aAgDQyct0uzw/FYqXma79YGfBZ+XB5d0fJG
         dq5rXy7x0hVB2s2mU6bck5fQekMMTukz/ufvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkgX/l6nyVHOkHtVICWEWlZsAs77Eh7E8vZnP+04cZU=;
        b=QC3dptopxzCCBrsSsJ4jJN70Z/iqj6ug7IJvzaRZPZFtbrVVZ8YhFU1xF1V0nxH1zO
         DGNA5YOi6HvfDwXyFWQ48f7+jqJvE/29OpQQO3zm8ZrnyKWojw9eKdhDGQT12IwM72xp
         Ior6SMO//Kzz3w+oe7StJaHDBUAk7dJFyAwLVgRC3j1PNMVpXhfPAEV7rnoMI32/civa
         ZoEPVpkBDKWbS8hUT6PemItpZwdI/cnpg1ihBzj6VF4OaSGobhSqf/GW3n8hhADbUd/K
         Rac2CDNVUl+fow5mhAzhxs553M5mAOTuXwMJcHLQghPaafcH0+nTyyDw6APUDC99SQ4g
         7DHw==
X-Gm-Message-State: AOAM532rY4O6i+JJl+s00eW1xspQYJKd2p+iX4kqaTfCYp7uZ6jP4VD4
        gr824PY3kOrZjZWSA0aF79OXVQ==
X-Google-Smtp-Source: ABdhPJwDqkm3t0Zwuy34uTWGsjAywlzfUwSe78RbVnfvHZrGSmFPSQRG5iMuesZvQ5sZ2hfjRRaV2Q==
X-Received: by 2002:a62:380c:0:b029:2f7:4057:c3ed with SMTP id f12-20020a62380c0000b02902f74057c3edmr34233852pfa.21.1625030588089;
        Tue, 29 Jun 2021 22:23:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm20087789pfj.178.2021.06.29.22.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 22:23:07 -0700 (PDT)
Date:   Tue, 29 Jun 2021 22:23:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-api@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Semantics of SECCOMP_MODE_STRICT?
Message-ID: <202106292156.9458CF22@keescook>
References: <87r1gkp9i7.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1gkp9i7.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 29, 2021 at 05:54:24PM -0500, Eric W. Biederman wrote:
> 
> I am the process of cleaning up the process exit path in the kernel, and
> as part of that I am looking at the callers of do_exit.  A very
> interesting one is __seccure_computing_strict.
> 
> Looking at the code is very clear that if a system call is attempted
> that is not in the table the thread attempting to execute that system
> call is terminated.
> 
> Reading the man page for seccomp it says that the process is delivered
> SIGKILL.
> 
> The practical difference is what happens for multi-threaded
> applications.
> 
> What are the desired semantics for a multi-threaded application if one
> thread attempts to use a unsupported system call?  Should the thread be
> terminated or the entire application?
> 
> Do we need to fix the kernel, or do we need to fix the manpages?

I don't know of anyone actually using SECCOMP_MODE_STRICT, but the
original implementation was (perhaps accidentally) thread-killing. It
turns out this is not a particularly desirable situation, and when
SECCOMP_MODE_FILTER was created, it continued with that semantic,
but later grew a process-killing flags, as that's what most programs
actually wanted.

It's likely the manpage needs fixing (we had to make similar updates
for SECCOMP_MODE_FILTER), since some of the early examples of using
SECCOMP_MODE_STRICT were basically "fork, calculate, write result to
fd, exit".

FWIW the seccomp selftests don't even check for the thread-vs-process
SIGKILL of SECCOMP_MODE_STRICT. :)

-- 
Kees Cook
