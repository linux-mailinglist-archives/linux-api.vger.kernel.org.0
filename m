Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CCB22269F
	for <lists+linux-api@lfdr.de>; Thu, 16 Jul 2020 17:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGPPMl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jul 2020 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgGPPMi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jul 2020 11:12:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7302BC08C5DB
        for <linux-api@vger.kernel.org>; Thu, 16 Jul 2020 08:12:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so4006323pls.4
        for <linux-api@vger.kernel.org>; Thu, 16 Jul 2020 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N9cLlw64hWKscX8FZb2xpNSIxOyx8OVcITnqRM7FpVI=;
        b=mv9JS06gZ97E3G32ZQWL6GS0ElnkOcD6uZoaEwIKSYlYwnw+I789fgsnu9RIyKRAU+
         UtjwIxEz8y/Rd1KzJvRZW5NPhGYYsAgc+9JcovTIRuRW4JSCU7Yy4LtIaNRwRtKYVMAa
         O0HqOafeihrdM6BtpKQ9bf/CSzxCZGvW/VyGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N9cLlw64hWKscX8FZb2xpNSIxOyx8OVcITnqRM7FpVI=;
        b=tsEU+Ohm3schtskVZLoDQH5NIfsvhgeWRhCwWU/NAkeM30MU0xpLnJmv5L3rS/2faW
         watGuT/LdCRPAaRViMvA0NDApFubTvV7qICiMVGlI5iQOOYJr3CocluTgh/sAVKuTQ4S
         2QLAL7MSMPWkJ4PTDYzhvgglYp58TIl6O7S23ymHxrHitmdwkS9IZrUk+7A//0jV7iKL
         X0j6sPzK7q1oiwE1S64Tj1ODQpJziPVahS3837KB+Xhxzo+RETgZ4u2ObolQhIrIlShW
         jiSxRIwi6OZiFN+vdOs8ZClKxleQF4cYd+N7SiuoROF8AL3ZvyE5pS8ifZ0gU6b5osEt
         1ogw==
X-Gm-Message-State: AOAM530bM7NHL7RPmv0NlDNpBF8jkpubmCrB/Ta6fcDq7VUp/pD9LSJd
        BaAXEQh/pUgweKnyiqSGYkR4GA==
X-Google-Smtp-Source: ABdhPJxZQy+rxF9/jXytbGfyHMD/u/Eum1INRvVxrE25iFO25PsexI0VEAJV5sGRq2U2nAyAa4wWdA==
X-Received: by 2002:a17:90a:cc:: with SMTP id v12mr4994854pjd.96.1594912357822;
        Thu, 16 Jul 2020 08:12:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm5060155pfn.173.2020.07.16.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:12:36 -0700 (PDT)
Date:   Thu, 16 Jul 2020 08:12:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: strace of io_uring events?
Message-ID: <202007160751.ED56C55@keescook>
References: <CAJfpegu3EwbBFTSJiPhm7eMyTK2MzijLUp1gcboOo3meMF_+Qg@mail.gmail.com>
 <D9FAB37B-D059-4137-A115-616237D78640@amacapital.net>
 <20200715171130.GG12769@casper.infradead.org>
 <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
 <20200716131404.bnzsaarooumrp3kx@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716131404.bnzsaarooumrp3kx@steredhat>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 16, 2020 at 03:14:04PM +0200, Stefano Garzarella wrote:
> On Wed, Jul 15, 2020 at 04:07:00PM -0700, Kees Cook wrote:
> [...]
> 
> > Speaking to Stefano's proposal[1]:
> > 
> > - There appear to be three classes of desired restrictions:
> >   - opcodes for io_uring_register() (which can be enforced entirely with
> >     seccomp right now).
> >   - opcodes from SQEs (this _could_ be intercepted by seccomp, but is
> >     not currently written)
> >   - opcodes of the types of restrictions to restrict... for making sure
> >     things can't be changed after being set? seccomp already enforces
> >     that kind of "can only be made stricter"
> 
> In addition we want to limit the SQEs to use only the registered fd and buffers.

Hmm, good point. Yeah, since it's an "extra" mapping (ioring file number
vs fd number) this doesn't really map well to seccomp. (And frankly,
there's some difficulty here mapping many of the ioring-syscalls to
seccomp because it's happening "deeper" than the syscall layer (i.e.
some of the arguments have already been resolved into kernel object
pointers, etc).

> Do you think it's better to have everything in seccomp instead of adding
> the restrictions in io_uring (the patch isn't very big)?

I'm still trying to understand how io_uring will be used, and it seems
odd to me that it's effectively a seccomp bypass. (Though from what I
can tell it is not an LSM bypass, which is good -- though I'm worried
there might be some embedded assumptions in LSMs about creds vs current
and LSMs may try to reason (or report) on actions with the kthread in
mind, but afaict everything important is checked against creds.

> With seccomp, would it be possible to have different restrictions for two
> instances of io_uring in the same process?

For me, this is the most compelling reason to have the restrictions NOT
implemented via seccomp. Trying to make "which instance" choice in
seccomp would be extremely clumsy.

So at this point, I think it makes sense for the restriction series to
carry on -- it is io_uring-specific and solves some problems that
seccomp is not in good position to reason about.

All this said, I'd still like a way to apply seccomp to io_uring
because it's a rather giant syscall filter bypass mechanism, and gaining
access (IIUC) is possible without actually calling any of the io_uring
syscalls. Is that correct? A process would receive an fd (via SCM_RIGHTS,
pidfd_getfd, or soon seccomp addfd), and then call mmap() on it to gain
access to the SQ and CQ, and off it goes? (The only glitch I see is
waking up the worker thread?)

What appears to be the worst bit about adding seccomp to io_uring is the
almost complete disassociation of process hierarchy from syscall action.
Only a cred is used for io_uring, and seccomp filters are associated with
task structs. I'm not sure if there is a way to solve this disconnect
without a major internal refactoring of seccomp to attach to creds and
then make every filter attachment create a new cred... *head explody*

-- 
Kees Cook
