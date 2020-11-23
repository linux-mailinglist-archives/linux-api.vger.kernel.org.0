Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0E2C1306
	for <lists+linux-api@lfdr.de>; Mon, 23 Nov 2020 19:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgKWSVA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Nov 2020 13:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbgKWSU7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Nov 2020 13:20:59 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE41C0613CF
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 10:20:59 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id m9so15019888pgb.4
        for <linux-api@vger.kernel.org>; Mon, 23 Nov 2020 10:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXjQw/Ei2ozuIWUZyXPQXVN4Mqw8skdXF2+muz2N79E=;
        b=s+K6c+/1JMFv5v1GY5Rt4oHFUl3vsl5xKDRka4miXE/3AEPkByXvY2M3x8+WfDrIzJ
         WCTTmBXMSw0jdFXi4vPbaJjwNZRpK77r5EN2S35021v7Ev+DzPW9Sb2tDw5Nzj7Z0x77
         N/B7RFCnbe3my9RJxaH3dtnI06yA9386agGRM7nLg02J9QfNI6INmQltHeFkGLXmOxRg
         2l9me9tjj8fTwpir07h7iLmk/BK0gmX+9TBVqEthYuJOdBdiQh8+0kmQiJXBeaS7fHCp
         heqnPA/yAYJ5d/IlXFkdiYG6hAJ4JPy0L0c96jjmf8p1m3IAv87RGr8V0Ba/IinMjPzn
         nNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXjQw/Ei2ozuIWUZyXPQXVN4Mqw8skdXF2+muz2N79E=;
        b=aVdO4d3y14mTZKy/v3eWIOgZOxTEk+LIcJFA0z1TUz5Y1FcxDmjWIRkdg3l+QDlUs1
         KiL+ZibSi1GH4vIsBHdpCGk7ShioEfHWJypREDxVJ105dwWXND0UT4ZumM3+C0nzf6Gu
         CdPP8oCO6IpeO/PIvrk6WMjd13vXx50PhczDBMadyqLTkNR7SuV/a6JkYt4edwfay23z
         I+L1abyKqYqFt4XmEaDM7U1BqETrSXwldCrblyjk1DV6eTqgnD/9x1fnV6TUkkf+2TEA
         7bgPYekeYmg0hONZF80Rn0nuEXs1r+1kmN3kRNQDCjiO2Ce6Pfas7QCt0n7YBH3nTPw9
         TUhw==
X-Gm-Message-State: AOAM5300ls/OVcjoa9LjpqiQt8OVO8R6aubLx8WkcdHBFw4Lq2Dn/7ph
        hoA0XDspltg2RVg3ZkSpv1HDEKe4CLd8huIq8aVHag==
X-Google-Smtp-Source: ABdhPJzRohL9fsaii/K1Xw/nq0y8iaZIigOAp8jNEBB2DO23+xsD1mUl5DscPIvbbiZz6YUhrmKf6/fSi6x+r7YOQXk=
X-Received: by 2002:a17:90a:db03:: with SMTP id g3mr175751pjv.41.1606155658781;
 Mon, 23 Nov 2020 10:20:58 -0800 (PST)
MIME-Version: 1.0
References: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
In-Reply-To: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Nov 2020 19:20:47 +0100
Message-ID: <CAAeHK+wvFC+Nx+1==2oidsm=3xFC_0n9jNarnTB2j5eq5CTdkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: arm64: set TCR_EL1.TBID1 when enabled
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Nov 21, 2020 at 10:59 AM Peter Collingbourne <pcc@google.com> wrote:
>
> On hardware supporting pointer authentication, we previously ended up
> enabling TBI on instruction accesses when tag-based ASAN was enabled,
> but this was costing us 8 bits of PAC entropy, which was unnecessary
> since tag-based ASAN does not require TBI on instruction accesses. Get
> them back by setting TCR_EL1.TBID1.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Link: https://linux-review.googlesource.com/id/I3dded7824be2e70ea64df0aabab9598d5aebfcc4
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 1 +
>  arch/arm64/mm/proc.S                   | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 01a96d07ae74..42442a0ae2ab 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -260,6 +260,7 @@
>  #define TCR_TBI1               (UL(1) << 38)
>  #define TCR_HA                 (UL(1) << 39)
>  #define TCR_HD                 (UL(1) << 40)
> +#define TCR_TBID1              (UL(1) << 52)
>  #define TCR_NFD0               (UL(1) << 53)
>  #define TCR_NFD1               (UL(1) << 54)
>  #define TCR_E0PD0              (UL(1) << 55)
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 23c326a06b2d..97a97a61a8dc 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -40,7 +40,7 @@
>  #define TCR_CACHE_FLAGS        TCR_IRGN_WBWA | TCR_ORGN_WBWA
>
>  #ifdef CONFIG_KASAN_SW_TAGS
> -#define TCR_KASAN_FLAGS TCR_TBI1
> +#define TCR_KASAN_FLAGS TCR_TBI1 | TCR_TBID1
>  #else
>  #define TCR_KASAN_FLAGS 0
>  #endif
> --
> 2.29.2.454.gaff20da3a2-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
