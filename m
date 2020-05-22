Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E011DEE5E
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 19:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgEVRgF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 May 2020 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgEVRgE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 May 2020 13:36:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AAC05BD43
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 10:36:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l73so2402826pjb.1
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 10:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2JbpNQ5BB8THZLFRZdUsN5zyBBBg1g/qGCRRq9W1mM=;
        b=KCChTIHcglv8zga3a5aOx2ivsb/AjYh4uFhKYSzdjk8Zy7lmmEqJJ6I41tdc7Qxcel
         SKXsc6lA7boxff1mWCeR6Hym/HbT/Y8JCY54dDB2dKV7LUqpig3/sEfxfj3YlbMjxk78
         cf4xmQWG34WMeCDIKi5DinQN2V4caGJiIsSXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2JbpNQ5BB8THZLFRZdUsN5zyBBBg1g/qGCRRq9W1mM=;
        b=gm+QvQu+WyrqI11BB0+88yyDIUe5InS6YfQwW3K0bbXUiKrH618xRn4jNpSXqivW8U
         hvTPAAZ1p0nLrpjv2OLOJZZVMx0B8xc+FzKhe1ZFgNg1/Op8OqbIm7Y0KhAjuUJfZzpR
         +qIpgbG3BWcvIMYlgKsPtIkReigOee8oAwywuRpkCGRXwoK+Q7UzrsGPd0i3UPYYlxlX
         6pKy64peiFuxYR9b49+XgHDJHt3QdD6NbQtcB41FrKtNsXTNh9NvpBuzAEqm6s4/5CGv
         f/il8qNguXs4zecGoUawfzZtxK5qPzMJ9q2/4WgecMkn4fUr8FSUkEwivv9S0F9bISFm
         67Vw==
X-Gm-Message-State: AOAM533V//OEROYI6MmyLL7p9POjaczRsn8AaPx6LBF5uBlwF2R9kZnV
        dAy3+WNCB/nThY2eqZRInvjS/A==
X-Google-Smtp-Source: ABdhPJy3bKJ2cO/LbOCqUoRt6uBWzveUTeVTjmUCNI6pxDVh8fOHpftgmCyiWGsqex2F3Yb7IJd/Xw==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr15646877plz.179.1590168962631;
        Fri, 22 May 2020 10:36:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm6224293pgp.69.2020.05.22.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:36:01 -0700 (PDT)
Date:   Fri, 22 May 2020 10:36:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 5/5] selftest/x86: Add CET quick test
Message-ID: <202005221034.59F5DF75@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-6-yu-cheng.yu@intel.com>
 <20200522092848.GJ325280@hirez.programming.kicks-ass.net>
 <202005221020.B578B8C6@keescook>
 <20200522172711.GA317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522172711.GA317569@hirez.programming.kicks-ass.net>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 22, 2020 at 07:27:11PM +0200, Peter Zijlstra wrote:
> On Fri, May 22, 2020 at 10:22:51AM -0700, Kees Cook wrote:
> 
> > But yes, I think getting a copy of asm.h would be nice here. I don't
> > think the WRITE_ONCE() is needed in this particular case. Hmm.
> 
> Paranoia on my end because I had no clue wth he wanted with his -O0
> magic gunk.

Heh, yes, which is why I asked for many more comments. ;) I *think* it
was entirely to control the stack (and ssp) behavior (i.e. don't inline,
don't elide unused stack variables, etc).

-- 
Kees Cook
