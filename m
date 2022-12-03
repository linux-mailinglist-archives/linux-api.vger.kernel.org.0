Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0B0641368
	for <lists+linux-api@lfdr.de>; Sat,  3 Dec 2022 03:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiLCCbr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Dec 2022 21:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234986AbiLCCbq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Dec 2022 21:31:46 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2BE11A2
        for <linux-api@vger.kernel.org>; Fri,  2 Dec 2022 18:31:45 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 136so5849581pga.1
        for <linux-api@vger.kernel.org>; Fri, 02 Dec 2022 18:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGqaY0xiVxHPg7cMRS547FM4Lr8dWUdA5dzrwiaKHuE=;
        b=B5n0Iq7dEb+7UzBELfeGTVQdnAg0xgb38UHmaEjMy6ZmaexXPWrWjTcXsGGBFS7xK4
         +NLs0EPjreK31tixZceDpn5Ri/yqjz2sbrRW1/V1C+q9m6/CZuUchOtiITC+dERTH4ls
         RkTFsIgLPJ3ZZDSVerJJmGgyX35YrqVUWCBn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGqaY0xiVxHPg7cMRS547FM4Lr8dWUdA5dzrwiaKHuE=;
        b=tDZ65TVx8roRh1npIZJXqTX1tfcsmNxnJ3VB1+SIqH03NELk218KiP2jdg8Ecc3I2m
         ffuPuYDjPz5F7XLm/Z9o/NUnv3y/xgXWDWPmzxt1rjRLSd91shKqDIQ4KuPjxu3I+ibf
         YI8i2z0t5Red5T/OfxwRhCu+Om3y/m1OLaNejJDP8G4wu01r1kdYG+71lvL/zUY1CtOp
         ZLA+7cOlc2a2pCmO8DyjasrMOzRCcu6vTZr7aYeUf+i2/UaJoPHK6mSpkJqR7XYmtafI
         72ateIZxst/yp37w7ASxU5Jx5VSbp1iyZbkS1GMSIl3g7z+W2D/s3x9LYxevgFQfGvJn
         As2A==
X-Gm-Message-State: ANoB5pl6rHy1CIgcINSStWEy5KLVGFYQg9QklkDyU188YXXtEsGC1apo
        MnN8FnekvTzOaCRkr59fZmYVxw==
X-Google-Smtp-Source: AA0mqf7Zg+kWzNeYUsEZY2iFjYDIgYVkwmEwlhE8SBhV/Dqsgul2/43ostusGBEacXblZx3cwuwd5w==
X-Received: by 2002:a63:4e20:0:b0:46f:4d37:e95c with SMTP id c32-20020a634e20000000b0046f4d37e95cmr47482506pgb.354.1670034704847;
        Fri, 02 Dec 2022 18:31:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14-20020a62640e000000b0056bb4bbfb9bsm2971706pfb.95.2022.12.02.18.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:31:44 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:31:43 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 11/39] x86/mm: Update pte_modify for _PAGE_COW
Message-ID: <202212021831.697AA89B7B@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-12-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-12-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:38PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The Write=0,Dirty=1 PTE has been used to indicate copy-on-write pages.
> However, newer x86 processors also regard a Write=0,Dirty=1 PTE as a
> shadow stack page. In order to separate the two, the software-defined
> _PAGE_DIRTY is changed to _PAGE_COW for the copy-on-write case, and
> pte_*() are updated to do this.
> 
> pte_modify() takes a "raw" pgprot_t which was not necessarily created
> with any of the existing PTE bit helpers. That means that it can return a
> pte_t with Write=0,Dirty=1, a shadow stack PTE, when it did not intend to
> create one.
> 
> However pte_modify() changes a PTE to 'newprot', but it doesn't use the
> pte_*(). Modify it to also move _PAGE_DIRTY to _PAGE_COW. Apply the same
> changes to pmd_modify().
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
