Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47A61E0FD4
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403841AbgEYNun (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 09:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403897AbgEYNum (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 09:50:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA17AC061A0E;
        Mon, 25 May 2020 06:50:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z5so20583340ejb.3;
        Mon, 25 May 2020 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dpDoqtle89oMVZav++4VvJVMWQAzIvDKYzkUUcdunEw=;
        b=NW+zm73DRelXLZ5sBomfzu4+PxDqvP8CsG4xbbPCqo24ArxrG3N8Cgq5HV4uyFqPF7
         z3R5e8SH65DwmVNtyDIoy1gECoxDjjqVNpXG0KWOK58q5FinvOIrRxDrlmPeSp9k4P5D
         1xqL38Cdmz4+D16QhTfC+30JM/UF2wi+c+4ziCJwOPFx6aFmzW1ngeRu5n0dWBF4+KhR
         mOnbdFiNeC+Km7huoQYt4jy4vjvnxnrEgiNB5Iquio4RsFI4Sy5Db4ev8WGNrlMwYDka
         MAjbDZlAHcQ/VyE2gr3VqGq5NeoJf/gUx38Cv/6xSwZdV1ZTF7rHe15gJdFQHF6/ybwL
         SACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dpDoqtle89oMVZav++4VvJVMWQAzIvDKYzkUUcdunEw=;
        b=Naf5JpKAJwJeigaR9IJGPclVX/nEPNo5bar1CstjVdmHDk/GhPwg6YeGVgl48Fv3Rr
         j70+bKZKZwBcyj3OcWFwqn9EKBjczb9CmhAkSTRLmX4lc0jRszdIUsg8QgZawId86rji
         Wq81q3J2qmaWu+jwX9LnqTKVPeWoPRQ/VQrVjVVv0ZepdDKaCqW+UDlz1lQS4tycdmT6
         ExmcbMAX0xKsdtbJKT0YI9dU2Df7P4bvQI54UdiajGNDYmEt0dyyk+TONn07FwnEcfiv
         ySMPcOkqch1v7i3jmKCFUA7OSL91olHrkYewBKE3BycdfVXTSdwpktBZfUvOxUR1Gz6U
         R7Kw==
X-Gm-Message-State: AOAM5328cFA7/mAcmadLq5WTNUyWldvEfpBbTj4qf67JU/IyUUg4jFi2
        SsGD09KNaSYHQJryfRR6M4M=
X-Google-Smtp-Source: ABdhPJyNHy9KwhzwGMSS43P11YocfOM/h36IBUYqOErK8Hy15T5PPDieh7cJpqIkwx3VqgiJlVKxFw==
X-Received: by 2002:a17:906:7d90:: with SMTP id v16mr18177637ejo.554.1590414639616;
        Mon, 25 May 2020 06:50:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:a081:4793:30bf:f3d5? ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id df21sm15997034edb.27.2020.05.25.06.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 06:50:39 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org, nilal@redhat.com,
        Florian Weimer <fweimer@redhat.com>,
        =?UTF-8?Q?Colm_MacC=c3=a1rtaigh?= <colm@allcosts.net>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] proc.5: add "wf" to VmFlags in /proc/[pid]/smaps
To:     Ian Rogers <irogers@google.com>, Rik van Riel <riel@redhat.com>
References: <20200521222551.259804-1-irogers@google.com>
 <CAP-5=fXjXgWEgp9gqReByrDBTvjDbPEsubeAFxrpxj_+FsFn6w@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1edcb7ac-bc5f-b9ec-a037-656005ae85e3@gmail.com>
Date:   Mon, 25 May 2020 15:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fXjXgWEgp9gqReByrDBTvjDbPEsubeAFxrpxj_+FsFn6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/22/20 1:13 AM, Ian Rogers wrote:
> On Thu, May 21, 2020 at 3:25 PM Ian Rogers <irogers@google.com> wrote:
>>
>> This patch documents a flag added in the following kernel commit:
>>
>> commit d2cd9ede6e193dd7d88b6d27399e96229a551b19
>> Author: Rik van Riel <riel@redhat.com>
>> Date:   Wed Sep 6 16:25:15 2017 -0700
>>
>>     mm,fork: introduce MADV_WIPEONFORK
>>
>> This was already documented in man2/madvise.2 in the commit:
>>
>> commit c0c4f6c29c494c466f3a2a6273c5b55b76a72927
>> Author: Rik van Riel <riel@redhat.com>
>> Date:   Tue Sep 19 20:32:00 2017 +0200
>>
>>     madvise.2: Document MADV_WIPEONFORK and MADV_KEEPONFORK
>>
>> Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Doing a quick audit of fs/proc/task_mmu.c having noticed this flag was
> missing I note:
>  - "mp" isn't documented, only possible with INTEL_MPX
>  - "nl" is documented but not present in show_smap_vma_flags
>  - "um" and "uw" aren't documented

I took a shot at fixing these:


             mp  - MPX-specific VMA (x86, since Linux 3.19)
             nl  - non-linear mapping (removed in Linux 4.0)
             um  - userfaultfd missing pages tracking (since Linux 4.3)
             uw  - userfaultfd wprotect pages tracking (since Linux 4.3)
             sf  - perform synchronous page faults (since Linux 4.15)

Thanks,

Michael
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
