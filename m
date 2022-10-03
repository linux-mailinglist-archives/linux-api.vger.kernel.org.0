Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA775F34B3
	for <lists+linux-api@lfdr.de>; Mon,  3 Oct 2022 19:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJCRlY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiJCRk6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 13:40:58 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFE36850
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 10:40:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso10045372pjm.0
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7trZKNMH95kI/vdclw2zTtJbLljChYab2N/m8HA2aLk=;
        b=KJmn+3c/xJjpT22xjRIMBTxDLO7GD6WCvCmoYYhclb4OwxuUfDcVrF5sx0CMqpPmQE
         tlWzP1Pt52Ej+zHCMN/xFotPDK7bduuzPXBvFElPX5qQhqUUFRM5ixnbZLjvI4Z1IVcC
         zHmEXUg5sNFLFhfSakgkdCc7SJHWhA8dMF2Fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7trZKNMH95kI/vdclw2zTtJbLljChYab2N/m8HA2aLk=;
        b=1kusXclli8WrVvtpUvoR43srWKoGz6up6rGBtG664zVkOLA7ml7VIp3b+GES3cnxih
         p2zWLTGcwlb3y5gj/PX1hUpptH8GVU2RP2PcJ7yA47nN/1UoWzOCu4hvb33KaEl9dFTG
         lg0isYcN8qrIg+vglCUtqim4Y4jwKL+LxpSwpqeIjqMRkheu9/FnVbDV7e/dH9mM55UT
         VzNwz/gbdvcMwNy+ctGhHx1VmpE6JktMOA340hcoES3q9D4qm9mWrlTT8uVjKvOLOF9a
         xyzWcF1oIuaYeXqw7saHu18mNKytXyUd5df/GFqQFB7OQRSp+OEbOx1qcB8sD34LDEvo
         9HJQ==
X-Gm-Message-State: ACrzQf3mSCOPf4E1bIbpa9gXXB5mJHm4ggOLE7MHTf6oUhVMWPDyLwvk
        rLkj08TaBxHrgoctoqT1aXitJA==
X-Google-Smtp-Source: AMsMyM6P+kbQZa+MmQq3yIJOz6N3zTNS9HCzupkiFwvUnyAIMLQFO7JZpP6RaaJ86An0YJJfI0NRMw==
X-Received: by 2002:a17:902:e547:b0:178:43de:acac with SMTP id n7-20020a170902e54700b0017843deacacmr23426908plf.39.1664818849212;
        Mon, 03 Oct 2022 10:40:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g13-20020a170902e38d00b0017550eaa3eesm7404108ple.71.2022.10.03.10.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:40:48 -0700 (PDT)
Date:   Mon, 3 Oct 2022 10:40:47 -0700
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
Subject: Re: [PATCH v2 05/39] x86/fpu/xstate: Introduce CET MSR and XSAVES
 supervisor states
Message-ID: <202210031032.82AD49E14@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-6-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-6-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:02PM -0700, Rick Edgecombe wrote:
> [...]
> xfeatures. So refactor these check's by having XCHECK_SZ() set a bool when
> it actually check's the xfeature. This ends up exceeding 80 chars, but was

Spelling nit through-out all patches: possessive used for plurals. E.g.
the above "check's" instances should be "checks". Please review all the
documentation and commit logs; it shows up a lot. :)

> [...]
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index c8340156bfd2..5e6a4867fd05 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -39,26 +39,26 @@
>   */
>  static const char *xfeature_names[] =
>  {
> -	"x87 floating point registers"	,
> -	"SSE registers"			,
> -	"AVX registers"			,
> -	"MPX bounds registers"		,
> -	"MPX CSR"			,
> -	"AVX-512 opmask"		,
> -	"AVX-512 Hi256"			,
> -	"AVX-512 ZMM_Hi256"		,
> -	"Processor Trace (unused)"	,
> -	"Protection Keys User registers",
> -	"PASID state",
> -	"unknown xstate feature"	,
> -	"unknown xstate feature"	,
> -	"unknown xstate feature"	,
> -	"unknown xstate feature"	,
> -	"unknown xstate feature"	,
> -	"unknown xstate feature"	,
> -	"AMX Tile config"		,
> -	"AMX Tile data"			,
> -	"unknown xstate feature"	,
> +	"x87 floating point registers"			,
> +	"SSE registers"					,
> +	"AVX registers"					,
> +	"MPX bounds registers"				,
> +	"MPX CSR"					,
> +	"AVX-512 opmask"				,
> +	"AVX-512 Hi256"					,
> +	"AVX-512 ZMM_Hi256"				,
> +	"Processor Trace (unused)"			,
> +	"Protection Keys User registers"		,
> +	"PASID state"					,
> +	"Control-flow User registers"			,
> +	"Control-flow Kernel registers (unused)"	,
> +	"unknown xstate feature"			,
> +	"unknown xstate feature"			,
> +	"unknown xstate feature"			,
> +	"unknown xstate feature"			,
> +	"AMX Tile config"				,
> +	"AMX Tile data"					,
> +	"unknown xstate feature"			,

What a strange style. Why not just leave the commas after the " ? Then
these kinds of multi-line updates aren't needed in the future.

> [...]
> -	/*
> -	 * Make *SURE* to add any feature numbers in below if
> -	 * there are "holes" in the xsave state component
> -	 * numbers.
> -	 */
> -	if ((nr < XFEATURE_YMM) ||
> -	    (nr >= XFEATURE_MAX) ||
> -	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
> -	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_RSRVD_COMP_16))) {
> +	if (!chked) {
>  		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
>  		XSTATE_WARN_ON(1);
>  		return false;

This clean-up feels like it should be part of a separate patch, but
okay. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
