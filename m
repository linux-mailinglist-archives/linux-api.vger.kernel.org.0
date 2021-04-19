Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2029D363F76
	for <lists+linux-api@lfdr.de>; Mon, 19 Apr 2021 12:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbhDSKW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Apr 2021 06:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238512AbhDSKWG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Apr 2021 06:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618827696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xpi5lBk+awQqaK6Y03m/CCSgGP4Mxrpo1j7RjBYWGpQ=;
        b=VQtgG7bjwPc5KvfVcRrHIyF1krPDYdvPVsUAZ+1XEaHVZGVb+Z1kzERzcc1gabboa+icfq
        l9+JuGzBsTL6cE9BVAr5kgXHx7Yq0KwJ1qYf28gspCCO7LuSAYmRcY/GTrcoOrl2r4LD8g
        VDaF4f2vBa8ARiPQ0cP4odXFg64XlJM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-L_Pc0AcuMWi-xVYo6JqrOw-1; Mon, 19 Apr 2021 06:21:34 -0400
X-MC-Unique: L_Pc0AcuMWi-xVYo6JqrOw-1
Received: by mail-ed1-f71.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso10909354edc.3
        for <linux-api@vger.kernel.org>; Mon, 19 Apr 2021 03:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xpi5lBk+awQqaK6Y03m/CCSgGP4Mxrpo1j7RjBYWGpQ=;
        b=H5d/F/WnzvCJxH7hjZxiTYIVwSMzxr/h6CGssVjpTsVR+uBqPRZFdyiCibJuigAvJ+
         ++kPXyyabC5pWLRK3YT5HgFzU1BFxOvH6+Q3WVfY3GkmIjW/7uCj5W21Rxr6u/enfsug
         XEnuRiZRgaJVPmX0s9kOLNxJZlQ6JLFFoOQd03TAoQtKI19AYYfRuuUERbHVx0SBtOA8
         xevjMEbzzpcR+Zc1gALJ9LtWAmNIIEsQQEUQQQpadiRjdd9VM+0SIKjq3X289QHD90hW
         20LDUkevB6BM8nfIAv9w6u/KrqAxgcK37twlY1Io0lOeDcgxxOxWExAHm4NNK9bXVel+
         pPZA==
X-Gm-Message-State: AOAM533vX/r6QxAA7TCWiih08Fvju8xTOlRZGavtfUwpf5JofZ63SzNz
        yq2Bd4vi+BSQd0puQip1lmVB17GJg08+NflbgPo/pkDK/3Rq4nivEeR2Vg11I9SXSU2ZATF+zBn
        f3OTRv/Tn02q0W8EW15x3
X-Received: by 2002:a05:6402:26c3:: with SMTP id x3mr25471495edd.126.1618827693633;
        Mon, 19 Apr 2021 03:21:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmgqAt375JQolL1odKMUOeY+mBAXFeiW3PyhYVPJipQltfTGdvih9swcKv5opSGIf6ZUpLaQ==
X-Received: by 2002:a05:6402:26c3:: with SMTP id x3mr25471472edd.126.1618827693375;
        Mon, 19 Apr 2021 03:21:33 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c69b8.dip0.t-ipconnect.de. [91.12.105.184])
        by smtp.gmail.com with ESMTPSA id g11sm12241330edy.9.2021.04.19.03.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 03:21:32 -0700 (PDT)
Subject: Re: [PATCH] secretmem: optimize page_is_secretmem()
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
 <56d8b80c-ce2c-ed86-0eda-253768d8d463@redhat.com>
 <YH1X+0CMH/2yppHK@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0a957f9b-b4d7-869a-44ec-14e92a40d941@redhat.com>
Date:   Mon, 19 Apr 2021 12:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YH1X+0CMH/2yppHK@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 19.04.21 12:14, Mike Rapoport wrote:
> On Mon, Apr 19, 2021 at 11:40:56AM +0200, David Hildenbrand wrote:
>> On 19.04.21 11:38, David Hildenbrand wrote:
>>> On 19.04.21 11:36, Mike Rapoport wrote:
>>>> On Mon, Apr 19, 2021 at 11:15:02AM +0200, David Hildenbrand wrote:
>>>>> On 19.04.21 10:42, Mike Rapoport wrote:
>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>
>>>>>> Kernel test robot reported -4.2% regression of will-it-scale.per_thread_ops
>>>>>> due to commit "mm: introduce memfd_secret system call to create "secret"
>>>>>> memory areas".
>>>>>>
>>>>>> The perf profile of the test indicated that the regression is caused by
>>>>>> page_is_secretmem() called from gup_pte_range() (inlined by gup_pgd_range):
>>>>>>
>>>>>>      27.76  +2.5  30.23       perf-profile.children.cycles-pp.gup_pgd_range
>>>>>>       0.00  +3.2   3.19 ± 2%  perf-profile.children.cycles-pp.page_mapping
>>>>>>       0.00  +3.7   3.66 ± 2%  perf-profile.children.cycles-pp.page_is_secretmem
>>>>>>
>>>>>> Further analysis showed that the slow down happens because neither
>>>>>> page_is_secretmem() nor page_mapping() are not inline and moreover,
>>>>>> multiple page flags checks in page_mapping() involve calling
>>>>>> compound_head() several times for the same page.
>>>>>>
>>>>>> Make page_is_secretmem() inline and replace page_mapping() with page flag
>>>>>> checks that do not imply page-to-head conversion.
>>>>>>
>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>>>>> ---
>>>>>>
>>>>>> @Andrew,
>>>>>> The patch is vs v5.12-rc7-mmots-2021-04-15-16-28, I'd appreciate if it would
>>>>>> be added as a fixup to the memfd_secret series.
>>>>>>
>>>>>>      include/linux/secretmem.h | 26 +++++++++++++++++++++++++-
>>>>>>      mm/secretmem.c            | 12 +-----------
>>>>>>      2 files changed, 26 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
>>>>>> index 907a6734059c..b842b38cbeb1 100644
>>>>>> --- a/include/linux/secretmem.h
>>>>>> +++ b/include/linux/secretmem.h
>>>>>> @@ -4,8 +4,32 @@
>>>>>>      #ifdef CONFIG_SECRETMEM
>>>>>> +extern const struct address_space_operations secretmem_aops;
>>>>>> +
>>>>>> +static inline bool page_is_secretmem(struct page *page)
>>>>>> +{
>>>>>> +	struct address_space *mapping;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Using page_mapping() is quite slow because of the actual call
>>>>>> +	 * instruction and repeated compound_head(page) inside the
>>>>>> +	 * page_mapping() function.
>>>>>> +	 * We know that secretmem pages are not compound and LRU so we can
>>>>>> +	 * save a couple of cycles here.
>>>>>> +	 */
>>>>>> +	if (PageCompound(page) || !PageLRU(page))
>>>>>> +		return false;
>>>>>
>>>>> I'd assume secretmem pages are rare in basically every setup out there. So
>>>>> maybe throwing in a couple of likely()/unlikely() might make sense.
>>>>
>>>> I'd say we could do unlikely(page_is_secretmem()) at call sites. Here I can
>>>> hardly estimate which pages are going to be checked.
>>>>>> +
>>>>>> +	mapping = (struct address_space *)
>>>>>> +		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>>>>>> +
>>>>>
>>>>> Not sure if open-coding page_mapping is really a good idea here -- or even
>>>>> necessary after the fast path above is in place. Anyhow, just my 2 cents.
>>>>
>>>> Well, most if the -4.2% of the performance regression kbuild reported were
>>>> due to repeated compount_head(page) in page_mapping(). So the whole point
>>>> of this patch is to avoid calling page_mapping().
>>>
>>> I would have thought the fast path "(PageCompound(page) ||
>>> !PageLRU(page))" would already avoid calling page_mapping() in many cases.
>>
>> (and I do wonder if a generic page_mapping() optimization would make sense
>> instead)
> 
> Not sure. Replacing page_mapping() with page_file_mapping() at the
> call sites at fs/ and mm/ increased the defconfig image by nearly 2k
> and page_file_mapping() is way simpler than page_mapping()
> 
> add/remove: 1/0 grow/shrink: 35/0 up/down: 1960/0 (1960)
> Function                                     old     new   delta
> shrink_page_list                            3414    3670    +256
> __set_page_dirty_nobuffers                   242     349    +107
> check_move_unevictable_pages                 904     987     +83
> move_to_new_page                             591     671     +80
> shrink_active_list                           912     970     +58
> move_pages_to_lru                            911     965     +54
> migrate_pages                               2500    2554     +54
> shmem_swapin_page                           1145    1197     +52
> shmem_undo_range                            1669    1719     +50
> __test_set_page_writeback                    620     670     +50
> __set_page_dirty_buffers                     187     237     +50
> __pagevec_lru_add                            757     807     +50
> __munlock_pagevec                           1155    1205     +50
> __dump_page                                 1101    1151     +50
> __cancel_dirty_page                          182     232     +50
> __remove_mapping                             461     510     +49
> rmap_walk_file                               402     449     +47
> isolate_movable_page                         240     287     +47
> test_clear_page_writeback                    668     714     +46
> page_cache_pipe_buf_try_steal                171     217     +46
> page_endio                                   246     290     +44
> page_file_mapping                              -      43     +43
> __isolate_lru_page_prepare                   254     297     +43
> hugetlb_page_mapping_lock_write               39      81     +42
> iomap_set_page_dirty                         110     151     +41
> clear_page_dirty_for_io                      324     364     +40
> wait_on_page_writeback_killable              118     157     +39
> wait_on_page_writeback                       105     144     +39
> set_page_dirty                               159     198     +39
> putback_movable_page                          32      71     +39
> page_mkclean                                 172     211     +39
> mark_buffer_dirty                            176     215     +39
> invalidate_inode_page                        122     161     +39
> delete_from_page_cache                       139     178     +39
> PageMovable                                   49      86     +37
> isolate_migratepages_block                  2843    2872     +29
> Total: Before=17068648, After=17070608, chg +0.01%
>   
>> Willy can most probably give the best advise here :)
> 
> I think that's what folios are for :)

Exactly my thought. :)


-- 
Thanks,

David / dhildenb

