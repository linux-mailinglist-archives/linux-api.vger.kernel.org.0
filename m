Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5504593BA
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 18:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbhKVROr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 12:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239798AbhKVROr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 12:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637601100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Phf2QrzzmaDIwGVfZVve7wU0yQ9D8hvAWEdQ6KPMNRo=;
        b=MyA9zamn8ULDxOAR88K8koxBU7TwhLx6O4mu5cQ5p7zsyfjrL4qA8HoCMp8xnJM9ALehLO
        PzHQI6FtvDYtjOSGamq9OiwQE1q2oYuewVMyLoG86mkIFWoKUYtKoy0W0P86ADvwakEY4B
        nguWTmcJlGN819zkpK8jwwvSKYsMBqQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-Fke4fuR9Ml-qzq9fSmXVkA-1; Mon, 22 Nov 2021 12:11:37 -0500
X-MC-Unique: Fke4fuR9Ml-qzq9fSmXVkA-1
Received: by mail-wm1-f69.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so193441wmb.4
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 09:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=Phf2QrzzmaDIwGVfZVve7wU0yQ9D8hvAWEdQ6KPMNRo=;
        b=ZTCZxFHLi0MxbqLPAzflEX9G0P9zHLrYDB38szrQsZIprX8W1kesqXbKjS4KGoCxDF
         x36X9V/nvHfhtszIHfreZZfJN8xorzYH4/BM23/ABUjxZfbp7IQsCrrvlIgpqeiq39NT
         dlm7i1vfQ4eQZVLg+98m7qO/XFbAuVMRwWrd4ao6mahEh6L7s7aClxiZRieNs+IITToW
         zOTSCtYjXC5uz/WNvGIaBdCMHg4nSOUjn60gUpkKFp0m1l1RF/BSjCmeF9VamVO5XfAW
         QiQLEWBzNwbYnGa1Qq4tPJclXtMebXkhklb6xGfekj06BAZtL0teQE67I4tURXc/0hzu
         KMRg==
X-Gm-Message-State: AOAM531Xm9OgxDEKybDeSIqbjb3LHyDo1X7g2O2QBOEAZxDcZ0lriBxv
        //sDt7+U+e9LW+obVoYUyXMrDbsNpH5H1g58HfRjfXWI1ZLluP3bEpzaHgeJiFteCEUEIyA2zye
        0YX6RZFQVBEGemR0O6liD
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr30737763wmj.190.1637601090596;
        Mon, 22 Nov 2021 09:11:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJSOfXqMAnLV5Q/tuhdq3GNQ8VLl419MW+cfbNy8G3bRV/AYoyovM3ensDWzOdfrrIx6af/Q==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr30737727wmj.190.1637601090332;
        Mon, 22 Nov 2021 09:11:30 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id k37sm11072331wms.21.2021.11.22.09.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 09:11:29 -0800 (PST)
Message-ID: <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
Date:   Mon, 22 Nov 2021 18:11:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Drew DeVault <sir@cmpwn.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        io_uring Mailing List <io-uring@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>, linux-mm@kvack.org
References: <20211028080813.15966-1-sir@cmpwn.com>
 <CAFBCWQ+=2T4U7iNQz_vsBsGVQ72s+QiECndy_3AMFV98bMOLow@mail.gmail.com>
 <CFII8LNSW5XH.3OTIVFYX8P65Y@taiga>
 <593aea3b-e4a4-65ce-0eda-cb3885ff81cd@gnuweeb.org>
 <20211115203530.62ff33fdae14927b48ef6e5f@linux-foundation.org>
 <CFQZSHV700KV.18Y62SACP8KOO@taiga>
 <20211116114727.601021d0763be1f1efe2a6f9@linux-foundation.org>
 <CFRGQ58D9IFX.PEH1JI9FGHV4@taiga>
 <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
In-Reply-To: <20211116133750.0f625f73a1e4843daf13b8f7@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 16.11.21 22:37, Andrew Morton wrote:
> On Tue, 16 Nov 2021 20:48:48 +0100 "Drew DeVault" <sir@cmpwn.com> wrote:
> 
>> On Tue Nov 16, 2021 at 8:47 PM CET, Andrew Morton wrote:
>>> Well, why change the default? Surely anyone who cares is altering it
>>> at runtime anyway. And if they are not, we should encourage them to do
>>> so?
>>
>> I addressed this question in the original patch's commit message.
> 
> Kinda.
> 
> We're never going to get this right, are we?  The only person who can
> decide on a system's appropriate setting is the operator of that
> system.  Haphazardly increasing the limit every few years mainly
> reduces incentive for people to get this right.
> 
> And people who test their software on 5.17 kernels will later find that
> it doesn't work on 5.16 and earlier, so they still need to tell their
> users to configure their systems appropriately.  Until 5.16 is
> obsolete, by which time we're looking at increasing the default again.
> 
> I don't see how this change gets us closer to the desired state:
> getting distros and their users to configure their systems
> appropriately.
> 

My 2 cents: while we should actually try to avoid new FOLL_LONGTERM
users where possible, we introduce more (IOURING_REGISTER_BUFFERS) to be
consumed by ordinary, unprivileged users. These new features, *when
used* require us to raise the MLOCK_LIMIT. Secretmem is similar, but for
now it rather "replaces" old mlock usage and IIRC has similarly small
memory demands; that might change in the future, though.

Why is FOLL_LONGTERM bad? Not only does it prevent swapping like mlock
does, the pages are also unmovable in memory, such that they cannot be
moved around, for example, for memory compaction.

Well, I'm not too mad about IOURING_REGISTER_BUFFERS, it actually helped
me to write a simple reproducer for the COW issues we have in upstream
mm, and can be quite beneficial in some setups. Still, I think it should
be used with care depending on the actual environment.

So, just because a new feature is around that could be used, does it
mean that we should adjust our kernel default? I'd say in this case,
rather not. Distributions, or much better, the responsible admin, should
make such decisions, knowing the environment and the effect this could have.

(I know that we can similarly trigger allocation of a lot of unmovable
memory using other means by malicious user space; but that is rather
something to limit or handle in the future IMHO)

-- 
Thanks,

David / dhildenb

