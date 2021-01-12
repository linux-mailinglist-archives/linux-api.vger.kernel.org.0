Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C92F3756
	for <lists+linux-api@lfdr.de>; Tue, 12 Jan 2021 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbhALRhV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Jan 2021 12:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389426AbhALRhP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Jan 2021 12:37:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89708C0617A2
        for <linux-api@vger.kernel.org>; Tue, 12 Jan 2021 09:36:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d13so3346294wrc.13
        for <linux-api@vger.kernel.org>; Tue, 12 Jan 2021 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfBdHlbPhe9JJVFJ53u2WB3aTeFtdCK9M9opKH7jl0E=;
        b=r+hFbctf7X7hHlEJB3cUCjzH8j2xrYepKGUGArG/haPmHg3VEsQqEoP+bjyfE+JUV4
         7fNlBjtiSaVAjnlZ8OaToJ9zft6m1wHPMAvTu/fKvVnerheKqOs0WRIVdNMN12Jw7COZ
         FVQMfPoZ0h5x0cFG0Z9WY0uT5Hp0zqIxpVoCNdwBTExy689NFmyPnNG3yNlT+FuggQJY
         PcUzwOPS1IslA3+lNcHct75qRyTW9ivKIgWwcPwxQoEltGGD4o6tV3kE9jPcvQfhuuXA
         O6Owucb4wqQ+RuictebWz50p1Hg4HXq7M3petBX90hlXHPZpAra0SIB2ZVih0uotmjgi
         REWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfBdHlbPhe9JJVFJ53u2WB3aTeFtdCK9M9opKH7jl0E=;
        b=Fsl7R27mpBds2QR1Ha/7W8KqwOsg0/yA7L89uMP4FkZt/XbxTA0kUhO8UETNjzTrux
         oERy+8HEJlpjgNM+KGZ2V/9iMN5h5IvNNXlDj3Z//bGIE9vuD4KH3X+gm1ec3xcAt6Gm
         3ZfhQRB6fhHz9C0J+II8Dm8wqODLzrX8AGqW4ExXz23WAWMwSrMNNOy3yZ49OuLfcyHu
         28DmmckYc+QKuWjBHtk4RgCYDgMKCfm4akLJcKZEE/N1gLUmQzwfJYGrLkn318CnGxG0
         NVGLG4GOKYYwxDs/Hj02z8WFdNRpw8Lms0/R8Dft42AwrxxP8apxShu2s32EEp1SDqv/
         nd3Q==
X-Gm-Message-State: AOAM533mifoIeMgypmAQi+PseFzYYQVPnceiK+LYnXtA0qlZNnyrNnc0
        kdDYrHWZhppreO8REjYR1XxAch3KKn3C2YG9UQL3TQ==
X-Google-Smtp-Source: ABdhPJw1Jgdy43yhmaRwTd0pdcF+MsZsBqxx4SqJd+UJxoXstrUpJMKOObpVqUZhNvBXniG6D6ajQpMGbSb4nXVH30o=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr5603702wro.162.1610472990153;
 Tue, 12 Jan 2021 09:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
In-Reply-To: <20210111172213.ab4185a1de916c35f3245021@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 Jan 2021 09:36:18 -0800
Message-ID: <CAJuCfpFdSNTp+PhJ1ztyfbzdVWVHy=qJJPVizXPGizgBQqTKYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 11, 2021 at 5:22 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 11 Jan 2021 09:06:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > process_madvise currently requires ptrace attach capability.
> > PTRACE_MODE_ATTACH gives one process complete control over another
> > process. It effectively removes the security boundary between the
> > two processes (in one direction). Granting ptrace attach capability
> > even to a system process is considered dangerous since it creates an
> > attack surface. This severely limits the usage of this API.
> > The operations process_madvise can perform do not affect the correctness
> > of the operation of the target process; they only affect where the data
> > is physically located (and therefore, how fast it can be accessed).
> > What we want is the ability for one process to influence another process
> > in order to optimize performance across the entire system while leaving
> > the security boundary intact.
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
> It would be useful to see the proposed manpage update.
>
> process_madvise() was released in 5.10, so this is a
> non-backward-compatible change to a released kernel.
>
> I think it would be OK at this stage to feed this into 5.10.x with a
> cc:stable and suitable words in the changelog explaining why we're
> doing this.

Sure, I will post another patchset that will include manpage update
and will CC:stable. That's of course after Michal's concerns are
addressed.
Thanks!

>
> Alternatively we could retain PTRACE_MODE_ATTACH's behaviour and add
> PTRACE_MODE_READ&CAP_SYS_NICE alongside that.
