Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD739149D23
	for <lists+linux-api@lfdr.de>; Sun, 26 Jan 2020 23:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgAZWGr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 26 Jan 2020 17:06:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37385 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgAZWGr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 26 Jan 2020 17:06:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so4906467lfc.4
        for <linux-api@vger.kernel.org>; Sun, 26 Jan 2020 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bIjpqXTvBSR6objHCm0IzTR/hQ3TPrKkme7EJy7SinQ=;
        b=vd7wN7vaZJfsftvGGeIdYEwGAd4ISoPUjH4z/airo4c26P52SSKuDuY4RS0FCTd3jk
         KGJuozw/CRaeDQ8RBJpp+oWUfc2eDnUbiMFkXFrBXbs5ojteYSba/dGN1A/1KxD1aEzs
         kwJfOZOp2vtTZ1sI5xIYQJlNEmUxEGX6JXv4Xurm4zHypuUTquU8mvoaBx/394qcnVUj
         RzzbO3aM80carMr02Nqzb6oeiw1Uu4+S5GWqP8R0NK6qJX9IlkQ0sONrEey8uSOh9ukr
         a/5FajX0UzsqgSnvcxbbzkeC25sud1T/2dcmQXy0fbovFOy/mw4wm/rc/xExEVA6kt85
         nmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIjpqXTvBSR6objHCm0IzTR/hQ3TPrKkme7EJy7SinQ=;
        b=ROa1yIyLyEtVXlHJuTTPkm4o6+M+ejb3PuyilJr/DOPOHgRiphtw02krYUJM+W8cCO
         QpI7V1l/s0Sm9cCifRrxsvb/cDAt88kRtl5r4dUWbcPxLthae+Yg+1LnO/nOT+h7fUSv
         irfkc6vHcF52PfyqCUwHSvKm82j82DfJxtNRrFoZ5SxkYuqTe7lX4gXS2JmEmyWvNArM
         gWfCjcUxAuYgthn/LoZwsBar9V33SdoyyNwH92FdO/H7MSUMaeyfYgGCNlTTXaih2jlw
         4KTHjxBwo6btUY15eR8ueOZQHbsk+3sCcpN9HAq33AsED75f026JTTa6XQBA9z1pnFrh
         xcHw==
X-Gm-Message-State: APjAAAXe34gWUD1gLLdCp65qydlfnOgLjFJE6I6/Nf4RezvCGKTg04vP
        kYRT9ELzoMGQQa/9DwN+OvVvKw==
X-Google-Smtp-Source: APXvYqzcewzG3j/TNt2F5XioQ+wUekZmF3eUnjfjLtEYPRrWC1YWX5O7aKsWt9YIO7SAizSUaGlpNQ==
X-Received: by 2002:a19:4855:: with SMTP id v82mr6199593lfa.197.1580076405722;
        Sun, 26 Jan 2020 14:06:45 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w20sm7129060ljo.33.2020.01.26.14.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 14:06:44 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0082B100301; Mon, 27 Jan 2020 01:06:50 +0300 (+03)
Date:   Mon, 27 Jan 2020 01:06:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200126220650.i4lwljpvohpgvsi2@box>
References: <20200123014627.71720-1-bgeffon@google.com>
 <20200124190625.257659-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124190625.257659-1-bgeffon@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 24, 2020 at 11:06:25AM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.  If a userfaultfd was watching
> the source, it will continue to watch the new mapping.  For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
> also used.

Implies? From code it looks like it requires MREMAP_FIXED. And
MREMAP_FIXED requires MREMAP_MAYMOVE. That's strange flag chaining.
I don't really see need in such dependencies. It maybe indeed implied, not
requied.

> The final result is two equally sized VMAs where the
> destination contains the PTEs of the source.

Could you clarify rmap situation here? How the rmap hierarchy will look
like before and after the operation. Can the new VMA merge with the old
one? Sounds fishy to me.

> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
> 
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."

-- 
 Kirill A. Shutemov
