Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94E4D14C3EF
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 01:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgA2AYT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Jan 2020 19:24:19 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:42019 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgA2AYT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Jan 2020 19:24:19 -0500
Received: by mail-pg1-f169.google.com with SMTP id s64so7889395pgb.9
        for <linux-api@vger.kernel.org>; Tue, 28 Jan 2020 16:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h2GpRLoQ1nfksopHIubIV44mAt0KTxXLpFS5BS6cG+g=;
        b=mKRXvembf7tCfMN4vf8UQjTmZF8o5NwO5M/KXe2za+nEcTKgcX5XDFxV6rARBEDOtd
         vI3P8LrGDtCB/Ue+MdqqgAKpCb93rBHt5esiRU9ecstAbfJ+TuK55WTHDJ9iF4EXkQIf
         b5BrHovLVxcTMotoadFBwsx6RJlcOtUQ04FmccLO1791fvYcnUCL7iMCQuzdrChG0Yn6
         fyEZlesyNkwfmCzGtCW2qUDyQaX7P+SJR484bgGoUpz74JXPhUEb51h17htXCNAfmzaQ
         FzBmMVeAMjAAyFRGcgEmOEHe7qbrX21jJoehBE1rFn1YxqRkItFasFUq5c9mZpPK5pVc
         mXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h2GpRLoQ1nfksopHIubIV44mAt0KTxXLpFS5BS6cG+g=;
        b=G/PTHcIKnUGigLg4IuoFCGQmnRsKcnpjbLozoLgNmZUhzm/wqjBcPelPk1Sh2wyfVf
         RD09MmkqaQxPUxxmTfhnpDbi4VhedXMUnHIo4hLAuTL0EbgcpLUp6QjakVWlZKs1Yb3d
         Z/c6x86apH/ukr0qLQwylt3u+Q/Pqk/OeABXNogT3YphVbklqcFaH2CaCCkNIcikY5Pg
         YvNBzi9h5hQk3qVR/ehQ2NwtWrsc2SPaJbjrO3Iyr2AVBPKl+O+9LGVAPipY12Of4niv
         vHAVfA19ycc3cvAV8EKFZSot4rSKrXKc112E7yskt9m8fySSZZydBNAV443yHul5LVje
         QD+w==
X-Gm-Message-State: APjAAAX8p3gDyCUm1I+ryHzRwL88/eDwZUGGBVTDgKy55TF/mnVitX+4
        zId8ysmzT2poWEbtCUBBa8ndWx5uYoE=
X-Google-Smtp-Source: APXvYqzVEz80OtbAFw71RFUFB00mQPhJy4cs7PmTgpUGf/OFGokqlpOk8IUebgcQgccl70SZqv21Xg==
X-Received: by 2002:a63:184d:: with SMTP id 13mr27264896pgy.132.1580257457437;
        Tue, 28 Jan 2020 16:24:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id f1sm64556pjq.31.2020.01.28.16.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 16:24:17 -0800 (PST)
Subject: Re: IORING_REGISTER_CREDS[_UPDATE]() and credfd_create()?
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Stefan Metzmacher <metze@samba.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>
References: <ea9f2f27-e9fe-7016-5d5f-56fe1fdfc7a9@samba.org>
 <d6bc8139-abbe-8a8d-7da1-4eeafd9eebe7@kernel.dk>
 <688e187a-75dd-89d9-921c-67de228605ce@samba.org>
 <b29e972e-5ca0-8b5f-46b3-36f93d865723@kernel.dk>
 <1ac31828-e915-6180-cdb4-36685442ea75@kernel.dk>
 <0d4f43d8-a0c4-920b-5b8f-127c1c5a3fad@kernel.dk>
 <b88f0590-71c9-d2bd-9d17-027b05d30d7a@kernel.dk>
 <2d7e7fa2-e725-8beb-90b9-6476d48bdb33@gmail.com>
 <6c401e23-de7c-1fc1-4122-33d53fcf9700@kernel.dk>
 <35eebae7-76dd-52ee-58b2-4f9e85caee40@kernel.dk>
 <d3f9c1a4-8b28-3cfe-de88-503837a143bc@gmail.com>
 <c9e58b5c-f66e-8406-16d5-fd6df1a27e77@kernel.dk>
 <6e5ab6bf-6ff1-14df-1988-a80a7c6c9294@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2019e952-df2a-6b57-3571-73c525c5ba1a@kernel.dk>
Date:   Tue, 28 Jan 2020 17:24:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6e5ab6bf-6ff1-14df-1988-a80a7c6c9294@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/28/20 5:21 PM, Pavel Begunkov wrote:
> On 29/01/2020 03:20, Jens Axboe wrote:
>> On 1/28/20 5:10 PM, Pavel Begunkov wrote:
>>>>>> Checked out ("don't use static creds/mm assignments")
>>>>>>
>>>>>> 1. do we miscount cred refs? We grab one in get_current_cred() for each async
>>>>>> request, but if (worker->creds != work->creds) it will never be put.
>>>>>
>>>>> Yeah I think you're right, that needs a bit of fixing up.
>>>>
>>>
>>> Hmm, it seems it leaks it unconditionally, as it grabs in a ref in
>>> override_creds().
>>>
>>
>> We grab one there, and an extra one. Then we drop one of them inline,
>> and the other in __io_req_aux_free().
>>
> Yeah, with the last patch it should make it even

OK good we agree on that. I should probably pull back that bit to the
original patch to avoid having a hole in there...

-- 
Jens Axboe

