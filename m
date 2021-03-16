Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7F33D31F
	for <lists+linux-api@lfdr.de>; Tue, 16 Mar 2021 12:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbhCPLf3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Mar 2021 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbhCPLfC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Mar 2021 07:35:02 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953EC06174A;
        Tue, 16 Mar 2021 04:35:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v9so61903403lfa.1;
        Tue, 16 Mar 2021 04:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IKq4ek8vxtJozQIHUfJnIO9yQXnXv6nYePXQr5PXTrs=;
        b=V4ATfEzNMGqq47uJKyufRl7ICYR2UJ7rBgNH1p5kST43w8cwJ+040tD45YpPXyTx7d
         JXEUlfA9LXu05xR+F9b73OjxsGZLENz7+ycb9j6vosNd8I/9BuM4qe94+quenCm7LJ/O
         f2AI6IAtfpU6tgiwVjBhuEdOsY3s94O8q0sdj1MaBgdVoz5HTqK9u8RJN7nw8mFYEFiz
         RZOAnx/ajMy2d53sf9Bg0bnEYxFsvlPNABbUF3sPUDO5vKLsRqjfJuvzBPV3lZjWTEv7
         PPSUFV0XvbH2iOBCE8Zq6rj5oT5tMrKESG1lxq+WhqG95qIuFt/ktI3ADrPkAuiLkcZp
         INcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IKq4ek8vxtJozQIHUfJnIO9yQXnXv6nYePXQr5PXTrs=;
        b=VmG3MNLHDnwCv41iLI/f4J6h1KziosFOZYE+3Rgi7lJ937XUypxAHpkja5oYGM/Xn3
         J4ph7j5+1ldXeEdTdfi9kuXQyqVPChDWpMPfWQU/Tqz/d9IvZCiAECVGPDHEnixxuqi0
         7hjrK2AM+xIbZEFe137qBzkSMJpmQjh6m8hd0IZ2v30Hjpun+jBq4h1kw0YkexDIcaO6
         FjE0RbkviFUAuxN3MHBE9lzyQkkjyj+AnLT9oK2YxgnvcjaLLpg09899AJf38xw1gv8K
         fxUiggsdFEc4k5Cpuxkswc/pbi+nwfTwAEmqaV1ZLepgpo093MKYT5Ee3uADGsR9hoih
         3Gsg==
X-Gm-Message-State: AOAM530UcvIIWu8abJ6XAcC27mDmkvQXQbk1qcA6pVg7Sw1SLPaTHFEn
        So/a8qHLQw7k9i1CxdBvvFw=
X-Google-Smtp-Source: ABdhPJzeTEzowewtj7H/UZHzJr2g65mMPWNwh/mTrCpjuyWHHP8pMMIJwYiVk4gsOPUmOsa0tJ5DYA==
X-Received: by 2002:a05:6512:21cb:: with SMTP id d11mr10527323lft.177.1615894498617;
        Tue, 16 Mar 2021 04:34:58 -0700 (PDT)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y11sm3200770ljc.18.2021.03.16.04.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 04:34:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 16 Mar 2021 12:34:56 +0100
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20210316113456.GA31764@pc636>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <f2d6965b-1801-ce91-0c7c-2cdc92493393@gmail.com>
 <20210315122410.GA26784@pc636>
 <202103150914.4172D96@keescook>
 <20210315174742.GA2038@pc638.lan>
 <85515ea8-744e-acec-76ba-034b38d0f9fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85515ea8-744e-acec-76ba-034b38d0f9fa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 16, 2021 at 10:01:46AM +0200, Topi Miettinen wrote:
> On 15.3.2021 19.47, Uladzislau Rezki wrote:
> > On Mon, Mar 15, 2021 at 09:16:26AM -0700, Kees Cook wrote:
> > > On Mon, Mar 15, 2021 at 01:24:10PM +0100, Uladzislau Rezki wrote:
> > > > On Mon, Mar 15, 2021 at 11:04:42AM +0200, Topi Miettinen wrote:
> > > > > What's the problem with that? It seems to me that nothing relies on specific
> > > > > addresses of the chunks, so it should be possible to randomize these too.
> > > > > Also the alignment is honored.
> > > > > 
> > > > My concern are:
> > > > 
> > > > - it is not a vmalloc allocator;
> > > > - per-cpu allocator allocates chunks, thus it might be it happens only once. It does not allocate it often;
> > > 
> > > That's actually the reason to randomize it: if it always ends up in the
> > > same place at every boot, it becomes a stable target for attackers.
> > > 
> > Probably we can randomize a base address only once when pcpu-allocator
> > allocates a fist chunk during the boot.
> > 
> > > > - changing it will likely introduce issues you are not aware of;
> > > > - it is not supposed to be interacting with vmalloc allocator. Read the
> > > >    comment under pcpu_get_vm_areas();
> > > > 
> > > > Therefore i propose just not touch it.
> > > 
> > > How about splitting it from this patch instead? Then it can get separate
> > > testing, etc.
> > > 
> > It should be split as well as tested.
> 
> Would you prefer another kernel option `randomize_percpu_allocator=1`, or
> would it be OK to make it a flag in `randomize_vmalloc`, like
> `randomize_vmalloc=3`? Maybe the latter would not be compatible with static
> branches.
> 
I think it is better to have a separate option, because there are two
different allocators.

--
Vlad Rezki
