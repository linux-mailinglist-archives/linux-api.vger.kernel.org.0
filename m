Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA5633C4E1
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 18:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhCOR4F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 13:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhCORsm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 13:48:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DA5C0613D7;
        Mon, 15 Mar 2021 10:47:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 18so58197164lff.6;
        Mon, 15 Mar 2021 10:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fdMDCgNpygqH5MPN3KQlWAA4EwgfeKoFJFcXCdqXUfo=;
        b=JZIC5BeE2vnm8pUt2+wuIoJ7SA4bt95uSMebW/6FIEKwBLWhNK0ZKU95YGgRKMWsPd
         vApjC6kUSxPuRs6dgtTB0EtpIyysovFu4l+lxJ39sMo0FOwur40bfrez7mHuW4P+SRuI
         H23dZwOnU38maLlLI/RuBZhyPidpfg5WRdCRbHy0M7ThzvuShKgcHI6lB9nbC32OTmFb
         riHVSf6Dz8ZQFobiyVIwqCtu/YsIx70UlBQauoTzh/qXpvRb3+MZ2tK8VV1S3D/2vfKu
         Ecjt8hMnYWkP0O7Nxqhm+8/9YUXHaD8J1wIDjigk33HvzlJjpM/oZ55ItIO2m4CPf9Yl
         K6+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fdMDCgNpygqH5MPN3KQlWAA4EwgfeKoFJFcXCdqXUfo=;
        b=OKTUZlmPNtwrCnitq0gcth7tARYFRGDKlQXNLVYiRKepnFFBpqbZOlAstqR1EXpVZJ
         nyIhTv0p8IHBgvyLLduLwIZQzSN5mD9bO8/pGkByIrP08xRnAXPG2fmAq23N0oga3P6j
         gnS7isHScTl2y7MNCOtbY7Pm8hZJUeNX8fVL13JS0wXklv1NS1hc2dxy3p4VOk7ZMoKQ
         Gr8q5q6MWlvIwG1JwLBNPWpqK5rMaD/APGF/3riKMNY15i4PwrsQ3vouE6lny40Fkq0O
         gN1VBpdLpPTF1ZWEMS/scSnqAdhnMhHKotcBIqSZDtIvfCqPT3CH/bm2U4Pw2OD1D4KA
         kI7Q==
X-Gm-Message-State: AOAM532j+G9dfcFZ5+/1GbvgEnnlFiOxe10BCKQCQd64pSk9IZmo+Wt9
        Nvb+7WkUIwh4VjF/0GxxYW0=
X-Google-Smtp-Source: ABdhPJy6QivAfG/xnyNZaddupxb9bqOukKr0r9K2EEL0KSF/e8VAngPeI1zRXfcNeUveZJ2WY150Mw==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr8929717lfh.338.1615830464827;
        Mon, 15 Mar 2021 10:47:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q3sm2755918lfr.33.2021.03.15.10.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 10:47:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 15 Mar 2021 18:47:42 +0100
To:     Kees Cook <keescook@chromium.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
Message-ID: <20210315174742.GA2038@pc638.lan>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
 <f2d6965b-1801-ce91-0c7c-2cdc92493393@gmail.com>
 <20210315122410.GA26784@pc636>
 <202103150914.4172D96@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202103150914.4172D96@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 15, 2021 at 09:16:26AM -0700, Kees Cook wrote:
> On Mon, Mar 15, 2021 at 01:24:10PM +0100, Uladzislau Rezki wrote:
> > On Mon, Mar 15, 2021 at 11:04:42AM +0200, Topi Miettinen wrote:
> > > What's the problem with that? It seems to me that nothing relies on specific
> > > addresses of the chunks, so it should be possible to randomize these too.
> > > Also the alignment is honored.
> > > 
> > My concern are:
> > 
> > - it is not a vmalloc allocator;
> > - per-cpu allocator allocates chunks, thus it might be it happens only once. It does not allocate it often;
> 
> That's actually the reason to randomize it: if it always ends up in the
> same place at every boot, it becomes a stable target for attackers.
> 
Probably we can randomize a base address only once when pcpu-allocator
allocates a fist chunk during the boot.

> > - changing it will likely introduce issues you are not aware of;
> > - it is not supposed to be interacting with vmalloc allocator. Read the
> >   comment under pcpu_get_vm_areas();
> > 
> > Therefore i propose just not touch it.
> 
> How about splitting it from this patch instead? Then it can get separate
> testing, etc.
> 
It should be split as well as tested.

--
Vlad Rezki
