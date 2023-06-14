Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C377E72F862
	for <lists+linux-api@lfdr.de>; Wed, 14 Jun 2023 10:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243890AbjFNIwI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jun 2023 04:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243791AbjFNIvr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jun 2023 04:51:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B61FC8
        for <linux-api@vger.kernel.org>; Wed, 14 Jun 2023 01:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686732640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HJaR5Vd/9JW0NW0jYiNZu8AUcFpeksRgJUrDG804Cew=;
        b=QHbxbCckLGsed+JFNt5XIxkkujV1THNxwIu+9syBs0cueYrbdFuBHqincK4iZvuB5DtQCn
        fUHVcwHIl88nsd4CE4jlG7Swp3sd3BH78O2vKB3cPk0CnIdqp4ypFsS6fStJ0Gcf26EGGO
        MagZi67ZLUPNX30DT3/HQ2xnYjBz2lc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-bE9vFTyFNTaKUsaC56vbDA-1; Wed, 14 Jun 2023 04:50:38 -0400
X-MC-Unique: bE9vFTyFNTaKUsaC56vbDA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f7f4dc6ec2so3606175e9.0
        for <linux-api@vger.kernel.org>; Wed, 14 Jun 2023 01:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732637; x=1689324637;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJaR5Vd/9JW0NW0jYiNZu8AUcFpeksRgJUrDG804Cew=;
        b=jcGFEOcA1g4VMV7ibrVAyrs9q/rkVDYtbb/v8ysi57A6LqCKhDGepPmcAJPRSi2Iy1
         UffIzRcnVDgW4OdhjerZeDvR/s6/fRZo1MXYUjq430ADcTDqEEJnTkhRZMZc6nwQ1Xo4
         sQi+COKRfICcy8WJ0l2NRhh9kcvNBSVa/zmU6T42SD6CwYvMt0Edbo3RfJuDMK5HYVss
         DYPteEtwJE9S2GfVGDeEPB7dRHVRlvLaJny/w/wBxKoAegPk9N/R4v7cmN1dulLBTkIF
         W2ifjO3/7LbesxomAEMuuBvi0kUbZHSScUSvQ9uYxWzClWSrHA0UJKp/5pnoLbMJYmQ+
         9kJg==
X-Gm-Message-State: AC+VfDwZZ/duUdngMDJePZ66jkjIRD8dZ3ffecNvhJRsIk3J4ggwMMRU
        QSBV+5gagLU6iWW7rMfz/3csfYdjx9Do90GURPx9ZGWqQhXWOVpeNsLbOfzgA+NtsU1AdnHmV1s
        woVpGu+ONg4QSUww+RphW
X-Received: by 2002:a7b:ca55:0:b0:3f8:1b4b:bd13 with SMTP id m21-20020a7bca55000000b003f81b4bbd13mr6322831wml.20.1686732637288;
        Wed, 14 Jun 2023 01:50:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6GW/YLOQGF4QzFEcbvIwVImxYPULU1Owp7RiYxkgnp7L2Y4w+g6T2tmVS8Psfxf8hHira/QQ==
X-Received: by 2002:a7b:ca55:0:b0:3f8:1b4b:bd13 with SMTP id m21-20020a7bca55000000b003f81b4bbd13mr6322791wml.20.1686732637000;
        Wed, 14 Jun 2023 01:50:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0030e5ccaec84sm17746027wrz.32.2023.06.14.01.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:50:36 -0700 (PDT)
Message-ID: <61027367-695b-65ae-3f39-7b59c1e05bc5@redhat.com>
Date:   Wed, 14 Jun 2023 10:50:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 14/42] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-15-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613001108.3040476-15-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.06.23 02:10, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> New hardware extensions implement support for shadow stack memory, such
> as x86 Control-flow Enforcement Technology (CET). Add a new VM flag to
> identify these areas, for example, to be used to properly indicate shadow
> stack PTEs to the hardware.
> 
> Shadow stack VMA creation will be tightly controlled and limited to
> anonymous memory to make the implementation simpler and since that is all
> that is required. The solution will rely on pte_mkwrite() to create the
> shadow stack PTEs, so it will not be required for vm_get_page_prot() to
> learn how to create shadow stack memory. For this reason document that
> VM_SHADOW_STACK should not be mixed with VM_SHARED.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> ---
>   Documentation/filesystems/proc.rst | 1 +
>   fs/proc/task_mmu.c                 | 3 +++
>   include/linux/mm.h                 | 8 ++++++++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 7897a7dafcbc..6ccb57089a06 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -566,6 +566,7 @@ encoded manner. The codes are the following:
>       mt    arm64 MTE allocation tags are enabled
>       um    userfaultfd missing tracking
>       uw    userfaultfd wr-protect tracking
> +    ss    shadow stack page
>       ==    =======================================
>   
>   Note that there is no guarantee that every flag and associated mnemonic will
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 420510f6a545..38b19a757281 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -711,6 +711,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>   #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>   		[ilog2(VM_UFFD_MINOR)]	= "ui",
>   #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +		[ilog2(VM_SHADOW_STACK)] = "ss",
> +#endif
>   	};
>   	size_t i;
>   
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6f52c1e7c640..fb17cbd531ac 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -319,11 +319,13 @@ extern unsigned int kobjsize(const void *objp);
>   #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
>   #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
>   #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
> +#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
>   #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
>   #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
>   #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
>   #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
>   #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
>   #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>   
>   #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -339,6 +341,12 @@ extern unsigned int kobjsize(const void *objp);
>   #endif
>   #endif /* CONFIG_ARCH_HAS_PKEYS */
>   
> +#ifdef CONFIG_X86_USER_SHADOW_STACK
> +# define VM_SHADOW_STACK	VM_HIGH_ARCH_5 /* Should not be set with VM_SHARED */
> +#else
> +# define VM_SHADOW_STACK	VM_NONE
> +#endif
> +
>   #if defined(CONFIG_X86)
>   # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
>   #elif defined(CONFIG_PPC)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

