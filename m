Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CA438052F
	for <lists+linux-api@lfdr.de>; Fri, 14 May 2021 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhENI3I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 May 2021 04:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhENI3H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 May 2021 04:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620980876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1mI4ocY2raC+FaNmp1QLwbvQ7SwKQVD3QJeG7UD1jEM=;
        b=SoJsFqQTNvxWOrB82XHKxHgyrVNqEOdvmRLKtCDUgsH8urgdQY9+Yp58aCeZ3Ff3QPW7jg
        BuRBlw3qKf5mk9rFupuMjlmiDlEoUkexGirBRHq1TBNb3O+BKxCzJHOJHLRAnfpFZV0gdH
        I7ZxjfGVyTWMuvsSfFoo09+Bj78EKko=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-kdsuEYEwMGmlaCyzjq0KLQ-1; Fri, 14 May 2021 04:27:55 -0400
X-MC-Unique: kdsuEYEwMGmlaCyzjq0KLQ-1
Received: by mail-ed1-f70.google.com with SMTP id y15-20020aa7d50f0000b02903885ee98723so15923792edq.16
        for <linux-api@vger.kernel.org>; Fri, 14 May 2021 01:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1mI4ocY2raC+FaNmp1QLwbvQ7SwKQVD3QJeG7UD1jEM=;
        b=hVlyFC4zQDTB+mK7mo8vt12Xl6epiiXFT2LOvwX0AUWJMdSpkhMPrUSON5/o7Ct0Wv
         fcBwNHetP1tBak+QfY0snzMmMHfVD7I21v6pcNodXb4ViB+Y1Y+IEiXitECH2PtUfDm+
         wSriNe7ePvoZuqzjdS8og3Yms6N1HDCLllLKeIbQjQOfzIhZBZWHBmv9g3MnTTU5wA6x
         0PHZ5e/f7l9m781m+YVKF/CrHwWliyTPd1ke6Bz5WRIKg6A4GhroKXnX+k1V6xBEpkFG
         UgOGw5RmW1OZejRR0efUouawT3rO8Oh/dVFAavoh5HT6N3AadAPkw9jjy5BoX/qDW28d
         PqgA==
X-Gm-Message-State: AOAM531SFyOzr8H8wYndTeAu+x3iAur3iZQmYrfjuUm9NgSHZv1fIDzW
        y8TV/KH4uJptGOsp4W2U+ttgzMctt8zGP58I5+GbJAOjkgfDFgYFLcqxUzxvJ7la6X5H4ON/ghI
        qudOqVelX8Hv/UMfePtq7
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr5726985ejb.246.1620980874023;
        Fri, 14 May 2021 01:27:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYM3IfGE3NxrG0ZrIWpmGkbHrM02LfrvrKJb1wjjik/A6PZcbISFg2IAai8LzSK6j7yfSBCQ==
X-Received: by 2002:a17:907:2136:: with SMTP id qo22mr5726935ejb.246.1620980873769;
        Fri, 14 May 2021 01:27:53 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id z26sm3292663ejl.38.2021.05.14.01.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 01:27:53 -0700 (PDT)
Subject: Re: [PATCH v19 1/8] mmap: make mlock_future_check() global
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <8bb6ca25-5d30-70e6-c590-5930832ec9b2@redhat.com>
Date:   Fri, 14 May 2021 10:27:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.05.21 20:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> It will be used by the upcoming secret memory implementation.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christopher Lameter <cl@linux.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Cc: Hagen Paul Pfeifer <hagen@jauu.net>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Tycho Andersen <tycho@tycho.ws>
> Cc: Will Deacon <will@kernel.org>
> ---
>   mm/internal.h | 3 +++
>   mm/mmap.c     | 5 ++---
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 54bd0dc2c23c..46eb82eaa195 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -373,6 +373,9 @@ static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
>   extern void mlock_vma_page(struct page *page);
>   extern unsigned int munlock_vma_page(struct page *page);
>   
> +extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> +			      unsigned long len);
> +
>   /*
>    * Clear the page's PageMlocked().  This can be useful in a situation where
>    * we want to unconditionally remove a page from the pagecache -- e.g.,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 0584e540246e..81f5595a8490 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1352,9 +1352,8 @@ static inline unsigned long round_hint_to_min(unsigned long hint)
>   	return hint;
>   }
>   
> -static inline int mlock_future_check(struct mm_struct *mm,
> -				     unsigned long flags,
> -				     unsigned long len)
> +int mlock_future_check(struct mm_struct *mm, unsigned long flags,
> +		       unsigned long len)
>   {
>   	unsigned long locked, lock_limit;
>   
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

