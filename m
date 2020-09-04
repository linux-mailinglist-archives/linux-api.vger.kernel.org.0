Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15A25D872
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 14:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgIDMLz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 08:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbgIDMLv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 08:11:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AE7C061244
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 05:11:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b3so4326557qtg.13
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o1zM0HomSRa3Af0Z+HovFGcU3tJp/Xd+knAzR2m42KM=;
        b=i2mJ0buDsLn1kST0TMjkPu8wwBpnMWvfg9036VDlPu7J8p5rNRlDbBdFW3A8kEL/1A
         DQXjOTieNpm/iAfeoSNJVIywwIREPpaMqReBt9RdpJvO5JjdaNth9LKV1OhWxYtzO5pc
         nHCjbyAhk8AweDfxVb6MWItE2HG+dbVkkLP/MWSogXAGqfUw+MJH+NkVZqMKLlwq9JG5
         VjkKj5zgPAq+kvZqALpxHz9QwxOt8GDK2fJbezDz/uKUHeVXQUxFf86uMDRC4v3HuZLV
         WWgxX1r+dxppAqC+EY90rRnSSUsbfhKdsUczvTo04b/TVBm2wMwSJPA2vX4x7fXi7p0S
         51Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o1zM0HomSRa3Af0Z+HovFGcU3tJp/Xd+knAzR2m42KM=;
        b=QQGWnqX/wHuOvlG6FkZauI9eIR8pqjZzTHseSRD1xAOq4qAQhHbrmyOmHHBh4fdAi0
         1pywQHbl2P/ARtG2Mm7KR7WXiR7OoGxEtRoIsOzADh+xhUHCKQKTQWvUFmH6AKtYkCa1
         mw3KHCCOCeGcd8GpU7VrZqTMldRQaL+mQdOrHjshO7fe4FwRkv892QfH5QWubHWz4Sqj
         dyb7qFD0RF3Pb7mauw6xphvkEGUx55GVSQxJXbADC0DBixBEoHkTLSBIeevc1nsJw1HD
         VpZzKiN+PULhGTz0DHnSa9y5AGtd6jbOEZN3LnSoD6WFHKnfmeu03M8USzhJ8yMuoEMg
         MNwQ==
X-Gm-Message-State: AOAM530y1vfgjHX02At8BGd1fDflNRM8ogLRGr6coOYpWNuq3TgboXzK
        wUEiKDFzOdyzTiv+FUIqsgStbQ==
X-Google-Smtp-Source: ABdhPJxpoOENgxYhhXZk9mQZVPa0xVYtQJ/sp+/RXtdpjkWoZCUtCcG0Pmz6D078Mk6ACNpkrDsCoQ==
X-Received: by 2002:ac8:1667:: with SMTP id x36mr8270759qtk.51.1599221510189;
        Fri, 04 Sep 2020 05:11:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l95sm4292631qte.36.2020.09.04.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:11:49 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kEAZI-007IGM-Rb; Fri, 04 Sep 2020 09:11:48 -0300
Date:   Fri, 4 Sep 2020 09:11:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
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
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200904121148.GR24045@ziepe.ca>
References: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Lazăr wrote:
> VMAs obtained by mmap()ing memory access fds mirror the contents of the remote
> process address space within the specified range. Pages are installed in the
> current process page tables at fault time and removed by the mmu_interval_notifier
> invalidate callbck. No further memory management is involved.
> On attempts to access a hole, or if a mapping was removed by PIDFD_MEM_UNMAP,
> or if the remote process address space was reaped by OOM, the remote mapping
> fault handler returns VM_FAULT_SIGBUS.

I still think anything along these lines needs to meet the XPMEM use
cases as well, we have to have more general solutions for such MM
stuff:

https://gitlab.com/hjelmn/xpmem

However, I think this fundamentally falls into some of the same bad
direction as xpmem.

I would much rather see this design copy & clone the VMA's than try to
mirror the PTEs inside the VMAs from the remote into a single giant
VMA and somehow split/mirror the VMA ops.

This is just too weird and fragile to be maintaible over a long
term.

For instance, one of the major bugs in things like xpmem was that they
are incompatible with get_user_pages(), largely because of this issue.

I feel like I said this already..

Jason
