Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D2342484
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 19:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCSSVQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Mar 2021 14:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCSSVK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Mar 2021 14:21:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A629CC06175F
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 11:21:10 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so7486496qtc.1
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 11:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aZO007NOGK5FV5hcJF+9nPZpAjB3mMOoENzfIjB7eyI=;
        b=Es29CEtKx7aWt0Mu7Rf7r6zP8u1j7OadS2rkCWi2B0aWO4le6y29TMczbOWlrSBehw
         bYCvLUO9imjIJs6ButG39En4CrWVbnOVZE3EJ1UZqco8GEbZqpYjL44mNs6o63TiMdGN
         t8T4hLOCh4mgQ3RFXu2Kcro1RuJWPopOzeOd++uSRvHOwFS6/Bm6xjfkx6VTssMo/mW7
         zicApRiZJmjS/DW56q1D+m4urw40bVrRjm9li2qD11h2oYTlTMWmdB8firSXVf4EjLzv
         nsbK8BjL2jA/0pNztSiDt6rSRLgtmEuxGFDNJ1NFCY01+0yzM4XkylYHLDPDlVgl65Rn
         TcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aZO007NOGK5FV5hcJF+9nPZpAjB3mMOoENzfIjB7eyI=;
        b=UQVmeK4eq5bc3aAUnu+gF0t/we/ZlJ30IotFNpWrNLAztqbAYAhaKHOSUtGvnJUTW7
         R4O89sJMpne+50TO0aTw794SOWL+1FfeMoqFcScHHYrKYcdIy4AmlWRxNrJe8Fn0ikoD
         iQEc6GQlHtPWAqZLvBvEBjr9Tkni4qcFwM2dX8YrcDIr9swMxTPrvaPVmkLW0WmtWSxM
         tizJc6K56xY2wVGrKQoFtj2wlKaZ8izuIP8nDxtVpC99b1h/kTDsIUOgkjCzzuVBjwE3
         Rjk0WSs/XwR8SABS71MIKAYoMjAbHOkJi5lcgizwrvzMKCJbsVcKQW9wPf8EwBKzdcCv
         yy1w==
X-Gm-Message-State: AOAM533h7RsPfZlgYeJWGx/Y6/aVxXAAOgFjtp1/I5gz2TWl/S8078Ag
        jZ5dT4DMyVdoNpcuaGQyIoL56g==
X-Google-Smtp-Source: ABdhPJysGF2xqgjPbje3n3YZdro3ADum8wBFF6X03iG4iyBfDoEyHZOq/lt0JUA7mzMEkupxjVFjmA==
X-Received: by 2002:ac8:4750:: with SMTP id k16mr9100126qtp.239.1616178069757;
        Fri, 19 Mar 2021 11:21:09 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o21sm4243759qtp.72.2021.03.19.11.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 11:21:09 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1615922644.git.osandov@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
Date:   Fri, 19 Mar 2021 14:21:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <cover.1615922644.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/16/21 3:42 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This series adds an API for reading compressed data on a filesystem
> without decompressing it as well as support for writing compressed data
> directly to the filesystem. As with the previous submissions, I've
> included a man page patch describing the API. I have test cases
> (including fsstress support) and example programs which I'll send up
> [1].
> 
> The main use-case is Btrfs send/receive: currently, when sending data
> from one compressed filesystem to another, the sending side decompresses
> the data and the receiving side recompresses it before writing it out.
> This is wasteful and can be avoided if we can just send and write
> compressed extents. The patches implementing the send/receive support
> will be sent shortly.
> 
> Patches 1-3 add the VFS support and UAPI. Patch 4 is a fix that this
> series depends on; it can be merged independently. Patches 5-8 are Btrfs
> prep patches. Patch 9 adds Btrfs encoded read support and patch 10 adds
> Btrfs encoded write support.
> 
> These patches are based on Dave Sterba's Btrfs misc-next branch [2],
> which is in turn currently based on v5.12-rc3.
> 

Al,

Can we get some movement on this?  Omar is sort of spinning his wheels here 
trying to get this stuff merged, no major changes have been done in a few 
postings.  Thanks,

Josef
