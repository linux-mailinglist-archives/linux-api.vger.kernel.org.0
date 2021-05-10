Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D01379181
	for <lists+linux-api@lfdr.de>; Mon, 10 May 2021 16:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbhEJOz1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 May 2021 10:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45850 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240362AbhEJOyF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 May 2021 10:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620658380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r3F85XZzjNHLRburwhBXkleEvJxBouqVwWLwoQqGQIQ=;
        b=dI1E2SzRWKpehGTtOXQsTs22YXLrLtT3CFiJQTXKbYPFf3JbAHOkXk0gc4knhgTbbNgM9a
        en0eMNyFBV5N7tAm9/0onb7Q6WpnDR8b1NL8hTfiWXb+WbgXo6T7Q7UxU4gASPdA4Q+tvZ
        k3cTM0O9+Ka8TlGA2Cm1vEcb1CfCyRY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-N2yycahFMfGBmZHpKdgMIw-1; Mon, 10 May 2021 10:52:59 -0400
X-MC-Unique: N2yycahFMfGBmZHpKdgMIw-1
Received: by mail-ed1-f72.google.com with SMTP id y19-20020a0564022713b029038a9f36060dso9176529edd.4
        for <linux-api@vger.kernel.org>; Mon, 10 May 2021 07:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=r3F85XZzjNHLRburwhBXkleEvJxBouqVwWLwoQqGQIQ=;
        b=lF+jBfk7lHYoRqrBXp1olcwJftWlUHdV105Rdf5NNASKWovR5JyxVFn4+RuWDObgUR
         D5f/aXcbSliz8rxHwq9TFmMrBSIVD2SxYprwE0KEuQ7AwoX/QoYx1WW3h4dfqJSPNdw1
         hVOEA4SkZayOJP/3zsTA7RG5E3VVy1Jq9863F/WfEn8S296Tqvrawitinwg/KQXhljrJ
         OJ6/SqIm4QwiTwdvbF/zif1xkj5LhEcxttUPCU4eWtUYPCjfLxU4mESPOXURsV655sXe
         Ddnpk7nYBlxhHiv5fdkGQCR/rgw0issi48QBRUfjwmYTENfBPqxthUtfmjI/xOF+Ao48
         08CQ==
X-Gm-Message-State: AOAM533Dg5kcneHQI1jZ4KhsAL1geacbfV4quLsocgslIXc2psMAABqC
        HjDIaTBVMqv2tXsp2+cPjnPYXFjvRmYwdVql6LK4es5TkYq33YX/KW6M6bt5bX+jcr1OeTLKmP+
        CrEoKLLxTAcFkzW/o9NQ+
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr26911033ejw.353.1620658378040;
        Mon, 10 May 2021 07:52:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzufxfdZUWjdIZ/nOsKy6x6eC3yTNUojQQY26UL0d5i1D2Ys7+JmehWAMQcO1ct85KkfBxw3A==
X-Received: by 2002:a17:906:4c5a:: with SMTP id d26mr26911000ejw.353.1620658377805;
        Mon, 10 May 2021 07:52:57 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676a.dip0.t-ipconnect.de. [91.12.103.106])
        by smtp.gmail.com with ESMTPSA id k5sm13003545edk.46.2021.05.10.07.52.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 07:52:57 -0700 (PDT)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Rik van Riel <riel@surriel.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20210419135443.12822-1-david@redhat.com>
 <20210509212105.d741b7026ca6dca86bdb56d2@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault page tables
Message-ID: <79bb75e1-4ee9-5fe2-e495-577518956e1f@redhat.com>
Date:   Mon, 10 May 2021 16:52:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210509212105.d741b7026ca6dca86bdb56d2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10.05.21 06:21, Andrew Morton wrote:
> On Mon, 19 Apr 2021 15:54:38 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Excessive details on MADV_POPULATE_(READ|WRITE) can be found in patch #2.
> 
> I grabbed the series, but some additional review would help things
> along here..

Thanks -- indeed, while there have been some comments to previous 
versions that improved the series as a whole, there are no explicit acks 
or rbs. Fortunately, we still have some time until the next merge window 
opens :)

> 
> Did patch #2 actually make it to linux-mm?  It's missing from my
> archive.

Ehm, good point. I punch out everything via " git send-email  --to 
linux-kernel@vger.kernel.org  --cc "linux-mm@kvack.org" ..." and don't 
remember any bounces.

Doesn't seem to appear on linux-mm:

https://lore.kernel.org/linux-mm/20210419135443.12822-1-david@redhat.com/

But it did make it to lkml as well:

https://lore.kernel.org/lkml/20210419135443.12822-3-david@redhat.com/

> https://lkml.kernel.org/r/20210419135443.12822-3-david@redhat.com lands
> on the linux-api@vger copy.

Weird, looks like linux-mm is swallowing mails.

I can just resend the series, thoughts?

-- 
Thanks,

David / dhildenb

