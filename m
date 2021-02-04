Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947EE30FE1D
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 21:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhBDUW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbhBDUWu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 15:22:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3748C06178A
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 12:22:15 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r38so2885872pgk.13
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wnU2ljW3GZfVnC0yk4dz3F0Y7a+z0DVuakcSpmImkaw=;
        b=gk1+3E6zusffn9W5IuwsN3M705pg/AsgpNvWYuk60I9SgeXKbvb/YqudopHfguTWg9
         XHcDS3MQ5Ux9oTwks1PbxMjwOQxFmmNtlcxRxjcKXwBpL+AypZgWkafkkCYlZNNC8R7x
         wPriOS6bS/ExEs3s+CHTQ9aBYRWxITrDlxn9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wnU2ljW3GZfVnC0yk4dz3F0Y7a+z0DVuakcSpmImkaw=;
        b=NzVSNXgXUYPP3419vDC0g82cGhiIrecMdPH5BRj6KHv2Ehj04TWvt48laWpd4csN7S
         c3W+nmkC0JyamfbCpZJV9STIoktP/57ymUxj09I03Jk2Wt31Q3/NLiPa925hDjtRbbAn
         BcMhmqAr8gmur2MTsIlOcJrOp8VIqteAr3jiy3sERa6UII/uPhlr75JyVrn2Yxx5UYhO
         SKe/7OPSBDsFtkMF9YJj0lNZMxEfwwf/Au1B1AfW4CaUCEIwlPz+zOPw/bO2c6ynyQde
         AAUsGUkVKsusx5oI8cptfzDvIzvlg1O4n4qfXBB9XjwH6hOAhk44DexfcqpQmtiWBHPn
         HijQ==
X-Gm-Message-State: AOAM532tCaSUPxUshHRKederx873trtmPK+3Abq984CZj7Dmw8Q2hcwv
        lHzAgqM9EoBlzLjJdRByASPtzg==
X-Google-Smtp-Source: ABdhPJxQWfp/aPzc5XZSKfbRPLKD5pttOTUDGoXyRh6jr8ntSfLzFQ6LjNTCdQXVJDDoi4XbHDHR4A==
X-Received: by 2002:a63:5952:: with SMTP id j18mr708407pgm.29.1612470135501;
        Thu, 04 Feb 2021 12:22:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 11sm7480618pgz.22.2021.02.04.12.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:22:14 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:22:13 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 14/25] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <202102041222.B111A20A9@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-15-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:36PM -0800, Yu-cheng Yu wrote:
> When serving a page fault, maybe_mkwrite() makes a PTE writable if its vma
> has VM_WRITE.
> 
> A shadow stack vma has VM_SHSTK.  Its PTEs have _PAGE_DIRTY, but not
> _PAGE_WRITE.  In fork(), _PAGE_DIRTY is cleared to effect copy-on-write,
> and in page fault, _PAGE_DIRTY is restored and the shadow stack page is
> writable again.
> 
> Update maybe_mkwrite() by introducing arch_maybe_mkwrite(), which sets
> _PAGE_DIRTY for a shadow stack PTE.
> 
> Apply the same changes to maybe_pmd_mkwrite().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
