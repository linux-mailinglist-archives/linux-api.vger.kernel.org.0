Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168AD21A99D
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgGIVRR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 17:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgGIVRM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 17:17:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB60C08E763
        for <linux-api@vger.kernel.org>; Thu,  9 Jul 2020 14:17:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x11so1330799plo.7
        for <linux-api@vger.kernel.org>; Thu, 09 Jul 2020 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OdZDweBCXIY5hOfHC/pzwDJUpC5RDbUGhkzQWryCGXU=;
        b=Ekb99TF0TfmRaA9hW6hG4dBbVri8QR1MMxv9/mRy/x0ImlbCX507ivj5lU7T+5R4Pb
         DsC3NKoXWhj5yyGBbqvxD/A1SXEK2191ZyAwulgr1lDggvHGTgyiCcn8kMCbFzRYi9TU
         5Pipg4QaZAq+z2XgKxlu7h0Za08DFYoJM93GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OdZDweBCXIY5hOfHC/pzwDJUpC5RDbUGhkzQWryCGXU=;
        b=NaPOUYdF5/ehH3Mya8uQYM4Z9tzzaH9vBmwNifll/T2x0EscRcoBZpFH7+q1bU618Y
         H6Z/gjzs0Y41k/h+kAlADrR0r/UDyt5Rew975re7piUFX6Kb4uTsRsvOnqpo5ftcYrdX
         8Bml5iOP6b4MMzR8+UY/BN5nIwlrsTM9dXTjmzU25OdPCQSMMB340NyyPCuO8YRA3emU
         RaPW9dD2s2ZM+CX7uNDmzwkxJSN+GUaFRKT8LYPVz83gGIR9I8ob0rZscLk/ARD4TWns
         CzyQ+XVNeILBki750LWMNBZB/46D9sLCl//n/nYtgH4/rNSkJfC5VT0SZ78R9JeWados
         1w3g==
X-Gm-Message-State: AOAM531+Oh03yQAhf205o5/dSWVMzIpfWuLeHWKZaNokmmW92o87jvQD
        WaBcwYQ2RIBV54RDCj8VXk90CA==
X-Google-Smtp-Source: ABdhPJzIErmRrR6qma2jb3xZPC+8eFY/GKXvK8O6767phNef8KK0PNwVAWZMl7fyfoDxnU3LZlOzzw==
X-Received: by 2002:a17:902:c38b:: with SMTP id g11mr9718711plg.340.1594329431105;
        Thu, 09 Jul 2020 14:17:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y22sm3411040pjp.41.2020.07.09.14.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:17:09 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:17:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v7 2/9] pidfd: Add missing sock updates for pidfd_getfd()
Message-ID: <202007091416.42530A9C@keescook>
References: <20200709182642.1773477-1-keescook@chromium.org>
 <20200709182642.1773477-3-keescook@chromium.org>
 <CAG48ez1gz3mtAO5QdvGEMt5KnRBq7hhWJMGS6piGDrcGNEdSrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1gz3mtAO5QdvGEMt5KnRBq7hhWJMGS6piGDrcGNEdSrQ@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 09, 2020 at 10:00:42PM +0200, Jann Horn wrote:
> On Thu, Jul 9, 2020 at 8:26 PM Kees Cook <keescook@chromium.org> wrote:
> > The sock counting (sock_update_netprioidx() and sock_update_classid())
> > was missing from pidfd's implementation of received fd installation. Add
> > a call to the new __receive_sock() helper.
> [...]
> > diff --git a/kernel/pid.c b/kernel/pid.c
> [...]
> > @@ -642,10 +643,12 @@ static int pidfd_getfd(struct pid *pid, int fd)
> >         }
> >
> >         ret = get_unused_fd_flags(O_CLOEXEC);
> > -       if (ret < 0)
> > +       if (ret < 0) {
> >                 fput(file);
> > -       else
> > +       } else {
> >                 fd_install(ret, file);
> > +               __receive_sock(file);
> > +       }
> 
> __receive_sock() has to be before fd_install(), otherwise `file` can
> be a dangling pointer.

Burned by fd_install()'s API again. Thanks. I will respin.

-- 
Kees Cook
