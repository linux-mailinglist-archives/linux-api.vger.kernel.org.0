Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C221E8892
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 22:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgE2UJS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 May 2020 16:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgE2UJP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 May 2020 16:09:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0BC03E969
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 13:09:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n18so386146pfa.2
        for <linux-api@vger.kernel.org>; Fri, 29 May 2020 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0dHCo8mIqCH++ZYUH2A3bMWUKj4OZy8vTm8Z83SEx1s=;
        b=Y1WSc8t1dF107b3vxptUBYhnuSLrItSatx+Ps5mdq3YoYllO74ndBZgsrsBklDAJS1
         dbkDuyz6D2RlLJl+a2mtn6FKf9EhMvl1wDP3COGelgErrEIMoHeZmTMwu3l2zkfKCd0l
         gWnt965+Xp/U+FWgBWApZ2m3CRc7EXiYrcguU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dHCo8mIqCH++ZYUH2A3bMWUKj4OZy8vTm8Z83SEx1s=;
        b=bjC1/OFIzeCR3A9CNGpam3L4lzjTSQJIDNTf7wgRzNH6tXiMyG1fMBzXeMZLg0/O6X
         uuxPRZvXusI8qLy4QSbQ6njGFQYNJc8avo1h5dDsyHLIJcJi8u1CCpvz61FRObHpksYQ
         uFc3QwtnXIcv5ReuUMF0D5V8tKH+3nFFYrAEQeR+ZNDe74weSwz7QJnXNkjFBN7YPtqX
         5E0HFXVJ5mb4Zj6LVZ9zZpFtdZplcEk/0qr3fdeOAXGhWbP6UOP89A3uMW/tv6H0IuAM
         BTDvhJNPWSLLKwVMzatzN9sWU/vMfCi0cmB4WGgov0doFILjwHmc4IDL9ZngsU/XXo3f
         12Yg==
X-Gm-Message-State: AOAM532Iv80zVJV2b6u6K/ZTk7yC4g3hLnBl6SzTvvhsdTpfPFzFAF+n
        BTa1jEuLoJoDa+fKMHGB8EST9g==
X-Google-Smtp-Source: ABdhPJzWvn+MWjavSEFRh2llx+NGCe0a6uDpMrS2R/YDJSyxJee6wJdoXrFRsYDklUtpRzy5MFy9Yg==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr9840282pgd.412.1590782954399;
        Fri, 29 May 2020 13:09:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t4sm7040021pgp.2.2020.05.29.13.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:09:13 -0700 (PDT)
Date:   Fri, 29 May 2020 13:09:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>
Subject: Re: [PATCH v2 3/3] selftests/seccomp: Test SECCOMP_IOCTL_NOTIF_ADDFD
Message-ID: <202005291308.448DA71@keescook>
References: <20200528110858.3265-1-sargun@sargun.me>
 <20200528110858.3265-4-sargun@sargun.me>
 <202005290036.3FEFFDA@keescook>
 <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529184606.GB11153@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 29, 2020 at 06:46:07PM +0000, Sargun Dhillon wrote:
> On Fri, May 29, 2020 at 12:41:51AM -0700, Kees Cook wrote:
> > On Thu, May 28, 2020 at 04:08:58AM -0700, Sargun Dhillon wrote:
> > > +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> > > +
> > > +	nextid = req.id + 1;
> > > +
> > > +	/* Wait for getppid to be called for the second time */
> > > +	sleep(1);
> > 
> > I always rebel at finding "sleep" in tests. ;) Is this needed? IIUC,
> > userspace will immediately see EINPROGRESS after the NOTIF_SEND
> > finishes, yes?
> > 
> > Otherwise, yes, this looks good.
> > 
> > -- 
> > Kees Cook
> I'm open to better suggestions, but there's a race where if getppid
> is not called before the second SECCOMP_IOCTL_NOTIF_ADDFD is called,
> you will just get an ENOENT, since the notification ID is not found.
> 
> The other approach is to "poll" the child, and wait for it to enter
> the second syscall. Calling receive beforehand doesn't work because
> it moves the state of the notification in the kernel to received,
> and then the kernel doesn't error with EINPROGRESS.

For tests, I prefer polling. How about adding a busy-loop
(with a iteration-bounded small usleep) that just calls
SECCOMP_IOCTL_NOTIF_ID_VALID until it's valid?

-- 
Kees Cook
