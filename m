Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF63F0D0E
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 22:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHRU67 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 16:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbhHRU67 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 16:58:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AABC061764;
        Wed, 18 Aug 2021 13:58:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so3332504pjb.0;
        Wed, 18 Aug 2021 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eqOo/6HQ3yqEsh3fgdKiKd/SoMq47M4f8HbYZUxUp64=;
        b=uTqJEGsU3Kh/nFVcwOBLgzZcDftaXaoaXoL1X/nC0AJCQvXTYvw2ZxB9HJeoyPBLIl
         R84XI176tCE3TKKPupcgfhlylMg/12mfGKf+KI7ifBcO0IK68JqMdknv4kM8yCVZ6LhZ
         mR3hLEYC5j5GuWVEsw49mM3ZO9FESIgbiIRRm1U+1BcDjxXa991OQooGOzqbEAInU1EM
         XDIHF0zlbZXEqDx02VgUXJ1uAM9rI6NLZXTvlXY6dJ3Nr6SQX7ir8+ht03z8S/gPSrbG
         iFyE5mOGQ4GN11wWnnUBZyPCN4E0VJqpOMOYXoULWzAOxVbfj0PQTTBVfkCX6zYhJAXI
         6bBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eqOo/6HQ3yqEsh3fgdKiKd/SoMq47M4f8HbYZUxUp64=;
        b=lJAG/P3+CjyUX5j4Uh/ITCdMWJZENTyRJJVxykCWfHD8uxNlSw6iMbFYw/JpFpA150
         /n0s3NPlWrM2lhsdlTkwAodpeXZ9Mto8HQ1SxU3CmrWcRGF3Z7lcumiNywnQGG5uZA6n
         7I3Kb46gtLUpp2KriMW4VuULyFA0/6yWXx7qE+T+Yio7bpHgtH3LiBEI8VlQYL+VlXRB
         msEXuq2fO4FR+wvbn1l7YiLszQL6vD1FClyIQSltVFJzZ4F1IbFVwORbJ185dLUOdLQQ
         wTClCR0ke6+1xbKqmDMCMF3u+UcCT0hxspi3ycCt/DYXMjrHQ2djQl++nGtTXfxQqPXB
         kepQ==
X-Gm-Message-State: AOAM531iSMf76Pwy/v/N8lsstCkGjF2IGASwRPMCkj8YsVRgUVRkxXnX
        dZL+prHi15t/yUShwuAo/Js=
X-Google-Smtp-Source: ABdhPJwl/IKmfu2aNrkf75QS/Df1fV3xJdszoRbiJNETdwX6/g3h71/P/AFPN4obVLvRln+2tykVrg==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr11151357pjs.57.1629320303713;
        Wed, 18 Aug 2021 13:58:23 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id 4sm667832pjb.21.2021.08.18.13.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 13:58:23 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Pankaj Gupta <pankaj.gupta@ionos.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
To:     David Hildenbrand <david@redhat.com>, linux-man@vger.kernel.org
References: <20210816081922.5155-1-david@redhat.com>
 <d70ef542-051a-521f-807d-fa469b28e897@gmail.com>
 <70792f9c-ace1-6876-378b-5388f7948a60@redhat.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <abec69cb-6db9-79ab-869e-907da573bfbc@gmail.com>
Date:   Wed, 18 Aug 2021 22:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <70792f9c-ace1-6876-378b-5388f7948a60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello David,

On 8/18/21 10:35 AM, David Hildenbrand wrote:
> On 17.08.21 23:42, Michael Kerrisk (man-pages) wrote:
>> Hello David,
>>
>> Thank you for writing this! Could you please take
>> a look at the comments below and revise?
> 
> Hi Michael,
> 
> thanks for your valuable input. Your feedback will certainly make this 
> easier to understand for people that are not heavily involved in MM work :)
> 
> [...]
> 
>>>   man2/madvise.2 | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 107 insertions(+)
>>>
>>> diff --git a/man2/madvise.2 b/man2/madvise.2
>>> index f1f384c0c..f6cea9ad2 100644
>>> --- a/man2/madvise.2
>>> +++ b/man2/madvise.2
>>> @@ -469,6 +469,72 @@ If a page is file-backed and dirty, it will be written back to the backing
>>>   storage.
>>>   The advice might be ignored for some pages in the range when it is not
>>>   applicable.
>>> +.TP
>>> +.BR MADV_POPULATE_READ " (since Linux 5.14)"
>>> +Populate (prefault) page tables readable for the whole range without actually
>>
>> I have trouble to understand "Populate (prefault) page tables readable".
>> Does it mean that it is just the page tables are being populated, and the
>> PTEs are marked to indicate that the pages are readable? If yes, I
>> think some rewording would help.
> 
> I actually tried phrasing it similar to our MAP_POPULATE documentation:
> 	("Populate  (prefault)  page tables for a mapping.")

Yeah, well that description is a bit thin too :-}.

> We will prefault all pages, faulting them in.
>>
>>> +reading memory.
>>
>> I don't understand "without actually reading memory"? Do you mean,
>> "without actually  faulting in the pages"; or something else?
> 
> "Populate (prefault) page tables readable, faulting in all pages in the 
> range just as if manually reading one byte of each page; however, avoid 
> the actual memory access that would have been performed after handling 
> the fault."
> 
> Does that make it clearer? (avoiding eventually touching the page at all 
> can be beneficial, especially when dealing with DAX memory where memory 
> access might be expensive)

That text is much better. But, what's still not clear to me then is the
dfference between mmap(2) MAP_POPULATE, and MADV_POPULATE_READ and
MADV_POPULATE_WRITE. What is the differnece, and in what situations 
would one prefer one or the other approach? I think it would be helpful
if the manual page said something about these details.

>>> +Depending on the underlying mapping,
>>> +map the shared zeropage,
>>> +preallocate memory or read the underlying file;
>>> +files with holes might or might not preallocate blocks.
>>> +Do not generate
>>> +.B SIGBUS
>>> +when populating fails,
>>> +return an error instead.
>>
>> Better:
>>
>> [[
>> If populating fails, a
>> .B SIGBUS
>> signal is not generated; instead, an error i returned.
>> ]]
>>
> 
> Sure, thanks.
> 
>>> +.IP
>>> +If
>>> +.B MADV_POPULATE_READ
>>> +succeeds,
>>> +all page tables have been populated (prefaulted) readable once.
>>> +If
>>> +.B MADV_POPULATE_READ
>>> +fails,
>>> +some page tables might have been populated.
>>> +.IP
>>> +.B MADV_POPULATE_READ
>>> +cannot be applied to mappings without read permissions
>>> +and special mappings,
>>> +for example,
>>> +marked with the kernel-internal
>>
>> s/marked/mappings marked/
>>
>>> +.B VM_PFNMAP
>>> +and
>>
>> Just checking: should it be "and" or "or" here"?
>>
>> Looking at the EINVAL error below, I guess "or", and a better
>> wording would be:
>>
>> [[
>> ...for example, mappings marked with kernel-internal flags such as
>> .B VMPPFNMAP
>> or
>> .BR BR_V_IO.
>> ]]
> 
> Much better. Note that there might be more types of mappings that won't 
> work (e.g., initially also secretmem IIRC).

Ahh nice. Since there's about to be a memfd_secret() manual page, 
I suggest adding also "or secret memory regions created using
memfd_secret(2)".

>>> +.BR VM_IO .
>>> +.IP
>>> +Note that with
>>> +.BR MADV_POPULATE_READ ,
>>> +the process can be killed at any moment when the system runs out of memory.
>>> +.TP
>>> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)"
>>> +Populate (prefault) page tables writable for the whole range without actually
>>
>> I have trouble to understand "Populate (prefault) page tables writable".
>> Does it mean that it is just the page tables are being populated, and the
>> PTEs are marked to indicate that the pages are writable? If yes, I
>> think some rewording would help.
>>
>>> +writing memory.
>>
>> I don't understand "without actually writing memory"? Do you mean,
>> "without actually  faulting in the pages"; or something else?
>>
> 
> Similar to the other wording:
> 
> "Populate (prefault) page tables writable, faulting in all pages in the 
> range just as if manually writing one byte of each page; however, avoid 
> the actual memory access that would have been performed after handling 
> the fault."

Much better, but see also my comments above re MADV_POPULATE_READ.

[...]

>>> +.B EFAULT
>>> +.I advice
>>> +is
>>> +.B MADV_POPULATE_READ
>>> +or
>>> +.BR MADV_POPULATE_WRITE ,
>>> +and populating (prefaulting) page tables failed because a
>>> +.B SIGBUS
>>> +would have been generated on actual memory access and the reason is not a
>>> +HW poisoned page.
>>
>> Maybe:
>> s/.$/(see the description of MADV_HWPOISON in this page)./
>> ?
>>
> 
> Sure, we can add that. But note that MADV_HWPOISON is just one of many 
> ways to HWpoison a page.

Then maybe something like:

"(HW poisoned pages can, for example, be created using the
MADV_HWPOISON flag described elsewhere in this page.)"

[...]

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
