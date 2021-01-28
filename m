Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D94308124
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhA1WcP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 17:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53248 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhA1WcH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 17:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611873039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWdKaMuCZ+HHzjgfktT+jouFy+6VZ9GcHMswE44Yles=;
        b=UrPujDrmuZvjyzn13XtB219inY/0BFj8qx5Fo+ps83++wQ+opHJ9TUBMFOZo9k3Igcs2H8
        ORUYW2r2jgfywKsGriKW1s/Y82BKnjONIpBPjWYLBC5WPkJm3ng5XNSVg1M1Kx1zL/o8DG
        STWbZIo4dQcVH0nM1s+NDA3t5zrJZPg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-zcVvpyWAPq6TzL_AMJ4HtQ-1; Thu, 28 Jan 2021 17:30:37 -0500
X-MC-Unique: zcVvpyWAPq6TzL_AMJ4HtQ-1
Received: by mail-wr1-f70.google.com with SMTP id z9so3902932wro.11
        for <linux-api@vger.kernel.org>; Thu, 28 Jan 2021 14:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=BWdKaMuCZ+HHzjgfktT+jouFy+6VZ9GcHMswE44Yles=;
        b=B4gN2EADx6pUunHgH+OzEmXgDBIGMbb4glsHw+yy3DcI9aJenTPwt+Dql1YdsfG6sM
         hWJ1JMxZCloZX/3wFL45x2qaLcbuIWq4aUuzcXlFFBHJs90dYedKKFJV2MqOQPCkdtal
         /nKH4Itde1qpR183JlaW5XuSvG4jqb2SzUhscIbOE6JwdL60Y/VucIblJMhvqnVSjLds
         NLdaVqlxufxX6Q9Z9CCmCg1pS2lldrE9vtwjmgUrZx2isYjOVoIvFAKZc8s/J7dP3Idi
         cqnA4l/rpviQKXi9JgGf7bqz3tiwNpMGLGxRQLGXqCdzAhckcWseLhjIvjPAIH9RG6uj
         Fk/A==
X-Gm-Message-State: AOAM5329QaDIqx1oEMXRPSD9ZviXgmrsi2FR3e4RuoZMrTd00Dc5fYNc
        QdaPHD6RE5oHVJe7FVaR+bdFPB9zaxouYLJQVobRVxPeq7zuqlYRACzItZtyktnYlJP0g98a+qB
        1h3f0Z4VsVU/fOARVdis/
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr1283873wrq.226.1611873035355;
        Thu, 28 Jan 2021 14:30:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxn3h5kinNtCU52JfJLJu32fgDwMUJMEY0AZ7dz8O2wBaHcZtwyYlApVZxRXD7DfG+kujRu9A==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr1283854wrq.226.1611873035174;
        Thu, 28 Jan 2021 14:30:35 -0800 (PST)
Received: from [192.168.3.108] (p5b0c66c6.dip0.t-ipconnect.de. [91.12.102.198])
        by smtp.gmail.com with ESMTPSA id y18sm8653691wrt.19.2021.01.28.14.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 14:30:34 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] mm/page_alloc: count CMA pages per zone and print them in /proc/zoneinfo
Date:   Thu, 28 Jan 2021 23:30:33 +0100
Message-Id: <2CF5220A-5452-4913-AFCB-41E1C642E521@redhat.com>
References: <89e1dbcd-605d-6a7b-361-c130f7eb9d8c@google.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
In-Reply-To: <89e1dbcd-605d-6a7b-361-c130f7eb9d8c@google.com>
To:     David Rientjes <rientjes@google.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> Am 28.01.2021 um 23:28 schrieb David Rientjes <rientjes@google.com>:
>=20
> =EF=BB=BFOn Thu, 28 Jan 2021, David Hildenbrand wrote:
>=20
>>> =EF=BB=BFOn Thu, 28 Jan 2021, David Hildenbrand wrote:
>>>=20
>>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>>> index 7758486097f9..957680db41fa 100644
>>>> --- a/mm/vmstat.c
>>>> +++ b/mm/vmstat.c
>>>> @@ -1650,6 +1650,11 @@ static void zoneinfo_show_print(struct seq_file *=
m, pg_data_t *pgdat,
>>>>          zone->spanned_pages,
>>>>          zone->present_pages,
>>>>          zone_managed_pages(zone));
>>>> +#ifdef CONFIG_CMA
>>>> +    seq_printf(m,
>>>> +           "\n        cma      %lu",
>>>> +           zone->cma_pages);
>>>> +#endif
>>>>=20
>>>>   seq_printf(m,
>>>>          "\n        protection: (%ld",
>>>=20
>>> Hmm, not sure about this.  If cma is only printed for CONFIG_CMA, we can=
't=20
>>> distinguish between (1) a kernel without your patch without including so=
me=20
>>> version checking and (2) a kernel without CONFIG_CMA enabled.  IOW,=20
>>> "cma 0" carries value: we know immediately that we do not have any CMA=20=

>>> pages on this zone, period.
>>>=20
>>> /proc/zoneinfo is also not known for its conciseness so I think printing=
=20
>>> "cma 0" even for !CONFIG_CMA is helpful :)
>>>=20
>>> I think this #ifdef should be removed and it should call into a=20
>>> zone_cma_pages(struct zone *zone) which returns 0UL if disabled.
>>>=20
>>=20
>> Yeah, that=E2=80=99s also what I proposed in a sub-thread here.
>>=20
>=20
> Ah, I certainly think your original intuition was correct.
>=20
>> The last option would be going the full mile and not printing nr_free_cma=
. Code might get a bit uglier though, but we could also remove that stats co=
unter ;)
>>=20
>> I don=E2=80=98t particularly care, while printing =E2=80=9E0=E2=80=9C mig=
ht be easier, removing nr_free_cma might be cleaner.
>>=20
>> But then, maybe there are tools that expect that value to be around on an=
y kernel?
>>=20
>=20
> Yeah, that's probably undue risk, the ship has sailed and there's no=20
> significant upside.
>=20
> I still think "cma 0" in /proc/zoneinfo carries value, though, especially=20=

> for NUMA and it looks like this is how it's done in linux-next.  With a=20=

> single read of the file, userspace can make the determination what CMA=20
> pages exist on this node.
>=20
> In general, I think the rule-of-thumb is that the fewer ifdefs in=20
> /proc/zoneinfo, the easier it is for userspace to parse it.

Makes sense, I=E2=80=98ll send an updated version tomorrow - thanks!


>=20
> (I made that change to /proc/zoneinfo to even print non-existant zones for=
=20
> each node because otherwise you cannot determine what the indices of=20
> things like vm.lowmem_reserve_ratio represent.)

