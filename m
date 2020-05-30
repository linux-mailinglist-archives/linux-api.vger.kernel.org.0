Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E31E9287
	for <lists+linux-api@lfdr.de>; Sat, 30 May 2020 18:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE3QO4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 30 May 2020 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgE3QOy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 30 May 2020 12:14:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76361C08C5C9
        for <linux-api@vger.kernel.org>; Sat, 30 May 2020 09:14:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so2914322pjb.5
        for <linux-api@vger.kernel.org>; Sat, 30 May 2020 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1mMCBOJ9xlSs04aJtX5nG/zBArlwzRItgMFXRdNse4Q=;
        b=Ldmbb0t/hm9FKTfMQcWfFbocbn/wE6YMJBSuHLGLExSNELGaIkXeKC0sMS5xIUJLue
         FPUt2ivoeJSpEYqXEAwaf239OuUNgs8RqzdTV0PzY4K8St3W3XCXAGh4KTPBzFRAMWJu
         2nHXFRpmCV7GliRyzRDdqLgwCTJhjsoaEv4BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mMCBOJ9xlSs04aJtX5nG/zBArlwzRItgMFXRdNse4Q=;
        b=RjvXeGFXZobWVHnWKta9PjV30TnxGoHCmKBQI9YLmXCQRBK7/bobLJRzSpGImOgr6p
         owPA7GdTM/bjAXWCIqWLeq2xzwzpeUujmUDqG6YwVbOoOXePwSfUSQJ21uaWKvPJtvzY
         DCtb1REAYWi4NjqNWZ/ZwXWTkRhuzDzTbHeQN41TFEMjUDL9iQIF/gZonWrMKVbntUeE
         3EwuwFJLHYkxkHbknbCzy+rizx6SFo7hYTOYNGGMbqJ3rKBpDeeXCXxS5bHks+yHR70M
         /oie24pRglz+SHMQKxknMMALzFDrETorJ4TOP8SjTi5yU5OzXAWPlDMaYF9iip84Vt3l
         mN/g==
X-Gm-Message-State: AOAM533wxM1h5cP0yxooxKTLNMQU6Se4wIC/b27PdsGcZx14p7/MdEg1
        T7ud9z0IMvZN+M1sVcCXHXs7gw==
X-Google-Smtp-Source: ABdhPJwjpc7g4uprc/EQZZudD+avWs8D2XrWZrO6loVOnWgAQmFsGL6QDGqkL4TIdwTwUyLQKt6YdQ==
X-Received: by 2002:a17:90b:3650:: with SMTP id nh16mr15078357pjb.135.1590855292927;
        Sat, 30 May 2020 09:14:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm289949pfe.174.2020.05.30.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 09:14:52 -0700 (PDT)
Date:   Sat, 30 May 2020 09:14:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user
 notifier
Message-ID: <202005300911.AAE71F1955@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook>
 <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
 <20200530035817.GA20457@ircssh-2.c.rugged-nimbus-611.internal>
 <202005292223.1701AB31@keescook>
 <20200530141329.tjrtrdy66jhqzojy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530141329.tjrtrdy66jhqzojy@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 30, 2020 at 04:13:29PM +0200, Christian Brauner wrote:
> On Fri, May 29, 2020 at 10:47:12PM -0700, Kees Cook wrote:
> > Oh hey! Look at scm_detach_fds_compat(). It needs this too. (And it's
> > missing the cgroup tracking.) That would fix:
> > 
> > 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
> > d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
> > 
> > So, yes, let's get this fixed up. I'd say first fix the missing sock
> > update in the compat path (so it can be CCed stable). Then fix the missing
> 
> send this patch to net.
> 
> > sock update in pidfd_getfd() (so it can be CCed stable), then write the
> 
> send this patch to me.
> 
> > helper with a refactoring of scm_detach_fds(), scm_detach_fds_compat(),
> 
> this would be net-next most likely.
> 
> > and pidfd_getfd(). And then add the addfd seccomp user_notif ioctl cmd.
> 
> If you do this first, I'd suggest you resend the series here after all
> this has been merged. We're not in a rush since this won't make it for
> the 5.8 merge window anyway. By the time the changes land Kees might've
> applied my changes to his tree so you can rebase yours on top of it
> relieving Kees from fixing up merge conflicts.
> 
> About your potential net and net-next changes. Just in case you don't
> know - otherwise ignore this - please read and treat
> https://www.kernel.org/doc/Documentation/networking/netdev-FAQ.txt
> as the gospel. Also note, that after this Sunday - assuming Linus
> releases - net-next will be closed until the merge window is closed,
> i.e. for _at least_ 2 weeks. After the merge window closes you can check
> http://vger.kernel.org/~davem/net-next.html
> which either has a picture saying "Come In We're Open" or a sign saying
> "Sorry, We're Closed". Only send when the first sign is up or the wrath
> of Dave might hit you. :)

Yeah, timing is awkward here. I was originally thinking it could all
just land via seccomp (with appropriate Acks). Hmmm.

-- 
Kees Cook
