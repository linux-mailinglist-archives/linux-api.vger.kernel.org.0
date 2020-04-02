Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E0C19C0F1
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 14:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbgDBMQS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 08:16:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50270 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgDBMQS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 08:16:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id t128so3176529wma.0;
        Thu, 02 Apr 2020 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8QcgFjYXk62CSAIiHcOI9/XdDg5zZrBmGaSLaHxfLw=;
        b=DeybvvWWZdpgVt3QX472+Q1zODG0rVLBA93fZWO1jfSQytzkeS+GeFADY5IY31Twlx
         DQh3wUoycFYYaR2ZaXNizfifFLm43F1LBXqz9YClRrIVpm5qq+4IZjJ7VPAmU8G2Qsoo
         bQWhKwBPvegiOjusuw49MJ1+0vp94KuR/61333onBFQ++iFuXqzfTwTcA2G867iPDz2L
         xNajbsXZFMA2hvheCA6OaCmkADpfHyoefNNS6bgCMtKITz1cTzqhj+6zdMrCf8658MMU
         Jc0z3Fz9f3pd3ImdmSzXrsqcoiJh750qN1Jfe4C/4cGyzI+zqvP36q96rqfKGcYbUoD5
         hDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8QcgFjYXk62CSAIiHcOI9/XdDg5zZrBmGaSLaHxfLw=;
        b=nJuWm3hdfsEhZ36eRrGhSkla8kSJJKBsVzy8EgrDAOvGaSWdockV3fTkVdnBwzeRMS
         26R9GKCuMsosnQ1idkQfNh6qEYMctKbwCKRVZ8Xb0sUMGYL5rITYLdspm919216HwTRk
         N2A4OskofLVYiFc34WSej4QfnpVzStk7T2rXMH9Y4EHJxZ52HkYTc2AFeKXjoX+lfVQm
         HOKmBxZk/YKaoolzUH+j6k9jUWBiiz8gsnr4JkMcf3JqM9XtRd1QGwW3c9oO76zHoqQi
         zFDy9dnmkXBG0tiYYBLLdb5GZ0pWRFCOEWoTIo4rkNc37uVoAwkEKG2UJ+yRpl9gHrAY
         3D0Q==
X-Gm-Message-State: AGi0PuYX9mB5yhV2x3OlYUueOMGxqj2VeIPEaXgZKpRXcNvN+jlwx4MU
        in1pQYBOr36AG2nmYabCD7w+9a+U
X-Google-Smtp-Source: APiQypIbYD61WIMNGuofFwgHw0XErp2C1lptEUw43w/13VydI06ly45E4ml3oR50/5slIoR+pkHmKg==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr3201274wmc.15.1585829776011;
        Thu, 02 Apr 2020 05:16:16 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id i8sm7816360wrb.41.2020.04.02.05.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 05:16:15 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-api@vger.kernel.org,
        david@fromorbit.com, masato.suzuki@wdc.com, damien.lemoal@wdc.com,
        darrick.wong@oracle.com, bvanassche@acm.org,
        linux-man@vger.kernel.org
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Michal Hocko <mhocko@kernel.org>,
        Mike Christie <mchristi@redhat.com>
References: <20200402020850.7218-1-mchristi@redhat.com>
 <20200402064713.GD22681@dhcp22.suse.cz>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <cb4b5ddc-5c75-116e-fb4a-aeed5e3c96fd@gmail.com>
Date:   Thu, 2 Apr 2020 14:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402064713.GD22681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/2/20 8:47 AM, Michal Hocko wrote:
> On Wed 01-04-20 21:08:50, Mike Christie wrote:
>> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
>> prctl commands added to the linux kernel for 5.6 in commit:
>>
>> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
>> Author: Mike Christie <mchristi@redhat.com>
>> Date:   Mon Nov 11 18:19:00 2019 -0600
>>
>>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
> 
> Yes this wording is much better than the previous version.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for the review, Michal!

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
