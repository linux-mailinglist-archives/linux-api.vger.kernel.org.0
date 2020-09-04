Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2F25E21A
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 21:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgIDTlu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 15:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbgIDTls (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 15:41:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6D2C061245
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 12:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3XphRgx8UKKTziy8WhApuAQLUL4SuQrn1if9cGELvRs=; b=vqK+QfWlRKK9hrJvyTRswgGBlV
        hzVazHMiNCIES6LUe9bW7PqML+xMmOg/NGa7yOpQijX5maK1FgQBa+f8Ld/u6JJqpjjv80hQVz2h1
        3hKDHNbW2vyr0FopJ78Uz7xXfwl6KP451GoFlAgBEwvxwunNpuFab3RfXjEN68YkSZzFta3XHDesB
        sVhynGxeOmiURZ87LT5cvDa14sTIkY55Zy/qAK2aPa4yIntYl7F9MvMhSs+YEgJjaiAimtqB6PjhY
        H0RSGlwtA//vVX9TYch4MkEnlx7p/5c/VjQ814dCElHO8Js5DFX/lnulI7bZhkg5otrFtiCThDDr9
        S88rL8hg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kEHad-00023O-WD; Fri, 04 Sep 2020 19:41:40 +0000
Date:   Fri, 4 Sep 2020 20:41:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200904194139.GA5881@casper.infradead.org>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904121148.GR24045@ziepe.ca>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 09:11:48AM -0300, Jason Gunthorpe wrote:
> On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Lazăr wrote:
> > VMAs obtained by mmap()ing memory access fds mirror the contents of the remote
> > process address space within the specified range. Pages are installed in the
> > current process page tables at fault time and removed by the mmu_interval_notifier
> > invalidate callbck. No further memory management is involved.
> > On attempts to access a hole, or if a mapping was removed by PIDFD_MEM_UNMAP,
> > or if the remote process address space was reaped by OOM, the remote mapping
> > fault handler returns VM_FAULT_SIGBUS.
> 
> I still think anything along these lines needs to meet the XPMEM use
> cases as well, we have to have more general solutions for such MM
> stuff:
> 
> https://gitlab.com/hjelmn/xpmem
> 
> However, I think this fundamentally falls into some of the same bad
> direction as xpmem.
> 
> I would much rather see this design copy & clone the VMA's than try to
> mirror the PTEs inside the VMAs from the remote into a single giant
> VMA and somehow split/mirror the VMA ops.

I'm on holiday for the next few days, but does the mshare() API work for
your use case?

Proposal: http://www.wil.cx/~willy/linux/sileby.html
Start at implementation:
http://git.infradead.org/users/willy/linux.git/shortlog/refs/heads/mshare

