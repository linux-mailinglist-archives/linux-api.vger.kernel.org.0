Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95E641388
	for <lists+linux-api@lfdr.de>; Sat,  3 Dec 2022 03:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiLCCiF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Dec 2022 21:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235068AbiLCCiE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Dec 2022 21:38:04 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC16DE02CA
        for <linux-api@vger.kernel.org>; Fri,  2 Dec 2022 18:38:02 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id w23so6231672ply.12
        for <linux-api@vger.kernel.org>; Fri, 02 Dec 2022 18:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odrqLBAkmfFztXwXWAqVopowGGSKTPKe7S+AOTRL1ZQ=;
        b=PWjKyt2Kt/RRycNx6JJO2Pb9jWZ2WJmz6PjIJ0a4FvRuPtDJriT2OWOEx4kRCAfNE1
         nU7sIkDzpgr6zEocy25DpzdzbHUEl1Mcv1P2zgEmUcZYmH+CHZcAkw0z723t6XLPEkRP
         vuCP4ewHulGyB/WHzahfjEFh8VGjAlWyQFWjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odrqLBAkmfFztXwXWAqVopowGGSKTPKe7S+AOTRL1ZQ=;
        b=GyUjWehvXBFVJ3yLUqWG4bcMotsrPn97Nq1/j8WUdBiCtdAvAn0vCV3lRYcVu8G6dx
         gxoE2A0B7/oKRfHqUZCaeGZt5/qVURpBtIcj6pbjo9CV0uejuMYAjeTyIhDxbKRazX61
         HA9sHyJk2x74eUbF3SWg4CT1TIkMqg6mGPGbDaqAjAnJmkQIpc3Y07hAiqV1XlOhnrfd
         HldAuYe3pMUw/9att9sDeQbFlpKYaYoiXSBXb9urP0HLIGFsUm0wtFmf/JdMLE3DAsaN
         rguiPoQtLj8piLHQMqBeUoJ1wvF8dgoqXzdZukX/N0qq027mvFfUQqoylJMqdC+ztc0V
         u8Dg==
X-Gm-Message-State: ANoB5plA6BugeuGIU6P5FapDfKqjAjrOqQPjeiVKx06LqPZm/TZsclXR
        HoE7VE7gV0O0f+CtVfgyZoZALg==
X-Google-Smtp-Source: AA0mqf53Z4Y94GBaMZbVdWNlK3xcI2XLN4/EsyZ8nzte608xXtTxzEMQopHQ1hnL/bUGWJP4cHGDzQ==
X-Received: by 2002:a17:902:9a8a:b0:189:58a9:14a4 with SMTP id w10-20020a1709029a8a00b0018958a914a4mr44708547plp.18.1670035082380;
        Fri, 02 Dec 2022 18:38:02 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x189-20020a6263c6000000b00575d6ec23f2sm5744951pfb.106.2022.12.02.18.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 18:38:01 -0800 (PST)
Date:   Fri, 2 Dec 2022 18:38:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v4 20/39] mm/mmap: Add shadow stack pages to memory
 accounting
Message-ID: <202212021837.AACFC09F@keescook>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
 <20221203003606.6838-21-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203003606.6838-21-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 02, 2022 at 04:35:47PM -0800, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Account shadow stack pages to stack memory.
> 
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
