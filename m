Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98785165025
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 21:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBSUj5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 15:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSUj5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 19 Feb 2020 15:39:57 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8F4207FD;
        Wed, 19 Feb 2020 20:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582144796;
        bh=gj9va7+1ssiR0Xq4OizFiIrAex7E8V70tSOCZY9+oDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NxlUqyv+fP3skS7WtpxyG29P3a790L+lksyrIFK4+YwGWx7ELvnqgppw4cSVAdA+t
         MGDVjrnS6IyRW0LUTw5spQTy9SaK15ZgXVEQXfBX2oYS5YBhHKcOjM4RPUuP8cO2vl
         2nQVih708J1LGBOrXgqsSrBP0q7zvzeWunk8YrGs=
Date:   Wed, 19 Feb 2020 12:39:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        lokeshgidra@google.com
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-Id: <20200219123955.dc97c43524d6e6ab92722650@linux-foundation.org>
In-Reply-To: <20200218173221.237674-1-bgeffon@google.com>
References: <20200218173221.237674-1-bgeffon@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 18 Feb 2020 09:32:20 -0800 Brian Geffon <bgeffon@google.com> wrote:

> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. The remap operation
> will be performed as it would have been normally by moving over the
> page tables to the new mapping. The old vma will have any locked
> flags cleared, have no pagetables, and any userfaultfds that were
> watching that range will continue watching it.
> 
> For a mapping that is shared or not anonymous, MREMAP_DONTUNMAP will cause
> the mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> a VMA you MUST use the MREMAP_MAYMOVE flag. The final result is two
> equally sized VMAs where the destination contains the PTEs of the source.
> 
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

Thanks.

We're a bit thin on review activity on this one.  Has Lokesh been able
to review and preferably test the code?  Are you able to identify other
potential users?  perhaps even glibc?
