Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690C333C004
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 16:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbhCOPf1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhCOPfO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 11:35:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A20DC06175F;
        Mon, 15 Mar 2021 08:35:14 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k9so57518542lfo.12;
        Mon, 15 Mar 2021 08:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bMBCcUXuOU3Fm4nhvLl0kRKLKut+Z1kVT4eqPxPAYgU=;
        b=MQyhYUan/Eyh3CRmjhoq2OOQD8nqcjsBArmfbP7AGxf1OAtkHWRkiLfgrUHZ41z0dg
         TMHsQsL+/EDOdZIhSG7eEmjZtvTOfyc6CI9WfDje7Nfs+1BFspkkHrWUSPOb88V7tLig
         j2ams2noeaa//hf44XgFn/yjRsRmbjVakD8wGfMsjNGNa9gwsOzBxthV48Ou9OBoizP3
         cGzyhhBlIG5YAaOW+NXAkj5xPiqkYTfnBIOXynw+v5A4gwrYMPYSrhjB50fTwbBFw1B7
         mGogX0pM/iu2bxI3tpI3IzSOvlvr8ICzKHe85L3ABBJjII/Niv7K3hVzMAvmYusJZHjI
         WH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bMBCcUXuOU3Fm4nhvLl0kRKLKut+Z1kVT4eqPxPAYgU=;
        b=hbMAc6rlR5j2dV1vwmw2faeRS5qMKmyHpcGkUrKUOSpVbkb4CwiMyLlSvfiHa/fbCs
         dujsYwrzjttE6jVWg2KIpLGN5m7vhNalxl6gj8dAsKNBkz6LDyyJ6ELjLIp65TOxHkzN
         tuZgZg0wHC1A91H6MuQvNByl6O5h+/FnG6T8mqrvTmoaBbJ/vCqAJKSv+gsWd1Nlqf6t
         LxC/k05V44oBIRYUx2pCJPj2ABt8rLu6H7sOO7GkENrfr2jwiEszml4q2Z44LfuZRGKr
         XsEpERavq3rr3wj3Sptw4FDoriYh/3D3vDHkoaivzotoe8MvOGwRk9esGVs4jpI3pKz2
         4I+A==
X-Gm-Message-State: AOAM532tqMN5Fyn/DHfybaVtu/aRYI5M9gSHEDwV9Bh+VxxyPD9QRRi1
        bMEVw6MVS4SbdDPUVFhZARo=
X-Google-Smtp-Source: ABdhPJz+kveInYJo1Hmjwkxo1UdBuaiZdNgw19jnqZRBR4s0izEoKzjq35SSMVeolcYVFTZC6iJ+dA==
X-Received: by 2002:a05:6512:3184:: with SMTP id i4mr8625095lfe.314.1615822512436;
        Mon, 15 Mar 2021 08:35:12 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y3sm2717239lfg.6.2021.03.15.08.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 08:35:12 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 15 Mar 2021 16:35:10 +0100
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
Message-ID: <20210315153510.GA1865@pc638.lan>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <ba975607-9493-c78c-bbd8-6a85573114d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba975607-9493-c78c-bbd8-6a85573114d1@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> On 14.3.2021 19.23, Uladzislau Rezki wrote:
> > Also, using vmaloc test driver i can trigger a kernel BUG:
> > 
> > <snip>
> > [   24.627577] kernel BUG at mm/vmalloc.c:1272!
> 
> It seems that most tests indeed fail. Perhaps the vmalloc subsystem isn't
> very robust in face of fragmented virtual memory. What could be done to fix
> that?
> 
Your patch is broken in context of checking "vend" when you try to
allocate next time after first attempt. Passed "vend" is different
there comparing what is checked later to figure out if an allocation
failed or not:

<snip>
    if (unlikely(addr == vend))
        goto overflow;
<snip>

>
> In this patch, I could retry __alloc_vmap_area() with the whole region after
> failure of both [random, vend] and [vstart, random] but I'm not sure that
> would help much. Worth a try of course.
> 
There is no need in your second [vstart, random]. If a first bigger range
has not been successful, the smaller one will never be success anyway. The
best way to go here is to repeat with real [vsart:vend], if it still fails
on a real range, then it will not be possible to accomplish an allocation
request with given parameters.

>
> By the way, some of the tests in test_vmalloc.c don't check for vmalloc()
> failure, for example in full_fit_alloc_test().
> 
Where?

--
Vlad Rezki
