Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8062277AAE
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIXUqS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIXUqS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 24 Sep 2020 16:46:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE18C0613D4
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 13:46:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j2so272051eds.9
        for <linux-api@vger.kernel.org>; Thu, 24 Sep 2020 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNWgf5JR/cvx4+k2/k8//+NsLRafA9SikURsJTJxHl8=;
        b=N/W4hr3EM1UoBKdrsToiPIHVsXsZea5kjUdS8aVBO0VqX+vlNG+bO2voUqHrH92lkx
         v+cCb7BIpfE7J0COXu9ZveiX7hBiBESo1VPhidpBI1JkRyqPepo3jqNxoErSa7ggD7Bj
         MLUMxpjuK+mfC0nMTCX4DLvJzLTliYNOhloeeWBzNrArRN2m8nCyPvgHXMO/qRm9xIP9
         yDphfjjdEEvwDc1H58P3k8bEMGyF3FdmngMgF+y095/bdm8FGMsTS2nWw1Bvs8iIGz40
         6fSaqQQ8BTbKoWXpnnOg8j1RUBcZ/ah40mqYQZ90MYPclO65VlQGxG253bBnA8WCIAyt
         MFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNWgf5JR/cvx4+k2/k8//+NsLRafA9SikURsJTJxHl8=;
        b=KzIaXvWQRmAp5iw3Br2cl5xlBw3PyF2NhHWSYj9IkWlYXloxFXmWGZ7jFIqJU2Jz8H
         23iM2KnLNyqbtPNg3Dymd/K/w2qwBD3a1J6EWPVborazX0BQnF6m+l6Vc2+h+SCl5/+n
         zaLvW77B5ZyDjSXBWywMmoCNmseKOTeuAREu4LzNpp1nDQH9CMotdT4ujSy0NT6y81mM
         wLUL1RAyNfXpTRilxAbJORt/xuwL+xwR1ScrpUAz+FyHebTLg4ShSl8DRQBAZHJ84l5j
         TWD3MckqwsgZloV2L6dliC9qFCVn+XhhLQ21BgiZeyB316iecUQTWQdG4G+FvTOeeRwS
         wLWw==
X-Gm-Message-State: AOAM53074/uluvy5sugWwHm3uWntTVCwmPa61duu/VVMZXGX/5awKaDX
        cA8fS3OmGbEGj/RyvbQcsqi9hsoiV8T5BoqzBT+O
X-Google-Smtp-Source: ABdhPJys8MteKkL5WUs90rL77+/4O8I7EJZDSmxK4s4ECn/X6tsLMwrENyCDpmW58kDnYfzhj5A5Va1MBnTmQWGW++s=
X-Received: by 2002:aa7:cd06:: with SMTP id b6mr625058edw.196.1600980376408;
 Thu, 24 Sep 2020 13:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200923232923.3142503-1-keescook@chromium.org>
 <20200923232923.3142503-5-keescook@chromium.org> <CAG48ez251v19U60GYH4aWE6+C-3PYw5mr_Ax_kxnebqDOBn_+Q@mail.gmail.com>
 <202009240038.864365E@keescook> <CAHC9VhQpto1KuL7PhjtdjtAjJ2nC+rZNSM7+nSZ_ksqGXbhY+Q@mail.gmail.com>
 <202009241251.F719CC4@keescook>
In-Reply-To: <202009241251.F719CC4@keescook>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 24 Sep 2020 16:46:05 -0400
Message-ID: <CAHC9VhQudGg55atznkuWWW5h0d+vZZhO2NF4yNAqreg4NDsHKg@mail.gmail.com>
Subject: Re: [PATCH 4/6] seccomp: Emulate basic filters for constant action results
To:     Kees Cook <keescook@chromium.org>
Cc:     Tom Hromatka <tom.hromatka@oracle.com>,
        Jann Horn <jannh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
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
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 24, 2020 at 3:52 PM Kees Cook <keescook@chromium.org> wrote:
> On Thu, Sep 24, 2020 at 11:28:55AM -0400, Paul Moore wrote:
> > On Thu, Sep 24, 2020 at 3:46 AM Kees Cook <keescook@chromium.org> wrote:
> > > On Thu, Sep 24, 2020 at 01:47:47AM +0200, Jann Horn wrote:
> > > > On Thu, Sep 24, 2020 at 1:29 AM Kees Cook <keescook@chromium.org> wrote:
> > > > > This emulates absolutely the most basic seccomp filters to figure out
> > > > > if they will always give the same results for a given arch/nr combo.
> > > > >
> > > > > Nearly all seccomp filters are built from the following ops:
> > > > >
> > > > > BPF_LD  | BPF_W    | BPF_ABS
> > > > > BPF_JMP | BPF_JEQ  | BPF_K
> > > > > BPF_JMP | BPF_JGE  | BPF_K
> > > > > BPF_JMP | BPF_JGT  | BPF_K
> > > > > BPF_JMP | BPF_JSET | BPF_K
> > > > > BPF_JMP | BPF_JA
> > > > > BPF_RET | BPF_K
> > > > >
> > > > > These are now emulated to check for accesses beyond seccomp_data::arch
> > > > > or unknown instructions.
> > > > >
> > > > > Not yet implemented are:
> > > > >
> > > > > BPF_ALU | BPF_AND (generated by libseccomp and Chrome)
> > > >
> > > > BPF_AND is normally only used on syscall arguments, not on the syscall
> > > > number or the architecture, right? And when a syscall argument is
> > > > loaded, we abort execution anyway. So I think there is no need to
> > > > implement those?
> > >
> > > Is that right? I can't actually tell what libseccomp is doing with
> > > ALU|AND. It looks like it's using it for building jump lists?
> >
> > There is an ALU|AND op in the jump resolution code, but that is really
> > just if libseccomp needs to fixup the accumulator because a code block
> > is expecting a masked value (right now that would only be a syscall
> > argument, not the syscall number itself).
> >
> > > Paul, Tom, under what cases does libseccomp emit ALU|AND into filters?
> >
> > Presently the only place where libseccomp uses ALU|AND is when the
> > masked equality comparison is used for comparing syscall arguments
> > (SCMP_CMP_MASKED_EQ).  I can't honestly say I have any good
> > information about how often that is used by libseccomp callers, but if
> > I do a quick search on GitHub for "SCMP_CMP_MASKED_EQ" I see 2k worth
> > of code hits; take that for whatever it is worth.  Tom may have some
> > more/better information.
> >
> > Of course no promises on future use :)  As one quick example, I keep
> > thinking about adding the instruction pointer to the list of things
> > that can be compared as part of a libseccomp rule, and if we do that I
> > would expect that we would want to also allow a masked comparison (and
> > utilize another ALU|AND bpf op there).  However, I'm not sure how
> > useful that would be in practice.
>
> Okay, cool. Thanks for checking on that. It sounds like the arg-less
> bitmap optimization can continue to ignore ALU|AND for now. :)

What's really the worst that could happen anyways? (/me ducks)  The
worst case is the filter falls back to the current performance levels
right?

-- 
paul moore
www.paul-moore.com
