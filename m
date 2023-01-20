Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78937674885
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 02:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjATBFJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Jan 2023 20:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjATBFH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Jan 2023 20:05:07 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D3EA102E
        for <linux-api@vger.kernel.org>; Thu, 19 Jan 2023 17:05:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id i65so2907603pfc.0
        for <linux-api@vger.kernel.org>; Thu, 19 Jan 2023 17:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i74/kf5lW4kHShv6Z0Gp0/LN6JGTfz3NMfEeR3zBQxE=;
        b=GoRuHyDu314b5alYHUqIeA4iwWnqKmRTPgguZQu8m2BT54UuOxDL2kD8d4kJgWM1ZZ
         qR3Y/TV93KcQuVawLIeJk45pD9kgXh3Y53HiV5J2dnsTHM5SquPA0uJmVsLTHdPprrB1
         MEB1h7QwFkRO7g3dd+FRCu0LANZ3c5XVoOY6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i74/kf5lW4kHShv6Z0Gp0/LN6JGTfz3NMfEeR3zBQxE=;
        b=Y619HtwuhE+uzWviMhGKC9iq/Ss7qC/w4RAqdmWCJjSEGtip3388SXzvpp65gqhoQo
         Vlh+N5P6LpCexp3Rn0UQ+f/uVUsR/gkVXkbvECS96VD80NtNu8/B3VTIF0A7chbGXv48
         9/scQnPUkRhOiivMGhHD5Diq1054+kv7MAFf++M4kFXkuMDxm0/8CUVOGtAys2IkJwe7
         Ugpk9B5RpDGN7GFY40hDfHcYwX6oRptu3s4FKOxicTa+er/xwXpd8CBU36hGFoqC1BwP
         p+WewqN4yftxXlQCU7+tfo0Sq7X3u/hr4lpsFASjYETWHhu37bz5ptOH42BO8/zOyj0W
         Nxgg==
X-Gm-Message-State: AFqh2kostadV4G3yAncQhGnnpMqGka4ONQdk3+gwzgdzMAekRLrtgVx2
        s2Mtpmmvjy7WkNCp8KU+1OvOpg==
X-Google-Smtp-Source: AMrXdXtMzGgnTJkwmf6Dly8CjbEie3lwTxkUFFJtUk22J72Xgx8sc8ANi2hfM+4eU7Ti83oRSH8YRw==
X-Received: by 2002:aa7:8718:0:b0:576:14a4:b76a with SMTP id b24-20020aa78718000000b0057614a4b76amr11737546pfo.34.1674176705426;
        Thu, 19 Jan 2023 17:05:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18-20020aa78ed2000000b0058bbe1240easm12025111pfr.190.2023.01.19.17.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 17:05:04 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:05:04 -0800
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
Subject: Re: [PATCH v5 27/39] x86/shstk: Add user-mode shadow stack support
Message-ID: <202301191705.E64F62342D@keescook>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-28-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-28-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jan 19, 2023 at 01:23:05PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> Introduce basic shadow stack enabling/disabling/allocation routines.
> A task's shadow stack is allocated from memory with VM_SHADOW_STACK flag
> and has a fixed size of min(RLIMIT_STACK, 4GB).
> 
> Keep the task's shadow stack address and size in thread_struct. This will
> be copied when cloning new threads, but needs to be cleared during exec,
> so add a function to do this.
> 
> Do not support IA32 emulation or x32.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
