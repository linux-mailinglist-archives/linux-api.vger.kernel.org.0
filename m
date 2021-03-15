Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6233C51E
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 19:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCOSDA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhCOSCp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 14:02:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B7DC06174A;
        Mon, 15 Mar 2021 11:02:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x4so51599865lfu.7;
        Mon, 15 Mar 2021 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r+dvU73MJrRHuvPjWiuKmMrfLEr3LmmsYA54M4JMymY=;
        b=LBcZko346yfuZRRJ5flhDptRBfmPepbuTKX7g98QkIjRbFR0J4wBaQKHXBGz9Lt0Tz
         lCVwYdpL4m32mjEJZZVMmfMNcUVnvoTfM42MRAE9j5ds/ZI5XZuKpnL9k/EXEejjF8cK
         MSmKQ5Q1wc7+9Iy4xvA7HFyAxsu5jbYIYuz33Rma4Mno7Xu2sBsGARgkGZFzCf6NIbLg
         GzmyR+FW3zETCLQO+xmGTwiY77pLK87kLqIM2Yne99Sc9YBvy+lsaDKYjvXG5TfnVUqK
         SitXXaXGqc8XzxVCA/1I4E1UQaKdoELELuyeIQ4P7kTObjhfgafy57+kpJDvQAvb8EUv
         vYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r+dvU73MJrRHuvPjWiuKmMrfLEr3LmmsYA54M4JMymY=;
        b=Eyo6aEEUbAvpOi6g79Zs1lf/gorbADeDLNG6yf5eORMzKJLZgEaP9LTPZMBlZm10D1
         95Y3kq8z85kc3XiH9ylzzCgxXkUR3Ya0q2F+a3LvhmXD8nqJcmB47+tQo7BgWFN3xaVm
         +P+96JXY1ywJdvl3WigVDHa1KnC1pjeF1IPX6gbZYg3oh9LkU6OcNablRZIuonVhIfGE
         ISu+nFBq1+KTuvvd3FfgciZZz6kaZ5Nq6KEcrPuqWkhSg3mbNrUePNNWkOzl10cX0TIz
         m1OAYXP1OmAfofMd3/oVb/UPTSyagEa0+7z7IRyPjc/nyPsddZHR7GRySoJIxLb1Ykrr
         xf8A==
X-Gm-Message-State: AOAM533KDthI3B/NjeN9vJoGGJCQvI+DP4iCSzm8GACBdXxHmmpJtGds
        1i6hDvXJS4iOTS26MSNqKh4=
X-Google-Smtp-Source: ABdhPJx8G6kkZIFpEJZ+7W+HG25iWohcSZpPNIhK8kDzKCxOd6LJFSTB+eXgwl0Y8tVP3VYH1YPq7A==
X-Received: by 2002:a05:6512:108c:: with SMTP id j12mr9089568lfg.431.1615831361357;
        Mon, 15 Mar 2021 11:02:41 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id v80sm2784223lfa.229.2021.03.15.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 11:02:41 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 15 Mar 2021 19:02:39 +0100
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
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20210315180239.GA2117@pc638.lan>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <ba975607-9493-c78c-bbd8-6a85573114d1@gmail.com>
 <20210315153510.GA1865@pc638.lan>
 <4649f69d-b7cd-d1a6-26e0-9b8bf3b17df5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4649f69d-b7cd-d1a6-26e0-9b8bf3b17df5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 15, 2021 at 06:23:37PM +0200, Topi Miettinen wrote:
> On 15.3.2021 17.35, Uladzislau Rezki wrote:
> > > On 14.3.2021 19.23, Uladzislau Rezki wrote:
> > > > Also, using vmaloc test driver i can trigger a kernel BUG:
> > > > 
> > > > <snip>
> > > > [   24.627577] kernel BUG at mm/vmalloc.c:1272!
> > > 
> > > It seems that most tests indeed fail. Perhaps the vmalloc subsystem isn't
> > > very robust in face of fragmented virtual memory. What could be done to fix
> > > that?
> > > 
> > Your patch is broken in context of checking "vend" when you try to
> > allocate next time after first attempt. Passed "vend" is different
> > there comparing what is checked later to figure out if an allocation
> > failed or not:
> > 
> > <snip>
> >      if (unlikely(addr == vend))
> >          goto overflow;
> > <snip>
> 
> 
> Thanks, I'll fix that.
> 
> > 
> > > 
> > > In this patch, I could retry __alloc_vmap_area() with the whole region after
> > > failure of both [random, vend] and [vstart, random] but I'm not sure that
> > > would help much. Worth a try of course.
> > > 
> > There is no need in your second [vstart, random]. If a first bigger range
> > has not been successful, the smaller one will never be success anyway. The
> > best way to go here is to repeat with real [vsart:vend], if it still fails
> > on a real range, then it will not be possible to accomplish an allocation
> > request with given parameters.
> > 
> > > 
> > > By the way, some of the tests in test_vmalloc.c don't check for vmalloc()
> > > failure, for example in full_fit_alloc_test().
> > > 
> > Where?
> 
> Something like this:
> 
> diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> index 5cf2fe9aab9e..27e5db9a96b4 100644
> --- a/lib/test_vmalloc.c
> +++ b/lib/test_vmalloc.c
> @@ -182,9 +182,14 @@ static int long_busy_list_alloc_test(void)
>         if (!ptr)
>                 return rv;
> 
> -       for (i = 0; i < 15000; i++)
> +       for (i = 0; i < 15000; i++) {
>                 ptr[i] = vmalloc(1 * PAGE_SIZE);
> 
> +               if (!ptr[i])
> +                       goto leave;
> +       }
> +
>
Hmm. That is for creating a long list of allocated areas before running
a test. For example if one allocation among 15 000 fails, some index will
be set to NULL. Later on after "leave" label vfree() will bypass NULL freeing.

Either we have 15 000 extra elements or 10 000 does not really matter
and is considered as a corner case that is probably never happens. Yes,
you can simulate such precondition, but then a regular vmalloc()s will
likely also fails, thus the final results will be screwed up.

> +
>         for (i = 0; i < test_loop_count; i++) {
>                 ptr_1 = vmalloc(100 * PAGE_SIZE);
>                 if (!ptr_1)
> @@ -236,7 +241,11 @@ static int full_fit_alloc_test(void)
> 
>         for (i = 0; i < junk_length; i++) {
>                 ptr[i] = vmalloc(1 * PAGE_SIZE);
> +               if (!ptr[i])
> +                       goto error;
>                 junk_ptr[i] = vmalloc(1 * PAGE_SIZE);
> +               if (!junk_ptr[i])
> +                       goto error;
>         }
> 
>         for (i = 0; i < junk_length; i++)
> @@ -256,8 +265,10 @@ static int full_fit_alloc_test(void)
>         rv = 0;
> 
>  error:
> -       for (i = 0; i < junk_length; i++)
> +       for (i = 0; i < junk_length; i++) {
>                 vfree(ptr[i]);
> +               vfree(junk_ptr[i]);
> +       }
> 
>         vfree(ptr);
>         vfree(junk_ptr);
> 
Same here.

--
Vlad Rezki
