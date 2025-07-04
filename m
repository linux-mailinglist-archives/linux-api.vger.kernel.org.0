Return-Path: <linux-api+bounces-4135-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65685AF90B6
	for <lists+linux-api@lfdr.de>; Fri,  4 Jul 2025 12:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE3D7A63B9
	for <lists+linux-api@lfdr.de>; Fri,  4 Jul 2025 10:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B26E29293D;
	Fri,  4 Jul 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcskIKar"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E052262FD4
	for <linux-api@vger.kernel.org>; Fri,  4 Jul 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751625295; cv=none; b=f8iENsv6nvqTrWW+lAjzLBy44ikUdH5k4MkDXuYl8ggZ8rW06hbJ+454zkUfH347JA+NvaD6sbSrSR42zCreNIHAYIWZkNwfJDJgV3ux3NSUhaiwS/IIyBP478/oic2E+jX8geTLBvTKoyhRKIDTwFyP1l+b2JCqu8n7uMNL1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751625295; c=relaxed/simple;
	bh=Iy953uo3fN4jRG8qoKBTlrLNP0OC+xfursXNc0rNGYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puTZyi5LCdVftVxp1EIb4oeoR5q7Y8xfNx+Ek4CseZSDenLvHN0Z520Wu6mp7FFyIfg28qKzvSjnGWzux1UNYdAzmeEtLEJcsk8hBYBXdz40lYTvhLSgRbLm5dC64tiSvwNzBaLfXmZciMG1BvmgOIu+yqBMIOp7u2ihug8B+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcskIKar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751625292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kKC81+LYTS9wDqjhPfqay6re/S41xaelqqyXV7r8kmQ=;
	b=XcskIKar8bIffTs7mkYRUQ2Rniw9UrkhO4AbQhugOfsYheFhpq7D8F5QqkjHrtiRYFPIFn
	yETygTx8WOP/m/HPFuq4eXpXg7lzThayIvq4qyHuIio0BYwJbe/8tE+qk66x9eO+arMA6r
	Ev73Qm5VmhBwOT3r5JKoK6ciLZm3Vg8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-5S_KjAz5Pq-PGjDkSFRaHw-1; Fri, 04 Jul 2025 06:34:51 -0400
X-MC-Unique: 5S_KjAz5Pq-PGjDkSFRaHw-1
X-Mimecast-MFC-AGG-ID: 5S_KjAz5Pq-PGjDkSFRaHw_1751625290
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f858bc5eso543970f8f.0
        for <linux-api@vger.kernel.org>; Fri, 04 Jul 2025 03:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751625290; x=1752230090;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKC81+LYTS9wDqjhPfqay6re/S41xaelqqyXV7r8kmQ=;
        b=I6edktk1d2xkAzCneMDHm/EuuSuBC4e7lVwWUrlyUIP5IqMLkd5bwTvFrXp3mJFOes
         d2H15jJ0kwHTVcP46NoMCx3oWG0mWbQs/gx2QiLdXeUjiAiJ/mF7jmGUfxrdBQPF1VES
         95OeSx/uJD/+6xteKKtnpSSnd22JbjY/gsJcQSjQSuGTv8JsfM05zBcRKO6titRZPhYF
         BOPDH8Ie8WkYLia7KjICB1FJ67ciAfvTLAkm7C3/2p2k8JnTcE9ouVJEIcBXl3GpcqAY
         81XSSw5XO9HmNEU8CM/uUbytwPgdFmAx6JUhIaHZ8eN25pdDLADQM5/xR1Fywccq1QnY
         Dvpg==
X-Forwarded-Encrypted: i=1; AJvYcCVdPoC/chUt1csJgUobgKR8YXk8/hH9Xbjb8XilhmEasubrHqA8PJNsQcfQNeKoBErjDcYHbwteweM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bdT/X2QVhpdRAXJgw+1NZo5hdUMzAh3zagNvKjzIbRUrfw6V
	7jS2TB1aX2iuDPocYzg/xqynXaXvJ4llT+yP0bd+DiU4UV7xIdofh/rBl+BeZfvgbyf20i569Pz
	yDxwY74LfGpLmZjUJ67wp2raB5nG61VxSVfUPa2ZfW3Uo58A8ddn7nuAI/6IkTA==
X-Gm-Gg: ASbGncvKx0KXqvIp7TlBbLvcOGXKwRfFKUqVC/y/NyO5NZhkGlTQbGvt8+sDxSswmwp
	LsHYDhFtFDYh96+lXySTSexznTbk7uNLSuVQRVCVuN5bJJ4n13F4y4XS44bvIQB870ZfjHxhHgf
	GWft87IfAPvyh74gYyDWkVjy2OqH8OfB5mCW0ADy2x/UpdAp2kCXK18KJky5e538vsUs7jjcQZM
	ccx+KH+Lq0G7uR/jY/lcztSLh10dugJkd0TrHFqrG/gflJYDPpHlstkBvmGQICUhoEaqNe0XIaA
	mo0GWMIh7GwUCmsW1immqhV1+QpNpXmjRIZtNJxHZKR8TTIFJ3fGSJI5GEfQmY+qaI4gdhw6SIT
	q/mc4RIJSLTyFuvTGjI2B+k9Is5ehcB13b/lZ7nI/tLfEjB4=
X-Received: by 2002:a05:6000:1448:b0:3a4:f7df:baf5 with SMTP id ffacd0b85a97d-3b496fadcbamr1366208f8f.0.1751625290018;
        Fri, 04 Jul 2025 03:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqf1Mi5wCwlJzafl3k2+mdXvo4trSBHCVtKMwjAlL2Yv75Jprtj4nGpW3i3ft7VcKsW2kJeg==
X-Received: by 2002:a05:6000:1448:b0:3a4:f7df:baf5 with SMTP id ffacd0b85a97d-3b496fadcbamr1366165f8f.0.1751625289554;
        Fri, 04 Jul 2025 03:34:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:5500:988:23f9:faa0:7232? (p200300d82f2c5500098823f9faa07232.dip0.t-ipconnect.de. [2003:d8:2f2c:5500:988:23f9:faa0:7232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b470caa1b3sm2115225f8f.43.2025.07.04.03.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 03:34:49 -0700 (PDT)
Message-ID: <38aea444-a404-4176-8702-496362c88cfa@redhat.com>
Date: Fri, 4 Jul 2025 12:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
To: SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Barry Song <21cnbao@gmail.com>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
References: <20250702173816.59935-1-sj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250702173816.59935-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.07.25 19:38, SeongJae Park wrote:
> On Wed, 2 Jul 2025 15:15:01 +0100 Usama Arif <usamaarif642@gmail.com> wrote:
> 
> [...]
>> In terms of the approach of doing this, IMHO, I dont think the way to do this
>> is controversial. After the great feedback from Lorenzo on the prctl series, the
>> approach would be for userpsace to make a call that just does for_each_vma of the process,
>> madvises the VMAs,
> 
> One dirty hack that I can think off the top of my head for doing this without
> new kernel changes is, unsurprisingly, using DAMOS.  Using DAMOS, users can do
> madvise(MADV_HUGEPAGE) to virtual address ranges of specific access patterns.
> It is aimed to be used for hot regions, while using similar one of
> MADV_NOHUGEPAGE for cold regions.  An experiment with a prototype[1] showed it
> eliminates about 80% of internal fragmentation caused memory overhead while
> keeping 46% of performance improvement under a constrained situation.
> 
> If you set the access pattern as any pattern, hence, you can do
> madvise(MADV_HUGEPAGE) for effectively entire virtual address space of the
> process.  DAMON user-space tool supports periodically tracking childs and
> applying same DAMOS scheme to those.  So, for example, below hack could be
> tried.
> 
>      # damo start $(pidof XXX) --damos_action hugepage --include_child_tasks

IIRC, setting MADV_HUGEPAGE on arbitrary VMAs from arbitrary processes 
has the potential of breaking applications.

Just imagine them deliberately setting MADV_NOHUGEPAGE and are intending 
of using userfaultfd, where it is crucial that we don't over-allocate 
memory even before userfaultdf is actually registered.

(QEMU does that)

-- 
Cheers,

David / dhildenb


