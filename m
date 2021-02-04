Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2956A30FE77
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 21:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbhBDUd4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 15:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240235AbhBDUdv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 15:33:51 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D04C061788
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 12:33:11 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so2927824pgc.8
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 12:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NeprK6JinSqU49dQ1nFPWFvDyk0tPt3L+sHTBjkAdOQ=;
        b=D8TSY/I574CxB1blhR9D6u6bOcOmqMCyck3xJ5THhC5s9Yd8CgpIT8NoEAaCVNnzIF
         hqt9PagwwXSj48djg6joitbyoM/L0tatsbpJDqfEOWr6yEJgz3sBN1eQVR4sg21XZUPY
         mkH0vkZw4SIIvp4oxgImT0qojz0l3OFPib5Uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NeprK6JinSqU49dQ1nFPWFvDyk0tPt3L+sHTBjkAdOQ=;
        b=HoXHE6Npf6gekjCozdnX7om3mdHl0TtIAguuBF1EZHrz0VAUSoMpHWoPDQVkh9u+Po
         igheE6KIy0Xezq6Fau4Sd9FUpjhnXMH9MFFcsweTCHt4S7i2SskzY2TImVJIfyz0nz18
         wcpP35lmuRTEu4eoI+Z82KK+H8n5UlZrLZA9cd//FuOllnCNa1GwRpbxvFI546SV6CDI
         bIVJvRKWbzlTMwaV/Q/fxnYz+Q9xqHixxLeW68ulAMkmIb3899I0Oh/Z2Rb7hl8kQWDM
         C8mFITLNCZDkGeUnlrX+ymNt+BOvi48kMn+0I1WuOdQArGizRyNWiOgkXNvcA9nfg76V
         6l6g==
X-Gm-Message-State: AOAM530Ho9lKi2+Ua0ikb1nBCdCofqkcD0UzOj6C++OPtBVs5ZbIHFPK
        NzdeSNYLEgIC3YVT+r5qVIj04w==
X-Google-Smtp-Source: ABdhPJwJ8tkFZ1GvM2rS6EIJq9lw8kHUx/wvUF88J40CKTwNhAGVZNsM8/4iFq1PZVwRDJJhoNR3nQ==
X-Received: by 2002:a65:6246:: with SMTP id q6mr807193pgv.6.1612470791075;
        Thu, 04 Feb 2021 12:33:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r14sm7806546pgi.27.2021.02.04.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:33:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:33:09 -0800
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
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v19 22/25] ELF: Introduce arch_setup_elf_property()
Message-ID: <202102041233.2FCCEABF1C@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-23-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-23-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:44PM -0800, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates arch features supported by the
> file.  These features are extracted by arch_parse_elf_property() and stored
> in 'arch_elf_state'.
> 
> Introduce x86 feature definitions and arch_setup_elf_property(), which
> enables such features.  The first use-case of this function is Shadow
> Stack.
> 
> ARM64 is the other arch that has ARCH_USE_GNU_PROPERTY and arch_parse_elf_
> property().  Add arch_setup_elf_property() for it.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
