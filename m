Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD925DBE6
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgIDOjN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgIDOjG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 10:39:06 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C6C061244
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 07:39:05 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id n10so4764320qtv.3
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wDmkQHwEcY2XRhrLIEh8Bubr2jk1fGPsnbn+CUF1gC0=;
        b=Hwm/hipxtv14300WHvMwkXx4tHR1WqhdtdLWGqKlllTJm6nYDPZCmS2XOBwC+XKKf1
         YtUaqZTjp1g9YRR9pHraQvgUDjDrPrRzoBvbA5xEIejDqfkxOfzpoCquqsPTohQaowEO
         1jbtwZIzJRgb/qERCNK5ZX+qcfPjuTL7YDJV9pD4z0Z7/EzNzvznvtW/V8AQ8m9fc0PS
         JMqTPQ1JkMbFMUwX4rvJmfh0/EQHgDrI/rx+LDv5KAnDD6wgkncIUXDf2QBP0UnCLjG/
         cMutfPXuEc3eM7fQGF940STrQcr407UrAvqmYZPzIQZb2Oe4gK0SVr5UkJngvETOWQLh
         KkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wDmkQHwEcY2XRhrLIEh8Bubr2jk1fGPsnbn+CUF1gC0=;
        b=d8Wzp+IPffajl7js5GGGZA7J4l72/LRjQDWb1MJJ5/lbPoeIAr+sk2PrZGIPVQg3Kf
         ChdmLNMxDG0B/1iRa+4Iw1KBCof7Bf8MRmnJAi0Jer/XZG7WitARZlk8t8mRpMOqBSYG
         /riC+A5U8IMl9060ERi2Gpqx8MKgAxEXyEN8izEhomYFHrLF8ZFt6j0Ulzb8mgFQWuqF
         i8oh7dCgqYI7Sz4UFR3GiC7/sZwRCN0Sh/QflydRIItnh8/t8/VkhvJOw09OIcYoHNi5
         InUY+nXqk5sr/qiMojXfQEDlrHHxILNB2gZsTVehnAlQAzjPdwr3Bljr00caogbdXjNT
         KDDg==
X-Gm-Message-State: AOAM531PtlFeqCCd35FRsXUaVIKgCrGRpAdULLpoNFtXWhJrTcvuOAk4
        5vL8gTSSeUcRCD4XgcdCfv+arw==
X-Google-Smtp-Source: ABdhPJx2gfE56WEtnLuU3mS+tp1h1ay/F6XI1JmBGe3AskxgKplYS+YyVe+ew4QvzZ8paoG2uOBVWQ==
X-Received: by 2002:aed:3461:: with SMTP id w88mr8847483qtd.180.1599230344762;
        Fri, 04 Sep 2020 07:39:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l19sm4791162qtu.16.2020.09.04.07.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 07:39:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kECrn-007eyn-Gz; Fri, 04 Sep 2020 11:39:03 -0300
Date:   Fri, 4 Sep 2020 11:39:03 -0300
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
Message-ID: <20200904143903.GT24045@ziepe.ca>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904121148.GR24045@ziepe.ca>
 <AM7PR02MB60824E11A81A63A7CE94848CBB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
 <20200904133907.GS24045@ziepe.ca>
 <AM7PR02MB6082B1192A87C027DE2FD668BB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM7PR02MB6082B1192A87C027DE2FD668BB2D0@AM7PR02MB6082.eurprd02.prod.outlook.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 02:18:37PM +0000, Mircea CIRJALIU - MELIU wrote:
> > This seems really sketchy, get_user_pages is sensitive to the VMA, what
> > happens when VMA flags are different/etc?
> 
> A debugger shouldn't complain if a portion of the debuggee is read-only,
> just overwrite the data.

At this point the kernel API here is so incredibly limited you may as
well use a memfd for passing the shared address space instead of
trying to do and maintain this complexity.

Your use case is only qemu, so what is the problem to replace the
allocator backing VM memory in userspace? Other people have been
talking about doing a memfd already for different reasons - and memfd
can already be shared as this scheme desires.

Jason
