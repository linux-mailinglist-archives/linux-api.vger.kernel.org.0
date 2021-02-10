Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C18317049
	for <lists+linux-api@lfdr.de>; Wed, 10 Feb 2021 20:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhBJTgS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Feb 2021 14:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232854AbhBJTfS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Feb 2021 14:35:18 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4511EC06174A
        for <linux-api@vger.kernel.org>; Wed, 10 Feb 2021 11:35:03 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d26so1947922pfn.5
        for <linux-api@vger.kernel.org>; Wed, 10 Feb 2021 11:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lVugRE6fF0oJTBQd7d0RHKP3QOjg3imenXxdGjYCNio=;
        b=FOurCcBoEOTC173g8WpQOh8MpvMQlo/WlTwQI/cXieTsGgI0OsJU6jFdMuPewnsA8x
         N+Lu45EOVe6MZGpC4MeQO9562gudu7ifC8x9TKKAd7WGRrJKzSki8Id6v4RZ3j9MW3T3
         T3kC9Rjk7f1qpSc/LzUtjVX0oVYUJoOrnsQ4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lVugRE6fF0oJTBQd7d0RHKP3QOjg3imenXxdGjYCNio=;
        b=DNTCcOAF5TjVZmjF/HSuSiJ3V/7JZpehmafmPa0szQikgItzYyMnKsbF3d00nEu8Kp
         aCa1FQ4oGRJYKcH0SrdW6Ea7jwuKhg2Dia8WmCiTcvK6pYcFioL86zK321yaVo5iiY6A
         GB1OMef8dmwYQWt8WTduPAD+jOS9sDPgauWIcVENTpeFk5RAkSay4EIIhSJkeOngkEBH
         4bYYIWVw04dzBb1hr+SkHPhQnpxhg4irkQT41eqqlpU7zMfyfoWrd3SPqGvvHRxeqnS2
         Spq90UV4XTPYDygr1U365QmA0Wg/vvbKqJr0Hx6fWGlZon7nxsltel4q2DFe7rJKmc04
         UHdA==
X-Gm-Message-State: AOAM530c9IRVWI7xgpMMmvJI2UIMJ+9H6FW0RwFB1RNF02vfLlEaK9fj
        MjkjB4Y57ZYgoyxJFn2zY5a4WQ==
X-Google-Smtp-Source: ABdhPJyw/brekoVah28J4DYypOu+xfbWlmLb9xtdz4+0cBteusjYuV6Y5OvqRl1eOPZCqvkxSdOONQ==
X-Received: by 2002:a62:8445:0:b029:1c1:c862:8fc4 with SMTP id k66-20020a6284450000b02901c1c8628fc4mr4506463pfd.77.1612985702870;
        Wed, 10 Feb 2021 11:35:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u127sm3234989pfb.180.2021.02.10.11.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:35:02 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:35:01 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v20 07/25] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <202102101134.72F7495@keescook>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175703.12492-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:45AM -0800, Yu-cheng Yu wrote:
> The x86 family of processors do not directly create read-only and Dirty
> PTEs.  These PTEs are created by software.  One such case is that kernel
> read-only pages are historically setup as Dirty.
> 
> New processors that support Shadow Stack regard read-only and Dirty PTEs as
> shadow stack pages.  This results in ambiguity between shadow stack and
> kernel read-only pages.  To resolve this, removed Dirty from kernel read-
> only pages.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
