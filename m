Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D51830FD5C
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 20:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbhBDTyE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 14:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbhBDTvj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 14:51:39 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34E9C061356
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 11:50:17 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o63so2857180pgo.6
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 11:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVfkuBJxoMHahNTAuzjMVwQ5V275LoCHtWLRN4+qRmA=;
        b=SMhMJ0y1hFFkybLoK6RuX6W/uHtQZL/bYx1Vgct5XlRDHsQX7hEStJhU3muUb4fbEv
         hiUTrOqPhcz1pfUb97munHXmjX0c8gXGZ3hYDWbcMqclDY0sjxLOb8ku8yWr5/G0SoNh
         WUrWnsUWQvaHO1lagOpKt+BD5lQaiuCJGoC+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVfkuBJxoMHahNTAuzjMVwQ5V275LoCHtWLRN4+qRmA=;
        b=NxcVaFmOuuSyFYCUBBen6pOR0FqkhARYSHbZ9SldVCJKhoAD9NiCEB16UX97nEbbho
         O4mn8doyGYntUdAjlg3Oj2A3FIl1diA0LLRqKvmFeFhdDt7IIbDFSA9XWw4y+TqMXJMm
         /8YdBP1FVC50CoENrRmc1TPufxE4dJTargzIy063F09FoQScEI7u4CJblvhD7DqRmVcR
         kge/zas1CyNGb0GgcuUEeTkunMYZWoovcXLFUWGWyH0/IPvzF1p5FiF6UnewExu+z1Kd
         lr9KCo/a7dmQxjQ3qR2/PODOMmG0Mt9CbjyUmyPV/N/31bdtvPZntTH8pkondNu0tHwM
         v+eA==
X-Gm-Message-State: AOAM533i/EV7OIzjxxVOtqxkl1P1YivCoWxdwlZfbiYA+pM3Qc1s73Uq
        yFbu8L9e9QRw87Y4Zw0L+PiUhQ==
X-Google-Smtp-Source: ABdhPJzOajMVaIDiSuI0Zs6A72FQUA7Xr4U1otuUXAtASSA9xiRUczq+mdvc5mt1TaWo3NxHiyLjQw==
X-Received: by 2002:a62:7d03:0:b029:1bb:5919:6dec with SMTP id y3-20020a627d030000b02901bb59196decmr766097pfc.76.1612468217541;
        Thu, 04 Feb 2021 11:50:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y16sm7231723pfb.83.2021.02.04.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:50:16 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:50:15 -0800
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
Subject: Re: [PATCH v19 4/7] x86/cet/ibt: Update ELF header parsing for
 Indirect Branch Tracking
Message-ID: <202102041150.191C2FC@keescook>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
 <20210203225902.479-5-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225902.479-5-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:58:59PM -0800, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates features the file supports.
> The property is parsed at loading time and passed to arch_setup_elf_
> property().  Update it for Indirect Branch Tracking.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
