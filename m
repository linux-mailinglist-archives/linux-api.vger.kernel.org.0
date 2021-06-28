Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEBE3B5DED
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhF1M10 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhF1M1Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 08:27:25 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCDAC061760
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 05:24:59 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d25so25411384lji.7
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 05:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZl19EAHfBMj6o+esp+Ag6rbRzMSpGqttEk0/Qom/6Y=;
        b=ZVOOxa14dG+gGR+HyULgfW1QlZEE0vq5WSIHRrgiYp/5DUgQrlUg70uTV9+iiQJOS8
         Pe+tAx0ojKZ2yuaQIO/FdCeNLGMO39zO+3ghXHaGFb8Qv8ePjd2zRehTJFBSME3itL+N
         I4PF9q/n+1mVW9pd2W3di0CYIOLGySCGxFs1hPQL3cVZ8Nvm7PSEvIwX0+LSAqzn+AHP
         iK3mFtpAvxhnFAsLzeYuLG33r3zC3xTSgxkhDRIZ1EyktWdBn7qOB0Lv/WnKkjwB8Zei
         PZfQu+0zQ2cpmQizSDr0XELO9PnJNinhQMSs8rMRcoWZ7nNKtHnHR/jLeX1UEUH/9d2F
         YEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZl19EAHfBMj6o+esp+Ag6rbRzMSpGqttEk0/Qom/6Y=;
        b=WMsGakZo2iECq5AzjFpSvnE4v9TqKfQb09Y1lHSQi86W+CEg/S2phTX2ETIkAumqhp
         uvsOaULew3OcVoMfnaooOhVEohtqyHJ+FWz41HfXkN1AjxrzT0EuShuy60vUg0Jn3Mns
         r3sq0Bn/lp9Lf+NLfJRfGCyJnEucvkblQu0Vgb4T6NG2+Y8UVZkYUc1GCoDvqWXDWHqf
         rU8KxP+3UwlxmiWzarA4cXR/eMhbRp5vgtDbUQvUpIHNYsnu/xBFfFuynSWDwM3myu4n
         QF2oVruZk1u6qJ+JKzAHO4g21cSs9dUeYXj/Sfm47pnNGt8a0gADtedONckhrgIEt7VR
         Jdtw==
X-Gm-Message-State: AOAM533OM0aypDUbMemFIy2SGrKfoeqWfU808dpbH/NGE235TdLm0Et0
        ma8GCW9PBglKfNIujVmEaJ17NA==
X-Google-Smtp-Source: ABdhPJyfJ8jeeyfOn0CBv6l9Qm89e2M0XZhNu8UyBRm8yx8et6Em68BU7cax6g9fdMATElyOwR72kA==
X-Received: by 2002:a05:651c:10a8:: with SMTP id k8mr5284294ljn.99.1624883097640;
        Mon, 28 Jun 2021 05:24:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v3sm1355213lji.115.2021.06.28.05.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 05:24:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 066BE10280E; Mon, 28 Jun 2021 15:24:56 +0300 (+03)
Date:   Mon, 28 Jun 2021 15:24:55 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Collingbourne <pcc@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] mm: introduce reference pages
Message-ID: <20210628122455.sqo77q4jfxtiwt5b@box.shutemov.name>
References: <20210619092002.1791322-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210619092002.1791322-1-pcc@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jun 19, 2021 at 02:20:02AM -0700, Peter Collingbourne wrote:
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <sys/mman.h>
>   #include <unistd.h>
> 
>   constexpr unsigned char pattern_byte = 0xaa;
> 
>   #define PAGE_SIZE 4096
> 
>   _Alignas(PAGE_SIZE) static unsigned char pattern[PAGE_SIZE];
> 
>   int main(int argc, char **argv) {
>     if (argc < 3)
>       return 1;
>     bool use_refpage = argc > 3;
>     size_t mmap_size = atoi(argv[1]);
>     size_t touch_size = atoi(argv[2]);
> 
>     int refpage_fd;
>     if (use_refpage) {
>       memset(pattern, pattern_byte, PAGE_SIZE);
>       refpage_fd = syscall(448, pattern, 0);
>     }
>     for (unsigned i = 0; i != 1000; ++i) {
>       char *p;
>       if (use_refpage) {
>         p = (char *)mmap(0, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE,
>                          refpage_fd, 0);
>       } else {
>         p = (char *)mmap(0, mmap_size, PROT_READ | PROT_WRITE,
>                          MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>         memset(p, pattern_byte, mmap_size);
>       }
>       for (unsigned j = 0; j < touch_size; j += PAGE_SIZE)
>         p[j] = 0;
>       munmap(p, mmap_size);
>     }
>   }

I don't like the inteface. It is tied to PAGE_SIZE and this doesn't seem
to be very future looking. How would it work with THPs?

Maybe we should cosider passing down a filling pattern to kernel and let
kernel allocate appropriate page size on read page fault? The pattern has
to be power of 2 and limited in lenght.

-- 
 Kirill A. Shutemov
