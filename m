Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71C767482E
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 01:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjATAoe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Jan 2023 19:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjATAoe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Jan 2023 19:44:34 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B238F6F4
        for <linux-api@vger.kernel.org>; Thu, 19 Jan 2023 16:44:32 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so2748188pjg.2
        for <linux-api@vger.kernel.org>; Thu, 19 Jan 2023 16:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+fvpGapgvtVGeZuAY7OcezbzCMrWexY1QDif5YC73k=;
        b=XFsSugiSp88z0HmsOr19nYx6GTXzGDj0gHR9xaNyf3HdsqIlfolg80UaaqpwLt6Hw/
         f3CG89eBjl9+rOfqPoL2WyGaOKw5CHRThrkGAbpiZxT1cpMKa0r/l09hUiJsRww3sCVX
         PGOvqk0XAu9ph8slSgImKKj/L6v2vSSKsWQss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+fvpGapgvtVGeZuAY7OcezbzCMrWexY1QDif5YC73k=;
        b=JG+VXTeF4cxPy2HcPp/ZH45Xm151uJt/fPneuKx6RPOxLrNqCbN93jfoDtokBKNbwN
         Zsywlangi1GcCgF1uQpJ1fDNixyFV969HuuoKl6xb+pL57cC3CGoknZ9kyZU2FaNzsZv
         dEyVT/7QuWKWRJxHBTikrWW/6NUZz/xWJYTL5A0Qtdgsb/niiW47qNWbSb3sWRblkLrp
         MArOZrmIAtgr/o7UFKCm59vYDrwjGYW/TJp6pVtC08/RYquUOSgnxS7VZtRpz6jaIIRB
         FRdQ6aFDAU4YdQ8QluRUe4dUv9yXz+VX3N0aAw5tlYAnHfxnKwy7rvURjBUm0dLzofcy
         9Spw==
X-Gm-Message-State: AFqh2kqMOr3KArXLEfZCaaBpw0v7Ynca243mKIVUSTpXKclTiUWB+PCb
        7wq/RFQb9RQQnfZuAkmMHaRllg==
X-Google-Smtp-Source: AMrXdXtJCRP9I9FgTWke+BtwI9sCViCGPVxeDLSFp+Gamwo74cyDQdWSoZFp4OjdXosxwGgV2T8uYw==
X-Received: by 2002:a17:902:f646:b0:194:46e0:1b61 with SMTP id m6-20020a170902f64600b0019446e01b61mr13777190plg.63.1674175471728;
        Thu, 19 Jan 2023 16:44:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n20-20020a170902d0d400b00192e1590349sm25533566pln.216.2023.01.19.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:44:31 -0800 (PST)
Date:   Thu, 19 Jan 2023 16:44:30 -0800
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
Subject: Re: [PATCH v5 03/39] x86/cpufeatures: Add CPU feature flags for
 shadow stacks
Message-ID: <202301191644.CBF2951@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-4-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:41PM -0800, Rick Edgecombe wrote:
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
> support. This user shadow stack bit should depend on the HW "shstk"
> capability and that logic will be implemented in future patches.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
