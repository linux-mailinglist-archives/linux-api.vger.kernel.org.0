Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B401B343E49
	for <lists+linux-api@lfdr.de>; Mon, 22 Mar 2021 11:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCVKqn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Mar 2021 06:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbhCVKqL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Mar 2021 06:46:11 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2EC061574
        for <linux-api@vger.kernel.org>; Mon, 22 Mar 2021 03:46:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b14so7233408lfv.8
        for <linux-api@vger.kernel.org>; Mon, 22 Mar 2021 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YVhaX9TyJpOCjZ6lAAx4X7Evu71S5QgfpSg+uRC3XiQ=;
        b=M6jX3QVPO2UvJpsu3y0kv19VW5H79eVHUQvu9oD8AlEmyUmNNKBqbG0M9SlNIvKW1A
         j4HrUVwhPDK8XJkQb2YtadImTHZFIu+ZiV2CiY4VqPwXdbkbI/JEcbsz/1ysRzNkUGqm
         YCnNWVY5+wV8jyvDHq1hQJj647gMtGG8cTL9qnbbrc4R2mfABoXP185LrniGGhgOBl/e
         qE8Y2JCCUVVLVun6uiSqkngNMyVNRC9Zg/lBqOFWSItWSDvOVD/M0CWxh0J28yYm/R9J
         xKgmf9d5Z4dye+vyvIqCw6pxvy7dzPyFYk/ksskR9lwXAIK9kT/ZafHhgk+INpAYlx2n
         j88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVhaX9TyJpOCjZ6lAAx4X7Evu71S5QgfpSg+uRC3XiQ=;
        b=ZJfoKU53TjpUdSIHp3pEtTV3mpr0Net6pW4eDhgOuyY5RPwVPXFsnHrpCj77X0ELos
         xhp6OaQlnz+Z2/GrBTUMjcqbwwSnpno3yV1nlTbmLQVRwpSuOQhevEDVGD+ROCJXRY3c
         hXXh4pnYdMBta1a0rxzqtE1PLpR3r6kFwVzOUO9q3MrhTEpvH/EV+seYLcXBq1OGMAcE
         kfm6RQxDbf7dlNTrkImlwPZVgR5VSMDttEJVUW72qj8/u3Z6of+utVBuyMAkpUhvqsGX
         BiG1PfqtXDG26eAuGFpW2k+TgeMSP8W+000FONUPJxvsvRLmp0Kn2ByvVxvSmhHsqQtG
         5HGQ==
X-Gm-Message-State: AOAM5304U8Dwuxv36uZCdFtDdmSFzG/cNKTCydJa5PjQQrUcftmD9XNi
        MTG9gwRKKHztN+YH4HhsKzFoyA==
X-Google-Smtp-Source: ABdhPJzLM+bmJsvaTQY9QrPsDTclu+7bOjKDoiq6hBThy6PKFfc4RTvbqhPQkPHx8PacTz+LlaoISw==
X-Received: by 2002:a05:6512:219:: with SMTP id a25mr6170751lfo.222.1616409969171;
        Mon, 22 Mar 2021 03:46:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v80sm1531541lfa.229.2021.03.22.03.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 03:46:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 32D84101DEB; Mon, 22 Mar 2021 13:46:16 +0300 (+03)
Date:   Mon, 22 Mar 2021 13:46:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v23 15/28] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <20210322104616.tht6flrxif257fdb@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-16-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-16-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:41AM -0700, Yu-cheng Yu wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a6c18c5752d6..af805ffde48e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -997,6 +997,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>  {
>  	if (likely(vma->vm_flags & VM_WRITE))
>  		pte = pte_mkwrite(pte);
> +	else
> +		pte = arch_maybe_mkwrite(pte, vma);
>  	return pte;
>  }

I think it would be cleaner to allow arch code to override maybe_mkwrite()
and maybe_pmd_mkwrite() altogether. Wrap it into #ifndef maybe_mkwrite
here and provide VM_SHSTK-aware version from <asm/pgtable.h>.

-- 
 Kirill A. Shutemov
