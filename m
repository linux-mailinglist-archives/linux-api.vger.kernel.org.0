Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7E730FE30
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 21:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbhBDUZH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 15:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239437AbhBDUYw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 15:24:52 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD717C061788
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 12:24:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l18so2482385pji.3
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YiBh8kjoQsH+w1ie1OfB7U+mi5FxxL8KWnwrDiJ80SQ=;
        b=PPt+H4wqt1A6KWRSkPhPkxwMn/vw3TKT91vvsKmHebL+0nltYCjD9IrFeHTRAjQymj
         BUG3q3cW2DBZiH22qiC37rSeMW4mlApOQfqnOR82W1zU+j/au6dXILhqYy9A8+6Iv8qY
         bcd9AfXep4kZgB1Vmchd6yJteQKwVnKD37aR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YiBh8kjoQsH+w1ie1OfB7U+mi5FxxL8KWnwrDiJ80SQ=;
        b=ayjD8xD6svY7Pm5gwHGC12gd6SogUVQE6Myjgy7CfWwPbLWkUHr4iOvLWJMjjbRIs4
         xXspRmZe/wR+78+oz0tlyT0vUFIy0Ubqp/r3NzI2iWqkJjdq1Tn4fwm4EoAVHuCLdX3d
         h7ZJA6Wy6gTVKpW4+oPT5u5VquprDHPKldWwUiWDKLd+SauqB2rO5l1uAdo/T/BWGfKf
         UEemDF2Mu4IoyHL48PpPC1GwpkZfg419kPkBc6yqXcbsU8xmRphYWI5XxBW0U3OqQRXL
         71wdD4CVyF10O+Oh3vm/5fFbmR8anwtp0QvTu+SO8VlUhgvsv37CY4Vxm6aMzWWOF6Nj
         5AJA==
X-Gm-Message-State: AOAM531VofmJ1x9UlRQrZ+8MfMZoXDZKv/EsZG8jEqvPASjuZz07jMMv
        5hTVsuSJgFuPCjDuvVExTiulHw==
X-Google-Smtp-Source: ABdhPJw0Vm+wT2LUNwph4uBXmL08ISQPaD4Ai/QvO5oPqXHsNDkCcUZJ728ruOrlMF1dvvaBvhbAXQ==
X-Received: by 2002:a17:902:59dc:b029:e2:9e80:1537 with SMTP id d28-20020a17090259dcb02900e29e801537mr954553plj.66.1612470251540;
        Thu, 04 Feb 2021 12:24:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k11sm6241168pfc.22.2021.02.04.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:24:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:24:09 -0800
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
Subject: Re: [PATCH v19 16/25] mm: Add guard pages around a shadow stack.
Message-ID: <202102041224.5D300A122B@keescook>
References: <20210203225547.32221-1-yu-cheng.yu@intel.com>
 <20210203225547.32221-17-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225547.32221-17-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:55:38PM -0800, Yu-cheng Yu wrote:
> INCSSP(Q/D) increments shadow stack pointer and 'pops and discards' the
> first and the last elements in the range, effectively touches those memory
> areas.
> 
> The maximum moving distance by INCSSPQ is 255 * 8 = 2040 bytes and
> 255 * 4 = 1020 bytes by INCSSPD.  Both ranges are far from PAGE_SIZE.
> Thus, putting a gap page on both ends of a shadow stack prevents INCSSP,
> CALL, and RET from going beyond.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Yay guard pages! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
