Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D206E1E1AFA
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 08:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEZGI5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 02:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgEZGI5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 02:08:57 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17759C03E97E
        for <linux-api@vger.kernel.org>; Mon, 25 May 2020 23:08:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m21so84449eds.13
        for <linux-api@vger.kernel.org>; Mon, 25 May 2020 23:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5YTh51mOSkEuxU21BvSuS/w+t0LyTN4bdZGeF4brQo=;
        b=fWV/9lztW7nmFrKNP0PJ4RtoJAO6nrDX3GUlHhH4zIRcu804CcMll+BcR/TH+zTrIi
         VbimfFrLLAZRbnIDe4AovAH/2WLLd6lnUM9Mmhm0hZjDtq/EUCKd36hg6LZq+np9n/oj
         PIaajG/lFoLSUHfjAO5tASEwXekSEHmOnEB94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5YTh51mOSkEuxU21BvSuS/w+t0LyTN4bdZGeF4brQo=;
        b=dfGtyldO1S4KoY9dUtng/X1D/AJqhhbDT3+6IYMppzDTCZNxLohqv0PcFyI4eZJ16T
         O/0DTZHal7McNMnMQj7QVnBaa0bCJT6LOppDLPAAlujHMOj1a6PowZFKQh7u74oue4eF
         mXKtIKL4xEM/+PgM/guM5wmlrG+dOfxgXqTyKUuJ/i7WrVmSUdHirKU7N3y+wLOosR42
         0txcmg7zL02dOSFwCvkVMqWqm/m0JphQMeeAoiDWiVfNzBFLBS52bAJ5YIe0RhtimcPS
         CdBfMn5BHhheetz4bYTiDcBkv9eto98HTQp5fFaUFdhQMFM4lqbXmwprBB1oUTdayAo7
         UVwQ==
X-Gm-Message-State: AOAM531q1I58PYN6FqmPQYDcJZk6XvCpzRVipUmi0xNASRG700ftVgeo
        XrANiBXNqaqXX+QboUFn6rDPeNVlWocZB3mHYC3PDA==
X-Google-Smtp-Source: ABdhPJzib02G90pJOtMeOUHnKCP2wPTxzVpDsQuhN4DT9I2bM+InsgjG5fVPNFXE6LDET7T6rqwFER52/c6lbAlIXeA=
X-Received: by 2002:a05:6402:b38:: with SMTP id bo24mr18800566edb.24.1590473335434;
 Mon, 25 May 2020 23:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200524233942.8702-1-sargun@sargun.me> <20200524233942.8702-5-sargun@sargun.me>
 <20200525142043.jkdsfabntqusizxz@wittgenstein>
In-Reply-To: <20200525142043.jkdsfabntqusizxz@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Mon, 25 May 2020 23:08:19 -0700
Message-ID: <CAMp4zn_JFEVQd3PpOod=R11fSFOQYVWpS3bVQensOQyhc=BQag@mail.gmail.com>
Subject: Re: [PATCH 4/5] seccomp: Add SECCOMP_ADDFD_FLAG_MOVE flag to add fd ioctl
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
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

> > + * they are created in. Specifcally, sockets, and their interactions with the
> > + * net_cls and net_prio cgroup v1 controllers. This "moves" the file descriptor
> > + * so that it takes on the cgroup controller's configuration in the process
> > + * that the file descriptor is being added to.
> > + */
> > +#define SECCOMP_ADDFD_FLAG_MOVE              (1UL << 1)
>
> I'm not happy about the name because "moving" has much more to do with
> transferring ownership than what we are doing here. After a "move" the
> fd shouldn't be valid anymore. But that might just be my thinking.
>
> But why make this opt-in and not do it exactly like when you send around
> fds and make this mandatory?

Based upon Tycho's comments in an offline thread, I'm going to make
this the default
(setting the cgroup metadata) to mirror what SCM_RIGHTS does, and then
if we come
up with a good use case where we need to preserve *cgroup v1*
metadata, then we can
add an opt-out flag in the future.
