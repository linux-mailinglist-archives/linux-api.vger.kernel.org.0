Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF73D3651
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 10:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhGWHfC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 03:35:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234372AbhGWHfA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 03:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627028134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsOmQhhV5hj9QM8KqB7droIKpWy0pXqJreEnaRUzjas=;
        b=cIO0eb7x2WqMjqofHWDfp+RwqY4impJfvmINFExf13q3z4JYxLNWFczJs8vl45yGNztUIN
        mQ+LXWPdZL33MJ5gIVPEKQezT1yQrRYVV24HCIhKP5u6POOp/q10DnGkyS4ik3YfGxrEtd
        CSqSZ3iP50rAoMSpB9XvtdJV183JrnE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-uMsiINshOA6HCI_eaiNwKA-1; Fri, 23 Jul 2021 04:15:33 -0400
X-MC-Unique: uMsiINshOA6HCI_eaiNwKA-1
Received: by mail-wr1-f72.google.com with SMTP id u26-20020adfb21a0000b029013e2b4a9d1eso714419wra.4
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 01:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PsOmQhhV5hj9QM8KqB7droIKpWy0pXqJreEnaRUzjas=;
        b=ZCCzkMplyLjTFrIEV2hCjIBm/z6RBlxAGYx8hUnOdzfGIVw+8W2cPnq7jlRVgnPETg
         1earjIUxnTsHa2sjNRUv3lCodYgZarQEYafQdzLob76trj0zl7EM1SDfTaIw8iCLLFcO
         6IR3vdhymyTK9Jno0FAKKq4oIUaoWqsLfwutDkji6Jg2Ep0Bj/PsnQTL3GozfVWZx9rK
         92hJpykAeqF4zn/5VgmFqpzrYdMkGFnpi+NsoCYFItn+I1M0MzushjFT6bpywU7O+ilp
         8LZQVxBcc2vJzhreiP0775oUAx7fLXdJYa41rTZG8JgDaFuZs6KJglP5ydAjE8W+9SGa
         B54Q==
X-Gm-Message-State: AOAM530fkgOgB027F1cmkHq0W7BsTRZ8FA9wHxEXl7DAIpV9AwyvRotQ
        LOQUI0SD2N3tA+NuU21nOT44E0LOZ+MPNvTn26pcNJOXb0qyRUPSgoh39Wy0fv99v/KHZI46rOY
        Jh78Bi3T7gpwM6tDzkS7E
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr3338918wmi.49.1627028132051;
        Fri, 23 Jul 2021 01:15:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7Rr4Psd5MxeJacADEM5uXfuPl/hj7wRYNdObU8hvGa0HGoP8+m60PyLjmuurv4Hl+GMy/zQ==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr3338884wmi.49.1627028131852;
        Fri, 23 Jul 2021 01:15:31 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id j23sm4305407wmo.26.2021.07.23.01.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 01:15:31 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
References: <20210723011436.60960-1-surenb@google.com>
 <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz>
 <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <23ed1d8d-fe55-fdbc-ca33-01a3ce392dff@redhat.com>
Date:   Fri, 23 Jul 2021 10:15:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 23.07.21 10:11, Suren Baghdasaryan wrote:
> 
> 
> On Thu, Jul 22, 2021, 11:20 PM Michal Hocko <mhocko@suse.com 
> <mailto:mhocko@suse.com>> wrote:
> 
>     On Thu 22-07-21 21:47:56, Suren Baghdasaryan wrote:
>      > On Thu, Jul 22, 2021, 7:04 PM Shakeel Butt <shakeelb@google.com
>     <mailto:shakeelb@google.com>> wrote:
>      >
>      > > On Thu, Jul 22, 2021 at 6:14 PM Suren Baghdasaryan
>     <surenb@google.com <mailto:surenb@google.com>>
>      > > wrote:
>      > > >
>      > > [...]
>      > > > +
>      > > > +       mmap_read_lock(mm);
>      > >
>      > > How about mmap_read_trylock(mm) and return -EAGAIN on failure?
>      > >
>      >
>      > That sounds like a good idea. Thanks! I'll add that in the next
>     respin.
> 
>     Why is that a good idea? Can you do anything meaningful about the
>     failure other than immediately retry the syscall and hope for the best?
> 
> 
> I was thinking if this syscall implements "best effort without blocking" 
> approach then for a more strict usage user can simply retry. However 
> retrying means issuing another syscall, so additional overhead...
> I guess such "best effort" approach would be unusual for a syscall, so 
> maybe we can keep it as it is now and if such "do not block" mode is 
> needed we can use flags to implement it later?

The process is dying, so I am not sure what we are trying to optimize 
here in respect to locking ...


-- 
Thanks,

David / dhildenb

