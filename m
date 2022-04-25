Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8112950E2B0
	for <lists+linux-api@lfdr.de>; Mon, 25 Apr 2022 16:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbiDYOKQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Apr 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242367AbiDYOKP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Apr 2022 10:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB1542C649
        for <linux-api@vger.kernel.org>; Mon, 25 Apr 2022 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650895629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVM3muYPJyfaOhJtwnQezE4YHj5J/gwIIpTn05v9eQ0=;
        b=cv/UsoNPfNqX91dFXSy4cjeJw7K7YFlyVGrYU0/O/x384jacxAkS9y0ItG2SGGBY4drBFr
        SigH9vJWXULnBXUIKBnLE68BTqclw96P5Drp234vT5lEWwdvSipGp3RJ+Tk1r9QuQRHId9
        ZfC7q1mHuIC0Mwd3n9pO+xyEf6DxK5s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-cZe5b0nxOy6yzwabxWu6Nw-1; Mon, 25 Apr 2022 10:07:08 -0400
X-MC-Unique: cZe5b0nxOy6yzwabxWu6Nw-1
Received: by mail-wr1-f71.google.com with SMTP id e13-20020adf9bcd000000b0020adc114131so835860wrc.8
        for <linux-api@vger.kernel.org>; Mon, 25 Apr 2022 07:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=SVM3muYPJyfaOhJtwnQezE4YHj5J/gwIIpTn05v9eQ0=;
        b=GgnTreoan6PbimYeiHuYOEveSDfIzg1QRRAH1TE6AuTuGtrfGH9pOfoezorI/UM73x
         wLGl7VkBgqy4Rq55yVjBtIjwn1JdxTg7x2jrUHnEw3zKQCJLdqJR70S3WMUzjfGzevuJ
         pmzwS+Hy5L2pCBQigeRWbnxXzPfmMxutM5NM6nEF4V1TUCF/eTKKLumuMpgFRe3FUBls
         kSFpHh2PYq7waFeR5EHmlKp7dTRsPELEMhu5lKXYNv/IgjoWxEWuPh5J1JaKpwjjrdIW
         FeMOY6VCVWnlbi81CpVXi/QK/jQ+pGKoyAa+NX/qhvCE838P9sSUdQW7mgLqWxDpMMex
         NUtw==
X-Gm-Message-State: AOAM530KyhGfNh8UTiogNbyMDHQLEYK5WfgdFb0v38bJnloR129lQQdt
        7WjoEUn3EQViGcmhUplTZ6/UeCpn5MZpWqoA+vdJxQW0egRc0XfESdR8/EnljEI3LPxc6BaHeih
        3WdD6eH6GPRVU1tA3/t/T
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id m1-20020a5d6241000000b00207ac0e3549mr14371872wrv.343.1650895627105;
        Mon, 25 Apr 2022 07:07:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgoNX9maOD+O7h8van/rWNjXvLl8lKMAp755C32BIUi/e19PViAQ+6Xwf7k6WLPh49+cUdlA==
X-Received: by 2002:a5d:6241:0:b0:207:ac0e:3549 with SMTP id m1-20020a5d6241000000b00207ac0e3549mr14371841wrv.343.1650895626813;
        Mon, 25 Apr 2022 07:07:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b0039291537cfesm11669789wmq.21.2022.04.25.07.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:07:06 -0700 (PDT)
Message-ID: <d2aa867b-3355-8223-2721-f3e825632255@redhat.com>
Date:   Mon, 25 Apr 2022 16:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Sean Christopherson <seanjc@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <02e18c90-196e-409e-b2ac-822aceea8891@www.fastmail.com>
 <YlB3Z8fqJ+67a2Ck@google.com>
 <7ab689e7-e04d-5693-f899-d2d785b09892@redhat.com>
 <20220412143636.GG64706@ziepe.ca>
 <1686fd2d-d9c3-ec12-32df-8c4c5ae26b08@redhat.com>
 <20220413175208.GI64706@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
In-Reply-To: <20220413175208.GI64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.04.22 19:52, Jason Gunthorpe wrote:
> On Wed, Apr 13, 2022 at 06:24:56PM +0200, David Hildenbrand wrote:
>> On 12.04.22 16:36, Jason Gunthorpe wrote:
>>> On Fri, Apr 08, 2022 at 08:54:02PM +0200, David Hildenbrand wrote:
>>>
>>>> RLIMIT_MEMLOCK was the obvious candidate, but as we discovered int he
>>>> past already with secretmem, it's not 100% that good of a fit (unmovable
>>>> is worth than mlocked). But it gets the job done for now at least.
>>>
>>> No, it doesn't. There are too many different interpretations how
>>> MELOCK is supposed to work
>>>
>>> eg VFIO accounts per-process so hostile users can just fork to go past
>>> it.
>>>
>>> RDMA is per-process but uses a different counter, so you can double up
>>>
>>> iouring is per-user and users a 3rd counter, so it can triple up on
>>> the above two
>>
>> Thanks for that summary, very helpful.
> 
> I kicked off a big discussion when I suggested to change vfio to use
> the same as io_uring
> 
> We may still end up trying it, but the major concern is that libvirt
> sets the RLIMIT_MEMLOCK and if we touch anything here - including
> fixing RDMA, or anything really, it becomes a uAPI break for libvirt..
> 

Okay, so we have to introduce a second mechanism, don't use
RLIMIT_MEMLOCK for new unmovable memory, and then eventually phase out
RLIMIT_MEMLOCK usage for existing unmovable memory consumers (which, as
you say, will be difficult).

>>>> So I'm open for alternative to limit the amount of unmovable memory we
>>>> might allocate for user space, and then we could convert seretmem as well.
>>>
>>> I think it has to be cgroup based considering where we are now :\
>>
>> Most probably. I think the important lessons we learned are that
>>
>> * mlocked != unmovable.
>> * RLIMIT_MEMLOCK should most probably never have been abused for
>>   unmovable memory (especially, long-term pinning)
> 
> The trouble is I'm not sure how anything can correctly/meaningfully
> set a limit.
> 
> Consider qemu where we might have 3 different things all pinning the
> same page (rdma, iouring, vfio) - should the cgroup give 3x the limit?
> What use is that really?

I think your tackling a related problem, that we double-account
unmovable/mlocked memory due to lack of ways to track that a page is
already pinned by the same user/cgroup/whatsoever. Not easy to solve.

The problem also becomes interesting if iouring with fixed buffers
doesn't work on guest RAM, but on some other QEMU buffers.

> 
> IMHO there are only two meaningful scenarios - either you are unpriv
> and limited to a very small number for your user/cgroup - or you are
> priv and you can do whatever you want.
> 
> The idea we can fine tune this to exactly the right amount for a
> workload does not seem realistic and ends up exporting internal kernel
> decisions into a uAPI..


IMHO, there are three use cases:

* App that conditionally uses selected mechanism that end up requiring
  unmovable, long-term allocations. Secretmem, iouring, rdma. We want
  some sane, small default. Apps have a backup path in case any such
  mechanism fails because we're out of allowed unmovable resources.
* App that relies on selected mechanism that end up requiring unmovable,
  long-term allocations. E.g., vfio with known memory consumption, such
  as the VM size. It's fairly easy to come up with the right value.
* App that relies on multiple mechanism that end up requiring unmovable,
  long-term allocations. QEMU with rdma, iouring, vfio, ... I agree that
  coming up with something good is problematic.

Then, there are privileged/unprivileged apps. There might be admins that
just don't care. There might be admins that even want to set some limit
instead of configuring "unlimited" for QEMU.

Long story short, it should be an admin choice what to configure,
especially:
* What the default is for random apps
* What the maximum is for selected apps
* Which apps don't have a maximum

-- 
Thanks,

David / dhildenb

