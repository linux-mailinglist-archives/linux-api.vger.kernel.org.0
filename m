Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27FA6ADC37
	for <lists+linux-api@lfdr.de>; Tue,  7 Mar 2023 11:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjCGKor (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Mar 2023 05:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjCGKoI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Mar 2023 05:44:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA734252BA
        for <linux-api@vger.kernel.org>; Tue,  7 Mar 2023 02:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678185785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hkSFfGl4soWJh275ABriCY4OJqXhUGnQB2a/+uhCoY0=;
        b=GFJN9Hlbg7aVfvGCYL5IXaSPBxAY/t2e8El1phIQyhymXxEDjffQFpdzQKHmc0VAg/wEOS
        Ky3klskNQee6DKu5bLUpFzJwlX5qGS+jP+AbQbd+eSYa9vNJN+khOcCLtc3z3cS2R+7tCM
        abIuZRRgnoZ0chCEsJPpe15OiQAlzAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-IGSxTexWNL-RU87hZcg3qQ-1; Tue, 07 Mar 2023 05:42:56 -0500
X-MC-Unique: IGSxTexWNL-RU87hZcg3qQ-1
Received: by mail-wm1-f69.google.com with SMTP id m28-20020a05600c3b1c00b003e7d4662b83so8103686wms.0
        for <linux-api@vger.kernel.org>; Tue, 07 Mar 2023 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678185776;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkSFfGl4soWJh275ABriCY4OJqXhUGnQB2a/+uhCoY0=;
        b=P8/ptxn89KRLCyg8E4EE857hNInMmQv37KIRJaYVHrWyvthe7uiTUnH1RcdJwA9XYw
         a+zszKHX7KRBQUJrmJYakLlG1/wnPccPLOrr8KWEqtE5RN66RnUEwvDhrCd58hsqGpOp
         RXBcZbNibXFUspWmDCj551fkcwC+jBeYuqW58XT9C4mIc9YMCYzIm9Cfa6UrZyaevbeK
         Xt76+C+1nehW8MhIPglLwrZkzCL8WCMPli0x0xnZgEP/l0IUIuM9u+Gr07NF6XJQY6He
         PBHrWh+IxFmAUpqnagWVpxmnWCmnukwmT//EWtv9HpB0ucuXL4saf2UQxhy/Vby0VvXd
         xLFA==
X-Gm-Message-State: AO0yUKWdF4h9B7Zmx0TihcwVM2D8W3iw3iq4YLCMyuFYs4avuAmJzy9j
        zyMDiCswwdhw57DMQb9xp8K/o8r/7hMOX+T+daABFWs2Y5IPdIHRVe7dRlK1zYgq1GeOO9oucy/
        4uJpWim82j55dZmyQcVms
X-Received: by 2002:a05:600c:4687:b0:3e2:201a:5bcc with SMTP id p7-20020a05600c468700b003e2201a5bccmr12423841wmo.33.1678185775733;
        Tue, 07 Mar 2023 02:42:55 -0800 (PST)
X-Google-Smtp-Source: AK7set9qXIxQ9yHJKIfCwELq7tomci3ICaGJvPRazUwNeud11Cy9qjJe48+RLn1VklykElHsR9Tgqw==
X-Received: by 2002:a05:600c:4687:b0:3e2:201a:5bcc with SMTP id p7-20020a05600c468700b003e2201a5bccmr12423799wmo.33.1678185775374;
        Tue, 07 Mar 2023 02:42:55 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id h8-20020a5d5048000000b002c592535839sm12176234wrt.17.2023.03.07.02.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:42:54 -0800 (PST)
Message-ID: <1467f1b3-a529-50d3-9539-1056b2912d48@redhat.com>
Date:   Tue, 7 Mar 2023 11:42:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory
 accounting
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-23-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230227222957.24501-23-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.02.23 23:29, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Account shadow stack pages to stack memory. Do this by adding a
> VM_SHADOW_STACK check in is_stack_mapping().
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> 
> ---
> v7:
>   - Change is_stack_mapping() to know about VM_SHADOW_STACK so the
>     additions in vm_stat_account() can be dropped. (David Hildenbrand)
> 
> v3:
>   - Remove unneeded VM_SHADOW_STACK check in accountable_mapping()
>     (Kirill)
> 
> v2:
>   - Remove is_shadow_stack_mapping() and just change it to directly bitwise
>     and VM_SHADOW_STACK.
> 
> Yu-cheng v26:
>   - Remove redundant #ifdef CONFIG_MMU.
> 
> Yu-cheng v25:
>   - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().
> ---
>   mm/internal.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 7920a8b7982e..1d13d5580f64 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -491,14 +491,14 @@ static inline bool is_exec_mapping(vm_flags_t flags)
>   }
>   
>   /*
> - * Stack area - automatically grows in one direction
> + * Stack area


Maybe "Stack area (including shadow stacks)"


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

