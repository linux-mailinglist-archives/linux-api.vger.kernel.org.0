Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B340033B1A4
	for <lists+linux-api@lfdr.de>; Mon, 15 Mar 2021 12:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhCOLp2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Mar 2021 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhCOLpY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Mar 2021 07:45:24 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F7C061574;
        Mon, 15 Mar 2021 04:45:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id r20so15816490ljk.4;
        Mon, 15 Mar 2021 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vjVaFcFS2KPU0GR3VSubynVn74gNiK4UAqEdkhZDP14=;
        b=m/SSTTBPYiAAUBv4tnDpAOsgVB9MAKJ0KtUuCJ33y1G0NV4YdczLMiHsDwYJ0F7Ttq
         hBGNJkA8oGO+WlO71tH3x2upyUBabG6oXORPmX5BW5ygwoTfX8eni+POPLsCPHWq2cio
         CeNbvUHhkLmfj2iKPKwdAXqhDXdAfRL/A9CPmbYprGjcUgzlSn3hfuIXjQMGCR4e0x37
         Y3ieN0o22uDL2F/fpgkr8r1xdccp+nkCCQwPlCvG7NQo5WpWPRJ+pl9QEDjQ6gDWfalZ
         TCdw+LpvHpkIyuhpTgo1gS1IpB8BdLP7nr6V9UpN/LzrsjbO6jlkVDqaiV9nL3vjy13z
         r2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vjVaFcFS2KPU0GR3VSubynVn74gNiK4UAqEdkhZDP14=;
        b=FrI09z/sQAsJRgB3yh4q91aGHHPLzgH5WqRuXWpfkOMsVkdmnxY0l1iYmKgP24qsAC
         jeuS3ZaW4BxQOmC9bIPc4kaS5fgMbIh16Nzws2qZarly+g6tnP0cqCRWIuawn23QOyN0
         fEeOZlt7AnkVH2p0vNT6KKEwLpFxI6BcPuhp9rky5zWuZrdjMgzEyyyJtMBHdG3vbdM/
         xy8G0/MW+kFp3dCLhUOucVPOLRWXm9FN6w3M5zPWIfAyZoLYVYcSLvGOToCHzIRFZepG
         vLPZClY6ldEZqqPKf+5xL2Ruskaey8URpYDjwE0X60fgvlAgpJcAmdtbsPYdFBuXDHwE
         DZkA==
X-Gm-Message-State: AOAM530IhJryVWRBDotSra72mTipgStM7+k7Gkp6uoKjI6Vn+NEE94Sn
        NziQNmdPEcyl96w6EwrX2OI=
X-Google-Smtp-Source: ABdhPJzx8iQDlbKxv1vTmHq7rJcQaw8hBkXgcXKtKQFUPZUqCq5P2Qjhu7gM3M5Ayc1XSfOljBum7g==
X-Received: by 2002:a2e:95d6:: with SMTP id y22mr10256746ljh.361.1615808722604;
        Mon, 15 Mar 2021 04:45:22 -0700 (PDT)
Received: from [192.168.1.39] (88-114-223-25.elisa-laajakaista.fi. [88.114.223.25])
        by smtp.gmail.com with ESMTPSA id i16sm2851508ljj.74.2021.03.15.04.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 04:45:22 -0700 (PDT)
Subject: Re: [PATCH v4] mm/vmalloc: randomize vmalloc() allocations
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20210309135757.5406-1-toiwoton@gmail.com>
 <20210314172312.GA2085@pc638.lan>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ba975607-9493-c78c-bbd8-6a85573114d1@gmail.com>
Date:   Mon, 15 Mar 2021 13:45:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210314172312.GA2085@pc638.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 14.3.2021 19.23, Uladzislau Rezki wrote:
> Also, using vmaloc test driver i can trigger a kernel BUG:
> 
> <snip>
> [   24.627577] kernel BUG at mm/vmalloc.c:1272!

It seems that most tests indeed fail. Perhaps the vmalloc subsystem 
isn't very robust in face of fragmented virtual memory. What could be 
done to fix that?

In this patch, I could retry __alloc_vmap_area() with the whole region 
after failure of both [random, vend] and [vstart, random] but I'm not 
sure that would help much. Worth a try of course.

By the way, some of the tests in test_vmalloc.c don't check for 
vmalloc() failure, for example in full_fit_alloc_test().

-Topi

