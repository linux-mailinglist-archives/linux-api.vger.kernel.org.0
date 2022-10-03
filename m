Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEAB5F3577
	for <lists+linux-api@lfdr.de>; Mon,  3 Oct 2022 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJCSUh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 14:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJCSUg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 14:20:36 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF027DFC
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 11:20:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l12so10413401pjh.2
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UZjgWmpiJJffFVjLQAt9q1L84jCMCF8CBXS/nSLes6g=;
        b=hqz30n5kbVp2iZDtB7QPuCfGGOM134GF8OOn7Ux1URxpi8i/d4qkARtrNBTBahCeTt
         hKe7nKCzs+JCRPt8kPIUIqX8zEhUnnpcK4k/6arDQ3qVQYeVVQJt7ucuwYeFvzeRxb9v
         g55WTzhBzjO2XhZ0AhuPfc04gPLQ5at4fMdfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UZjgWmpiJJffFVjLQAt9q1L84jCMCF8CBXS/nSLes6g=;
        b=npTUw4kEUMJGvuEPoghlVKE15MZ+Nisa2r0vRLkg+NrC8SLJxQT99dtdd8UKGW9nnK
         6XxcZ8nsfiLg/Ni4oxbrLXPLgS8xyQcA/4+8I3L0VyEktaoM22ye1hIUiSZExAXlThyr
         Dwwh34KR7gnSOJTx0u4iEWzu4wh9zH6dwfLbAtDB+HJucV574/42qU5ZaR26Aa1WejaZ
         t8BwzScft95ItV4xz2XrDz2USW1XvdZr041DmbSoTxp2ChE+570LVUg05EJ78ZaPHgkh
         SWAUqhd5myHT5Z3UIbkKODCsfT+LjOeQmMc+OLwn2AWXBmXCvxQloHGxMg73DvIXC6iF
         Nxsw==
X-Gm-Message-State: ACrzQf2nYUZ6QodkhMSnoYGiZRYIVmUIGa3//crwPKjgmT+5Lk9zDJnL
        /2EI0pWuVRn96jgB7wbAMIiBPg==
X-Google-Smtp-Source: AMsMyM4iuggdVHvNKE+hcPJKVm+/Awmgm1n7+g/dZTw1HMBGUSC0F63k6senCKPiMOgNcH5U1XeTYQ==
X-Received: by 2002:a17:902:a511:b0:178:9702:7199 with SMTP id s17-20020a170902a51100b0017897027199mr22496151plq.155.1664821225428;
        Mon, 03 Oct 2022 11:20:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090a518400b00200a85fa777sm10516489pjh.1.2022.10.03.11.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:20:24 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:20:23 -0700
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
Subject: Re: [PATCH v2 15/39] x86/mm: Check Shadow Stack page fault errors
Message-ID: <202210031120.5B6D7BBAC@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-16-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-16-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:12PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The CPU performs "shadow stack accesses" when it expects to encounter
> shadow stack mappings. These accesses can be implicit (via CALL/RET
> instructions) or explicit (instructions like WRSS).
> 
> Shadow stacks accesses to shadow-stack mappings can see faults in normal,
> valid operation just like regular accesses to regular mappings. Shadow
> stacks need some of the same features like delayed allocation, swap and
> copy-on-write. The kernel needs to use faults to implement those features.
> 
> The architecture has concepts of both shadow stack reads and shadow stack
> writes. Any shadow stack access to non-shadow stack memory will generate
> a fault with the shadow stack error code bit set.
> 
> This means that, unlike normal write protection, the fault handler needs
> to create a type of memory that can be written to (with instructions that
> generate shadow stack writes), even to fulfill a read access. So in the
> case of COW memory, the COW needs to take place even with a shadow stack
> read. Otherwise the page will be left (shadow stack) writable in
> userspace. So to trigger the appropriate behavior, set FAULT_FLAG_WRITE
> for shadow stack accesses, even if the access was a shadow stack read.
> 
> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping. Also, generate the errors for invalid shadow stack accesses.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
