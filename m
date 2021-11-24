Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E0A45C2F2
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 14:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345451AbhKXNeV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 08:34:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348783AbhKXNcw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 08:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637760582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRYVWJ0dHQQi9iTSKLYm90ofCR3wC6pwccxUaAf29nM=;
        b=e10UOt4SaPoLD4eM0jQWBkL/2kDJAxgYofP1YvwjUa5w23ZIK6twqvV5qLhddHIwW1BYff
        vK/5rL58lqIINjlqhlvzscN22jIliF7g6lAzXNsQivaZ+eKWqYQWzpshzf+ONe2OUBZhVk
        PIrLMlDQe/LLDbMvMkGokXypBA1TFCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-dJ429_y7O7GwTPcGJaOaUA-1; Wed, 24 Nov 2021 08:29:41 -0500
X-MC-Unique: dJ429_y7O7GwTPcGJaOaUA-1
Received: by mail-wm1-f71.google.com with SMTP id m18-20020a05600c3b1200b0033283ea5facso1723829wms.1
        for <linux-api@vger.kernel.org>; Wed, 24 Nov 2021 05:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=xRYVWJ0dHQQi9iTSKLYm90ofCR3wC6pwccxUaAf29nM=;
        b=XGoPXA89vekZIaCJMuZSCu5/uzCQ6yW0JzZ9F5/DKvbxj5XPlQIZxFxYiAIDdkzX0W
         IEcViaEl+7ukUd7Zv077RGGjtNw4C1yVyb8HnSZphD37yLVF2vLn6MvoInlFfFMnBRHl
         IrfkVkmL43SFoiSyZpL2x2L1n/fWE8tdZoOWotKh9vZmsceeokpi1EjnaX3YRsXzy+fo
         6AdM9aLgHWGUzcwvP+yA/+SBbjswAYd5vy1haM3vmTGJU9OFZx3Tko3xLjw0qaJxN843
         So9gveAn5qk2mjMGtiIDhwfthN8g9Po3BlBskLnbcuYh2YC5pxLR4xwYK4exWKOVnPgW
         A0oQ==
X-Gm-Message-State: AOAM533/iZI4TC/7Rdt90/GXrt8jHwjBbUHMF5gnPDS3x5OuP9hvBs2W
        6ZR4J+WRQ1Py9RH/K1U+ddpqxF9vnvjRWPkzf0oDO1bza7hT44AXThirjtJsANNWB11wm3drjzY
        plwbY/A5yR/4vtAypSz4E
X-Received: by 2002:a05:600c:4113:: with SMTP id j19mr15740521wmi.48.1637760580118;
        Wed, 24 Nov 2021 05:29:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx78FKob78W4FbekErBlR8gszY218GTBoVGEEbXRoGoGY1c2BBkA3PDkq8LVS5+AsJnhYARCQ==
X-Received: by 2002:a05:600c:4113:: with SMTP id j19mr15740485wmi.48.1637760579921;
        Wed, 24 Nov 2021 05:29:39 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6380.dip0.t-ipconnect.de. [91.12.99.128])
        by smtp.gmail.com with ESMTPSA id j40sm5638552wms.16.2021.11.24.05.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Nov 2021 05:29:39 -0800 (PST)
Message-ID: <eab5aeba-e064-9f3e-fbc3-f73cd299de83@redhat.com>
Date:   Wed, 24 Nov 2021 14:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211123132523.GA5112@ziepe.ca>
 <10ccf01b-f13a-d626-beba-cbee70770cf1@redhat.com>
 <20211123140709.GB5112@ziepe.ca>
 <e4d7d211-5d62-df89-8f94-e49385286f1f@redhat.com>
 <20211123170056.GC5112@ziepe.ca>
 <dd92a69a-6d09-93a1-4f50-5020f5cc59d0@suse.cz>
 <20211123235953.GF5112@ziepe.ca>
 <2adca04f-92e1-5f99-6094-5fac66a22a77@redhat.com>
 <20211124132353.GG5112@ziepe.ca>
 <cca0229e-e53e-bceb-e215-327b6401f256@redhat.com>
 <20211124132842.GH5112@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211124132842.GH5112@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 24.11.21 14:28, Jason Gunthorpe wrote:
> On Wed, Nov 24, 2021 at 02:25:09PM +0100, David Hildenbrand wrote:
>> On 24.11.21 14:23, Jason Gunthorpe wrote:
>>> On Wed, Nov 24, 2021 at 09:57:32AM +0100, David Hildenbrand wrote:
>>>
>>>> Unfortunately it will only be a band aid AFAIU. I can rewrite my
>>>> reproducer fairly easily to pin the whole 2M range first, pin a second
>>>> time only a single page, and then unpin the 2M range, resulting in the
>>>> very same way to block THP. (I can block some THP less because I always
>>>> need the possibility to memlock 2M first, though).
>>>
>>> Oh!
>>>
>>> The issue is GUP always pins an entire compound, no matter how little
>>> the user requests.
>>
>> That's a different issue. I make sure to split the compound page before
>> pinning anything :)
> 
> ?? Where is that done in GUP?

It's done in my reproducer manually.

-- 
Thanks,

David / dhildenb

