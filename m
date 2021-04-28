Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DE036E06E
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbhD1UkP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 16:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbhD1UkN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 16:40:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CBC06138B
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:39:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d10so7218390pgf.12
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bP0jsyLUeBZMcia9mVsWBqP6zFcasRiNfS5tk4kM0rM=;
        b=A8+FVi1mPar4WLP24ObFpp1Q218abKlV0OQrmnoXUgmmTraergbRvRIY1olI2H8FM5
         Zs2ESIBKBScQGKK1e8f+Sa1YgkVnUJgNUswDh4G4ZG1eWdx+7ssZlBxd43RQhC93UIcT
         UKYW2k8b4p/NrYoP+17PCBkBmkSnwJZS6FulQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bP0jsyLUeBZMcia9mVsWBqP6zFcasRiNfS5tk4kM0rM=;
        b=f7kZsTTbVGTj3Km+efCexIFxSSDn+DDCOp5IqNB6DhH/S+b03lNKRsWpxLQq4d1k/i
         mHCahDqTsv4scax/CCKARDz0p9Jo2PeSWbefefUyTdeO4ybRqDqfNr9jdscSK200HvoQ
         lRxFViuGGHx/VSd9iFNuVgatFUh4WUQfLrxQ1g3awxczFQpA0FemFIyMBlwzEapfqVBu
         qdRRfouyM+KACUAP6dsD9ty9ebJKxPcvrq+T1Y8HV0NjuNGQoNcau8MSvkXwQiPbcLXW
         3bpx8qG9Tii7IAKiF/i+q4MK2IkNTBerHyG5nbLZxt/MR38mQAoXjooEE4OFlF+60wne
         QZ6A==
X-Gm-Message-State: AOAM5302pp59EHpAqLfrV1ey+6qDtwqHh/WjoEXFzu7A4cWgtzp4sQxv
        xtD0YI9hdAJWMLwt3zVUYCbOVQ==
X-Google-Smtp-Source: ABdhPJz7TORt5UPUxQHJtcwUy7DLeU9h16cX0ZufDjJxSEVTidsxEub3MlR7oNmOUCLjsAVtm6Bv+w==
X-Received: by 2002:a62:cd83:0:b029:275:d87e:612e with SMTP id o125-20020a62cd830000b0290275d87e612emr18839700pfg.49.1619642368304;
        Wed, 28 Apr 2021 13:39:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l18sm5405576pjq.33.2021.04.28.13.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:39:27 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:39:26 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Haitao Huang <haitao.huang@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v26 9/9] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
Message-ID: <202104281339.E21514F9D@keescook>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
 <20210427204720.25007-10-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427204720.25007-10-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 01:47:20PM -0700, Yu-cheng Yu wrote:
> ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
> component of CET.  IBT prevents attacks by ensuring that (most) indirect
> branches and function calls may only land at ENDBR instructions.  Branches
> that don't follow the rules will result in control flow (#CF) exceptions.
> 
> ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
> instructions are inserted automatically by the compiler, but branch
> targets written in assembly must have ENDBR added manually.
> 
> Add ENDBR to __vdso_sgx_enter_enclave() branch targets.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
