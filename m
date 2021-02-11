Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37637318835
	for <lists+linux-api@lfdr.de>; Thu, 11 Feb 2021 11:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhBKKco (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Feb 2021 05:32:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229943AbhBKKaf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Feb 2021 05:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613039346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uy1irgQ/ZwVow/3hF7bCH/moHa6j8udykjKdWqM+w4w=;
        b=QrrsdJRX1u16+sdFjLIJJucq6iT55FtZYFLwQ+NSdgyOUI7YrlvbRW+MVr9gDpvrWbrMUQ
        p16H2X7P9WZi7tQcou7Gh+8+1SAJqILCCx0Ugvo1zGxV0ch0vprGS3xjbgT+t0f1qV6uky
        VVT4tQ53F4OOH9JJMezsbZ+uIns9qik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-tBokRLcyOCuiMXeuiZATSA-1; Thu, 11 Feb 2021 05:29:02 -0500
X-MC-Unique: tBokRLcyOCuiMXeuiZATSA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA09FC7401;
        Thu, 11 Feb 2021 10:28:59 +0000 (UTC)
Received: from [10.36.114.52] (ovpn-114-52.ams2.redhat.com [10.36.114.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61FF96268D;
        Thu, 11 Feb 2021 10:28:53 +0000 (UTC)
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
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
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <a587bd61-9194-4b46-c122-8b4da7b941a8@redhat.com>
 <20210208183348.GV4718@ziepe.ca>
 <0dca000a6cd34d8183062466ba7d6eaf@hisilicon.com>
 <20210208213023.GZ4718@ziepe.ca>
 <0868d209d7424942a46d1238674cf75d@hisilicon.com>
 <20210209135331.GF4718@ziepe.ca>
 <2527b4ac8df14fa1b427bef65dace719@hisilicon.com>
 <20210210180405.GP4718@ziepe.ca>
 <8a676b45ebaa49e8886f4bf9b762bb75@hisilicon.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <c15e0c20-8253-fa49-ff44-a19c455353e9@redhat.com>
Date:   Thu, 11 Feb 2021 11:28:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <8a676b45ebaa49e8886f4bf9b762bb75@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

>>
>> Again in proper SVA it should be quite unlikely to take a fault caused
>> by something like migration, on the same likelyhood as the CPU. If
>> things are faulting so much this is a problem then I think it is a
>> system level problem with doing too much page motion.
> 
> My point is that single one SVA application shouldn't require system
> to make global changes, such as disabling numa balancing, disabling
> THP, to decrease page fault frequency by affecting other applications.
> 
> Anyway, guys are in lunar new year. Hopefully, we are getting more
> real benchmark data afterwards to make the discussion more targeted.

Right, but I think functionality as proposed in this patch is highly 
unlikely to make it into the kernel. I'd be interested in approaches to 
mitigate this per process. E.g., temporarily stop the kernel from 
messing with THP of this specific process.

But even then, why should some random library make such decisions for a 
whole process? Just as, why should some random library pin pages never 
allocated by it and stop THP from being created or NUMA layout from 
getting optimized? This looks like a clear layer violation to me.

I fully agree with Jason: Why do the events happen that often such that 
your use cases are affected that heavily, such that we even need such 
ugly handling?

What mempinfd does is exposing dangerous functionality that we don't 
want 99.99996% of all user space to ever use via a syscall to generic 
users to fix broken* hw.

*broken might be over-stressing the situation, but the HW (SVA) 
obviously seems to perform way worse than ordinary CPUs.

-- 
Thanks,

David / dhildenb

