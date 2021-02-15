Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7531B9D1
	for <lists+linux-api@lfdr.de>; Mon, 15 Feb 2021 13:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBOMxF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Feb 2021 07:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhBOMwk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Feb 2021 07:52:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D32CC061574;
        Mon, 15 Feb 2021 04:51:58 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p21so9872066lfu.11;
        Mon, 15 Feb 2021 04:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KAcKBIEJHkiFFEg+eBhYyKF6mpgLJGuodnHv7wBP55o=;
        b=do8GwdAHdZ4S6gFJ4luZv+iMpePUpfnAaldCHt2ph5JudPQ4FoDLvOtvthd1dvQlN4
         4WcX+AXXP5LLNaj+G85Y/ec07i1YH9Dj5sSotprlFsqHUGAxqF6n+T0St31xrK/7A6cf
         GZGWXzaJyB34RvotsoYwJZKpoTO60NfI7nSE8/HCgm3mNSl9nGw/DsP7MpsoGbM7tFJd
         N+HScTMO9OhH2Lnj9qoBHnFa7HVwmV6aJjivRT7RKnY40y2HPc9G6pamH01yaUi96w6+
         TEX5D0KSIBcZsZ2MInNeXBYA020G/dQA47cKxsAkqArPLC45UCuiWHEYRbE2Op+EbNBB
         ZqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KAcKBIEJHkiFFEg+eBhYyKF6mpgLJGuodnHv7wBP55o=;
        b=Chocy+DG23btjU8vtwBhfmX0BYW2J0QyKKacAg+T4UK/f7jXqs0KmWQ1y81a9Hex4d
         N95BmY51LGXXbQw+khA8fsuripKdvwX1MeYEM2dJ04eM+GTsMUrJkQ6uh6pxkjKLARKi
         6o0YdHEALThU+0g1+N6wfoZnqfOz1OcCRosDgMl7s9Y8SN1ZVtDjPohdCA+seXv+xDFn
         uZFtUro5kdEGRILlZjePgzT7QNVxmWBbDxoIPbjZCm0dtSozwVwQ4tOdUMM2M7uXs3Rq
         PEvM9+RHtbIHB/MV+Raz96McNagt8H1CBkzPqrnMuZ3H35ntu4voHJzkEkjQRZXghkhk
         37cg==
X-Gm-Message-State: AOAM533SyT5ARDcXkqn6OBbVbuonUrObnldL9U+DTc01qKXE23+gTcQ+
        mO+OKi6ntBCCTJSrdMYU4hY=
X-Google-Smtp-Source: ABdhPJxb3XiSBHop552bmK0mmybiubbDu9iubQJIgWo7X4Jme7oT6lUPuupRhc2C+deFXoNDbW7glQ==
X-Received: by 2002:a19:f814:: with SMTP id a20mr8229576lff.212.1613393517119;
        Mon, 15 Feb 2021 04:51:57 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id 3sm1891173lfr.105.2021.02.15.04.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 04:51:56 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 15 Feb 2021 13:51:54 +0100
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20210215125154.GA2259@pc638.lan>
References: <20201212175635.4217-1-toiwoton@gmail.com>
 <795016db-93fa-72ea-f5dd-16b9c56a62e9@gmail.com>
 <20210213115521.GA1907@pc638.lan>
 <8d60ba59-1d16-bb76-f3d3-f1b0c5a5b306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d60ba59-1d16-bb76-f3d3-f1b0c5a5b306@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Feb 13, 2021 at 03:43:39PM +0200, Topi Miettinen wrote:
> On 13.2.2021 13.55, Uladzislau Rezki wrote:
> > > Hello,
> > > 
> > > Is there a chance of getting this reviewed and maybe even merged, please?
> > > 
> > > -Topi
> > > 
> > I can review it and help with it. But before that i would like to
> > clarify if such "randomization" is something that you can not leave?
> 
> This happens to interest me and I don't mind the performance loss since I
> think there's also an improvement in security. I suppose (perhaps wrongly)
> that others may also be interested in such features. For example, also
> `nosmt` can take away a big part of CPU processing capability.
>
OK. I was thinking about if it is done for some production systems or
some specific projects where this is highly demanded.

>
> Does this
> answer your question, I'm not sure what you mean with leaving? I hope you
> would not want me to go away and leave?
>
No-no, that was a type :) Sorry for that. I just wanted to figure out
who really needs it.

> > For example on 32bit system vmalloc space is limited, such randomization
> > can slow down it, also it will lead to failing of allocations much more,
> > thus it will require repeating with different offset.
> 
> I would not use `randomize_vmalloc=1` on a 32 bit systems, because in
> addition to slow down, the address space could become so fragmented that
> large allocations may not fit anymore. Perhaps the documentation should warn
> about this more clearly. I haven't tried this on a 32 bit system though and
> there the VM layout is very different.
> 
For 32-bit systems that would introduce many issues not limited to fragmentations.

> __alloc_vm_area() scans the vmalloc space starting from a random address up
> to end of the area. If this fails, the scan is restarted from the bottom of
> the area up to this random address. Thus the entire area is scanned.
> 
> > Second. There is a space or region for modules. Using various offsets
> > can waste of that memory, thus can lead to failing of module loading.
> 
> The allocations for modules (or BPF code) are also randomized within their
> dedicated space. I don't think other allocations should affect module space.
> Within this module space, fragmentation may also be possible because there's
> only 1,5GB available. The largest allocation on my system seems to be 11M at
> the moment, others are 1M or below and most are 8k. The possibility of an
> allocation failing probably depends on the fill ratio. In practice haven't
> seen problems with this.
> 
I think it depends on how many modules your system loads. If it is a big
system it might be that such fragmentation and wasting of module space
may lead to modules loading.

> It would be possible to have finer control, for example
> `randomize_vmalloc=3` (1 = general vmalloc, 2 = modules, bitwise ORed) or
> `randomize_vmalloc=general,modules`.
> 
> I experimented by trying to change how the modules are compiled
> (-mcmodel=medium or -mcmodel=large) so that they could be located in the
> normal vmalloc space, but instead I found a bug in the compiler (-mfentry
> produces incorrect code for -mcmodel=large, now fixed).
> 
> > On the other side there is a per-cpu allocator. Interfering with it
> > also will increase a rate of failing.
> 
> I didn't notice the per-cpu allocator before. I'm probably missing
> something, but it seems to be used for a different purpose (for allocating
> the vmap_area structure objects instead of the address space range), so
> where do you see interference?
> 


   A                       B
 ---->                   <----
<---------------------------><--------->
|   vmalloc address space    |
|<--------------------------->


A - is a vmalloc allocations;
B - is a percpu-allocator.

--
Vlad Rezki
