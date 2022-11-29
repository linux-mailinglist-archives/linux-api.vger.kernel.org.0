Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D063BF32
	for <lists+linux-api@lfdr.de>; Tue, 29 Nov 2022 12:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiK2LkW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Nov 2022 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiK2LkQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Nov 2022 06:40:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD78ABC09
        for <linux-api@vger.kernel.org>; Tue, 29 Nov 2022 03:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669721959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRu/Hx0QeU09vI6dag4oeFynexJuKZWNYSe4MiEdyGs=;
        b=LvgyXO8f3BbpbjtYX3oZFa/hY+T4UU8Gg8/6yXU3Z+ROljnWq/R7ozcAu0iKYlwv2zEhVi
        UgIY6pXsdbBERoB7yfBoF6SNkgsIgyGfEis4g1OPiZkRInB+WdKeeQoDKE3tsgL6BM8EuV
        6DsgTU1EJtPPifhhu06WVY47P4KDo9A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-620-RQHeYYmTPJOOEAo3lP7eUA-1; Tue, 29 Nov 2022 06:39:10 -0500
X-MC-Unique: RQHeYYmTPJOOEAo3lP7eUA-1
Received: by mail-wm1-f71.google.com with SMTP id f1-20020a1cc901000000b003cf703a4f08so4627259wmb.2
        for <linux-api@vger.kernel.org>; Tue, 29 Nov 2022 03:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRu/Hx0QeU09vI6dag4oeFynexJuKZWNYSe4MiEdyGs=;
        b=iFrX7NdsPu+KIsG9P+H6ewMvGnWQwkLDKjLRIw85oLvhcXVmEAHKQjpEj4OMjVIvJg
         7Oaft2uQ0NU5dhMwuoikufEoudBb/uCZVS5Ro+TJos5R5BCmXZk14B4emerccg1+Jwjb
         kmTiEwM4LEhdUu/g5zw9zQfjXMQZR59Lvk8yCFnRQlTSvtnS539btHnfChj1Gf0zbkqY
         T2Dx8y2hdJXL14xP7B/9C52af5bZq0Nrx5TMzviay0Sm6nloEVohk+dDkyPMl3jpKJPo
         i1PEHzmPpAYQsCQsSxOlBx1loK0O8B8rc6IGEUNSmUmRXW2bw9EfP8/x0r+HWd0TtiWb
         m11w==
X-Gm-Message-State: ANoB5pmx82OlduX5p+flKqwNTt7qE+PcjkPFzwbm8sIHvQDQKcEeJeGs
        iJNa30/A509IdBIxSFIAnpQvX5xveCJxXTc1UVbU4PjlwsF6uYHWr9SwaBrDan5SB49T9OJoiaZ
        Z6gggFQ3nWrw0Px0XjSOI
X-Received: by 2002:a7b:ca45:0:b0:3c4:bda1:7c57 with SMTP id m5-20020a7bca45000000b003c4bda17c57mr44926197wml.6.1669721948941;
        Tue, 29 Nov 2022 03:39:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6s03pDZ7+AzRjiuWChsKfmd6tu6WfpxK1aogO4cyP+8Olozy3bxlj+8EqBduo9KzTHvAm5sQ==
X-Received: by 2002:a7b:ca45:0:b0:3c4:bda1:7c57 with SMTP id m5-20020a7bca45000000b003c4bda17c57mr44926175wml.6.1669721948661;
        Tue, 29 Nov 2022 03:39:08 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6623.dip0.t-ipconnect.de. [91.12.102.35])
        by smtp.gmail.com with ESMTPSA id bg11-20020a05600c3c8b00b003d069fc7372sm1471927wmb.1.2022.11.29.03.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 03:39:08 -0800 (PST)
Message-ID: <6d7f7775-5703-c27a-e57b-03aafb4de712@redhat.com>
Date:   Tue, 29 Nov 2022 12:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Roth <michael.roth@amd.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        tabba@google.com, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221129000632.sz6pobh6p7teouiu@amd.com>
 <20221129112139.usp6dqhbih47qpjl@box.shutemov.name>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20221129112139.usp6dqhbih47qpjl@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 29.11.22 12:21, Kirill A. Shutemov wrote:
> On Mon, Nov 28, 2022 at 06:06:32PM -0600, Michael Roth wrote:
>> On Tue, Oct 25, 2022 at 11:13:37PM +0800, Chao Peng wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>
>> <snip>
>>
>>> +static struct file *restrictedmem_file_create(struct file *memfd)
>>> +{
>>> +	struct restrictedmem_data *data;
>>> +	struct address_space *mapping;
>>> +	struct inode *inode;
>>> +	struct file *file;
>>> +
>>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>>> +	if (!data)
>>> +		return ERR_PTR(-ENOMEM);
>>> +
>>> +	data->memfd = memfd;
>>> +	mutex_init(&data->lock);
>>> +	INIT_LIST_HEAD(&data->notifiers);
>>> +
>>> +	inode = alloc_anon_inode(restrictedmem_mnt->mnt_sb);
>>> +	if (IS_ERR(inode)) {
>>> +		kfree(data);
>>> +		return ERR_CAST(inode);
>>> +	}
>>> +
>>> +	inode->i_mode |= S_IFREG;
>>> +	inode->i_op = &restrictedmem_iops;
>>> +	inode->i_mapping->private_data = data;
>>> +
>>> +	file = alloc_file_pseudo(inode, restrictedmem_mnt,
>>> +				 "restrictedmem", O_RDWR,
>>> +				 &restrictedmem_fops);
>>> +	if (IS_ERR(file)) {
>>> +		iput(inode);
>>> +		kfree(data);
>>> +		return ERR_CAST(file);
>>> +	}
>>> +
>>> +	file->f_flags |= O_LARGEFILE;
>>> +
>>> +	mapping = memfd->f_mapping;
>>> +	mapping_set_unevictable(mapping);
>>> +	mapping_set_gfp_mask(mapping,
>>> +			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
>>
>> Is this supposed to prevent migration of pages being used for
>> restrictedmem/shmem backend?
> 
> Yes, my bad. I expected it to prevent migration, but it is not true.

Maybe add a comment that these pages are not movable and we don't want 
to place them into movable pageblocks (including CMA and ZONE_MOVABLE). 
That's the primary purpose of the GFP mask here.

-- 
Thanks,

David / dhildenb

