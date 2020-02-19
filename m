Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC4165309
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 00:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgBSXXN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Feb 2020 18:23:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42666 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSXXM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Feb 2020 18:23:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so868514pfz.9;
        Wed, 19 Feb 2020 15:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CeoKC7hzC6I62gTM+Mhw7YfGVER9ZVRo7JdMhdNPmSk=;
        b=Cfn8V0YciBTXAuwpgcp6rJ1RRQWQ8YESs/k45IyinbQAtZtOm98ulE4qaSflYZd7sl
         eywfyM46Y1P2n8SwDF1GidyApN6qI1rhNuAY1yOun/lyTDQAOc8V9KBHQNDycGniKiW7
         1QHYPhY6hl/Sk8H2xcKnPJZVeHhhbF7evCksyKBIr6HqXEixSVZ3z1yqy7XkNHTVLnoP
         9uEdM0hEDV5JdaI/2ncUBOfVa2z30hrBiLFjkfSBt4i4k0DIfGfQbQWzjYdjj5aoMRCF
         5mVtod5EaNgCVF9gs2hmSmUyzTnVkTtBN9Vi903hiwAzzycvFDblncNDP14qPOmIeOVh
         jgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CeoKC7hzC6I62gTM+Mhw7YfGVER9ZVRo7JdMhdNPmSk=;
        b=bCf4ND02/X4yjNOQ09cwtSpuBLihtrd31ztz8mg1L8oJEEgQlkt2XKLyqYh3uiWwHH
         fUdyt/J4DkFwyDlkHASuL7+F1opZGgNMDhNQ05ssVAG7ZfKOc8Qy4w3aCxTHx7IHYjPg
         CiHL9q/9PVuYknyGCH6XbUKjUkDc8EJZaKUAkz2Ul4A+fmpZI69Itpwi1dg1eQwKT2DF
         Vle9aAKlw1JS7exkOkeR8323w1EOZn9cUEi0PFDzyfwmu5u+uL8CNwAo2Dp6VytcPkPU
         bgHT2l6PXuV949Rcf9MQ/4O7jTg/vL5MoEBGKNnXwzO3M/043IPwfKXbQWABuf3KByUm
         DNDA==
X-Gm-Message-State: APjAAAVvvvzPVQNYFJktkOm6/LWaZeJR/8eat9JLVPPrR4ex9fJerrJf
        4aYIr+ET5pvxef6azor/rEM=
X-Google-Smtp-Source: APXvYqzYVMfv/pKmDoOIvzEuKdD1kuiEsw68gFp/0c+G+WPa4VaIT2FxxcWcsbL/yOnHnbRu8/lxVQ==
X-Received: by 2002:aa7:820d:: with SMTP id k13mr30135749pfi.10.1582154592037;
        Wed, 19 Feb 2020 15:23:12 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id w11sm717199pfn.4.2020.02.19.15.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 15:23:11 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:23:09 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v6 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200219232309.GB148976@google.com>
References: <20200218173221.237674-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200218173221.237674-1-bgeffon@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 09:32:20AM -0800, Brian Geffon wrote:
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
> 
>   v5 -> v6:
>     - Code cleanup suggested by Kirill.
> 
>   v4 -> v5:
>     - Correct commit message to more accurately reflect the behavior.
>     - Clear VM_LOCKED and VM_LOCKEDONFAULT on the old vma.
>            
> Signed-off-by: Brian Geffon <bgeffon@google.com>

Description and implemenation looks clean/sane for me.

Reviewed-by: Minchan Kim <minchan@kernel.org>

When I review the patch, it seems to be broken with lots of "=20", not
sure it's my mail client problem or yours. Anyway, please double check
it.

Thanks.
