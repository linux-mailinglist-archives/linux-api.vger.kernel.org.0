Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA15F3931
	for <lists+linux-api@lfdr.de>; Tue,  4 Oct 2022 00:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJCWiD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 18:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJCWiB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 18:38:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888141988
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 15:38:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l12so10962532pjh.2
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1aT8gZ8YBZYKdqdpocYzKcdp4QTwJIFBwIdyk+5hEXw=;
        b=IaidlPULvIyiGqDbE5G7hS3w3xKB26x3hcYRXrEqxDsI9zc++O1gmvMKq1f0bVzeds
         8K3lX19RjkueqxRMkTMpp/Tft7xUjQyCx9JY8efa7Mdv7WHNvG66ggXMUtulLE/e4hZG
         DE2eXd2F1WQ0D9XVOFchXwKVBV6do3UTeiNMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1aT8gZ8YBZYKdqdpocYzKcdp4QTwJIFBwIdyk+5hEXw=;
        b=5bL+uLszHoJPAdntEFCLq/mVPmyQST3RfyCLD7xzHIi6wg2oEvN4LXiKkzfMCXyZ6c
         BqpxRoZBvWWEuwXjM2GDs4hYLrUOpWqHz+A+6PP3lWx5x2BX9KxaJu6qRyFLb8lCIeOW
         PeeWFxzH88tGUEb6hrzSkjKEPdjtszIiwzfwuAJEw8qL9z26nWSgT1NsXaLqj40Qw0V2
         SMEMUdoVN0WDpYz+0gir2gcUqLomL4HDi9Nz4xX7lrl+qak5NVbOW0yY7lIMSarmtVo3
         oTor0oiaU1OpaEnwllSzIyLFfyROSEL3XiZajm2RiCa/Arm8aDTUdN9NjdSkQneC2heh
         JdBg==
X-Gm-Message-State: ACrzQf2n9itjcS1inzMhoSOhrqvr90127WOigqRJt8gZuhWZZ1rp7N64
        k9hn/7APRw+Y7nNJQcfgqnuEcg==
X-Google-Smtp-Source: AMsMyM7epOCeIk28sJ5VBjYcYEakReAeIB1Rj5csunSmzv5KIYDwsSUH7jVIIb+J740mJ/hrJYBPtQ==
X-Received: by 2002:a17:902:a9c6:b0:178:b2d4:f8b2 with SMTP id b6-20020a170902a9c600b00178b2d4f8b2mr23901915plr.79.1664836679530;
        Mon, 03 Oct 2022 15:37:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902654400b001769206a766sm7624887pln.307.2022.10.03.15.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:37:58 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:37:57 -0700
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
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 30/39] x86: Expose thread features status in
 /proc/$PID/arch_status
Message-ID: <202210031530.9CFB62B39F@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-31-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-31-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:27PM -0700, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Applications and loaders can have logic to decide whether to enable CET.
> They usually don't report whether CET has been enabled or not, so there
> is no way to verify whether an application actually is protected by CET
> features.
> 
> Add two lines in /proc/$PID/arch_status to report enabled and locked
> features.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> [Switched to CET, added to commit log]
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> 
> v2:
>  - New patch
> 
>  arch/x86/kernel/Makefile     |  2 ++
>  arch/x86/kernel/fpu/xstate.c | 47 ---------------------------
>  arch/x86/kernel/proc.c       | 63 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 47 deletions(-)
>  create mode 100644 arch/x86/kernel/proc.c

This is two patches: one to create proc.c, the other to add CET support.

I found where the "arch_status" conversation was:
https://lore.kernel.org/all/CALCETrUjF9PBmkzH1J86vw4ZW785DP7FtcT+gcSrx29=BUnjoQ@mail.gmail.com/

Andy, what did you mean "make sure that everything in it is namespaced"?
Everything already has a field name. And arch_status doesn't exactly
solve having compat fields -- it still needs to be handled manually?
Anyway... we have arch_status, so I guess it's fine.

> [...]
> +int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
> +			struct pid *pid, struct task_struct *task)
> +{
> +	/*
> +	 * Report AVX512 state if the processor and build option supported.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
> +		avx512_status(m, task);
> +
> +	seq_puts(m, "Thread_features:\t");
> +	dump_features(m, task->thread.features);
> +	seq_putc(m, '\n');
> +
> +	seq_puts(m, "Thread_features_locked:\t");
> +	dump_features(m, task->thread.features_locked);
> +	seq_putc(m, '\n');

Why are these always present instead of ifdefed?

-Kees

-- 
Kees Cook
