Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3989C4595E1
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 21:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKVUHV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 15:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhKVUHP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 15:07:15 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54EC06174A
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 12:04:08 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id j21so13801932ila.5
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 12:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WcnIZFGVTPnrcYytNY02ni75O1bSYxfUiY64xA9VdJw=;
        b=oZB5IQXQN9L8o8iGXNo3OyAra+BxdLQvxICWQywbHB2Q1I6+6Pp+Wz8/5g8ze3VGkR
         lqeS1aJSbN9ttOXV0YvvS15DwWBX5NO6t1Gr9VC7Z0mnX5NMNU1MGrF0CwL/56m2hH4h
         aQeX4BYQ7o1IOT/LkkbFYGxAMqlJT2jFXOKYTpEt75y7y6Am4P314kHwe1BJQkwa4Iwx
         4fvjao9tsBMvGCYc5Cb+tgYyzn2Sx9mx+MjE0Z/qlPPyXcAD0GrYszUz2uBEMUK0Us4n
         Yrrv6KObfacGoSgBD0gmMyNaFh86lb0W0WrqebDFJKNCm4rj0vbuYefGds6NwQvn4mek
         l6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WcnIZFGVTPnrcYytNY02ni75O1bSYxfUiY64xA9VdJw=;
        b=x7VMlfZR65QGGLWD+lcEjlDj0LTpo8W+X/QTcT7uwjwM9X0/qZ113oVBG53qL6PF5Y
         erlCzhlNAbXR67+1aa0+oyAlaRaYp/7FfCLmAu2p/c3wYLHsNPAiy574+5aV6CMcYP2S
         Hz4aUjwJCx2hPfXKEczFyOD204aNQn/B8O1I3dXQ6o7WmVKhdzKgkNXOPVlUXnVN+1vc
         ndnEmUGViGWTn9SgdDAO6uJYAxXqt3MR1d5jEDfJ6Pgoa8OYr3CCB6Cmpzff3fROKkIl
         axASw8Qbg1lhSmOpGqXjcASqUpAGMalWWsnD3DknJvAoR4LeZPAh9asJfmh3QCT7ifZC
         ILng==
X-Gm-Message-State: AOAM530tv8mIan/NJYRfiZ62bmocOXOl22D0u2pAnFnkCL/oaZ86zC8t
        Ssv9Hi48XyC6CcbVzL/dT1w4yA==
X-Google-Smtp-Source: ABdhPJxfnND7HpPceC1uzpXx0XP6oJwV4n5DAJWri6sMooF2XhmePsbBGeWC4HcwLKMXRQxHqBbpNg==
X-Received: by 2002:a92:6e07:: with SMTP id j7mr988145ilc.188.1637611448241;
        Mon, 22 Nov 2021 12:04:08 -0800 (PST)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g4sm7765452ila.78.2021.11.22.12.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 12:04:07 -0800 (PST)
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <593aea3b-e4a4-65ce-0eda-cb3885ff81cd@gnuweeb.org>
 <20211115203530.62ff33fdae14927b48ef6e5f@linux-foundation.org>
 <CFQZSHV700KV.18Y62SACP8KOO@taiga>
 <20211116114727.601021d0763be1f1efe2a6f9@linux-foundation.org>
 <CFRGQ58D9IFX.PEH1JI9FGHV4@taiga>
 <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
 <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
 <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
 <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
 <ca96bb88-295c-ccad-ed2f-abc585cb4904@kernel.dk>
 <YZv3khUomkmRh/X6@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b1e8055-4d25-64ec-5756-848dc4283422@kernel.dk>
Date:   Mon, 22 Nov 2021 13:04:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YZv3khUomkmRh/X6@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/22/21 1:03 PM, Matthew Wilcox wrote:
> On Mon, Nov 22, 2021 at 12:53:31PM -0700, Jens Axboe wrote:
>> We should just make this 0.1% of RAM (min(0.1% ram, 64KB)) or something
>> like what was suggested, if that will help move things forward. IMHO the
>> 32MB machine is mostly a theoretical case, but whatever .
> 
> I think you mean max(0.1% ram, 64KB).  with that change, I agree.

Heh yes, that is indeed what I meant :-)

-- 
Jens Axboe

