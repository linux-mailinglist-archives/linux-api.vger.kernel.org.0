Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5287D363EFA
	for <lists+linux-api@lfdr.de>; Mon, 19 Apr 2021 11:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbhDSJld (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Apr 2021 05:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236018AbhDSJlc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Apr 2021 05:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618825262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeFgKAw6h+mPcXVcc4bWq1BMFLAt/JiFop1ZWmN9P3g=;
        b=blr3qaMcaPKptqAW2dsrPdu12MDl7piaeHIkesm5NN/Lq2z/+17F5ftkGJZYyfylE91JNa
        1E/9oK3IXvjT4146yDwp5+LMYz7N05gtn/OBk3GgQGZRCvVCUhWYMxZ/bAv1TojmNdmZNJ
        dtW6BdIZiSxr+3Sw7pvfvuwiDOHbqn0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-iGhIEsSBPiiqlCXljPQmTA-1; Mon, 19 Apr 2021 05:41:00 -0400
X-MC-Unique: iGhIEsSBPiiqlCXljPQmTA-1
Received: by mail-ed1-f70.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so10860619edd.5
        for <linux-api@vger.kernel.org>; Mon, 19 Apr 2021 02:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=GeFgKAw6h+mPcXVcc4bWq1BMFLAt/JiFop1ZWmN9P3g=;
        b=JuWwWS/d2cMvw5EL2qJuYWP376eMymHn6Bs7eZl41nriQdjMfmeFSSDpT4F/JIwEd4
         vJnvc7QlNZul9KzglF8XnCOeHriyngRe8HJaptkP8/QhcU87UkAkU98zM6MGgjagSMiQ
         byMrsy5YzaAf0iao9PSzvnF10kNCG8TzogrhaiecqtiASdgtJQh8Tv0lPOp0Gu5FJX/U
         EqX4vd0d6AEWa4EX+IyyCWId1sjc6Mkzl44qHQu4TUPrm9i1yg2s5+HRc03z2blLzxbP
         DDPI44RtUXrFrb41qMhK8ez9Jj0PGSwwx8k3caQLi0C87mfUHxfrxJG9cXrVqxT8EcVO
         e7/A==
X-Gm-Message-State: AOAM533mHOmcDzgGLlu8XVaGc1ZW/CHKAjW1Y29mxeOeYcwWmRqFGhtJ
        fvPzfw1UxwFsCrJ44hsbm6xKYvGDaGeBOezxaeMLkYLXenNpew8ea4PHFXiFaqHbiWHCxhtSX0L
        8CB/YyQ5UjCiy7T8qeupq
X-Received: by 2002:aa7:dcd3:: with SMTP id w19mr404783edu.157.1618825258841;
        Mon, 19 Apr 2021 02:40:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUep/F2sYsfc/GbdpC874xEruErysvjZiJSGRDsYz4g5yz9xbr6J9pJm9MKGKGsnTSZWCpUQ==
X-Received: by 2002:aa7:dcd3:: with SMTP id w19mr404773edu.157.1618825258627;
        Mon, 19 Apr 2021 02:40:58 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id b6sm1276048edd.18.2021.04.19.02.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:40:58 -0700 (PDT)
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
From:   David Hildenbrand <david@redhat.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20210419084218.7466-1-rppt@kernel.org>
 <3b30ac54-8a92-5f54-28f0-f110a40700c7@redhat.com>
 <YH1PE4oWeicpJT9g@kernel.org>
 <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
Organization: Red Hat
Message-ID: <56d8b80c-ce2c-ed86-0eda-253768d8d463@redhat.com>
Date:   Mon, 19 Apr 2021 11:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f4d0c4bf-423b-e227-444b-f1ea722dc43f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 19.04.21 11:38, David Hildenbrand wrote:
> On 19.04.21 11:36, Mike Rapoport wrote:
>> On Mon, Apr 19, 2021 at 11:15:02AM +0200, David Hildenbrand wrote:
>>> On 19.04.21 10:42, Mike Rapoport wrote:
>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>
>>>> Kernel test robot reported -4.2% regression of will-it-scale.per_thread_ops
>>>> due to commit "mm: introduce memfd_secret system call to create "secret"
>>>> memory areas".
>>>>
>>>> The perf profile of the test indicated that the regression is caused by
>>>> page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
>>>>
>>>>     27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
>>>>      0.00  +3.2   3.19 ± 2%  perf-profile.children.cycles-pp.page_mapping
>>>>      0.00  +3.7   3.66 ± 2%  perf-profile.children.cycles-pp.page_is_secretmem
>>>>
>>>> Further analysis showed that the slow down happens because neither
>>>> page_is_secretmem() nor page_mapping() are not inline and moreover,
>>>> multiple page flags checks in page_mapping() involve calling
>>>> compound_head() several times for the same page.
>>>>
>>>> Make page_is_secretmem() inline and replace page_mapping() with page flag
>>>> checks that do not imply page-to-head conversion.
>>>>
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>> ---
>>>>
>>>> @Andrew,
>>>> The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate if it would
>>>> be added as a fixup to the memfd_secret series.
>>>>
>>>>     include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
>>>>     mm/secretmem.c            | 12 +-----------
>>>>     2 files changed, 26 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
>>>> index 907a6734059c..b842b38cbeb1 100644
>>>> --- a/include/linux/secretmem.h
>>>> +++ b/include/linux/secretmem.h
>>>> @@ -4,8 +4,32 @@
>>>>     #ifdef CONFIG_SECRETMEM
>>>> +extern const struct address_space_operations secretmem_aops;
>>>> +
>>>> +static inline bool page_is_secretmem(struct page *page)
>>>> +{
>>>> +	struct address_space *mapping;
>>>> +
>>>> +	/*
>>>> +	 * Using page_mapping() is quite slow because of the actual call
>>>> +	 * instruction and repeated compound_head(page) inside the
>>>> +	 * page_mapping() function.
>>>> +	 * We know that secretmem pages are not compound and LRU so we can
>>>> +	 * save a couple of cycles here.
>>>> +	 */
>>>> +	if (PageCompound(page) || !PageLRU(page))
>>>> +		return false;
>>>
>>> I'd assume secretmem pages are rare in basically every setup out there. So
>>> maybe throwing in a couple of likely()/unlikely() might make sense.
>>
>> I'd say we could do unlikely(page_is_secretmem()) at call sites. Here I can
>> hardly estimate which pages are going to be checked.
>>    
>>>> +
>>>> +	mapping = (struct address_space *)
>>>> +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>>>> +
>>>
>>> Not sure if open-coding page_mapping is really a good idea here -- or even
>>> necessary after the fast path above is in place. Anyhow, just my 2 cents.
>>
>> Well, most if the -4.2% of the performance regression kbuild reported were
>> due to repeated compount_head(page) in page_mapping(). So the whole point
>> of this patch is to avoid calling page_mapping().
> 
> I would have thought the fast path "(PageCompound(page) ||
> !PageLRU(page))" would already avoid calling page_mapping() in many cases.

(and I do wonder if a generic page_mapping() optimization would make 
sense instead)

Willy can most probably give the best advise here :)

-- 
Thanks,

David / dhildenb

