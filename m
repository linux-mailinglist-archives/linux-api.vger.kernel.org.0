Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A803343C6D
	for <lists+linux-api@lfdr.de>; Mon, 22 Mar 2021 10:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhCVJOF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Mar 2021 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhCVJNs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Mar 2021 05:13:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F63C061756
        for <linux-api@vger.kernel.org>; Mon, 22 Mar 2021 02:13:47 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id u20so20054983lja.13
        for <linux-api@vger.kernel.org>; Mon, 22 Mar 2021 02:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oeb+PAJt63mP/90xgvzuCXrpKeElQVZ936dwu02SQSs=;
        b=vzzAMo3aw5fcRzSX+G3c49ViQ1+a2Z3evKUgoQIyGT2wxwNav+apCuqkclUmMbnlaN
         zqGSCJfOcEWSq8ssQkZwj+LJc/Ty/8pfNOYsNDllj78fk8jwexa9D9uyOL/WKSj70Usr
         b/FnwK1wkHphsBamUAgAH2GFPKESAUjtpENKMfga60ik9YyY9NFua3ZxI2CL7RjVZn6K
         aSBDoq5ZZSIdeXCzP2lF/W52ZHtaKfzU8cZU95Kpzj3XmLXkes3IYhX0QRvKkBO7r6B0
         waP7sq+Dfk9clJC3leU31iwsQYM3gisuCqBiHUGWg7CkT3CIms5CXdbp1NC4TqHkgmOp
         F7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oeb+PAJt63mP/90xgvzuCXrpKeElQVZ936dwu02SQSs=;
        b=sYB7HFfHybb70e3+AN921D2Hor/GI9v8yD5iO1EJu4weMy2xAdLNaFGWB2xVsh9U0/
         klVtKOpEmOdxHANNICUBLwILbGdjvNeqoJExtOFfh/lRasZ/avKue3yUwq1GDzG7N6P9
         HS+EBcbxL8p6URf+Z6j1dkIxFBHJyOmF5xaFz2GmMZW/Y54Qz8BOCmKxayYbWYY1u34T
         ACW4mMlOLBcu5r2QJLuUByhP9bnEiHxZ4hjOrJI7XiluxqTyaLZ2libtcqK+bLeO3Z+C
         bdsN/lXCe+RgCZYq26eGoM3dwICOYTbHmn2QbEb3gqLQaSmHly9UhIleHc2DL3/ZkXRo
         8i8g==
X-Gm-Message-State: AOAM531EGK8IXvl6mx21U9LZRYKjT9rNXIbRFH2S5jCxeDzQAqfpv5Zn
        uC0ve/ZxwMYjxkFtgsD+44ZTLg==
X-Google-Smtp-Source: ABdhPJxTA9cuU0Tj6UyaICAHV1a7JefKb/E4L50FuiajXX8hVPb/1lKfnwtXmcDOwPFeHA+rJ9ZfkA==
X-Received: by 2002:a05:651c:2005:: with SMTP id s5mr9499871ljo.491.1616404424784;
        Mon, 22 Mar 2021 02:13:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b39sm1792329ljf.68.2021.03.22.02.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:13:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A074B101DEB; Mon, 22 Mar 2021 12:13:51 +0300 (+03)
Date:   Mon, 22 Mar 2021 12:13:51 +0300
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v23 07/28] x86/mm: Remove _PAGE_DIRTY from kernel RO pages
Message-ID: <20210322091351.ulemcluuhqkzuwkm@box>
References: <20210316151054.5405-1-yu-cheng.yu@intel.com>
 <20210316151054.5405-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316151054.5405-8-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 16, 2021 at 08:10:33AM -0700, Yu-cheng Yu wrote:
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
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Peter Zijlstra <peterz@infradead.org>

Looks good to me.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
