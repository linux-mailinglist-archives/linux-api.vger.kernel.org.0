Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA9C69DC50
	for <lists+linux-api@lfdr.de>; Tue, 21 Feb 2023 09:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233624AbjBUInT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Feb 2023 03:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjBUInM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Feb 2023 03:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B7923C79
        for <linux-api@vger.kernel.org>; Tue, 21 Feb 2023 00:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676968939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLJIC/RrvVE7PdqmcHdwOf29lNkhzpC8wWHN3DTeCNY=;
        b=aPzBOSijiMtExbhqRz6ybw8P3aK84UyjEMzDq46cYRSG1YpVhL5h5B1g71+1YWOyxfDiEK
        O81/CeWvDOTEZQZpas8av0XlBcb4ku+MzN/LyxdDWQAje8E/DAp6Ji3BAznJRpPs6sFq28
        g9+/10RFStGRZw7dF5Qk89L3pLPFDB0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-tU57rC6aOuK22uwES-yvfw-1; Tue, 21 Feb 2023 03:42:18 -0500
X-MC-Unique: tU57rC6aOuK22uwES-yvfw-1
Received: by mail-wr1-f70.google.com with SMTP id c14-20020adffb0e000000b002bfda39265aso786912wrr.13
        for <linux-api@vger.kernel.org>; Tue, 21 Feb 2023 00:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLJIC/RrvVE7PdqmcHdwOf29lNkhzpC8wWHN3DTeCNY=;
        b=GytRrwtENs7H6NBWT51vWEZmVCiW45oFvhP/fIXQc7fVBrIg38DDy6D55gWkUXGzjW
         P5c/uq+ucDEIkDS3a4l5jxI9xJ5Ms6/fN3D3k+5d1CIUopXC8kvVYmCbZN6QQvla+FX2
         7MSqc4DAye571k7N9ly+jJWoX6UzCeKxwA0D5LKPjShYhE4MIIZXnQacshGBkhSsyo64
         WvuzOP1rbKpqDerLafUKppU2Jp1aW7nsRnDA9Gj0gRo8/vwLLeAZkiWmFCl6u+sBGFcs
         Ui8zbjvlsvDZF346LugLlv5d4GaETswySo/YqbrZyrkEO8I/QFTEoN0dgOEpqLOjoVZB
         Q+1Q==
X-Gm-Message-State: AO0yUKUsiHgiD5Ab/R/sEoGPPI7OlewPP3O0qgu0QNQtdf1s7xQiWiO1
        i0CW/lKZFVoUvCJWX57KJsfgyoC2kR7U9EtN2tnSJSHBAzWMVAWeN8a7mo2wLwP+Jp1RsdkTVNJ
        oLHCYhg+blegQGxdRadlx
X-Received: by 2002:a5d:5308:0:b0:2c5:6025:cd65 with SMTP id e8-20020a5d5308000000b002c56025cd65mr2218708wrv.9.1676968937539;
        Tue, 21 Feb 2023 00:42:17 -0800 (PST)
X-Google-Smtp-Source: AK7set8HYdakBP7NNr75W24EBS8ylbUTvbqe5cKGc3PV4r6NUAF4mQpJtQCSggSEkz/UdpiRyLcPVw==
X-Received: by 2002:a5d:5308:0:b0:2c5:6025:cd65 with SMTP id e8-20020a5d5308000000b002c56025cd65mr2218684wrv.9.1676968937186;
        Tue, 21 Feb 2023 00:42:17 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id c24-20020a7bc858000000b003e11ad0750csm1147194wml.47.2023.02.21.00.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:42:12 -0800 (PST)
Message-ID: <8b8ffa43-9003-010d-30ea-c5de128d646d@redhat.com>
Date:   Tue, 21 Feb 2023 09:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 24/41] mm: Don't allow write GUPs to shadow stack
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
        debug@rivosinc.com
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-25-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-25-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Shadow stack memory is writable only in very specific, controlled ways.
> However, since it is writable, the kernel treats it as such. As a result
> there remain many ways for userspace to trigger the kernel to write to
> shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this a
> little less exposed, block writable GUPs for shadow stack VMAs.
> 
> Still allow FOLL_FORCE to write through shadow stack protections, as it
> does for read-only protections.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> v3:
>   - Add comment in __pte_access_permitted() (Dave)
>   - Remove unneeded shadow stack specific check in
>     __pte_access_permitted() (Jann)
> ---
>   arch/x86/include/asm/pgtable.h | 5 +++++
>   mm/gup.c                       | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 6b7106457bfb..20d0df494269 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1641,6 +1641,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
>   {
>   	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
>   
> +	/*
> +	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
> +	 * shouldn't generally allow access to, but since they
> +	 * are already Write=0, the below logic covers both cases.
> +	 */
>   	if (write)
>   		need_pte_bits |= _PAGE_RW;

So, GUP fast will always fail when writing ...

>   
> diff --git a/mm/gup.c b/mm/gup.c
> index f45a3a5be53a..bfd33d9edb89 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -982,7 +982,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>   		return -EFAULT;
>   
>   	if (write) {
> -		if (!(vm_flags & VM_WRITE)) {
> +		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
>   			if (!(gup_flags & FOLL_FORCE))
>   				return -EFAULT;
>   			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */

and ordinary GUP without FOLL_FORCE.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

