Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8092D45A3F5
	for <lists+linux-api@lfdr.de>; Tue, 23 Nov 2021 14:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhKWNme (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Nov 2021 08:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236592AbhKWNmc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Nov 2021 08:42:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637674763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jh8FTAWWG20K+UA82402ba7LKfonIbuvjtOQUuW19c=;
        b=GYWWa0+JpIjt8sbExUi+TfLb8lTNgAQQufEpM4pemEgYNiNUSKWMogo1C9K2v5lSpVeu9A
        buAuiHSD4Rjtg/k39vcuCdvQ9CRRgKq0mM6dhwRuIxl8r8VrMCSNnjs00W90vHZqalMEW3
        Z+2SdJ2JzniGIrrvW6Jvr3h/hWPYXQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-tUZTSzZGMmuLvKC-8OkRTw-1; Tue, 23 Nov 2021 08:39:22 -0500
X-MC-Unique: tUZTSzZGMmuLvKC-8OkRTw-1
Received: by mail-wm1-f69.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so718850wme.0
        for <linux-api@vger.kernel.org>; Tue, 23 Nov 2021 05:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=+jh8FTAWWG20K+UA82402ba7LKfonIbuvjtOQUuW19c=;
        b=3AJqMKc/tsaVmFYW0HwHbEiP83w9Ie8nJOOQrcV7MTsaX7/XVarvbpeUcW9A/BUoOL
         +Y/1AjXGAKJ+F8rK7GVv0O9w+4nyEc3hSEe2YTfpIyqMZN0uwFNIkEqO4onHtQAYTveY
         NzEKz+Fjgq8mtOpDkzcXz3RV0FLCHo2uWKSFAt6aI3kJt0zJ6D7heU8lmKZFs49QVHaT
         LtbEQvvHjwBtVwjlTEu4T5gxX1YPof6GyOadTLbVFhc4aYUgUMXprxds+CzFwOnhEXAi
         fqeDVYYF0UsHswH1g+ZlNpC8e7NcK0UtybLqbxxUEvUikB1wL0w/PlCRX6O9Cn3gOdvB
         ka5A==
X-Gm-Message-State: AOAM532qA0UsowMq86zXFBlJ1xi7wqaycUA6QcXXFJW6IFYx2sq0UV8W
        lOppg4UMYARDJyHaTlckIZL66UYsP8UuOMVcnVPzMRWdgTpEOwLkaHcw3Xha3RZVjW6exTcT41a
        SZAJv5ojZKZGvydOjPDyt
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr7219872wrp.100.1637674761161;
        Tue, 23 Nov 2021 05:39:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzD7sb1IiFmX+xh4eNwq0pLdsNnZ6eK+UsBEy9hQfqP/PgF8XkS6qu6y8mJps6VYrFnZ4fKEQ==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr7219846wrp.100.1637674760974;
        Tue, 23 Nov 2021 05:39:20 -0800 (PST)
Received: from [192.168.3.132] (p5b0c6765.dip0.t-ipconnect.de. [91.12.103.101])
        by smtp.gmail.com with ESMTPSA id d6sm1456582wrn.53.2021.11.23.05.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Nov 2021 05:39:20 -0800 (PST)
Message-ID: <10ccf01b-f13a-d626-beba-cbee70770cf1@redhat.com>
Date:   Tue, 23 Nov 2021 14:39:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211115203530.62ff33fdae14927b48ef6e5f@linux-foundation.org>
 <CFQZSHV700KV.18Y62SACP8KOO@taiga>
 <20211116114727.601021d0763be1f1efe2a6f9@linux-foundation.org>
 <CFRGQ58D9IFX.PEH1JI9FGHV4@taiga>
 <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
 <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
 <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <5f998bb7-7b5d-9253-2337-b1d9ea59c796@redhat.com>
 <20211123132523.GA5112@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20211123132523.GA5112@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> 
>> 2) Could be provide a mmu variant to ordinary users that's just good
>> enough but maybe not as fast as what we have today? And limit
>> FOLL_LONGTERM to special, privileged users?
> 
> rdma has never been privileged

Feel free to correct me if I'm wrong: it requires special networking
hardware and the admin/kernel has to prepare the system in a way such
that it can be used.

-- 
Thanks,

David / dhildenb

