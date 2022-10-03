Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7335F35A5
	for <lists+linux-api@lfdr.de>; Mon,  3 Oct 2022 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJCSbF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJCSbD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 14:31:03 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246030F6B
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 11:31:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l12so10437117pjh.2
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yWFb7RgESUpR05JgfY3hGQPjFfcU1x/EUhBNi7FjnRo=;
        b=PheLfVQNZdvrd76w9fTEkeWjqZZ7/2eEa6fQ0EZZSMfVfQPgF+/CqIcflCzBBHUFpw
         itUFINwrcHRurA8ZI8pf9m7E8cFXP7Qi00SMBeUYc0qkUTk+BhxAbx/wB1yEkS+j8nGw
         IzJhH5y7YxjK1FQ3v2cmRb2f3dqi1djliUovc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yWFb7RgESUpR05JgfY3hGQPjFfcU1x/EUhBNi7FjnRo=;
        b=tF3I6LU2TPiqWsc7dj4UkmO9qXfbH3qjCDQv2alGnxlfnu8BQ4YE0gmnShtqPUCauI
         ZuQpOLdV0mcCpNXFybtTRgfW01+/ptF31VkETnslXeRdTn5xSwyPP4wuXtNua9JD5Oew
         A281FEnwm+VngsgAtYdohQ9c7ueBaifhpljccfcN9lQaaUoQubvTpD47qM7WKj9fkG5A
         jbbAbFvJpjScX+tOqelYbaxNAuQyWzTkkfUsBlTwYOVnioq1skSSsLnBzbzI8EiucFrd
         5MMQa/+OnJWOvlrkf1JJENMbk6B6+C0BCRlcUXJzlYjhTsU1sPG7IBr2WRFGzAYxoAMU
         QioQ==
X-Gm-Message-State: ACrzQf1b4rp/wN0d/AdrxilnqAykwM+9L95Fy6VomDWhfE1nYyu3yGuf
        vpKY9NZ36X+sbTBZMns2cq3dmQ==
X-Google-Smtp-Source: AMsMyM7uo5Tzw/2Wd31Jjw44SLZYLBYBBrjxbdxXYvJpm9EoFdqt2quPyfPmA35slsvVMZOnqpgYmA==
X-Received: by 2002:a17:90b:4ad1:b0:20a:b974:19a0 with SMTP id mh17-20020a17090b4ad100b0020ab97419a0mr3479373pjb.178.1664821861874;
        Mon, 03 Oct 2022 11:31:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902bb8700b0017bdfbfcf8dsm7500560pls.63.2022.10.03.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:31:00 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:30:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 18/39] mm: Add guard pages around a shadow stack.
Message-ID: <202210031127.C6CF796@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-19-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-19-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:15PM -0700, Rick Edgecombe wrote:
> [...]
> +unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		return stack_guard_gap;
> +
> +	/*
> +	 * Shadow stack pointer is moved by CALL, RET, and INCSSP(Q/D).
> +	 * INCSSPQ moves shadow stack pointer up to 255 * 8 = ~2 KB
> +	 * (~1KB for INCSSPD) and touches the first and the last element
> +	 * in the range, which triggers a page fault if the range is not
> +	 * in a shadow stack. Because of this, creating 4-KB guard pages
> +	 * around a shadow stack prevents these instructions from going
> +	 * beyond.
> +	 *
> +	 * Creation of VM_SHADOW_STACK is tightly controlled, so a vma
> +	 * can't be both VM_GROWSDOWN and VM_SHADOW_STACK
> +	 */

Thank you for the details on how the size choice is made here! :)

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fef14ab3abcb..09458e77bf52 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2775,15 +2775,16 @@ struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr)
>  	return vma;
>  }
>  
> +unsigned long stack_guard_start_gap(struct vm_area_struct *vma);
> +
>  static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
>  {
> +	unsigned long gap = stack_guard_start_gap(vma);
>  	unsigned long vm_start = vma->vm_start;
>  
> -	if (vma->vm_flags & VM_GROWSDOWN) {
> -		vm_start -= stack_guard_gap;
> -		if (vm_start > vma->vm_start)
> -			vm_start = 0;
> -	}
> +	vm_start -= gap;
> +	if (vm_start > vma->vm_start)
> +		vm_start = 0;
>  	return vm_start;
>  }
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 9d780f415be3..f0d2e9143bd0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -247,6 +247,13 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	return origbrk;
>  }
>  

I feel like something could be done with this definitions to make them
inline, instead of __weak:

#ifndef stack_guard_start_gap
> +unsigned long __weak stack_guard_start_gap(struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_GROWSDOWN)
> +		return stack_guard_gap;
> +	return 0;
> +}
#endif

And then move the x86 stack_guard_start_gap to a header?

It's not exactly fast-path, but it feels a little weird. Regardlesss:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
