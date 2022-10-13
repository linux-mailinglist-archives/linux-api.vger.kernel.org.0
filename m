Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E5B5FD7EB
	for <lists+linux-api@lfdr.de>; Thu, 13 Oct 2022 12:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJMKpJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 13 Oct 2022 06:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJMKpH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 13 Oct 2022 06:45:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEA13742F
        for <linux-api@vger.kernel.org>; Thu, 13 Oct 2022 03:45:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 128so1235731pga.1
        for <linux-api@vger.kernel.org>; Thu, 13 Oct 2022 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zY1ojGxBpTi2hn+yoQwCvHy/W57pGU8ECyExV1y6qnQ=;
        b=1DWlgqusN67Nh/Lk0vXcd5QO3A5QObZkpdbC+9nCPpKZvveDt4EyVeNBhRLQ23AlXd
         977ei/TEQ5w04x8QFrh9vK85nWyFHYCPiEaolBsaz7GeG7QFBSaY+dlNOHno6oOf32ts
         4N1sMJ5aaflczzA2acYDlJXdK3LkQbBYEiT9SORWT0jpyBLLwva+RLXppJFiA7cwOt1D
         xF/2Da+GoVl5CgdIHolQooeSsPun+ic5B1zrsYTlZLUun6fZZ6e/8p258fvfSQXeo8Fi
         xapBep1B08oRiNU2KOTkkNovTrOeQUwNX8jUj6gAAp91QgWBOTQoKESwmKTfpuiawofo
         inGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zY1ojGxBpTi2hn+yoQwCvHy/W57pGU8ECyExV1y6qnQ=;
        b=RcoaXpnrxZwTgCk76MmeYHPH0TQxnyikSoPQLsInM5dvcmnl+NOMbPHcU8STsbXRwZ
         /9sG7Xy9r270iKSZhZmpGemWT8EgQJw2ezhHHZRKXHpH79ghBUGWuy8fw/E860CB6L6X
         rpEzvsnGdrc12JBbXEjVzevmuoMKRZb2nx2zBAZBzj3T1GHv/izBXlF7OStHEP00YeB/
         bwhOnIcSI6yXnbu18LUCAQscwBTIyyJgZgxe/0Kq55dTH+cNTIFZLzD1No9PwbOUVhM8
         Yao0Em3H7DMgfe8s1s3MYWJat392js/9i8BXeIvpfvnRz/pnfXV4rSxIbW8axS2SHbs0
         puSA==
X-Gm-Message-State: ACrzQf2captc7gwf/5C8MdviGizEOEe59zE+R1vSksYEPxcj6FtcNPuw
        N0myydn3K3uf6hmxnBuIEKoBNQ==
X-Google-Smtp-Source: AMsMyM7MHYTMMEe0zkVoDtJLCO79Qh90HiVUU8OihvpobkC1CmBNEd2x4c1OtpT0T5YAID0rfu4/zw==
X-Received: by 2002:a05:6a00:23d2:b0:565:84d7:64c3 with SMTP id g18-20020a056a0023d200b0056584d764c3mr11206898pfc.20.1665657902431;
        Thu, 13 Oct 2022 03:45:02 -0700 (PDT)
Received: from [10.68.76.92] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id r1-20020aa79ec1000000b00538056de6ecsm1687688pfq.52.2022.10.13.03.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 03:45:01 -0700 (PDT)
Message-ID: <e825a27a-646b-9723-f774-947501c04ec2@bytedance.com>
Date:   Thu, 13 Oct 2022 18:44:55 +0800
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
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y0avztF7QU8P/OoB@dhcp22.suse.cz>
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

> On Wed 12-10-22 19:22:21, Zhongkun He wrote:
>>>
>>> Yes, this will require some refactoring and one potential way is to make
>>> mpol ref counting unconditional. The conditional ref. counting has
>>> already caused issues in the past and the code is rather hard to follow
>>> anyway. I am not really sure this optimization is worth it.
>>>
>>> Another option would be to block the pidfd side of things on completion
>>> which would wake it up from the task_work context but I would rather
>>> explore the ref counting approach first and only if this is proven to be
>>> too expensive to go with hacks like this.
>>
>> Hi Michal
>>
>> The counting approach means executing mpol_get/put() when start/finish using
>> mempolicy,right?
> 
> We already do that via mpol_{get,put} but there are cases where the
> reference counting is ignored because it cannot be freed and also mpol_cond_put
> resp. open coded versions of mpol_needs_cond_ref.

Hi Michal

Could we try to change the MPOL_F_SHARED flag to MPOL_F_STATIC to
mark static mempolicy which cannot be freed, and mpol_needs_cond_ref
can use MPOL_F_STATIC to avoid freeing  the static mempolicy.
MPOL_F_SHARED loses its original meaning in counting approach.

Thanks.
