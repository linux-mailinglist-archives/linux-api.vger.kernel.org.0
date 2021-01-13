Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC02F4D07
	for <lists+linux-api@lfdr.de>; Wed, 13 Jan 2021 15:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbhAMOWt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Jan 2021 09:22:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbhAMOWt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 13 Jan 2021 09:22:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610547723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YaJyrouPpgNEF+Q5LLB84J7mSoEpwJTbsWHp0jr/WhE=;
        b=nYxkz9Sq6tjTWZXiRBdUWWSzCCX6BtDKVlPAHOePb5A1L1HZPs7t55Upu+WK3pf4UFzwzb
        hCGFVYpzluAZT3bz0KONs0OSTUQaoUkunsNqL2ljnKSgfYvpNgZ2IvFKtI2lfR4OZBVAqd
        BP5XaBj2yUWfuZ3R4CjoSDXcuc9kdmE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC4B3B8DA;
        Wed, 13 Jan 2021 14:22:02 +0000 (UTC)
Date:   Wed, 13 Jan 2021 15:22:02 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Edgar Arriaga =?iso-8859-1?Q?Garc=EDa?= 
        <edgararriaga@google.com>, Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
Message-ID: <20210113142202.GC22493@dhcp22.suse.cz>
References: <20210111170622.2613577-1-surenb@google.com>
 <20210112074629.GG22493@dhcp22.suse.cz>
 <20210112174507.GA23780@redhat.com>
 <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFQz=x-LvONO3c4iqjKP4NKJMgUuiYc8HACKHAv1Omu0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 12-01-21 09:51:24, Suren Baghdasaryan wrote:
> On Tue, Jan 12, 2021 at 9:45 AM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > On 01/12, Michal Hocko wrote:
> > >
> > > On Mon 11-01-21 09:06:22, Suren Baghdasaryan wrote:
> > >
> > > > What we want is the ability for one process to influence another process
> > > > in order to optimize performance across the entire system while leaving
> > > > the security boundary intact.
> > > > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > > > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > > > and CAP_SYS_NICE for influencing process performance.
> > >
> > > I have to say that ptrace modes are rather obscure to me. So I cannot
> > > really judge whether MODE_READ is sufficient. My understanding has
> > > always been that this is requred to RO access to the address space. But
> > > this operation clearly has a visible side effect. Do we have any actual
> > > documentation for the existing modes?
> > >
> > > I would be really curious to hear from Jann and Oleg (now Cced).
> >
> > Can't comment, sorry. I never understood these security checks and never tried.
> > IIUC only selinux/etc can treat ATTACH/READ differently and I have no idea what
> > is the difference.
> 
> I haven't seen a written explanation on ptrace modes but when I
> consulted Jann his explanation was:
> 
> PTRACE_MODE_READ means you can inspect metadata about processes with
> the specified domain, across UID boundaries.
> PTRACE_MODE_ATTACH means you can fully impersonate processes with the
> specified domain, across UID boundaries.

Maybe this would be a good start to document expectations. Some more
practical examples where the difference is visible would be great as
well.

> He did agree that in this case PTRACE_MODE_ATTACH seems too
> restrictive (we do not try to gain full control or impersonate a
> process) and PTRACE_MODE_READ is a better choice.

All that being said, I am not against the changed behavior but I do not
feel competent to give an ack.
-- 
Michal Hocko
SUSE Labs
