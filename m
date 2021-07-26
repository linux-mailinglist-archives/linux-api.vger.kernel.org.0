Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2B43D539C
	for <lists+linux-api@lfdr.de>; Mon, 26 Jul 2021 09:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGZGbP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 02:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231909AbhGZGbM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 02:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627283501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxZD54M+2X15RdHVUN51d7n66Bvp24nWS/YYICKELtg=;
        b=P7OOHVQAFcl3f84aGO9LJMurhkLPXmdDNoRGvBjR953NJYgug51Ay6xpalmMeh8XYjZ+zg
        7jx/YHAqnsNaljYoohTwv1kD9GyjCySAT3BuiMWzsaC3sAD6/I78O9QhsbdMgzNtKb/2HG
        +P5yLTlQq13l/5wI94ejyIe7DsTMAv8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-JjGiZOsLPiOaSlC58408Ww-1; Mon, 26 Jul 2021 03:11:40 -0400
X-MC-Unique: JjGiZOsLPiOaSlC58408Ww-1
Received: by mail-wr1-f69.google.com with SMTP id l12-20020a5d6d8c0000b029011a3b249b10so4323690wrs.3
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 00:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UxZD54M+2X15RdHVUN51d7n66Bvp24nWS/YYICKELtg=;
        b=G5pNRXSuvrw4pG4XQkWpnLubmhE6+XKatnCtpk52NkGrUqOsXEknjBqgmH+q9b8UfP
         z5QXOBnw3UtZnwWEA8vX1eElYPQSHymh6VYDgKMPRunbJDveiNEjUPhUeYFy9//M8Fug
         w+jGRMktJKogsLqbQP6gSzAqy6IofiSctovrf6C08xlxSrlsZm+om3TebMsdTuRSwGuP
         Dq0uU94cs/8SdfARRf4hP5iObcdztq8vxt+KM4JTy71zvUDm2oE51tIMAT94L/la8NgP
         XYOCq4ZMY09pU99wSJbIAu6lqJ1XVVo0CjVRTphEVId32Dc8Kw9dKhf05AlW7J/Vu5zh
         Lfdg==
X-Gm-Message-State: AOAM532034zm2aLpXhV3nGeWGpVHRsohPR9PsWGDF/2Bef8b+nZyIqah
        4hYz2QsPf6ju9iJg4MrEDWIIbvg6/eYqzUwPnmllRy+Pm0aNpHDgmtGMDU1nMHLqgzC2AgTMvQb
        eFwRBdv7BhuUFlUwuen4I
X-Received: by 2002:a1c:7314:: with SMTP id d20mr24979107wmb.156.1627283499079;
        Mon, 26 Jul 2021 00:11:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH+NQkwO85JH+ShDKhtzyyG8CINi3dIsR0mvgcBcMNSLHJu0AjSyd3HNaYH+zxfF/BnekRSA==
X-Received: by 2002:a1c:7314:: with SMTP id d20mr24979089wmb.156.1627283498852;
        Mon, 26 Jul 2021 00:11:38 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23b33.dip0.t-ipconnect.de. [79.242.59.51])
        by smtp.gmail.com with ESMTPSA id 125sm11520392wmb.12.2021.07.26.00.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:11:38 -0700 (PDT)
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
References: <20210712083917.16361-1-david@redhat.com>
 <CAM9Jb+g7a5kY4DHzDzJTfs-mVEm_CFRcCeY2zdjo6sZWxkjnLA@mail.gmail.com>
 <51ec094e-e402-d8a4-d65f-24b8d7929707@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
Message-ID: <6c7543e4-23c8-8f2d-dc89-480be13738b3@redhat.com>
Date:   Mon, 26 Jul 2021 09:11:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <51ec094e-e402-d8a4-d65f-24b8d7929707@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Alex,

>>> ---
>>>    man2/madvise.2 | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 80 insertions(+)
>>>
>>> diff --git a/man2/madvise.2 b/man2/madvise.2
>>> index f1f384c0c..3ec8c53a7 100644
>>> --- a/man2/madvise.2
>>> +++ b/man2/madvise.2
>>> @@ -469,6 +469,59 @@ If a page is file-backed and dirty, it will be written back to the backing
>>>    storage.
>>>    The advice might be ignored for some pages in the range when it is not
>>>    applicable.
>>> +.TP
>>> +.BR MADV_POPULATE_READ " (since Linux 5.14)
> 
> s/$/"/


Thanks!


> 
>>> +Populate (prefault) page tables readable for the whole range without actually
> 
> See the following extract from man-pages(7):
> 
> $ man 7 man-pages | sed -n '/Use semantic newlines/,/^$/p';
>      Use semantic newlines
>          In the source of a manual page,  new  sentences  should  be
>          started  on new lines, and long sentences should split into
>          lines at clause breaks (commas, semicolons, colons, and  so
>          on).   This  convention,  sometimes known as "semantic new‐
>          lines", makes it easier to see the effect of patches, which
>          often  operate at the level of individual sentences or sen‐
>          tence clauses.

Thanks, something like the following (also limiting to 80 characters
per page) work?

"
Populate (prefault) page tables readable for the whole range without actually
reading.
Depending on the underlying mapping,
map the shared zeropage,
preallocate memory or read the underlying file;
files with holes might or might not preallocate blocks.
"

> 
>>> +reading. Depending on the underlying mapping, map the shared zeropage,
>>> +preallocate memory or read the underlying file; files with holes might or
>>> +might not preallocate blocks.
>>> +Do not generate
>>> +.B SIGBUS
>>> +when populating fails, return an error instead.
>>> +.IP
>>> +If
>>> +.B MADV_POPULATE_READ
>>> +succeeds, all page tables have been populated (prefaulted) readable once.
>>> +If
>>> +.B MADV_POPULATE_READ
>>> +fails, some page tables might have been populated.
>>> +.IP
>>> +.B MADV_POPULATE_READ
>>> +cannot be applied to mappings without read permissions
>>> +and special mappings marked with the kernel-internal
>>> +.B VM_PFNMAP
>>> +and
>>> +.BR VM_IO .
>>> +.IP
>>> +Note that with
>>> +.BR MADV_POPULATE_READ ,
>>> +the process can be killed at any moment when the system runs out of memory.
>>> +.TP
>>> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)
> 
> s/$/"/

Thanks!

-- 
Thanks,

David / dhildenb

