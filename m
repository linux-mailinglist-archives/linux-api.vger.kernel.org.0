Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB816C2B3
	for <lists+linux-api@lfdr.de>; Tue, 25 Feb 2020 14:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgBYNsg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Feb 2020 08:48:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:46416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYNsg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 25 Feb 2020 08:48:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDF33AD03;
        Tue, 25 Feb 2020 13:48:33 +0000 (UTC)
Subject: Re: [PATCH v7 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
To:     Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
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
        mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>
References: <20200221174248.244748-1-bgeffon@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABtCBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PokCVAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJcbbyGBQkH8VTqAAoJECJPp+fMgqZkpGoP
 /1jhVihakxw1d67kFhPgjWrbzaeAYOJu7Oi79D8BL8Vr5dmNPygbpGpJaCHACWp+10KXj9yz
 fWABs01KMHnZsAIUytVsQv35DMMDzgwVmnoEIRBhisMYOQlH2bBn/dqBjtnhs7zTL4xtqEcF
 1hoUFEByMOey7gm79utTk09hQE/Zo2x0Ikk98sSIKBETDCl4mkRVRlxPFl4O/w8dSaE4eczH
 LrKezaFiZOv6S1MUKVKzHInonrCqCNbXAHIeZa3JcXCYj1wWAjOt9R3NqcWsBGjFbkgoKMGD
 usiGabetmQjXNlVzyOYdAdrbpVRNVnaL91sB2j8LRD74snKsV0Wzwt90YHxDQ5z3M75YoIdl
 byTKu3BUuqZxkQ/emEuxZ7aRJ1Zw7cKo/IVqjWaQ1SSBDbZ8FAUPpHJxLdGxPRN8Pfw8blKY
 8mvLJKoF6i9T6+EmlyzxqzOFhcc4X5ig5uQoOjTIq6zhLO+nqVZvUDd2Kz9LMOCYb516cwS/
 Enpi0TcZ5ZobtLqEaL4rupjcJG418HFQ1qxC95u5FfNki+YTmu6ZLXy+1/9BDsPuZBOKYpUm
 3HWSnCS8J5Ny4SSwfYPH/JrtberWTcCP/8BHmoSpS/3oL3RxrZRRVnPHFzQC6L1oKvIuyXYF
 rkybPXYbmNHN+jTD3X8nRqo+4Qhmu6SHi3Vq
Message-ID: <61fc2045-b5fd-86b4-9092-e7638ad63b1e@suse.cz>
Date:   Tue, 25 Feb 2020 14:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221174248.244748-1-bgeffon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2/21/20 6:42 PM, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. The remap operation
> will be performed as it would have been normally by moving over the
> page tables to the new mapping. The old vma will have any locked
> flags cleared, have no pagetables, and any userfaultfds that were
> watching that range will continue watching it.
> 
> For a mapping that is shared or not anonymous, MREMAP_DONTUNMAP will cause
> the mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> a VMA you MUST use the MREMAP_MAYMOVE flag, it's not possible to resize
> a VMA while also moving with MREMAP_DONTUNMAP so old_len must always
> be equal to the new_len otherwise it will return -EINVAL.
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
>   v6 -> v7:
>     - Don't allow resizing VMA as part of MREMAP_DONTUNMAP.
>       There is no clear use case at the moment and it can be added
>       later as it simplifies the implementation for now.
> 
>   v5 -> v6:
>     - Code cleanup suggested by Kirill.
> 
>   v4 -> v5:
>     - Correct commit message to more accurately reflect the behavior.
>     - Clear VM_LOCKED and VM_LOCKEDONFAULT on the old vma.
>            
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Reviewed-by: Minchan Kim <minchan@kernel.org>
> Tested-by: Lokesh Gidra <lokeshgidra@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks.

> diff --git a/mm/mremap.c b/mm/mremap.c
> index 1fc8a29fbe3f..8b7bf3845e50 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  static unsigned long move_vma(struct vm_area_struct *vma,
>  		unsigned long old_addr, unsigned long old_len,
>  		unsigned long new_len, unsigned long new_addr,
> -		bool *locked, struct vm_userfaultfd_ctx *uf,
> -		struct list_head *uf_unmap)
> +		bool *locked, unsigned long flags,
> +		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)

The usage of MREMAP_DONTUNMAP directly in the "flags" parameter seems
weird for generically named vma manipulation functions, but as they are
all local to mremap.c then it's probably fine.

