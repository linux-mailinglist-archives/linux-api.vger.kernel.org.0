Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDF7314BA9
	for <lists+linux-api@lfdr.de>; Tue,  9 Feb 2021 10:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBIJaY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 9 Feb 2021 04:30:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12881 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhBIJ2W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Feb 2021 04:28:22 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DZcvp1gvBz7jFf;
        Tue,  9 Feb 2021 17:26:14 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 17:27:31 +0800
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
To:     Arnd Bergmann <arnd@kernel.org>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <CAK8P3a13aGbqvTxL+5OQxu-wPa6RDHQJkJ_n8O6YeOibbJQ2yg@mail.gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        gregkh <gregkh@linuxfoundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Sihang Chen <chensihang1@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <753db746-292c-4f1d-c79f-9a7282a19ba2@hisilicon.com>
Date:   Tue, 9 Feb 2021 17:27:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a13aGbqvTxL+5OQxu-wPa6RDHQJkJ_n8O6YeOibbJQ2yg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021/2/8 5:51, Arnd Bergmann wrote:
> On Sun, Feb 7, 2021 at 9:18 AM Zhou Wang <wangzhou1@hisilicon.com> wrote:
> 
>> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
>> index cccfbbe..3f49529 100644
>> --- a/arch/arm64/include/asm/unistd32.h
>> +++ b/arch/arm64/include/asm/unistd32.h
>> @@ -891,6 +891,8 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
>>  __SYSCALL(__NR_process_madvise, sys_process_madvise)
>>  #define __NR_epoll_pwait2 441
>>  __SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
>> +#define __NR_mempinfd 442
>> +__SYSCALL(__NR_mempinfd, sys_mempinfd)
> 
> This adds a compat syscall for 32-bit tasks running on arm64 without adding
> the same for the native arch/arm syscall table. Those two need to always
> stay synchronized. In fact, new system call should ideally get assigned
> on all architectures at the same time, with the same number (or +110
> on arch/alpha).

Thank for pointing out this. I use an ARM64 machine to test, so
currently only add it for ARM64 :)

Best,
Zhou

> 
>          Arnd
> 
> .
> 

