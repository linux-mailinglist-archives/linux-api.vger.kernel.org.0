Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701C71DDA6B
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgEUWoj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 May 2020 18:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgEUWoi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 May 2020 18:44:38 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573FC08C5C0
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:44:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so2478339pll.6
        for <linux-api@vger.kernel.org>; Thu, 21 May 2020 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJu9W8td60dlHtHyi+5unK6gpeAXqJ29SHAWsL9RWAs=;
        b=FyxMI4ZZl0PURR7iCViveWuP5CK3+qS4CaqRsugrQpFszxBJL5lNbPEfcYs6PLFYKw
         t4P6z1zwwxuglPfFfbOr206BbUh0XV5gWoMaTusRIwTt8dC2nkbrAqsX8XwXGuSU4oFw
         wte7+rxUaQ1tKXsuGjW/mJUFSlFiUGJKJ/7O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJu9W8td60dlHtHyi+5unK6gpeAXqJ29SHAWsL9RWAs=;
        b=Rk4esujMWI7qpdPRoLMSUOuEvzu1pi7WJE4msalniEMGw1X1o/yBsOOJGojlSwJ2Au
         PGajclA2BSfGBmre2mtMXt79vkJObSsnZA+gQl2zXqLiJajA5Ml2o6+ZlnG7yfEwgZhn
         LYcteJKQoZFOYZbc2u6+ZLfxJSeO7Qb8KsgbUQTmaZwG+65463qRAYzfxRc8aQko845i
         Fkksp5oZH5EbqkD8ULRLvwbQEDrlJBsPOTPlZTZBP4Soj8Jkl7hQLP9wHOnOYhl3rgH1
         ZXjbCOehVviM+qPJdQMcjz5OgoOSBjwoH+S3a+QY/4NflnGW7ddZKgZw+3qyaSJMHPks
         wlxw==
X-Gm-Message-State: AOAM5321p9hf7pLUpzCnEguHvGXZv4Cs6udtvF/O6Yn+eDhIvvwX1dqf
        nDYZQ6bZFk5d44xbfJGQVkaLhw==
X-Google-Smtp-Source: ABdhPJwbfzhVpxvrN3j/MRFGPobDoa0suCLVnXlB5gXgmrcSLI+uy6mgMoBKtenCAwI+gnf27dKTyQ==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr7752059plb.89.1590101076912;
        Thu, 21 May 2020 15:44:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm5311016pfx.105.2020.05.21.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:44:36 -0700 (PDT)
Date:   Thu, 21 May 2020 15:44:35 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 2/5] selftest/x86: Enable CET for selftests/x86
Message-ID: <202005211544.26CD475832@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-3-yu-cheng.yu@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 21, 2020 at 02:17:17PM -0700, Yu-cheng Yu wrote:
> To build CET-enabled applications, GCC needs to support '-fcf-protection'.
> Update x86 selftest makefile to detect and enable CET for x86 selftest
> applications.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
