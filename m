Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51AB611EFCF
	for <lists+linux-api@lfdr.de>; Sat, 14 Dec 2019 02:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfLNBzV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Dec 2019 20:55:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39766 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfLNBzU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Dec 2019 20:55:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so1372727oty.6;
        Fri, 13 Dec 2019 17:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+FqWQhg3zsQBz5OPBQ/f5P4w/hRAvhzjNsTIeI4VMs=;
        b=eb40YQJxxFI9nsr+8ZM6C6CNG9Kg++mk4g6aGxotH/5OAQqcVfJYawtKyUfsu4hymC
         nY1eR6f4dO235g/EebJLzVPWPps3gzeLlT5ilj2pnKiE8hEtqaGza2H38dPa0gAV+6DX
         liPMCf1DXr9pa0gV9e9sjaQTpIsiaGTziQoU7aCss0OD8ZSjAp4fB1PzU81p5Mkgx5Vb
         3nsfFiGMmeRrtATBDaAdsfOdrxGP/jiz0mT3Fsuhz0XYtj4xxmj11ljeuuWRx7q91myX
         cdXu8KQIkGdX1Yxg5sbOEFiaK4P0R+pYz8llSH65XJmqxihk4cDWI9XS6NRqBXUeyGG/
         04BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+FqWQhg3zsQBz5OPBQ/f5P4w/hRAvhzjNsTIeI4VMs=;
        b=MxSUXKFCLKslbiCKSbIs+d4bwWBVSu4bH3unPNE0qxmYdfdTJtOb6uq2P3cagJuso6
         rx+lMoysxHpAaw2boba68Xjn+pcZMPKmsBI0F3POo/UNYImkJO1nuMu2QXOGH4tgzSoD
         RuDoVKiZk86tzMGCHNM7zYvsGCDs09WjAKcakq2RXeQXq57ZS8aQcVOSEmuiRS9nDx3F
         evTztMLFMdtjjXww2XrhGeUwa2M+z4ZfmR8AUZmr5gagoLUSXtp+d5gmo+gnvNFZyYre
         UmZqDcfGo3uPyEX7yZfjzOiYql4WIaK3KW5cVnQvhRmfKHVwS8sFB7dILjOs/R/+BtWU
         cT1w==
X-Gm-Message-State: APjAAAW8r6ygEFcrJgfpfNPpIrPESV/LA0kPgToVWIxuN+vKV8T6cV8/
        cIKagZy9uNuhgvkrYmAp0yxXrTFHNj8=
X-Google-Smtp-Source: APXvYqzR10MlQHC06+el8PqUt6C6XneFN5lEqEgtMDJXXMvHieUzFlqxGcrPDSDiG28/Iyb29eRcdA==
X-Received: by 2002:a9d:4d01:: with SMTP id n1mr16983744otf.245.1576288519734;
        Fri, 13 Dec 2019 17:55:19 -0800 (PST)
Received: from ?IPv6:2600:1700:dac0:2450::38? ([2600:1700:dac0:2450::38])
        by smtp.gmail.com with ESMTPSA id s26sm4028031otk.43.2019.12.13.17.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 17:55:19 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>, cl@linux.com,
        mhocko@suse.com, cai@lca.pw, akpm@linux-foundation.org
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
 <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
Date:   Sat, 14 Dec 2019 02:55:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/6/19 6:26 PM, Yang Shi wrote:
> 
> 
> On 12/6/19 12:25 AM, John Hubbard wrote:
>> On 12/5/19 5:34 PM, Yang Shi wrote:
>>> Since commit e78bbfa82624 ("mm: stop returning -ENOENT
>>> from sys_move_pages() if nothing got migrated"), move_pages doesn't
>>> return -ENOENT anymore if the pages are already on the target nodes, but
>>> this change is never reflected in manpage.
>>>
>>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>>> Cc: Christoph Lameter <cl@linux.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Qian Cai <cai@lca.pw>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>>> ---
>>>   man2/move_pages.2 | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>>> index 2d96468..2a2f3cd 100644
>>> --- a/man2/move_pages.2
>>> +++ b/man2/move_pages.2
>>> @@ -192,9 +192,8 @@ was specified or an attempt was made to migrate 
>>> pages of a kernel thread.
>>>   One of the target nodes is not online.
>>>   .TP
>>>   .B ENOENT
>>> -No pages were found that require moving.
>>> -All pages are either already
>>> -on the target node, not present, had an invalid address or could not be
>>> +No pages were found.
>>> +All pages are either not present, had an invalid address or could 
>>> not be
>>>   moved because they were mapped by multiple processes.
>>>   .TP
>>>   .B EPERM
>>>
>>
>> whoa, hold on. If I'm reading through the various error paths 
>> correctly, then this
>> code is *never* going to return ENOENT for the whole function. It can 
>> fill in that
>> value per-page, in the status array, but that's all. Did I get that 
>> right?
> 
> Nice catch. Yes, you are right.
> 
>>
>> If so, we need to redo this part of the man page.
> 
> Yes.

So where are things at with this? Is an improved man-pages 
patch on the way, or is some other action (on the API) planned?

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
