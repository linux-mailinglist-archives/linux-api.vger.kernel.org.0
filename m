Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C025DA57
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgIDNrn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730651AbgIDNrL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 09:47:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB5C061247
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 06:39:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so4612214qtd.2
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y63H0eil7cRo4Z3Spspx32PZ0iMyNjkSmFBNpt+Ifzc=;
        b=ICshZPu87gxXRV7go1aGqkfsunf1FfCR+1VSRcVy2Jfz3Pt57eXImUODRxkivPv6Ao
         n2nx79VlpBPHr+gBU3n4+nFJPVFJl+Em8rtdGjq6x/+9gZP4mXcTkZ/ljUSnE7kwDPmB
         xaL+CMOMHlbTOnBWuegBbDcByLozg73il/uvBUTN3XCxlC1aKzKB0oDqFhEJ85jVhs0q
         ijqLbr1284NBoa3O/6PX3sOrNfx/RUdnDILVPlYxOQzxXn1AzSFzvBmqe4h4IFkxlsYO
         cRcC/RiUTXhHqkDFnQykKAOFqHCGYfdHujl/51OfyASEf+YEiOCOUJJmF8b+RGpIkONO
         pszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y63H0eil7cRo4Z3Spspx32PZ0iMyNjkSmFBNpt+Ifzc=;
        b=Fep/Dok2Q0bq7DSH9SLeBqmzh6C0B3Dhlqz/TVpay4TyCoSRfOsjfwBzVONVHKzd+3
         iJF6hQLQNzp/gbHuMwciV4YkIVcHDHFrBQrpl8zi+lVwqH/IzIcZXx8ZLtTqo3zp32q9
         orDzVT+h6P7C6VVBszqMqYijE1rpla0KrOuDlEcSU7gjqrnBp1yD9OgFRkcpPXt9CkTN
         QbDy//LUHKpSAnJBo7EJVPD7lcNDG4Mb+dmuZ+62JtcVh7cj3em+EeVPDttUd764MMuS
         P3Ao4Fw7sFNV5dGAa8xecqo1R5FJr1yErZMGi79scL9PgpuaWpBuGsZORK2yMhcQ/gNW
         TMLg==
X-Gm-Message-State: AOAM532s0EP7mZ6xalVn723T2T4B/AVK/qFo7j24mQjnLYct0e6BAOZD
        yEmk05SI7XwdDVAkrl6uD+JnGnO/IpF/WA==
X-Google-Smtp-Source: ABdhPJz4IYp9Yx0ptsdpwS3IyFtCg0MoRemzPNZPgMuvPTnjIWvlfGmsXRez56Ul+LW7plLhZ+wCXg==
X-Received: by 2002:ac8:1a52:: with SMTP id q18mr8853580qtk.274.1599226748978;
        Fri, 04 Sep 2020 06:39:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g64sm4384220qkf.71.2020.09.04.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:39:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kEBvn-007Wkb-Gn; Fri, 04 Sep 2020 10:39:07 -0300
Date:   Fri, 4 Sep 2020 10:39:07 -0300
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
Message-ID: <20200904133907.GS24045@ziepe.ca>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 01:24:43PM +0000, Mircea CIRJALIU - MELIU wrote:
> > On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Lazăr wrote:
> > > VMAs obtained by mmap()ing memory access fds mirror the contents of
> > > the remote process address space within the specified range. Pages are
> > > installed in the current process page tables at fault time and removed
> > > by the mmu_interval_notifier invalidate callbck. No further memory
> > management is involved.
> > > On attempts to access a hole, or if a mapping was removed by
> > > PIDFD_MEM_UNMAP, or if the remote process address space was reaped
> > by
> > > OOM, the remote mapping fault handler returns VM_FAULT_SIGBUS.
> > 
> > I still think anything along these lines needs to meet the XPMEM use cases as
> > well, we have to have more general solutions for such MM
> > stuff:
> > 
> > https://gitlab.com/hjelmn/xpmem
> > 
> > However, I think this fundamentally falls into some of the same bad direction
> > as xpmem.
> > 
> > I would much rather see this design copy & clone the VMA's than try to
> > mirror the PTEs inside the VMAs from the remote into a single giant VMA and
> > somehow split/mirror the VMA ops.
> 
> This design was made specifically for virtual machine introspection, where we 
> care more about the contents of the address space, rather than the remote VMAs
> and their vmops. (Right now only anon pages can be mapped, but I guess
> we can extend to pagecache pages as well.) I just used what seemed to be the
> common denominator to all page-related operations: range invalidation.
> This looks like a general solution.

The point is that a VMA is how the MM connects its parts together,
cloning the content of a VMA without the rest of the VMA meta-data is
just going to be very fragile in the long run.. 

Especially if the VMA is presented as a normal VMA with working struct
pages/etc, not a pfn map.

> IMO cloning a VMA in an address space that has a completely different layout
> will present its own set of caveats: What happens if the VMA resizes/splits? 
> Can you replay all the remote VMA vmops on the clone VMA?

The mirror would have to reclone the source VMA every time the source
VMA changes.

> > This is just too weird and fragile to be maintaible over a long term.
> > 
> > For instance, one of the major bugs in things like xpmem was that they are
> > incompatible with get_user_pages(), largely because of this issue.
> 
> We support get_user_pages(), that's how we integrate with KVM.

This seems really sketchy, get_user_pages is sensitive to the VMA,
what happens when VMA flags are different/etc?

Jason
