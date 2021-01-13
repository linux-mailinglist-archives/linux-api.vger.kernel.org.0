Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6211D2F4A05
	for <lists+linux-api@lfdr.de>; Wed, 13 Jan 2021 12:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhAMLYu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Jan 2021 06:24:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbhAMLYu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Jan 2021 06:24:50 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B69C061575;
        Wed, 13 Jan 2021 03:24:09 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b26so2201926lff.9;
        Wed, 13 Jan 2021 03:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jp7oVCO/s16g25YLCPyXULxbDEtiWxyNjeq/cNPPspM=;
        b=VDn/be97YAMsrOqxP8NWvn8/sfGec6JYdD3JXTc/FHdeoqVOWjb2U+XynWI/ioyoKo
         /+BFJ9t1dxplVTpU3kuzQnA5GDEnHDDNnfwiPrI8uRecJs9PQnzmMuEpKRRxgugYwRgp
         g+Udn9cBXt6m3OfGr5RCpzrq4RKs75KvbVEcqjxeYcvMj6wwhrmCcPL1PGT2npo0HVKy
         pCFcHosBG95HZYTj1txbrbnpY+aE6+rOOwxppYoUDc0z/Z95qEDjwUN59qbOgwHtipqk
         jUdAYLO1TLNhAbL+ctts8/oPnJYUWaSyIPli+RXDlETK89YCWM1IP5NcKOEzft5I/EnT
         MRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jp7oVCO/s16g25YLCPyXULxbDEtiWxyNjeq/cNPPspM=;
        b=lSTqkp/4J8YbuowFtWjad7bBUON48KM2uVlytPlGBXIfYhQxT+qb3acW+qwk3M95TF
         /WSXkFO6oyU6CTtkDpnv5vkZRd64NqHJST1pN2GBLsuZE18545CNXfdA81UyXHwNVeLt
         DZvwy7MxpTKpiEO24XPV+EOtQrwlVt5ks6NgfqwZ4qrweDwMXK43uRoG1Mt4Yji1LChS
         0Kj+b9zuXPGbe48VFAtzesoz7Ux14IQMrhnmaonKcLApt5f1K/JzbsfQxaYjgS1AeAcm
         5Jy3CzuP+Ka8DJooun4DC7TmkaaWb3zQlU28mod8yGps2T0n3PFTzHowaOqf6NxXVpQt
         nZ8w==
X-Gm-Message-State: AOAM533sVj7lzm7wdJVNyIWe0uZRoJZ5aYLhTMfEupj++Se2TMWZAcug
        TS5vEzwkDLuGt1KoQLknBhrBn4s1KPvjFA==
X-Google-Smtp-Source: ABdhPJz9z9zAfqVegJwhvFz1yzEBK99SQdYj+K3YwCrQwiLG55NndrE9lWOP4cfZkSkk0DQHrHYyxA==
X-Received: by 2002:a19:8983:: with SMTP id l125mr681304lfd.182.1610537047952;
        Wed, 13 Jan 2021 03:24:07 -0800 (PST)
Received: from [192.168.1.33] (88-114-222-21.elisa-laajakaista.fi. [88.114.222.21])
        by smtp.gmail.com with ESMTPSA id m7sm180344lfb.146.2021.01.13.03.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 03:24:07 -0800 (PST)
Subject: Re: [PATCH v9] mm: Optional full ASLR for mmap(), mremap(), vdso,
 stack and heap
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20210104155316.16259-1-toiwoton@gmail.com>
From:   Topi Miettinen <toiwoton@gmail.com>
Message-ID: <ee152267-744d-b619-4400-35e3ddbac16a@gmail.com>
Date:   Wed, 13 Jan 2021 13:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210104155316.16259-1-toiwoton@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4.1.2021 17.53, Topi Miettinen wrote:
> Writing a new value of 3 to /proc/sys/kernel/randomize_va_space
> enables full randomization of memory mappings. With 2, the base of the
> VMA used for such mappings is random, but the mappings are created in
> predictable places within the VMA and in sequential order. With 3, new
> VMAs are created to fully randomize the mappings.
> 
> Mappings created with mmap(NULL, ...) are randomized and mremap(...,
> MREMAP_MAYMOVE) will move the mappings even if not necessary. The
> locations of heap (memory allocated with brk()), stack and vdso are
> also randomized.

It seems that always moving the mappings in mremap() can expose bugs 
where the callers don't actually expect the mappings to move, even 
though MREMAP_MAYMOVE is specified (Debian libapt-pkg6.0):
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=980037

Perhaps this part should be a separate option to avoid tripping such 
bugs when compatibility is more important than improved ASLR and 
debugging. The option could be also used without randomize_va_space==3. 
How about something like sysctl.kernel.mremap_always_move, 
sysctl.vm.mremap_always_move or CONFIG_MREMAP_ALWAYS_MOVE?

-Topi
