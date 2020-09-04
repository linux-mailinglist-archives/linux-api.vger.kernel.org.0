Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9566F25DF69
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgIDQLI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDQLH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 12:11:07 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42187C061244
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 09:11:06 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cr8so3246347qvb.10
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 09:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ErDDXj4EwBDt0OZ5J7pAu9GlFqxRrQWgVOUzC5yARc0=;
        b=ZKDqX03YRzg6KyweUTUdd0ChXOJbiCvisiddVP3E6PEUgNRiqCXBqlzsShJv7hv+Yr
         pORN9HIcVVWEjOiOLxQnF+Fo6JP/r3VyvZKutuU0U8btisSB19ZteSzlU+ebTAgu87gn
         5D+b9J/6wghr4u9dDENGi8GJZZS/rLMtlSUbVnHjxt2HasIviOb4cJTxtwJL1+u6rHat
         9A/eGwLONMnjtEtDEEEi3OKWxoXz25NgQTXGRkZqKAtWFAY+Nfh4j+v2xo310iAUfac1
         Ift1m2X+LhDFNgn8TlZKgawYcCnMKSlydPIDlm4Yl6xnEggFDxDOfsj2ZN+ghqondKkU
         gAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ErDDXj4EwBDt0OZ5J7pAu9GlFqxRrQWgVOUzC5yARc0=;
        b=B7pmsh4KFpcGyHj7Yv1fZIN2t/OS0slyWKeOuKS1zTo3h0b/h2Bg/Eut37Cg/yPTJE
         bBZiHwqWr+6ru2LfGLlapw1NAvAYLWLbja10XPuDibENfOGYR6pPsxslphSGecDaMv0L
         U+DRT4IRZoy7KqeQCKw6Ezep7jpBNUA8cZytO8VpRyomkM4U//3+bK/1WhEMBC3V6tWt
         ouTLsIRU9lBckKCh+Wfb41wY+jT6z3OX/jBfIAnoYuxXcd7FpcAhVlSubmVk14hZYqlG
         ukgVHvJ7srQX7aWzNGFel8SV3+E66TcVkg4dEk5XxeSxJ8jd6SVVLWzl3QALwWuaOFyI
         xVeQ==
X-Gm-Message-State: AOAM531Y16Vfd/QkLOdf1kqFLzLCHwbF1KD3+InE+ELgiLW+i5ZdCvlg
        qEs3KbFhRvTuvydRrAbyrB7Uuw==
X-Google-Smtp-Source: ABdhPJz8LUvYzrCV/J0pOMMqLumsriTz8gryN+e4BnDWul2xovC8R7vel6cVOFLHAKJHxlLeDbYVtQ==
X-Received: by 2002:ad4:4b30:: with SMTP id s16mr7666735qvw.8.1599235864693;
        Fri, 04 Sep 2020 09:11:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y20sm4680134qkj.70.2020.09.04.09.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:11:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kEEIp-007iR4-0Q; Fri, 04 Sep 2020 13:11:03 -0300
Date:   Fri, 4 Sep 2020 13:11:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
Cc:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200904161102.GU24045@ziepe.ca>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
 <20200904133907.GS24045@ziepe.ca>
 <AM7PR02MB6082B1192A87C027DE2FD668BB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
 <20200904143903.GT24045@ziepe.ca>
 <AM7PR02MB6082C74BEE8285D242F3A03CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR02MB6082C74BEE8285D242F3A03CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 03:40:55PM +0000, Mircea CIRJALIU - MELIU wrote:
> > On Fri, Sep 04, 2020 at 02:18:37PM +0000, Mircea CIRJALIU - MELIU wrote:
> > > > This seems really sketchy, get_user_pages is sensitive to the VMA,
> > > > what happens when VMA flags are different/etc?
> > >
> > > A debugger shouldn't complain if a portion of the debuggee is
> > > read-only, just overwrite the data.
> > 
> > At this point the kernel API here is so incredibly limited you may as well use a
> > memfd for passing the shared address space instead of trying to do and
> > maintain this complexity.
> > 
> > Your use case is only qemu, so what is the problem to replace the allocator
> > backing VM memory in userspace? Other people have been talking about
> > doing a memfd already for different reasons - and memfd can already be
> > shared as this scheme desires.
> 
> KSM doesn't work on shmem.
> Once you replace the allocator you render KSM useless.

I suspect making memfd to work with KSM will be much less hacky than
this.

> Figures out it can peek into any kind of memory involving pages.

No, this approach is really liminted to anonymous VMAs.

You might make some argument that VMA differences can be ignored if
they are all anonymous to start with, but certainly not once other
types are VMAs are included.

Jason
