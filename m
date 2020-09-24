Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475DA276AF0
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgIXHiV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgIXHiV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 03:38:21 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8881AC0613CE
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 00:38:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so1227563plz.5
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2/ZWotEmwV2wYeMAbWubNYS0mAS1AJsi/PuMFNxSA0Y=;
        b=HnTNwGP8FohbDh7X+PypMX569OCpgnEdElmZ7hXNOGxNjGMFfEkxcg1my+0mklYktz
         UQxlLsrFts2bnq6rFWsLPHHuEQQ628XuCnd8XqRUUnUlvMTs3I66PIrsb0ARIcdPpkgp
         owqNp2wrBCqIff3j2oqFxAiN74eNqrGdyR6xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2/ZWotEmwV2wYeMAbWubNYS0mAS1AJsi/PuMFNxSA0Y=;
        b=amHyfJH0TCLscAyXjpUTHHH8J/H7Uf5i1NS97PeGmgdJe2LDwAcwuU9Up/D2EspaaJ
         HzV5HidB8OJ8q5S5JUkryrwRAdPs6i2XpCDy9y53NyeBv3K9c4QJZMzgJNEafHtVBoTK
         W9ayb5yM1aT83ZGfIPcj54FBV+GwmUr+tuORbp7j1u6/JPC0NKfSQHN9IoH8HulxHu8y
         6/d+728a8MX1c/pSsLgBd02tpIW8rfG31pkvAUjBuXWpW8L0Y9C0SpBIWp9AMzJHg9Ul
         x+8QzmoD6Rug6XyNKgvGYlZjuQqLkgAG2oN+hREaUh/LG6yX+p59AX65B8O3IZqiZXJP
         EBtg==
X-Gm-Message-State: AOAM533fvy4x4tHW7m1nsU90GW8vrKsL04ZjlrLbhpuSUvoUT94rVvoC
        2psqRUuwZy19m1nJ8LfxB/pJgg==
X-Google-Smtp-Source: ABdhPJwgnuX9NNL+oLb/kmNEL0CZL8XPv33AWyRHruVO1Vk1X5iwGSW6FVUhC/l7K0WYG62SFNLf2g==
X-Received: by 2002:a17:90a:ee16:: with SMTP id e22mr2551329pjy.81.1600933101134;
        Thu, 24 Sep 2020 00:38:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm1607476pjs.18.2020.09.24.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:38:20 -0700 (PDT)
Date:   Thu, 24 Sep 2020 00:38:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        YiFei Zhu <yifeifz2@illinois.edu>
Subject: Re: [PATCH 3/6] seccomp: Implement constant action bitmaps
Message-ID: <202009240037.21A9E3CE@keescook>
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-4-keescook@chromium.org>
 <DM6PR11MB271492D0565E91475D949F5DEF390@DM6PR11MB2714.namprd11.prod.outlook.com>
 <CABqSeAS=b6NQ=mqrD=hV60md3isYSDyAnE9QE_AT4=oYYFkAfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABqSeAS=b6NQ=mqrD=hV60md3isYSDyAnE9QE_AT4=oYYFkAfQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 23, 2020 at 07:36:47PM -0500, YiFei Zhu wrote:
> On Wed, Sep 23, 2020 at 6:29 PM Kees Cook <keescook@chromium.org> wrote:
> > In order to optimize these cases from O(n) to O(1), seccomp can
> > use bitmaps to immediately determine the desired action. A critical
> > observation in the prior paragraph bears repeating: the common case for
> > syscall tests do not check arguments. For any given filter, there is a
> > constant mapping from the combination of architecture and syscall to the
> > seccomp action result. (For kernels/architectures without CONFIG_COMPAT,
> > there is a single architecture.). As such, it is possible to construct
> > a mapping of arch/syscall to action, which can be updated as new filters
> > are attached to a process.
> 
> Would you mind educating me how this patch plan one handling MIPS? For
> one kernel they seem to have up to three arch numbers per build,
> AUDIT_ARCH_MIPS{,64,64N32}. Though ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
> does not seem to be defined for MIPS so I'm assuming the syscall
> numbers are the same, but I think it is possible some client uses that
> arch number to pose different constraints for different processes, so
> it would better not accelerate them rather than break them.

I'll take a look, but I'm hoping it won't be too hard to fit into what
I've got designed so for to deal with x86_x32. (Will MIPS want this
optimization at all?)

-- 
Kees Cook
