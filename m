Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED0F3128E0
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 03:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBHCSo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 21:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBHCSo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 21:18:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD194C06174A
        for <linux-api@vger.kernel.org>; Sun,  7 Feb 2021 18:18:03 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so8619653pjb.1
        for <linux-api@vger.kernel.org>; Sun, 07 Feb 2021 18:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GAcPfGgqFaC7AQHCBuJv2BWxwOPW6rvQxJdX43h7J8I=;
        b=RFsozuFj8ctQYWnOlHXA/Y/S/JT+BT2d1zgMTOBparInBD0Zft//MwDz9Pv3qTpRo6
         cYnt4/eMEoTNmZaIjVO2TLhCmJ5C57vV4qvNpNJbSbEiEAYxF4yWJG4MXu8cAsWDTDo+
         WbVbEUREEq2v/o6uVpD3zSkYM6tjdfLSWrvXySJCEv2KSD78mt+euMZNuzFuILuIrev/
         gekJ7tvJj2hVKKklNDYczXUA/ko/19HwJDowAenLYVLrIG2SP/7gwDb1vJahO8ndfhgh
         01X02jthq8tr3Gyytp+nR/cZpF484dMC3l0bxJqjGc6dIl8lMe9epYDH0TO4L9WbxQHy
         xe+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=GAcPfGgqFaC7AQHCBuJv2BWxwOPW6rvQxJdX43h7J8I=;
        b=ZovUd1C6ax1sJJU3itsWGt1NO+GRfRTnr0FqsAg25CtC6AgHwGsATDoOfyoATSS22Q
         VhaEYwLSlphKuL30uidZD7oDY3Ukh6w8cEZLkPvTyMbDdLKExA8OK1WJ8wezb4ZOdLP9
         GrCe/S9Hm96LTZVTaJTU1P5RmVMendxL80b6miI7OIFw4U1UjY1zCr3VnlSadqDH91QY
         3FIR1HiqQwVUX3duigJcBygipbAj+1tea8TgpsNQl5T8Cq+TAVtW4wP070bu1C/WDxVI
         ssDs2kl+CwI8xo0pn4AdqdYGCMeKOEf89yJ7hKdng9Cco8e5zgQUeQjpJvxg5PX5KAM8
         pOtg==
X-Gm-Message-State: AOAM532Z53qzFb7xsgrjdClo5hEPA1bRkZ0iXVAjPL87j1vIDETXCpz+
        xZhQexvEC2GClGHLUdYtpvUO7Q==
X-Google-Smtp-Source: ABdhPJzp7qfYhmXBu6bdi33JxaukusthN+TP0Ot/ZqOrf1qCP06tl6JjG1EiU2ivo+TK3WKChum8ew==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr14552165pjr.220.1612750683085;
        Sun, 07 Feb 2021 18:18:03 -0800 (PST)
Received: from [2620:15c:17:3:8d40:a1e2:ae2d:6c53] ([2620:15c:17:3:8d40:a1e2:ae2d:6c53])
        by smtp.gmail.com with ESMTPSA id f33sm354958pjk.17.2021.02.07.18.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 18:18:02 -0800 (PST)
Date:   Sun, 7 Feb 2021 18:18:01 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: RE: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
In-Reply-To: <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
Message-ID: <90aca1e9-61b5-88d-d28c-369e6973559e@google.com>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com> <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com> <20210207213409.GL308988@casper.infradead.org> <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, 7 Feb 2021, Song Bao Hua (Barry Song) wrote:

> NUMA balancer is just one of many reasons for page migration. Even one
> simple alloc_pages() can cause memory migration in just single NUMA
> node or UMA system.
> 
> The other reasons for page migration include but are not limited to:
> * memory move due to CMA
> * memory move due to huge pages creation
> 
> Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
> in the whole system.
> 

What about only for mlocked memory, i.e. disable 
vm.compact_unevictable_allowed?

Adding syscalls is a big deal, we can make a reasonable inference that 
we'll have to support this forever if it's merged.  I haven't seen mention 
of what other unevictable memory *should* be migratable that would be 
adversely affected if we disable that sysctl.  Maybe that gets you part of 
the way there and there are some other deficiencies, but it seems like a 
good start would be to describe how CONFIG_NUMA_BALANCING=n + 
vm.compact_unevcitable_allowed + mlock() doesn't get you mostly there and 
then look into what's missing.

If it's a very compelling case where there simply are no alternatives, it 
would make sense.  Alternative is to find a more generic way, perhaps in 
combination with vm.compact_unevictable_allowed, to achieve what you're 
looking to do that can be useful even beyond your originally intended use 
case.
