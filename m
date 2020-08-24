Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258C225078E
	for <lists+linux-api@lfdr.de>; Mon, 24 Aug 2020 20:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHXS2t (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Aug 2020 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHXS2n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Aug 2020 14:28:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB62C061575
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 11:28:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 144so8362487qkl.5
        for <linux-api@vger.kernel.org>; Mon, 24 Aug 2020 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kbc/0WNSK9GQMv/tCTMpnArWp4pi8OypQ1VFEUDrLJs=;
        b=tiTYDHa40+e7vInQq3bJ5RrwlxWXhpIhqsp8MSuJn5Jf2jcFRYuF0q5UdYADc+a7+P
         rqXZmuSHAH3R+6S1PJtqiJt72nTvtTjIFnXLNI4i36TWq5GXGnvVgwJxoFwvAS1bRkLb
         y8q4Cccqv30W5NejxKIKDDN1WzGAwZrtJqxPHW7Gm3yx1MuDDk0k4Sne0arrWKqQtB9e
         VvNTmbrmfq9f8Yihv5kTJqD5gzc7yU4PzDyQ5KPfeliMlEyC/AF7vy9aQK3MG9r6zvU6
         miVQUqYCmGCD4ZXvye4GIk5VzCRqJ3D2X53QspKVfpFxwWZQ0B0prKSkyyHFN1huEGq6
         42EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kbc/0WNSK9GQMv/tCTMpnArWp4pi8OypQ1VFEUDrLJs=;
        b=pyHlpz3V61yDCUhJ4QXDuQ086Ks2LbZmX4FjzUeidQdsove/xMMUF1TQk0oEW5iWaR
         ozQcdfD88MfPgGNbA5X30qiccPp/D7iaeGbjK6rgpP/4MhayoQWtTMs0tKmL4gleg/Re
         qgyOxE5+kNTja5CbWSCo8j//Rna9SPvEd7BXeMRH0iduuqWERTRJfUp1nNz4/9KeXOrx
         vWCAuHC3mt0H7K9zm4x3J4+UjtVSE3N1uMQwgfuBGafCno0XLg16E4SA9o2Nv5H9SQH7
         VxQTXFeFn3bwW6pcSt5B6vm+O4Mn3n/t0JZp/M8EbfEzB7yLiyApP9+Htla27ZVAXIPG
         ENcg==
X-Gm-Message-State: AOAM532Lv3or/yf6bH/3cMTHLmqvB4ayXU58/y6Tdg/uJpmNgptnIGFh
        6KSVeesmK4vm1y/iFWWe+lZnYA==
X-Google-Smtp-Source: ABdhPJz2aev34dwnZ9X3QRxlmhuNgGb0N5/eRXSkAkIaH0ZIeF+Z6EDHjZzU5Y6XtZZRi7frXXBQ/Q==
X-Received: by 2002:a05:620a:134b:: with SMTP id c11mr3992176qkl.256.1598293722046;
        Mon, 24 Aug 2020 11:28:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v185sm7964175qki.26.2020.08.24.11.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:28:41 -0700 (PDT)
Subject: Re: [PATCH v5 2/9] fs: add O_ALLOW_ENCODED open flag
To:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597993855.git.osandov@osandov.com>
 <f0db9f271dbe563d2ceaae68f8b74ce4b424efe5.1597993855.git.osandov@osandov.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3c44cdf2-e0fd-cea1-4028-d6315ba3b7fd@toxicpanda.com>
Date:   Mon, 24 Aug 2020 14:28:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f0db9f271dbe563d2ceaae68f8b74ce4b424efe5.1597993855.git.osandov@osandov.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/21/20 3:38 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The upcoming RWF_ENCODED operation introduces some security concerns:
> 
> 1. Compressed writes will pass arbitrary data to decompression
>     algorithms in the kernel.
> 2. Compressed reads can leak truncated/hole punched data.
> 
> Therefore, we need to require privilege for RWF_ENCODED. It's not
> possible to do the permissions checks at the time of the read or write
> because, e.g., io_uring submits IO from a worker thread. So, add an open
> flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> fcntl(). The flag is not cleared in any way on fork or exec; it should
> probably be used with O_CLOEXEC in most cases.
> 
> Note that the usual issue that unknown open flags are ignored doesn't
> really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.

It seemed like you agreed to require O_CLOEXEC to be set when using 
O_ALLOW_ENCODED in your last go around, what happened to that?  I know I'd feel 
better if we had that requirement, and if we aren't I'd like to know why we 
can't.  Thanks,

Josef
