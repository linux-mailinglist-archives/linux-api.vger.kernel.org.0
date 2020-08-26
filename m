Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB14253587
	for <lists+linux-api@lfdr.de>; Wed, 26 Aug 2020 18:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHZQzM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Aug 2020 12:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbgHZQzL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 26 Aug 2020 12:55:11 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86FEA22B4E
        for <linux-api@vger.kernel.org>; Wed, 26 Aug 2020 16:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598460910;
        bh=90eG2YC7ABsnYjclAXIjb+dB+da3NK2fm+peh/LcFOk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ALtDO/SGIdIyXtJEgnSUc5+3ECVAWbJUiZmmv4zc0htOnx8GLxrv0eP+vpvcifgBr
         4ercfZTjzUiKDT5N/tuG4G2vavO/VGYzZeLs6HiGnTXGWKm7MN/9B3hZhOaXf9NEbv
         YSjGr0Kf2NouFCLwjCP/LyibUnKlXuGq7Sbuc8Yc=
Received: by mail-wm1-f50.google.com with SMTP id s13so2462513wmh.4
        for <linux-api@vger.kernel.org>; Wed, 26 Aug 2020 09:55:10 -0700 (PDT)
X-Gm-Message-State: AOAM533qU3HqAxA3CFLUXl5FMUwFiVHUUlePasJm48fOWe66pbMBOjsK
        duaUnHGjbOXSJrVjFU7/nzYaM/lBrPOeH/JtWeADHw==
X-Google-Smtp-Source: ABdhPJzm6zw8GgmvAuLjLkF//j2YOGcbQK27MpOGIKs7o1yACCh0Pt9TsTFQE/afB1qwmSFWs+CN/ps0CGFC5GDu0TQ=
X-Received: by 2002:a1c:bc45:: with SMTP id m66mr7394687wmf.36.1598460908958;
 Wed, 26 Aug 2020 09:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200130162340.GA14232@rapoport-lnx> <CALCETrVOWodgnRBFpPLEnc_Bfg=fgfAJiD1p-eE1uwCMc6c9Tg@mail.gmail.com>
 <6e020a65-b516-9407-228f-2a3a32947ab9@intel.com>
In-Reply-To: <6e020a65-b516-9407-228f-2a3a32947ab9@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Aug 2020 09:54:57 -0700
X-Gmail-Original-Message-ID: <CALCETrUwO_y_b=kazRjen-de50r9b9TVXUXz_WT_hD3d3tTWxQ@mail.gmail.com>
Message-ID: <CALCETrUwO_y_b=kazRjen-de50r9b9TVXUXz_WT_hD3d3tTWxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: extend memfd with ability to create "secret"
 memory areas
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 14, 2020 at 11:09 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/14/20 10:46 AM, Andy Lutomirski wrote:
> > I'm a little unconvinced about the security benefits.  As far as I
> > know, UC memory will not end up in cache by any means (unless
> > aliased), but it's going to be tough to do much with UC data with
> > anything resembling reasonable performance without derived values
> > getting cached.
>
> I think this is much more in the category of raising the bar than
> providing any absolute security guarantees.

The problem here is that we're raising the bar in a way that is
weirdly architecture dependent, *extremely* nonperformant, and may not
even accomplish what it's trying to accomplish.

>
> Let's say you have a secret and you read it into some registers and then
> spill them on the stack.  You've got two cached copies, one for the
> primary data and another for the stack copy.  Secret areas don't get rid
> of the stack copy, but they do get rid of the other one.  One cache copy
> is better than two.  Bar raised. :)

If we have two bars right next to each other and we raise one of them,
did we really accomplish much?  I admit that having a secret in its
own dedicated cache line seems like an easier target than a secret in
a cache line that may be quickly overwritten by something else.  But
even user registers right now aren't specially protected -- pt_regs
lives is cached and probably has a predictable location, especially if
you execve() a setuid program.

>
> There are also some stronger protections, less in the bar-raising
> category.  On x86 at least, uncached accesses also crush speculation.
> You can't, for instance, speculatively get wrong values if you're not
> speculating in the first place.  I was thinking of things like Load
> Value Injection[1].

This seems genuinely useful, but it doesn't really address the fact
that requesting UC memory via PAT apparently has a good chance of
getting WB anyway.

>
> I _believe_ there are also things like AES-NI that can get strong
> protection from stuff like this.  They load encryption keys into (AVX)
> registers and then can do encrypt/decrypt operations without the keys
> leaving the registers.  If the key was loaded from a secret memory area
> right into the registers, I think the protection from cache attacks
> would be pretty strong.
>

Except for context switches :)
>
> 1.
> https://software.intel.com/security-software-guidance/insights/deep-dive-load-value-injection
