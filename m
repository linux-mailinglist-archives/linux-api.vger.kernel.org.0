Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9D85FD98E
	for <lists+linux-api@lfdr.de>; Thu, 13 Oct 2022 14:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiJMMvL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Oct 2022 08:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJMMvJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Oct 2022 08:51:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133C343164
        for <linux-api@vger.kernel.org>; Thu, 13 Oct 2022 05:51:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id l19so1189110qvu.4
        for <linux-api@vger.kernel.org>; Thu, 13 Oct 2022 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2cH3XkUWNLmNpwPQYLhtWACtStFj+VXNiGHkNXCbo0=;
        b=XxwCvmQ1OfqgGGbTHrcRTCqJQWsDbCAQaVv1lDeA+U/bZDTMcdIsls3Z9siap5rSd2
         hvneGkBQHEedy2YDOcb9hXvo33bTwqgMS5dmPvBRasi2lr/hp7IeptFLeUIqjRU0lFTI
         uizc1YvsBhmHDhetspqPlCknQqP4Y3kZs9h5lfpRI3voVtOcm2ljtlxXREaNF+6Hcny6
         v5tVRgHfAhPBy4SrwxfCP0wHcZ1F1lev3ymv1oSe0Q4+FAFq1GJS/oLSrrFxEDRoepS+
         3rCqFR/1Y3jQ7FGzes2cKVlq5c8J6p84PORSkId4LuLMZV3rR1Rnsagi/dMrZj/dHMcx
         UPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E2cH3XkUWNLmNpwPQYLhtWACtStFj+VXNiGHkNXCbo0=;
        b=ONLDDvUns27ObvsIeP1o8wUQC07w2XZnXG+Qsue5eaXzb7hPyEIuXyX9OPN0+W4TMq
         UtghihN8a/fr/eiLau/FPbYWp9cDo6xfiPxwaQ7szDK/eAGUwDETHL+PQD0udLpKw+Vs
         QN6fzMxmAIcPf75D2Q0iuTbkSmyeWtREPVQzd2TzO1m4pdfTI+kmFeCwkDsqzruGZZc8
         t2zRgLHzgDPYD5CaPoEpw9Z4emyUenp1YnWrWpKmRVL3SOSkObzvb27SqtocjoVUSUuW
         siZ4Ukf+Uty8c0M7vncto53PR6F5m11aQpVrDrGoaZ50UvACao2y0+i3t3uLwgiBQYCm
         A04g==
X-Gm-Message-State: ACrzQf2dJ1+xMjCq3+4scF6Nhnb0nbklPj8E7eEZQLEl9uSMLw2FtN3G
        f3nvKg4dTUUl81yrB/bSra0gAKvVg1CRkA==
X-Google-Smtp-Source: AMsMyM5wWXDn76e8mvrqcBBxuxQMpTsIi+Sda1mv26vttJb13vgAl0Xcx57FAQYYbgMIO1+VqhQeeQ==
X-Received: by 2002:a17:902:da8a:b0:180:6f4f:beee with SMTP id j10-20020a170902da8a00b001806f4fbeeemr30972033plx.82.1665665454343;
        Thu, 13 Oct 2022 05:50:54 -0700 (PDT)
Received: from [10.68.76.92] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id c72-20020a621c4b000000b00561c179e17dsm1934281pfc.76.2022.10.13.05.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:50:53 -0700 (PDT)
Message-ID: <db41c662-19ce-fc1a-21ba-38ecda7d09c8@bytedance.com>
Date:   Thu, 13 Oct 2022 20:50:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [External] Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
To:     Michal Hocko <mhocko@suse.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <Y0WEbCqJHjnqsg8n@dhcp22.suse.cz>
 <582cf257-bc0d-c96e-e72e-9164cff4fce1@bytedance.com>
 <Y0aCiYMQ4liL2azT@dhcp22.suse.cz>
 <a0421769-c2b9-d59a-0358-3cc84b2cb2bd@bytedance.com>
 <Y0avztF7QU8P/OoB@dhcp22.suse.cz>
 <e825a27a-646b-9723-f774-947501c04ec2@bytedance.com>
 <Y0f17v1c3aAszlbk@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y0f17v1c3aAszlbk@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

>> Hi Michal
>>
>> Could we try to change the MPOL_F_SHARED flag to MPOL_F_STATIC to
>> mark static mempolicy which cannot be freed, and mpol_needs_cond_ref
>> can use MPOL_F_STATIC to avoid freeing  the static mempolicy.
> 
> Wouldn't it make more sense to get rid of a different treatment and
> treat all memory policies the same way?

I found a case, not sure if it makes sense. If there is no policy
in task->mempolicy, the use of atomic_{inc,dec} can be skiped
according  to MPOL_F_STATIC. Atomic_{inc,dec} in hot path may reduces 
performance.

Thanks.
