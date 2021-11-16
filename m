Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054234539A0
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 19:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbhKPS6n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239630AbhKPS6k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 13:58:40 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D604C061764
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:55:43 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i11so142654ilv.13
        for <linux-api@vger.kernel.org>; Tue, 16 Nov 2021 10:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MVFNckbP4TBTfql4KrG+4Ukp5cz3YYPgjjkXF4pzcJc=;
        b=JtPD1BecFV1FEJH0GTNl7174E9A8l550vBQXhFzRj8USVrgQDYjSwRir9Xp8/SHM6+
         p5DaDEQPL1E7ez44Nw+GXeGsnWZBv4nMeaKLhNMdjoo8ixaJq+lv5I4Oc3GXLCyPFpLU
         pdfGDhs42bKvzHcxpDXZJQpMfiPWCKfjGnHYrHBVcC3CYaUUDAe6Sr5tNCFLWUtpJS+R
         affOkx50hu9r2ztdpWGJHQNzorEXr8oZ6ytD95+NcEVboAhNHNVfmRN4Wws3p+MeoeC8
         OurqThAM+iP3jgMeyeimtHZrKdyQhOV9O53NSlb9TSbSnEiwG/0+XC61qqMSdSNPDsva
         utGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MVFNckbP4TBTfql4KrG+4Ukp5cz3YYPgjjkXF4pzcJc=;
        b=d9tXPGuBcENmiRQfEnTKUDYL4mJVqJ1jtryLtuZI9wyrwe7PppEXW9+/lHms58vixX
         6LAV5V4pb6e0+I/pP/WhFqDw2A8zy2uYogtg+IBLFUkTt0drMdvyThWQGZLhOly9QUVJ
         iyjAN1GstHSTT7Eq6YfncW3LahPBQxzLowihDb2BJ3vIra2cOGr0HsxJmaoRHtUSm3Of
         58wqNPCGMcF/0F/+FEPoYRGRFkMB8GfbWVPB9R6LAvQbojZl6qpMwMPZOzaStFlUkl78
         k6GcH87WmenvmU1NNFUFCfMGkm22QThX1fJZctl9+63q94Gw5b9kxRRdACct3KxSs2pY
         /kkw==
X-Gm-Message-State: AOAM533egYGvOmkXpMIsMW3w1F8ndJjd+THKE9Sy1zge4y5BlWZQveRA
        2+ppzKPtSE6OY7VZK5zAJg1XeA==
X-Google-Smtp-Source: ABdhPJyYe1hgk2fEdouckIqm5RWn3n7q2+/VfPl6eb5Tmuo3m/ZvVuWgcvs1OKTDYNPTQTqaEyU7tA==
X-Received: by 2002:a05:6e02:180e:: with SMTP id a14mr6156312ilv.313.1637088942271;
        Tue, 16 Nov 2021 10:55:42 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id a20sm12315511ila.22.2021.11.16.10.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Nov 2021 10:55:41 -0800 (PST)
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Drew DeVault <sir@cmpwn.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211028080813.15966-1-sir@cmpwn.com>
 <CAFBCWQ+=2T4U7iNQz_vsBsGVQ72s+QiECndy_3AMFV98bMOLow@mail.gmail.com>
 <CFII8LNSW5XH.3OTIVFYX8P65Y@taiga>
 <593aea3b-e4a4-65ce-0eda-cb3885ff81cd@gnuweeb.org>
 <20211115203530.62ff33fdae14927b48ef6e5f@linux-foundation.org>
 <YZP6JSd4h45cyvsy@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b97f1b15-fbcc-92a4-96ca-e918c2f6c7a3@kernel.dk>
Date:   Tue, 16 Nov 2021 11:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YZP6JSd4h45cyvsy@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/16/21 11:36 AM, Matthew Wilcox wrote:
> On Mon, Nov 15, 2021 at 08:35:30PM -0800, Andrew Morton wrote:
>> I'd also be interested in seeing feedback from the MM developers.
> [...]
>> Subject: Increase default MLOCK_LIMIT to 8 MiB
> 
> On the one hand, processes can already allocate at least this much
> memory that is non-swappable, just by doing things like opening a lot of
> files (allocating struct file & fdtable), using a lot of address space
> (allocating page tables), so I don't have a problem with it per se.
> 
> On the other hand, 64kB is available on anything larger than an IBM XT.
> Linux will still boot on machines with 4MB of RAM (eg routers).  For
> someone with a machine with only, say, 32MB of memory, this allows a
> process to make a quarter of the memory unswappable, and maybe that's
> not a good idea.  So perhaps this should scale over a certain range?
> 
> Is 8MB a generally useful amount of memory for an iouring user anyway?
> If you're just playing with it, sure, but if you have, oh i don't know,
> a database, don't you want to pin the entire cache and allow IO to the
> whole thing?

8MB is plenty for most casual use cases, which is exactly the ones that
we want to "just work" without requiring weird system level
modifications to increase the memlock limit.

For db etc server setups, you're going to be mucking with the setup
anyway, and then I don't see it as a big problem that you'll need to
increase it further. Because yes, that won't fit within 8MB if you start
doing registered buffers.

-- 
Jens Axboe

