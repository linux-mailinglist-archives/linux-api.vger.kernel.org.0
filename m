Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91103080E6
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 23:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhA1WFR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 17:05:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229692AbhA1WFR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 17:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611871431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfY5AvEwsoH+kbk1QwL4Ppj2/ZQAB0t6+ns8YqF9dOI=;
        b=U4PdRLw2zRJJSEDeBdTrOY6VnS0q3l0GFzycH79XtesjHUawtxc41GMr21g9xUvqPNe3Wj
        cJw45TxIIFVJp6IyPz2t7XdMS7+PYOmxgAqiWCHns3TJARqI7l3v2cHFqxMxK50xQArSMX
        VHkqFFOqU6iskHluW3dRvIFVJf5+/Is=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-wVMU-ohdPCGeGRnk7NJiow-1; Thu, 28 Jan 2021 17:03:48 -0500
X-MC-Unique: wVMU-ohdPCGeGRnk7NJiow-1
Received: by mail-wr1-f70.google.com with SMTP id n15so3865119wrv.20
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 14:03:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wfY5AvEwsoH+kbk1QwL4Ppj2/ZQAB0t6+ns8YqF9dOI=;
        b=Nu1SpoFhIsw6zuquLfbImmGeSGFqBtsWYUeBjk52CEBpr4us1YsQTAx4KGBrP6z9sh
         TAN8FD6n6cmgRMuUMuVZSXRCMc3YEDo/ZpLc8dNmEfmeMwyJVaRvRRIUFQTjnzojTeFx
         fWHcbJ7t4ROmt+OjfrF0y9ntzKwSGnv1rlqfvO3T8msVkrvuUjqOsRS1UTsN0UsEE/Pe
         +di4XgUe7iFYBhwrBBdsz4bM7z99h7NOLKw7TxiRDy2B5mc2qXUNCrHqfV36VXvNCK+s
         JK9F5bUnPpZdqNWCIUKjy2Us3M0F4+wCj8z0O8NkJBd7lxzWYmTYbSPy3ic2gRKGTORB
         3JWQ==
X-Gm-Message-State: AOAM532m73MnFlH+Pxt2audv7JhKYXKeqrs+wHUs+gV35DhHXGEz4tkn
        kva28C9QdvEYJWR6D2SmNrsdi6BnTe39gDNvLNeJ4fe75YtV4ZaFQr1fCv+U+k5V9VEaY0o6IDX
        mcb2S0MoNmt65KsXNbkKs
X-Received: by 2002:a5d:4f87:: with SMTP id d7mr1104972wru.385.1611871426933;
        Thu, 28 Jan 2021 14:03:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysqQfhWq7XvaSq0pHnWrOtVEhYLmCkcoS1wdNrN0T+39kv0KDA3j3fod8WE49oA05WGDtjug==
X-Received: by 2002:a5d:4f87:: with SMTP id d7mr1104947wru.385.1611871426710;
        Thu, 28 Jan 2021 14:03:46 -0800 (PST)
Received: from [192.168.3.108] (p5b0c66c6.dip0.t-ipconnect.de. [91.12.102.198])
        by smtp.gmail.com with ESMTPSA id u5sm7723931wmg.9.2021.01.28.14.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 14:03:46 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/page_alloc: count CMA pages per zone and print them in /proc/zoneinfo
Date:   Thu, 28 Jan 2021 23:03:44 +0100
Message-Id: <F1BB7F6F-DD08-4D97-A79A-CC7CA6A579E2@redhat.com>
References: <6d9cff33-39c1-ef8e-a18e-c865b95240b6@google.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
In-Reply-To: <6d9cff33-39c1-ef8e-a18e-c865b95240b6@google.com>
To:     David Rientjes <rientjes@google.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> Am 28.01.2021 um 22:54 schrieb David Rientjes <rientjes@google.com>:
>=20
> =EF=BB=BFOn Thu, 28 Jan 2021, David Hildenbrand wrote:
>=20
>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>> index 7758486097f9..957680db41fa 100644
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -1650,6 +1650,11 @@ static void zoneinfo_show_print(struct seq_file *m=
, pg_data_t *pgdat,
>>           zone->spanned_pages,
>>           zone->present_pages,
>>           zone_managed_pages(zone));
>> +#ifdef CONFIG_CMA
>> +    seq_printf(m,
>> +           "\n        cma      %lu",
>> +           zone->cma_pages);
>> +#endif
>>=20
>>    seq_printf(m,
>>           "\n        protection: (%ld",
>=20
> Hmm, not sure about this.  If cma is only printed for CONFIG_CMA, we can't=
=20
> distinguish between (1) a kernel without your patch without including some=
=20
> version checking and (2) a kernel without CONFIG_CMA enabled.  IOW,=20
> "cma 0" carries value: we know immediately that we do not have any CMA=20
> pages on this zone, period.
>=20
> /proc/zoneinfo is also not known for its conciseness so I think printing=20=

> "cma 0" even for !CONFIG_CMA is helpful :)
>=20
> I think this #ifdef should be removed and it should call into a=20
> zone_cma_pages(struct zone *zone) which returns 0UL if disabled.
>=20

Yeah, that=E2=80=99s also what I proposed in a sub-thread here.

The last option would be going the full mile and not printing nr_free_cma. C=
ode might get a bit uglier though, but we could also remove that stats count=
er ;)

I don=E2=80=98t particularly care, while printing =E2=80=9E0=E2=80=9C might b=
e easier, removing nr_free_cma might be cleaner.

But then, maybe there are tools that expect that value to be around on any k=
ernel?

Thoughts?

Thanks=

