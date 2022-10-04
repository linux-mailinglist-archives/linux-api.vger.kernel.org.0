Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC435F3BF4
	for <lists+linux-api@lfdr.de>; Tue,  4 Oct 2022 06:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiJDEEH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Oct 2022 00:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJDEEE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Oct 2022 00:04:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CE821E18
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 21:04:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c24so11626838plo.3
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 21:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=RvEgKxP6T1qxqAkm7Unywj2tbhQw7Pjq7jdmWAsf7To=;
        b=hnk1iBSJ70l817ATL90p2KUf/st5w6VY728N6VYCOyE5NZEV0I5QKKoKHWaibjPaLq
         pZ9gLKLeXx+vt27FliXjO96UKvvr5+sDu4InpI2ML4eAI4ENY/Blyh0fLL7UN+z36Nq2
         zID3qeceqlcQWqa226GaXwdViomNJnxxcfdR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RvEgKxP6T1qxqAkm7Unywj2tbhQw7Pjq7jdmWAsf7To=;
        b=nYCL+5y69sZjCZvJJSG5CvszGC3HyuydM6ELbktZmbGKmnDRTU0kxC4vDa2XUJebbT
         5jvtjcIr+NBVr8wruHY3A8z/y6Ls5/R8HMCB36AqnqoFFjWz8P4DXiVO80DXYyOLDX5D
         d6hpDQaA+EDPuMXAdfd+XmwYehrewM5V0CicmAct9I7xYEq7CnkV9OTd1nIilS4c+Zl3
         Z2MWxeS6LoAdD+PcewiCFNQty4mzhU+sQDndlBfJMfhWNadNZBAtfH7gL0GmBYrlc9Xq
         e+ATCgSch3EHV8WM33O4uaPUc9PyN1pVKObsvKzOaTImKs+ck4wPZwNsTXG+svYpyrkE
         bmaw==
X-Gm-Message-State: ACrzQf3rYUvWM811lDp84u6pug1+aRqVzzyRHFliEZ5zoE4kMDJytWMq
        i7EtI5xZrZhFx3a4fADZvrD6lg==
X-Google-Smtp-Source: AMsMyM7KdEI59H+iJ47/cAMFWwA0qEn0hsnOiP5znSBXMuB570wDOkrIO5UVg5W1BrAPa62Gu5h5tQ==
X-Received: by 2002:a17:90b:4c41:b0:202:78e9:472b with SMTP id np1-20020a17090b4c4100b0020278e9472bmr15538866pjb.207.1664856241699;
        Mon, 03 Oct 2022 21:04:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a604800b0020a9f7405aesm2572982pjm.13.2022.10.03.21.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 21:04:01 -0700 (PDT)
Date:   Mon, 3 Oct 2022 21:04:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [PATCH v2 24/39] x86/cet/shstk: Add user-mode shadow stack
 support
Message-ID: <202210032101.A33914E4@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-25-rick.p.edgecombe@intel.com>
 <202210031203.EB0DC0B7DD@keescook>
 <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474d3aca-0cf0-8962-432b-77ac914cc563@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 03, 2022 at 01:04:37PM -0700, Dave Hansen wrote:
> On 10/3/22 12:43, Kees Cook wrote:
> >> +static inline void set_clr_bits_msrl(u32 msr, u64 set, u64 clear)
> >> +{
> >> +	u64 val, new_val;
> >> +
> >> +	rdmsrl(msr, val);
> >> +	new_val = (val & ~clear) | set;
> >> +
> >> +	if (new_val != val)
> >> +		wrmsrl(msr, new_val);
> >> +}
> > I always get uncomfortable when I see these kinds of generalized helper
> > functions for touching cpu bits, etc. It just begs for future attacker
> > abuse to muck with arbitrary bits -- even marked inline there is a risk
> > the compiler will ignore that in some circumstances (not as currently
> > used in the code, but I'm imagining future changes leading to such a
> > condition). Will you humor me and change this to a macro instead? That'll
> > force it always inline (even __always_inline isn't always inline):
> 
> Oh, are you thinking that this is dangerous because it's so surgical and
> non-intrusive?  It's even more powerful to an attacker than, say
> wrmsrl(), because there they actually have to know what the existing
> value is to update it.  With this helper, it's quite easy to flip an
> individual bit without disturbing the neighboring bits.
> 
> Is that it?

Yeah, it was kind of the combo: both a potential entry point to wrmsrl
for arbitrary values, but also one where all the work is done to mask
stuff out.

> I don't _like_ the #defines, but doing one here doesn't seem too onerous
> considering how critical MSRs are.

I bet there are others, but this just weirded me out. I'll live with a
macro, especially since the chance of it mutating in a non-inline is
very small, but I figured I'd mention the idea.

-- 
Kees Cook
