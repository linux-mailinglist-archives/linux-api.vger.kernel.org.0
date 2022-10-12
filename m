Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9665FC447
	for <lists+linux-api@lfdr.de>; Wed, 12 Oct 2022 13:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJLLWa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Oct 2022 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJLLW3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Oct 2022 07:22:29 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C13C2C80
        for <linux-api@vger.kernel.org>; Wed, 12 Oct 2022 04:22:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1689547pjq.3
        for <linux-api@vger.kernel.org>; Wed, 12 Oct 2022 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nky5UA9/w8YUBIpkVBR5e9cekqkEeekQYjUhuGyBtKg=;
        b=F+FQNnDoQHD5t5tPpMk0+FKE7G6dvQAGJzFK5fVeXzDJFPyaI1PVeIoRWVFByjqRcQ
         F/WBP355WLp+tg2jIQTGyypaHGkIAkY7IqZFqe5Hl9NQQJcD3YFOK1/NhXJrNuvd3zyk
         V/Sob77RzIKbhO/njyZXVvSrlzLMBYDPl1mH8HhQ3dDiKCQqSG1uRGEhfI6+cd98e7Fc
         7p34h/hQP0Mcy36K70/zxOSM4qIYCEKbOiX1E/j3bKS5ozsdEz2K5wOuEq1IKFASq8Om
         0zC9FhuF6f13xKFTE+CROJ6J7upO9d3YCxVKYGJ2QwYVdtfGuAiiG4d46ZT4OJjBqnJT
         8saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nky5UA9/w8YUBIpkVBR5e9cekqkEeekQYjUhuGyBtKg=;
        b=p4g73tz3e11JRKnndmpzfW1O0/8I5cTrvq8RbJq/4SkID9rX6DOUxAK8bRWqAvQxjV
         l6O8nl3Zi9sFLVGA2Z7Bab2JxaQSuoDJahKScOMRkaeqk5gmxaJsBcYIIs5vp3ixpuks
         yEJTqDaxO5j/GHPg+8oD7adOslUMzZdYHNhpdAGhs5w2Fs3/YEbaIC7iRWXH3bYSZqLv
         ZEOKbfzlhEKopQSfudoJEhKxfQUHXZsR+CIU2pw74YrjkXbtoQf62D4piBv+gfZ5E06r
         OkaXzKMtBn2ACQHHch138aEztgBGkBVa/4Jy4wtfLcJVEJGxfr9oNB9Gardiv3hHSKpz
         A8jQ==
X-Gm-Message-State: ACrzQf1Yi4t7hLine2NVtSB4aViPzi/D5dfZH5DyTyji4ym8QWWy2KXL
        wyVN2/ws/Sj+r3KcstTtn7m1WA==
X-Google-Smtp-Source: AMsMyM5VAuc3jwLsVUUvKgOJss7juuz6l0hUGBBMAC7PbDxQU9lzEbHe4f+9/QYUQXvashRZDobT4A==
X-Received: by 2002:a17:90b:38c8:b0:20d:9ac4:b476 with SMTP id nn8-20020a17090b38c800b0020d9ac4b476mr170513pjb.26.1665573747385;
        Wed, 12 Oct 2022 04:22:27 -0700 (PDT)
Received: from [10.68.76.92] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm9422302pgq.43.2022.10.12.04.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 04:22:26 -0700 (PDT)
Message-ID: <a0421769-c2b9-d59a-0358-3cc84b2cb2bd@bytedance.com>
Date:   Wed, 12 Oct 2022 19:22:21 +0800
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
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y0aCiYMQ4liL2azT@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> 
> Yes, this will require some refactoring and one potential way is to make
> mpol ref counting unconditional. The conditional ref. counting has
> already caused issues in the past and the code is rather hard to follow
> anyway. I am not really sure this optimization is worth it.
> 
> Another option would be to block the pidfd side of things on completion
> which would wake it up from the task_work context but I would rather
> explore the ref counting approach first and only if this is proven to be
> too expensive to go with hacks like this.

Hi Michal

The counting approach means executing mpol_get/put() when start/finish 
using mempolicy,right?  With the addition of lock add/dec on the hot 
path, the performance may be degraded.

I'll try it to see its performance impact in detail.


Thanks.
