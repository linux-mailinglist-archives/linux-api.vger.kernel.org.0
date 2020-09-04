Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3BA25E22C
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 21:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgIDTtQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 15:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIDTtQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 15:49:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51838C061244
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 12:49:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so7503310qkj.7
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wlp5eq0L4jf0fV1dZhNQXxwrYrnlfBr1ejU/Wv6GFRE=;
        b=dukJUYr81zmJLJUq/pSBUq9knB3bs5cVV7IdVU+zFjBm0RI3v5y9t5zYBXwNDChKum
         +sJ/Xp3y45b6rmrsS1B3T/3Za7B56UHjMUG5Q58BgF7a3FTZBOFsopO87a8ply+So4OT
         Dty7MuUow8EoYwyWxZ5pbV+mhDVSNKl71gPorUkDXYtIx737bmRAgxkaqGOeCfQJin6h
         gt78V7U8E8qUQnc97Ho5MK8GKp0GIpUQBKSEMQXp59ISDoFWzxb+cIOTO2HTJQ4pYR34
         EaK3WYBENHr+ZYWXFZ4LUw5TfhaMw9oE20M+pYJbOYL8Ju7GsZtnjzmbdjBR25RUTKh7
         UfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wlp5eq0L4jf0fV1dZhNQXxwrYrnlfBr1ejU/Wv6GFRE=;
        b=bpBh60BPkIhRXgOd4XPAnlWhcPxDmYA76AUlc6q/W4ViDBeiklNvKP3wzDANrzjjPh
         lq30EZ8jcgxHAmQITGeEwKIp0VElaa/KkLZcyH1Lcjs8KNMUhQY+LBK6Yi9Z6xWbjnpO
         HOGcRWDRkdqnjOj4M5aci464uTSx4FZAh49FW56OF4FwIp2srItJ1DahNsAeHtfU5R/O
         rCl/Ftaf1Q2Df1zdEvZgCWOLnrtBJvAmg8dZirhgm0ESraPazV+9aqVAWaBfWo73DnD1
         f1VqwSLyMYJ1Z10Qxab6lm9ott+UlGtJFiYNv0qs8qiPI1t54+45tjfiXpVk7v8Qrmkc
         MeWw==
X-Gm-Message-State: AOAM530baqqZNDq2nyrT2dH6ZzWAnrBBuRufE14YNqQwATZ1iAfatO2c
        lUIJO3fCW4kfCU8Y+1ceHgt/dA==
X-Google-Smtp-Source: ABdhPJwOjyB3sB4YRkZQ0ZL+RtGFS9Bz0C/TP12GqAsX1WiYNNC8MVUuTcOSB7KvXJpNMwoAUxuu+g==
X-Received: by 2002:a37:6109:: with SMTP id v9mr9321198qkb.418.1599248953730;
        Fri, 04 Sep 2020 12:49:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y7sm5333481qtn.11.2020.09.04.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 12:49:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kEHhv-0014CU-Rm; Fri, 04 Sep 2020 16:49:11 -0300
Date:   Fri, 4 Sep 2020 16:49:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20200904194911.GA87483@ziepe.ca>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <20200904194139.GA5881@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904194139.GA5881@casper.infradead.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 08:41:39PM +0100, Matthew Wilcox wrote:
> On Fri, Sep 04, 2020 at 09:11:48AM -0300, Jason Gunthorpe wrote:
> > On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Lazăr wrote:
> > > VMAs obtained by mmap()ing memory access fds mirror the contents of the remote
> > > process address space within the specified range. Pages are installed in the
> > > current process page tables at fault time and removed by the mmu_interval_notifier
> > > invalidate callbck. No further memory management is involved.
> > > On attempts to access a hole, or if a mapping was removed by PIDFD_MEM_UNMAP,
> > > or if the remote process address space was reaped by OOM, the remote mapping
> > > fault handler returns VM_FAULT_SIGBUS.
> > 
> > I still think anything along these lines needs to meet the XPMEM use
> > cases as well, we have to have more general solutions for such MM
> > stuff:
> > 
> > https://gitlab.com/hjelmn/xpmem
> > 
> > However, I think this fundamentally falls into some of the same bad
> > direction as xpmem.
> > 
> > I would much rather see this design copy & clone the VMA's than try to
> > mirror the PTEs inside the VMAs from the remote into a single giant
> > VMA and somehow split/mirror the VMA ops.
> 
> I'm on holiday for the next few days, but does the mshare() API work for
> your use case?
>
> Proposal: http://www.wil.cx/~willy/linux/sileby.html
> Start at implementation:
> http://git.infradead.org/users/willy/linux.git/shortlog/refs/heads/mshare

Let me ask around, it seems in a similar space at least!

Thanks,
Jason
 
