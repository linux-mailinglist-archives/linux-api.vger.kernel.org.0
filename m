Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542B325A1AC
	for <lists+linux-api@lfdr.de>; Wed,  2 Sep 2020 00:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIAWvl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Sep 2020 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIAWvf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Sep 2020 18:51:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940DC061247
        for <linux-api@vger.kernel.org>; Tue,  1 Sep 2020 15:51:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so1311596plr.0
        for <linux-api@vger.kernel.org>; Tue, 01 Sep 2020 15:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73Z9tnUqBHSQd4rVrF0YKolOG5wWkir8Qe+k7njEBUs=;
        b=JbImz5WsjQvNso/bkzCqvJB3HU/vCONvAuUDL1NUhxq8EXfgBd6gJU/ZbPxsO4JCoj
         fbia4mrRoqvjC9hA2NE877kpM8KSXxurm3Sx0F3EUrx5+hNHxVqURx7Al9dd/TdZJEt8
         M1fRjT4TjPeMdm8pIPkKuO+B86gugS4YQG5QKHpnEVfRzc6aBzdOh87c4uZbVSn+adTT
         Bxa6y9Yjd8zSdL7Y/JPXy23oNwj/xfQCIeHasUirag5WP3wtFNsX5pt6tutvFlh8uRUh
         ocSwHqvV58dwCL2IXYTiyWDy2SrnKLJDmavsdFO+jTguZkigciC00f+5WMe4rTC2CbZt
         9JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73Z9tnUqBHSQd4rVrF0YKolOG5wWkir8Qe+k7njEBUs=;
        b=La6SGarD2DsgS4nXCUGzDoGBynuk9jKQouyChcHG1Q5rdxleVylLZrS7XygyA2HEcQ
         lefoBPcJslwk0mj8fwg/kHz48jzdCiV+H1tOLrJuM8cSict60OdjF3eUdYHgkuETK2+H
         Icw/pdHmM8B76Aym5nWdbQXy/EJiiooSBaDJTIMM/bOFmTuo8nRGVrX5JjyE7g+XCq/U
         9ovcPNt11n4AtdZ3AUOa+u/qYJEplNMK3gKAfoaOCshSKNoNVoGWWM1RAUBxV3kZM+Jo
         PIX0c6wZbcygsVbOs6yLxzOFpDMGHCy98sZKnK0Nl8/7ypchnWQwvcT7bHZjaHn0IaZz
         SQoA==
X-Gm-Message-State: AOAM530YQZ9KnBSVmm1R1kmtt5hHhVVyaFMjTgSR5bgH1DTFBsDv/NOe
        QeN25BfbrE9m0e2WDoaCZQntNfbI55czW7bx
X-Google-Smtp-Source: ABdhPJybEiMVNVLdw9lLzttpP8rQTxf/7m5Nxo5x90EP5wGNQib42AHfwb/cCr16WzqHroCbzeq4CQ==
X-Received: by 2002:a17:902:a70d:: with SMTP id w13mr3305891plq.94.1599000694466;
        Tue, 01 Sep 2020 15:51:34 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f21sm2554223pjj.48.2020.09.01.15.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:51:33 -0700 (PDT)
Subject: Re: [PATCH v2] block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE
To:     Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Serge Hallyn <serge@hallyn.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
References: <20200824221034.2170308-1-khazhy@google.com>
 <e50a4ff6-39fb-6ba0-40ab-d348fbf5567f@acm.org>
 <CACGdZY+6qdymU5cVqu9cVep+P6uNw6muxznZ23XJkxdiihiKFg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <97f1712d-ed8a-b84a-b3b2-acc518cd9324@kernel.dk>
Date:   Tue, 1 Sep 2020 16:51:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACGdZY+6qdymU5cVqu9cVep+P6uNw6muxznZ23XJkxdiihiKFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/1/20 4:49 PM, Khazhismel Kumykov wrote:
> On Sat, Aug 29, 2020 at 6:00 PM Bart Van Assche <bvanassche@acm.org> wrote:
>>
>> From https://www.kernel.org/doc/man-pages/linux-api-ml.html:
>> "all Linux kernel patches that change userspace interfaces should be CCed
>> to linux-api@vger.kernel.org"
>>
>> So I have added the linux-api mailing list to the Cc-list. Anyway:
> Thanks, sorry for missing that!
>>
>> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
> Jens, does this change look good?

Yes, I'll queue it up for 5.10.

-- 
Jens Axboe

