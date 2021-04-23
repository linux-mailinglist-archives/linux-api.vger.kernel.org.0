Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A5036901F
	for <lists+linux-api@lfdr.de>; Fri, 23 Apr 2021 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241997AbhDWKOc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Apr 2021 06:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhDWKOb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Apr 2021 06:14:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994DC061574
        for <linux-api@vger.kernel.org>; Fri, 23 Apr 2021 03:13:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j18so76763042lfg.5
        for <linux-api@vger.kernel.org>; Fri, 23 Apr 2021 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gnaf3r9UNdG1FggI1YyKvtZjPl2wCw9hbk0IVarKdeY=;
        b=rohJ3ApdIp8eIDty7ZTykL0M+0n3Epndq2W6IeNG7zaahDj/PopRDPrmIvMNC5+N5q
         AbvRN7ueJnP4X2turnnaqbrP6Os4PRpq5vuSizTQDpO5+U7hQ8upLvlWgZ5Q9TBz2oRD
         SzqgQhOBxMZv76R3gF7og4Q9hoI1fQZgXTPB8BfTIymSc8oUc62hJd9YYqip9qBV6xl0
         1OeDqztS0gOfQxsE12iqR4DLWIe98uxJIdb5LaueIcey95FCDvFFxL5sGmlQ1gJtuMg2
         JBH+yeQy2LyQLAkvjJnkBhNAy6ciRblNJIOHfcp2z8Ush5vGQicLNhE9yuknfI5K7Qg/
         Dy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gnaf3r9UNdG1FggI1YyKvtZjPl2wCw9hbk0IVarKdeY=;
        b=jkvSqhSxsggIsI+LNGcX4Y6Kn90+PNEvdTXimhzGLlERReIl+Au9p00gmu0TKtNSn0
         QVSQU2AJ9LX1DlwZpoYjSiTRyZ01LtEccbczjmxTSsrPLvZD7yfcbRGKnxgXFI49ALfI
         VawX/qTCqJ9wk3U6sqbRn5Vw5HldvC1j0FACnwl5ChgR9WjWL5OGF2WO7gTsJg8Wlg2R
         2HEZkWVRxpb08PjkR3/TDxnKdwNVgC7My9dC23yuIpRJkLbAgufDLd9utXrNsUG8j/Gj
         q08NjZyBiskPcOdlWwB2tdlJzPk+fHy7uDY/uqaqzbFJOZt8Fct3b9dN2UG3x7W6cY6K
         VcZw==
X-Gm-Message-State: AOAM530ZxmbBXrPsyNhrLJIVBT7/yuXsuRnt1OiEby65TCZWeh1yM5KA
        +OWxstDF7CUGoMo6lK/XzTjtqw==
X-Google-Smtp-Source: ABdhPJz9uy18OLUxIti5N9jQtwFUmXPO5gGtMxzSl2Fy0S1+VLIN2ACGrMCf6lbceikj1AyzpdDXhA==
X-Received: by 2002:a05:6512:308a:: with SMTP id z10mr2280947lfd.15.1619172831869;
        Fri, 23 Apr 2021 03:13:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h66sm505910lfd.248.2021.04.23.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 03:13:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D32BC10257F; Fri, 23 Apr 2021 13:13:52 +0300 (+03)
Date:   Fri, 23 Apr 2021 13:13:52 +0300
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
Subject: Re: [PATCH v25 16/30] mm: Fixup places that call pte_mkwrite()
 directly
Message-ID: <20210423101352.zwvltq734peuec4g@box.shutemov.name>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
 <20210415221419.31835-17-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415221419.31835-17-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 15, 2021 at 03:14:05PM -0700, Yu-cheng Yu wrote:
> When serving a page fault, maybe_mkwrite() makes a PTE writable if it is in
> a writable vma.  A shadow stack vma is writable, but its PTEs need
> _PAGE_DIRTY to be set to become writable.  For this reason, maybe_mkwrite()
> has been updated.
> 
> There are a few places that call pte_mkwrite() directly, but have the
> same result as from maybe_mkwrite().  These sites need to be updated for
> shadow stack as well.  Thus, change them to maybe_mkwrite():
> 
> - do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
>   and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
>   them to maybe_mkwrite().
> 
> - In do_numa_page(), if the numa entry was writable, then pte_mkwrite()
>   is called directly.  Fix it by doing maybe_mkwrite().  Make the same
>   changes to do_huge_pmd_numa_page().
> 
> - In change_pte_range(), pte_mkwrite() is called directly.  Replace it with
>   maybe_mkwrite().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Kees Cook <keescook@chromium.org>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
