Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515E56C100D
	for <lists+linux-api@lfdr.de>; Mon, 20 Mar 2023 12:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCTLBD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Mar 2023 07:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCTLAp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Mar 2023 07:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D302A6E1
        for <linux-api@vger.kernel.org>; Mon, 20 Mar 2023 03:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679309732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZyCMxGpcR0S73UtYylnn7dYqSGpGJubntx2gaRzXj0=;
        b=hN3mNu4yEf2xkfj4or3ogFG6HVzJReytpvfqTslXSta/D7lHv2cAn5XgyPErzy/G9FPBCw
        0I3LCYS5Rm5SMszITLcOY6u+OaYJyLSgLJkadAMlBdUfFLOswbz5uKgHR2/4Pdm2uG8++z
        NP11k1jSZJIsoS/DqXuW7CZ7Z5TJqzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-shWCWMBnPWqI-Jvd1zVxcQ-1; Mon, 20 Mar 2023 06:55:31 -0400
X-MC-Unique: shWCWMBnPWqI-Jvd1zVxcQ-1
Received: by mail-wm1-f71.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so403658wmb.2
        for <linux-api@vger.kernel.org>; Mon, 20 Mar 2023 03:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679309730;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZyCMxGpcR0S73UtYylnn7dYqSGpGJubntx2gaRzXj0=;
        b=wwHxaH4hWwWLdRYR76vSVFcpHvecyYZn5KucHsDOIF6hjnqRQLYj+EwzfkFjJipK27
         /eRjNLPP4rsgYwcdM/7oBZup4aFgQBCACH6OeeBTYG4JbNOx6D50glyThQ75d2yGblgt
         OdQFNwP4s5HYgVmnW/wnSPlOl9mN9v9Dmpji7LnM7dGPcSwlr61vqn99zKytv/kl0zZC
         UQPAPKKI2/ak+jU74YhzUSLsblXSDk/4jiAYz3u6lbn8BgmNjPJwPcfnLcSnAKu0pPpd
         8JVEDru5/pXE2cbQobY66eVq0EWbpcA/eIfiKX5jHaSi2dl2us9A8uBigVv3/Tftebbl
         SPdA==
X-Gm-Message-State: AO0yUKVTA1/i88OWZYfmdApAf+Zw69zdV065lDC2dUSYWaRFt29Gu38x
        PxGorxm+y3gNXRheoLpfFXd1Y0bh5giD4LgdMTS4M6qOGZUcBvX962FHY6zQmtmXuoqOxT4+Nb1
        m+8SPX6Tge571aLUowNUg
X-Received: by 2002:a5d:4d10:0:b0:2d1:7ade:aad with SMTP id z16-20020a5d4d10000000b002d17ade0aadmr11360085wrt.31.1679309730068;
        Mon, 20 Mar 2023 03:55:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set93CzdZEb3DYvK+1MT2JxGK+OwqrYFwweBrtleHk/IXtONusAqG4ZSXQvD5FA52RfO37i3ukA==
X-Received: by 2002:a5d:4d10:0:b0:2d1:7ade:aad with SMTP id z16-20020a5d4d10000000b002d17ade0aadmr11360062wrt.31.1679309729712;
        Mon, 20 Mar 2023 03:55:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:4100:a064:1ded:25ec:cf2f? (p200300cbc7024100a0641ded25eccf2f.dip0.t-ipconnect.de. [2003:cb:c702:4100:a064:1ded:25ec:cf2f])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d4b07000000b002c56af32e8csm8555317wrq.35.2023.03.20.03.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:55:29 -0700 (PDT)
Message-ID: <da5c721e-3492-5028-2439-64875efc5a6d@redhat.com>
Date:   Mon, 20 Mar 2023 11:55:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v8 17/40] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
 <20230319001535.23210-18-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230319001535.23210-18-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 19.03.23 01:15, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Future patches will introduce a new VM flag VM_SHADOW_STACK that will be
> VM_HIGH_ARCH_BIT_5. VM_HIGH_ARCH_BIT_1 through VM_HIGH_ARCH_BIT_4 are
> bits 32-36, and bit 37 is the unrelated VM_UFFD_MINOR_BIT. For the sake
> of order, make all VM_HIGH_ARCH_BITs stay together by moving
> VM_UFFD_MINOR_BIT from 37 to 38. This will allow VM_SHADOW_STACK to be
> introduced as 37.
> 
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> ---


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

