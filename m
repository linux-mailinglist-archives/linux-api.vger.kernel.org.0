Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F1C6413D2
	for <lists+linux-api@lfdr.de>; Sat,  3 Dec 2022 03:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiLCC4a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Dec 2022 21:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbiLCC43 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Dec 2022 21:56:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785124A5A1
        for <linux-api@vger.kernel.org>; Fri,  2 Dec 2022 18:56:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso7445941pjb.1
        for <linux-api@vger.kernel.org>; Fri, 02 Dec 2022 18:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tg9EUUtodmg3gzO5fuJCgAWvD6/vLGnjIJiAun4Wv1k=;
        b=dVzAW/5PnjoZ12qC31fP/OIaS00ZFKjjcdlIUmoFH4nqs2oQXU84uYYZcR2U26j75i
         lnWRKv4wFwfIfD1FKValEnoCUusu4OBsS1JkUWnNuD6ZjqEx7CnkNQVfq+pJTytFAtTd
         dgTWMEIqYR5j5j25ehzviauGOZFFMVPS2Dhh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg9EUUtodmg3gzO5fuJCgAWvD6/vLGnjIJiAun4Wv1k=;
        b=A4RK7f2i9dxFr5dvVCuhlW1cxHug7zVGk0GVm918JE/ygdW422eDkJG9Irfbo4TeAB
         fq14lH8meuOQpm4jNydUNSH/sO/mMFiY+V238Yxo7dQ7VtCx2G6M6Xi2GB6dkxYVNjae
         xfNW5t3s6zTBsLiO0T8I8QoWKc09NIKZuOlnzaZOs2FhCDQmH1ZqyZXneIv6SwQ8wk22
         DW/EtuRLxpYqfnuPBGSumj7Lmv0x+1Mwe90ITLvy7xT1uVm8Q5mIequy/H8bSRuOzsJP
         lZ502OoYfkMbeBxlVfqaHBgzdjnzJ+qU3NqO/qRNDheZYTeqEVtoWNd0OaMQnRulm3uF
         lSbQ==
X-Gm-Message-State: ANoB5plIeTP/XISGaapxwW0x3Cf+l+IRUtri0O1wrY+jWi44afV9DCkl
        Abmhy2ZPVRGtfsUjlUBqTZIyxw==
X-Google-Smtp-Source: AA0mqf4wVFTnC0RifpAPxFPsQcjIHmX2vnF/zqOn8r7PZSoadjwf+cAK/tzZY5B/v6Z6SG7U6oDVQQ==
X-Received: by 2002:a17:902:ce90:b0:186:b46d:da5e with SMTP id f16-20020a170902ce9000b00186b46dda5emr56175295plg.92.1670036188007;
        Fri, 02 Dec 2022 18:56:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0017e64da44c5sm6263310plk.203.2022.12.02.18.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:56:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:56:26 -0800
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
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v4 38/39] x86/shstk: Add ARCH_SHSTK_UNLOCK
Message-ID: <202212021856.603F800BC@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-39-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-39-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 02, 2022 at 04:36:05PM -0800, Rick Edgecombe wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Userspace loaders may lock features before a CRIU restore operation has
> the chance to set them to whatever state is required by the process
> being restored. Allow a way for CRIU to unlock features. Add it as an
> arch_prctl() like the other shadow stack operations, but restrict it being
> called by the ptrace arch_pctl() interface.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
