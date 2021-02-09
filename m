Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 158243150FB
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 14:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhBINzF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Feb 2021 08:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbhBINyc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Feb 2021 08:54:32 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F8C061794
        for <linux-api@vger.kernel.org>; Tue,  9 Feb 2021 05:53:33 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q85so5625933qke.8
        for <linux-api@vger.kernel.org>; Tue, 09 Feb 2021 05:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T8f8DDfwXSd9VRLmEP8P3umzAghI6Kqw6/qy/jeS5Qo=;
        b=gh04iuWWyfXXLlaV1RWSVt6ZQHHbXgL+7SqTdgohcZssGB7SFCglc2Da1zz58QYygR
         9tVoLF0GKpMU5fAKOJUQeZbKmiZNBpriOh6NJ88Z8/8Oiy+02484H0DfDsD9oLpEdCJB
         iqbllGJHAulzwrFuz8zaWKtRoDWR91pkLeY3goABlW/bNnl7a7ucWFWFLWHoTWeFdCfi
         E81odK7NiX2mIG23/RyV6fotvVvwHXBJ3/Y6NQ+7HvCiAyAGmRSY3kUdW52i458n5RX4
         NyglMvima/h3o9mIMHNuMfUszee7pZjUtNzI0o4O78Zz7zTTtKPysaZeIPpMxYD972RH
         nQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T8f8DDfwXSd9VRLmEP8P3umzAghI6Kqw6/qy/jeS5Qo=;
        b=U0y4Dd/vXbUVq0kxG2pjGIEVHnFfziD4Jk4aMiAgfJzujfjej6KX7d3PCYD88pP6SR
         l4Pue4PJpmpbZWcfHsvJkcT0PduY+u/+ZRIWH/iCK7MhmkOompLraQT2Fnu5SXcEUrXI
         TFfJ+/uxXgSuh4TqtTRak4w0V9VjW5W4BEoW0rnNqGgphGul7ueecp3lOcawnBnLPM4T
         vC33+Oe/iWEoqJ3o3dbB+3IijAHnQXwCjt5monnE6/SG2/FBw84vUWpLNOCKmEM5kIKn
         SxuXK3JsFzIpCxkLQO4ErWHYTXX6/lRNYC44a6D0NHIavXyNTJl7VjP0+eaCH5PCMAKU
         utvw==
X-Gm-Message-State: AOAM532zR+zbgy67Pj66mvLHkfAJcUwlzm+gp0dQi7bhtcQJRWwt9IEo
        GDLeipY8cruX7gDbfiIb69pNOw==
X-Google-Smtp-Source: ABdhPJx3et279cgNvk+uqR894IQLoOIQFoSZDGEjQvDKhVHg09126LSd7Y8VSphbQdCDRlOdHVR86w==
X-Received: by 2002:ae9:e80e:: with SMTP id a14mr11633708qkg.103.1612878812715;
        Tue, 09 Feb 2021 05:53:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id d16sm17820271qka.44.2021.02.09.05.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:53:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9TSN-005RZu-ON; Tue, 09 Feb 2021 09:53:31 -0400
Date:   Tue, 9 Feb 2021 09:53:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     David Hildenbrand <david@redhat.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210209135331.GF4718@ziepe.ca>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0868d209d7424942a46d1238674cf75d@hisilicon.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 09, 2021 at 03:01:42AM +0000, Song Bao Hua (Barry Song) wrote:

> On the other hand, wouldn't it be the benefit of hardware accelerators
> to have a lower and more stable latency zip/encryption than CPU?

No, I don't think so.

If this is an important problem then it should apply equally to CPU
and IO jitter.

Honestly I find the idea that occasional migration jitters CPU and DMA
to not be very compelling. Such specialized applications should
allocate special pages to avoid this, not adding an API to be able to
lock down any page
 
Jason
