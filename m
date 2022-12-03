Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410CA641346
	for <lists+linux-api@lfdr.de>; Sat,  3 Dec 2022 03:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiLCCWK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Dec 2022 21:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiLCCWJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Dec 2022 21:22:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE32D0383
        for <linux-api@vger.kernel.org>; Fri,  2 Dec 2022 18:22:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o12so6509799pjo.4
        for <linux-api@vger.kernel.org>; Fri, 02 Dec 2022 18:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaBD+K8vuSmT+9I8IhibTBAr2KH9ByAD3wUnDitrKaU=;
        b=kzuyfeQoSyAUG8+Imi6tO8JNZ9YWhAvNTmNhd180HVAkqGC4AP/R8m6q61VMEcHQRG
         p7cLD+caVlXkQdtHDCF/fuJIF24rqo9qnNke7raYkP2CANUAw0h9aTVF44y5HmBXRc/r
         wccuXLJp0VZqNK1XcjzQ/6hC6bpV87Q28yJHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaBD+K8vuSmT+9I8IhibTBAr2KH9ByAD3wUnDitrKaU=;
        b=q5PIfjZ55bweTDqWFG+Y6HIQUKSPiVFlsCgF/OXZXf4A085w5+sjGECN24bBy/TpPe
         ZviDb3bRX+Pe9i37eqymc5cyS+1Tjn1Nh9derr0vD2BIjoQytzUOkfNvrheOKlrzV+Ok
         7IxAv9nR4bsfYHMG9rtSn4/odtHCqWZ9ztHLqYd9XVgVxkcbTSQ/v9SWod7/cM6v5vR1
         P5hfp3noX0t0c+SgDv4hi4Q8cfXtsiZNJsVREHa9/EU00LuGGOeHSXBhTZlTkXmVEQmP
         KLHnAOqH1iQmFQ9d4oeEwWNmjqr/D4gAstIKiSz08KFeY47NJCxiglaEKPcMeh0bIv2o
         fO/Q==
X-Gm-Message-State: ANoB5plqB2Lz+qJwA4jwZ4p3PWRc9IAa5QNOqWN3Iv2I40sjb3KwnTL3
        awklk+zNqCg2zck7vT6dDQ1rOQ==
X-Google-Smtp-Source: AA0mqf7RlLfxZY8tl49/Cmo2Vk4zDlapekvLt7FYfPvAGMMifNLP7nDG6LQK1uvuLIe2NY1n6ig04Q==
X-Received: by 2002:a17:902:e807:b0:189:117c:fcfe with SMTP id u7-20020a170902e80700b00189117cfcfemr55432765plg.124.1670034128032;
        Fri, 02 Dec 2022 18:22:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ju2-20020a170903428200b00174d9bbeda4sm6187424plb.197.2022.12.02.18.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:22:07 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:22:06 -0800
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
Subject: Re: [PATCH v4 03/39] x86/cpufeatures: Add CPU feature flags for
 shadow stacks
Message-ID: <202212021822.79D8BD1@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-4-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:30PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The Control-Flow Enforcement Technology contains two related features,
> one of which is Shadow Stacks. Future patches will utilize this feature
> for shadow stack support in KVM, so add a CPU feature flags for Shadow
> Stacks (CPUID.(EAX=7,ECX=0):ECX[bit 7]).
> 
> To protect shadow stack state from malicious modification, the registers
> are only accessible in supervisor mode. This implementation
> context-switches the registers with XSAVES. Make X86_FEATURE_SHSTK depend
> on XSAVES.
> 
> The shadow stack feature, enumerated by the CPUID bit described above,
> encompasses both supervisor and userspace support for shadow stack. In
> near future patches, only userspace shadow stack will be enabled. In
> expectation of future supervisor shadow stack support, create a software
> CPU capability to enumerate kernel utilization of userspace shadow stack
> support. This will also allow for userspace shadow stack to be disabled,
> while leaving the shadow stack hardware capability exposed in the cpuinfo
> proc. This user shadow stack bit should depend on the HW "shstk"
> capability and that logic will be implemented in future patches.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
