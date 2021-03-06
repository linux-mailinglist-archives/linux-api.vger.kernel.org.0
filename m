Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1401932F76D
	for <lists+linux-api@lfdr.de>; Sat,  6 Mar 2021 02:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhCFBNk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Mar 2021 20:13:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhCFBNe (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 5 Mar 2021 20:13:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB11065090;
        Sat,  6 Mar 2021 01:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614993212;
        bh=Uw04knjc4xx7x3agCMeJqcaVgzDCRD/JHNyGNt2bGIo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rrlGcLV/iQuL/RnkUBIctgDo4IL+sqJKuHHI4vEq4GFnEbK3eyG1IqxAyw7/zgEz9
         nU5nMBl4w1rrPU7gGUUlbEqAcdSs3F70xqpBKKXrWvsKNbDxNi14tl1Ox5rzZUNeMe
         CQKDNhM+a6qFcgTMALZwXLbxY/DRWmlzQBksg1rU=
Date:   Fri, 5 Mar 2021 17:13:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Vlad Rezki <urezki@gmail.com>
Subject: Re: [PATCH v3] mm/vmalloc: randomize vmalloc() allocations
Message-Id: <20210305171331.2424b166ed4d2d9da73ac335@linux-foundation.org>
In-Reply-To: <20210215202634.5121-1-toiwoton@gmail.com>
References: <20210215202634.5121-1-toiwoton@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 15 Feb 2021 22:26:34 +0200 Topi Miettinen <toiwoton@gmail.com> wrote:

> Memory mappings inside kernel allocated with vmalloc() are in
> predictable order and packed tightly toward the low addresses, except
> for per-cpu areas which start from top of the vmalloc area. With
> new kernel boot parameter 'randomize_vmalloc=1', the entire area is
> used randomly to make the allocations less predictable and harder to
> guess for attackers. Also module and BPF code locations get randomized
> (within their dedicated and rather small area though) and if
> CONFIG_VMAP_STACK is enabled, also kernel thread stack locations.
> 
> On 32 bit systems this may cause problems due to increased VM
> fragmentation if the address space gets crowded.
> 
> On all systems, it will reduce performance and increase memory and
> cache usage due to less efficient use of page tables and inability to
> merge adjacent VMAs with compatible attributes. On x86_64 with 5 level
> page tables, in the worst case, additional page table entries of up to
> 4 pages are created for each mapping, so with small mappings there's
> considerable penalty.
>
> ...
>

How useful is this expected to be?  What sort of attack scenarios will
this help to defend against?

And what do others think of the proposal?
