Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B5721AAA1
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 00:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGIWf3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIWf2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 18:35:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86504C08C5DD
        for <linux-api@vger.kernel.org>; Thu,  9 Jul 2020 15:35:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so1625178pfn.7
        for <linux-api@vger.kernel.org>; Thu, 09 Jul 2020 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kM+IChOCCY2qzDdaGchO/Aoq+RoZYyonRNazqswaWP0=;
        b=Qhvrh91HDkhVWDK/+/B4Hw+OlVZvwuv/ZWHMiSSmCgw4vLrsIhG7VMztdqxMlrJ8rU
         0hOl5IUFf89c+iaFoOJ0W/zebf1rv05PMvYbbeipkhEXh5q8hG1euVeLv+ribwqLJWYB
         cHm1vpObishp1g4R12qBkYvtLtPyqTKezLIrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kM+IChOCCY2qzDdaGchO/Aoq+RoZYyonRNazqswaWP0=;
        b=nq/ax2262hDswjUT9+I11WdvCXmW9eciHLohDRjQ6z22TCI1Ey4KxzMQCIdKXQDhRy
         M2smFEpJesdOq+PHpEZga1LAFhQlDvwAokm34jae71DAwnU91n5stR+wkHArAjaJlc3Q
         Ptxz/pW1N2JdQVz2bb6Ce6FaG/JQI3zl3shHzJGedL3kjK+/TeE/k22e3utaHfXHt9dg
         OYY5RexeAC88lu/TNY2wgw4nXr5QiWfrXkHUisSo7z5++W461yb8EBm2CtWIJy9gVwTr
         gQ+DhX4KevRf/EEeYPvOV/LSrTd6XGEIDIxCXQRDhANU22G6CjcJNJ6naz894Rsl7I7C
         qGtg==
X-Gm-Message-State: AOAM53259RnU5vPKa1Jt4HhyIDdulGcM3CRIrKR0ayDLCOAo41f1/6Zy
        8tgDvUpvxls2nEvdDCpiEuVFIA==
X-Google-Smtp-Source: ABdhPJwD/P7eqvd4f5ccMiZGMgkLzKVgKJseEMwpjGYj6fVV5lmNaBSoLKMV9VLKUql7LxXfBZ6HOw==
X-Received: by 2002:aa7:938c:: with SMTP id t12mr59089142pfe.37.1594334128092;
        Thu, 09 Jul 2020 15:35:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm3717827pfm.151.2020.07.09.15.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:35:27 -0700 (PDT)
Date:   Thu, 9 Jul 2020 15:35:26 -0700
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
Message-ID: <202007091534.382887A@keescook>
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

I've swapped the order now and double-checked the other uses. Everything
else seems fine.

-- 
Kees Cook
