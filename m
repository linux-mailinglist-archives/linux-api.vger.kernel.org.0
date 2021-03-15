Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896F933C175
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 17:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCOQQg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 12:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCOQQ2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 12:16:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3AFC06175F
        for <linux-api@vger.kernel.org>; Mon, 15 Mar 2021 09:16:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso15045238pjb.4
        for <linux-api@vger.kernel.org>; Mon, 15 Mar 2021 09:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUbNPoyJNI0p475d5f3CQqbt9mQMt4DepM5CFXS3wjU=;
        b=Bxh1CL5PZWIGVBGdFGdjCmlxM1BJeW1oPj3IWF2YhXBqYM4f+6vKceGfmW7x696iPS
         WtWca31ZbxmTdK88SVKQpWF8ilc3K3L4qY2/1fxnDa6Gi3xn8eJTE5Odi3HhBc8Yioma
         uh51Ay5Hot/L43sQXFrrToeoFIGWndzVGKB1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUbNPoyJNI0p475d5f3CQqbt9mQMt4DepM5CFXS3wjU=;
        b=dy446UR75/hWvaKlYcbK44iuICfytu1Vlot0bTQ8fr3BUkh+9gUtRRkbtBk5RWNZbh
         e7nmo0A8Sm0McxXfINjx31ckx0Ph/QcLH0b/j6cNc17fcrLbNqDHO9mdNVMAgdfvTc89
         wJDrDgK0vB2Fo6uw0b+4aJcBGTYl+5B80sPovryh9lXY7fjz9uai13sQYo6gcQ82ItZc
         Fd8gyejb2enA811xcOfmwXK2NGiCNiobLSVx49A6ZCq/K31NiLnjMYyJkhEmo1VADp4G
         UgSUFzZl+Dhra37fSUksJOba07GZFDB+dC2JrTG2h1PUmg/FSHMEBvdwgjbnyBSxhrcK
         Te0g==
X-Gm-Message-State: AOAM530CE/zf3IOiNI+U2FyQ8QDRtQOF4DdxVy5eqTQXffmV6Yz0ZR++
        dfJhCrcOFWUgFvqbKQmxBJ7zoQ==
X-Google-Smtp-Source: ABdhPJwyuitbf4ebUbZHbasW6NJC0ii7LhiMoi8oLWHW+iYq+9W48zWbXAS3jEAl344tzAvZq6K0tQ==
X-Received: by 2002:a17:90b:e08:: with SMTP id ge8mr13279801pjb.130.1615824987909;
        Mon, 15 Mar 2021 09:16:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bk8sm98493pjb.13.2021.03.15.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:16:27 -0700 (PDT)
Date:   Mon, 15 Mar 2021 09:16:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <202103150914.4172D96@keescook>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <f2d6965b-1801-ce91-0c7c-2cdc92493393@gmail.com>
 <20210315122410.GA26784@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315122410.GA26784@pc636>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 15, 2021 at 01:24:10PM +0100, Uladzislau Rezki wrote:
> On Mon, Mar 15, 2021 at 11:04:42AM +0200, Topi Miettinen wrote:
> > What's the problem with that? It seems to me that nothing relies on specific
> > addresses of the chunks, so it should be possible to randomize these too.
> > Also the alignment is honored.
> > 
> My concern are:
> 
> - it is not a vmalloc allocator;
> - per-cpu allocator allocates chunks, thus it might be it happens only once. It does not allocate it often;

That's actually the reason to randomize it: if it always ends up in the
same place at every boot, it becomes a stable target for attackers.

> - changing it will likely introduce issues you are not aware of;
> - it is not supposed to be interacting with vmalloc allocator. Read the
>   comment under pcpu_get_vm_areas();
> 
> Therefore i propose just not touch it.

How about splitting it from this patch instead? Then it can get separate
testing, etc.

-- 
Kees Cook
