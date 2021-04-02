Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C49352648
	for <lists+linux-api@lfdr.de>; Fri,  2 Apr 2021 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDBEhQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Apr 2021 00:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhDBEhQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Apr 2021 00:37:16 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E3DC0613E6
        for <linux-api@vger.kernel.org>; Thu,  1 Apr 2021 21:37:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so4093954pjb.4
        for <linux-api@vger.kernel.org>; Thu, 01 Apr 2021 21:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vM45/P2fkskhNC9Pi4JhTYL40XcOm7rleD9sfr3mD98=;
        b=umn0kYFQss3RUcN+MI88Z4iWl2uuiLGyUdqhMxwoNWlHDuYbbgCkT0FQDFeXOnfirK
         k89l1KDyA+VPXoR7p9/EOEjauKHHw+WG4vph7n0k6lcqdXz2H7WvrM9xtun2WzhOz8lt
         xfXZV23UPtftCh7KwJyIE+tvV6jAh+QZx7FccS3yaJLM6mgr1uUBVbk6cRrkMQbZeipj
         jmYMKiPj8ZGtJRzXmrf16BCfkwTDnxP9hTJQ3T89WSMTwoRiWcjOT3/zgLUpcOlFadTg
         hjZp2BxFP+OlBMgT4ZpdFrW3O57a2RLE61n6XsLmjTMtgaFbRB+j8cc36YpuwK2t4crw
         /F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vM45/P2fkskhNC9Pi4JhTYL40XcOm7rleD9sfr3mD98=;
        b=Bo6+wKwjysbd5f1CWAoxvzPgCeAwoEWZseUkPRxF4nMe2+sF63SzpNoF35yJoYBxJa
         U8CmlbCQvotA79jXIDGfnkZyHB8VFmeagf1I8Ox8ptiUBAQSOpFIn3MPVqYbKwzUPQb9
         qpl8B4MJliB2LuXVyzl2QDa4cW9iHvd01SzmpT/8ZDaj9MJqkXe/IayHlbuTbghEY6Rj
         cUCGZmL50K5wKeZhrTcrDkEledIv41cUTPg7x6mJfJddPjIhag6mB/1KLv2t/qq6IsEX
         4O5Pf5SfpHKh63gEPGTFC+T6x2KzPKUnup9eyEVXKxbL58M+lQj3bea0ImYEB8kcXP21
         wkgA==
X-Gm-Message-State: AOAM533zxbV+cYCCIB3+DEXSNpSn1sgmOC/kHxCpBIydvceVyvf8SF1r
        g15TTf/rkr06XQe073TftW+mO3qKtUAyzQ==
X-Google-Smtp-Source: ABdhPJwJpz+wXqtGbLkWvIyoQhjW1a/r+eVcAWwWeT4eygWs+CgHs2CwdQnJik04EKWP9chLze/CJg==
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr12153985pjv.23.1617338235768;
        Thu, 01 Apr 2021 21:37:15 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y5sm6696592pfl.191.2021.04.01.21.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 21:37:15 -0700 (PDT)
Date:   Thu, 01 Apr 2021 21:37:15 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Apr 2021 21:37:09 PDT (-0700)
Subject:     Re: [PATCH] riscv: Bump COMMAND_LINE_SIZE value to 1024
In-Reply-To: <alpine.DEB.2.21.2103302221590.18977@angie.orcam.me.uk>
CC:     alex@ghiti.fr, Paul Walmsley <paul.walmsley@sifive.com>,
        dvyukov@google.com, linux-api@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     macro@orcam.me.uk
Message-ID: <mhng-08e5e4fb-8a42-4f7b-8ceb-ff549784100e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 30 Mar 2021 13:31:45 PDT (-0700), macro@orcam.me.uk wrote:
> On Mon, 29 Mar 2021, Palmer Dabbelt wrote:
>
>> > --- /dev/null
>> > +++ b/arch/riscv/include/uapi/asm/setup.h
>> > @@ -0,0 +1,8 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
>> > +
>> > +#ifndef _UAPI_ASM_RISCV_SETUP_H
>> > +#define _UAPI_ASM_RISCV_SETUP_H
>> > +
>> > +#define COMMAND_LINE_SIZE	1024
>> > +
>> > +#endif /* _UAPI_ASM_RISCV_SETUP_H */
>>
>> I put this on fixes, but it seemes like this should really be a Kconfig
>> enttry.  Either way, ours was quite a bit smaller than most architectures and
>> it's great that syzbot has started to find bugs, so I'd rather get this in
>> sooner.
>
>  This macro is exported as a part of the user API so it must not depend on
> Kconfig.  Also changing it (rather than say adding COMMAND_LINE_SIZE_V2 or
> switching to an entirely new data object that has its dimension set in a
> different way) requires careful evaluation as external binaries have and
> will have the value it expands to compiled in, so it's a part of the ABI
> too.

Thanks, I didn't realize this was part of the user BI.  In that case we 
really can't chage it, so we'll have to sort out some other way do fix 
whatever is going on.

I've dropped this from fixes.
