Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2044594AD
	for <lists+linux-api@lfdr.de>; Mon, 22 Nov 2021 19:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240279AbhKVS31 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Nov 2021 13:29:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240260AbhKVS30 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Nov 2021 13:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637605579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=su8UwITbLNscSJUA/m0/+bJ/+gkmAd2xTdWSLbbVwD0=;
        b=bEDm7VSQH3q7fTY9fWwxsXigtFhbaasoosog5P8G5DEi08E3HFFGTfqt5bANbpD0w+DowG
        l2P55P1x0G7rA60ZeVylGp/bLow3m+szieCrkYCF9iy1QqJXbHMaMWCWlp4moiOXNdht/Y
        b/WuMT6sO12pNb3TM9ArDITsLm9mA18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-296-j03p2yqpPgWOOm-U_nHO6Q-1; Mon, 22 Nov 2021 13:26:18 -0500
X-MC-Unique: j03p2yqpPgWOOm-U_nHO6Q-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso3316672wrj.12
        for <linux-api@vger.kernel.org>; Mon, 22 Nov 2021 10:26:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=su8UwITbLNscSJUA/m0/+bJ/+gkmAd2xTdWSLbbVwD0=;
        b=hWxZAfhLhNjbzgARww/MUw6NgeMTai2+ZFHyxYOUhKiYzr9ebhZYrvF7L25FnZWOCa
         VWKc71jYtOyz8R/YELJixMcqWyU/5YnDzGV6INv4bGOUACloMy4guNhdvDvYcDhoFMvR
         uD2hWScGK4xCYJ+6oy7tLEuHOFOezmcNSL1lxjwUm+n9o/BWx2scT+f1M5FM8+c6kYXt
         UhPcY98jj3woIOVOjDpo0L0qe0AK+h5nhmLu6ugMwBOZw3epoGQYxreyrxNTS/iAP8RO
         tcqnoM4H7ghhTIed8JwB3gKhUhPQhb7bWsDBlZfj8BPAJQR5lfDRY5AMqQz6f4HqNG0e
         Y27A==
X-Gm-Message-State: AOAM531EP8YYySPsqMNhzIj73Dt7p7Oz26lpmR4wIoxWdfRIZzW8rCm+
        xbWI++RZO/RoxonuHSJV6oyrSSmgx3T/Ah5yEYfxB3ARmIUP9krF9z2AkshKJ72aUNFs8dnkmrA
        j1T+jxc74puq1SPSCOf4e
X-Received: by 2002:a7b:c207:: with SMTP id x7mr33034609wmi.108.1637605577023;
        Mon, 22 Nov 2021 10:26:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl1geMQCCGpeHmabH1NU7TvFBIvZ2sdcXAUIiuRx8awMBeyFGSlesgD0P73Py4z3p5I7iiAw==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr33034569wmi.108.1637605576784;
        Mon, 22 Nov 2021 10:26:16 -0800 (PST)
Received: from [192.168.3.132] (p5b0c667b.dip0.t-ipconnect.de. [91.12.102.123])
        by smtp.gmail.com with ESMTPSA id t8sm11470375wmq.32.2021.11.22.10.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 10:26:16 -0800 (PST)
Message-ID: <333cb52b-5b02-648e-af7a-090e23261801@redhat.com>
Date:   Mon, 22 Nov 2021 19:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Andrew Dona-Couch <andrew@donacou.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <b84bc345-d4ea-96de-0076-12ff245c5e29@redhat.com>
 <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Increase default MLOCK_LIMIT to 8 MiB
In-Reply-To: <8f219a64-a39f-45f0-a7ad-708a33888a3b@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 22.11.21 18:55, Andrew Dona-Couch wrote:
> Forgive me for jumping in to an already overburdened thread.  But can
> someone pushing back on this clearly explain the issue with applying
> this patch?

It will allow unprivileged users to easily and even "accidentally"
allocate more unmovable memory than it should in some environments. Such
limits exist for a reason. And there are ways for admins/distros to
tweak these limits if they know what they are doing.

> 
> The only concerns I've heard are that it doesn't go far enough.  That
> another strategy (that everyone seems to agree would be a fair bit more
> effort) could potentially achieve the same goal and then some.  Isn't
> that exactly what's meant by "don't let perfection be the enemy of the
> good"? The saying is not talking about literal perfection -- the idea is
> that you make progress where you can, and that incremental progress and
> broader changes are not necessarily in conflict.
> 
> This tiny patch could be a step in the right direction.  Why does this
> thread need dozens of replies?

Because it does something controversial. Send controversial patches,
receive many opinions, it's that simple.

This is not a step into the right direction. This is all just trying to
hide the fact that we're exposing FOLL_LONGTERM usage to random
unprivileged users.

Maybe we could instead try getting rid of FOLL_LONGTERM usage and the
memlock limit in io_uring altogether, for example, by using mmu
notifiers. But I'm no expert on the io_uring code.

-- 
Thanks,

David / dhildenb

