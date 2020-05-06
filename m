Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D71C6D6D
	for <lists+linux-api@lfdr.de>; Wed,  6 May 2020 11:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgEFJod (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 6 May 2020 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729173AbgEFJod (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 6 May 2020 05:44:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5EC061A0F;
        Wed,  6 May 2020 02:44:31 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i15so960644wrx.10;
        Wed, 06 May 2020 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zogrk4yKNPGjGulfAcYpBrIv088QASAAIJAwuPc2cMc=;
        b=nwKkH16LhWlT+bRmDLOqlb62L7lMOBj0lVHGmMoYjf9KKOPZxhGT+veeUtA8edrqhV
         DaQxZ77L9pT8ZFbKIQ2twphPpWq+YRHSny61w6yS1mBJQVHGPMFypuN2Ih+XzYQqkd47
         jXUNaoJzkfNBFF5xpT2FREDat5xloD6IAvdaYpXDdmyqpLJHwHp4pW+8ciJ/UnKuLLfe
         3DU4b/SkgyPwyMtIyvEH3CejIUprI3VIgsjContx4T5R2j3fh12z0R7L/hEvqvXam33j
         zpYn835hwfGOZJw41AgyawJ4ZR2TFfk3SHt2kvAbK/37lpXS3ttcAJ//jdxqDWOGROdx
         yw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zogrk4yKNPGjGulfAcYpBrIv088QASAAIJAwuPc2cMc=;
        b=If0bhn+Uxcn2dc2nUPax2pQwIDKNJRbpHRsAoGZLl7MntjUbPtc6M0pLiFcVje/ghX
         cjjE+D+/KDunWKpX1e1YeB7xXS9qmrM054KSbSLb0WB/wmubDZXNfloA+/XueB/5kOCj
         MOhhXir53QNSLYfk89f20hVbMiVJO77HmT+CMluYqn92QlfLg1uZGoCusFcWzPI0dD8W
         qqqnhDwZfb4Rb5UZmnoLsOucxjCaONqfjawL2A6dcUAU1510/yeZKjS5c8wMfAR9oIP0
         OCXYbLvlEqZ+gs3fR5Unyun1dscu4j7Hn+v6Jr2HH0vViVKbeAvVdITDTCBvI1GwV66c
         GHXA==
X-Gm-Message-State: AGi0PuaEHWTBI7ggsigqnk9gsqHS4OadJDDQefuFAnvbM+lecesp09mv
        tvQQaIa+YVhhRHFjxZ9Osu3+ZAIh
X-Google-Smtp-Source: APiQypJ5g4ZBJNyJkYTa3cLcRX63ovlHVbsJD9mSh0LKDOqUMhT6uYN+uW0OeMr72zLKmm7geZtWhA==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr9271796wra.71.1588758270228;
        Wed, 06 May 2020 02:44:30 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id d27sm1939555wra.30.2020.05.06.02.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 02:44:29 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, narayan@google.com, zezeozue@google.com,
        kernel-team@android.com, maco@google.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com
References: <20200429140341.13294-1-maco@android.com>
 <20200429140341.13294-11-maco@android.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7d73bafe-5228-b02e-5b53-4a41543aebe3@gmail.com>
Date:   Wed, 6 May 2020 11:44:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429140341.13294-11-maco@android.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Martijn,

On 4/29/20 4:03 PM, Martijn Coenen wrote:
> This allows userspace to completely setup a loop device with a single
> ioctl, removing the in-between state where the device can be partially
> configured - eg the loop device has a backing file associated with it,
> but is reading from the wrong offset.
> 
> Besides removing the intermediate state, another big benefit of this
> ioctl is that LOOP_SET_STATUS can be slow; the main reason for this
> slowness is that LOOP_SET_STATUS(64) calls blk_mq_freeze_queue() to
> freeze the associated queue; this requires waiting for RCU
> synchronization, which I've measured can take about 15-20ms on this
> device on average.
> 
> In addition to doing what LOOP_SET_STATUS can do, LOOP_CONFIGURE can
> also be used to:
> - Set the correct block size immediately by setting
>   loop_config.block_size (avoids LOOP_SET_BLOCK_SIZE)
> - Explicitly request direct I/O mode by setting LO_FLAGS_DIRECT_IO
>   in loop_config.info.lo_flags (avoids LOOP_SET_DIRECT_IO)
> - Explicitly request read-only mode by setting LO_FLAGS_READ_ONLY
>   in loop_config.info.lo_flags
> 
> Here's setting up ~70 regular loop devices with an offset on an x86
> Android device, using LOOP_SET_FD and LOOP_SET_STATUS:
> 
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m03.40s real     0m00.02s user     0m00.03s system
> 
> Here's configuring ~70 devices in the same way, but using a modified
> losetup that uses the new LOOP_CONFIGURE ioctl:
> 
> vsoc_x86:/system/apex # time for i in `seq 30 100`;
> do losetup -r -o 4096 /dev/block/loop$i com.android.adbd.apex; done
>     0m01.94s real     0m00.01s user     0m00.01s system
> 
> Signed-off-by: Martijn Coenen <maco@android.com>


Can we have also a patch for the loop.4 manual page please?

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
