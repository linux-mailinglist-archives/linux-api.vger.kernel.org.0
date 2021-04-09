Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA1935A1C4
	for <lists+linux-api@lfdr.de>; Fri,  9 Apr 2021 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhDIPMm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Apr 2021 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDIPMk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Apr 2021 11:12:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2284C061762
        for <linux-api@vger.kernel.org>; Fri,  9 Apr 2021 08:12:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id v140so10266685lfa.4
        for <linux-api@vger.kernel.org>; Fri, 09 Apr 2021 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PDyMSJJvLIMFC1KbCjmLHB5PTIgl8fLhsjpA7s8Yb6Q=;
        b=WUE6Vxis/wkboifvaP4/0mKQH9ZqXTXg09FLow2NBClwREFinJQQ7Ym269+P2rGdYS
         H8OWs7F1iSt6G0pM1qTUlLYbVDnQPeqAXBmP92LWmtN69zpGrjqmOrTUUlRTZHR8pogT
         HSxBDs2fiYTfAa+HHPHzSFp+8beCoBX+rQifO+DG79+wglkVBUUlIFhyZuhQz4JHNwqk
         kPJS1NjJ+V/xdMmrwNrtSJB7PzFZN5PhPjT2q6jGA2WKNNSR3+/AURsA2gkd01+BcMhd
         0LXY1hEnpKIJdbbkNFmtfPJLm1ibRZPKLfbAtJRACzTh3QzzHpzbwLEb4YDGLWvW7amr
         s2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PDyMSJJvLIMFC1KbCjmLHB5PTIgl8fLhsjpA7s8Yb6Q=;
        b=Iwv9jQ6sBPgBHsNVj/ziusGBHUNqwdCJv4XlXHHhoq6nyZR4Up3GWC8Lw7TXw6GKYI
         9KKsM1xN/5yPtqYcD46bc6E3AFZGOe+hwhto/9fOgs25DKNapZBf2LT/zlhUaR92K/5b
         vZDjcuYVMTyf/E4PGZ0Giz6LTNwpc1d7W0+cqdMdMoEO1wuK4QpA+hQtEsW5WALmhliT
         SDKrsGBK1AO+3FweleIho3aqJ86UAqC7UqhTh57n95UYwaFtUnSIsEdBxXhb/UHvrcuL
         CZM3iqg6yYph2WH9nFrk+6pjDFQG4yZQyqPFST/rMVONRCIJAjP/1IGrkyRypvBLxiSk
         REyg==
X-Gm-Message-State: AOAM5312rpiFU23vzlYqWx8JXu4kSIrWGg7yygsjKscgXkuCvT+DYnTU
        4RNOShBK0H+nqjiSZk48o9HxQQ==
X-Google-Smtp-Source: ABdhPJyAXO7XxweiGZ6jKD2WpLH/voQpq46hnsIJmUDXRxILxGzeLt3DBPtRLvbc6rthzzbO9px7xw==
X-Received: by 2002:a19:8c0a:: with SMTP id o10mr10600843lfd.175.1617981146160;
        Fri, 09 Apr 2021 08:12:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k18sm295287lfg.32.2021.04.09.08.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 08:12:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 05C1F102498; Fri,  9 Apr 2021 18:12:25 +0300 (+03)
Date:   Fri, 9 Apr 2021 18:12:24 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
        Kees Cook <keescook@chromium.org>,
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
        Haitao Huang <haitao.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v24 14/30] x86/mm: Shadow Stack page fault error checking
Message-ID: <20210409151224.4tlklypbjpxcztpt@box.shutemov.name>
References: <20210401221104.31584-1-yu-cheng.yu@intel.com>
 <20210401221104.31584-15-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401221104.31584-15-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 01, 2021 at 03:10:48PM -0700, Yu-cheng Yu wrote:
> Shadow stack accesses are those that are performed by the CPU where it
> expects to encounter a shadow stack mapping.  These accesses are performed
> implicitly by CALL/RET at the site of the shadow stack pointer.  These
> accesses are made explicitly by shadow stack management instructions like
> WRUSSQ.
> 
> Shadow stacks accesses to shadow-stack mapping can see faults in normal,
> valid operation just like regular accesses to regular mappings.  Shadow
> stacks need some of the same features like delayed allocation, swap and
> copy-on-write.
> 
> Shadow stack accesses can also result in errors, such as when a shadow
> stack overflows, or if a shadow stack access occurs to a non-shadow-stack
> mapping.
> 
> In handling a shadow stack page fault, verify it occurs within a shadow
> stack mapping.  It is always an error otherwise.  For valid shadow stack
> accesses, set FAULT_FLAG_WRITE to effect copy-on-write.  Because clearing
> _PAGE_DIRTY (vs. _PAGE_RW) is used to trigger the fault, shadow stack read
> fault and shadow stack write fault are not differentiated and both are
> handled as a write access.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
