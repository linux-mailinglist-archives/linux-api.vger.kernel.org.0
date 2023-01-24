Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B2679EA0
	for <lists+linux-api@lfdr.de>; Tue, 24 Jan 2023 17:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjAXQ3X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Jan 2023 11:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbjAXQ3P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Jan 2023 11:29:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7729559D3
        for <linux-api@vger.kernel.org>; Tue, 24 Jan 2023 08:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674577708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ySlJVrmItDOerr+H1CEk6K2XPX97r28SzTHxaNzIPCg=;
        b=idv7JaA+Vx8gaDNNpKTSfu5nMIdSAkoCc9qNZxmVjZgzJ8lNxXmg3BaIiOrexcYSVpF6B9
        Yy8SPbab4pfhBDAl9EXon2iHBPLCcJseIW8vHjW1X0Lz15G1iGpMmegz1xXY+zZg0dPf+1
        B51vyfTu8zU33wK3jkKGaWjKNsyp/04=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-IpoiBojvNkKu17RZaBXjOQ-1; Tue, 24 Jan 2023 11:28:27 -0500
X-MC-Unique: IpoiBojvNkKu17RZaBXjOQ-1
Received: by mail-wm1-f70.google.com with SMTP id l19-20020a05600c1d1300b003dc13fc9e42so1078075wms.3
        for <linux-api@vger.kernel.org>; Tue, 24 Jan 2023 08:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ySlJVrmItDOerr+H1CEk6K2XPX97r28SzTHxaNzIPCg=;
        b=FwJPQzOlsCcrepU6F30aAbEVK87fS/3/1Kb0CjYgZQpbiClvv8E0rDq0zZ0XMBKekj
         bx99tDPWs7AzNb3cOp7/ksFGJOpZ6Gl8awqcdA6D/gLX253a6X5474hWagSX5RwY/F9x
         a1ZcexoO3lg3vhM31DSir3KWPW0Cz1K9agTKp0TNl+9eAuxHSVwya6nPhAXVaVvBjEAK
         g/yGManlHsnwBFF6uP2onNMsJhDY0hAQzhGxLILLLOMa2bFVJEPkPE2J9RpSDGVevmS3
         PTT13AEwkR64EnuV1/JWM+uX+I24X5VbjLwQxLOI7DT0CagtbHjRZPb0w9KVdfAIHlbm
         CtZA==
X-Gm-Message-State: AFqh2kp2N7pl5LVQmkS3iF3lhEA4zEs+jxy3FI4aL2FpEh5m1fDedxHq
        IRvR78AAyq/nqolJqA/0uNTniOHqhgyNaZrGAb3rH9nWqce6FkuMyVxojoYfNQCcVg8JFtvpjah
        9AKx5kUTLEUkw9AjI1vJI
X-Received: by 2002:adf:df10:0:b0:26a:3eee:dde4 with SMTP id y16-20020adfdf10000000b0026a3eeedde4mr23657059wrl.8.1674577706142;
        Tue, 24 Jan 2023 08:28:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv9Sv+gszxHCBZj/Xm9GV3TOnkrQ2UmBhTzEl1d7Z6kmqZ7MMwUJonsHw8WPEvQXnKOrfZd7Q==
X-Received: by 2002:adf:df10:0:b0:26a:3eee:dde4 with SMTP id y16-20020adfdf10000000b0026a3eeedde4mr23657025wrl.8.1674577705812;
        Tue, 24 Jan 2023 08:28:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id bv17-20020a0560001f1100b002be2f18938csm2248680wrb.41.2023.01.24.08.28.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:28:25 -0800 (PST)
Message-ID: <c45ea1da-1531-8c33-f060-c06225a413da@redhat.com>
Date:   Tue, 24 Jan 2023 17:28:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 10/39] x86/mm: Introduce _PAGE_COW
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-11-rick.p.edgecombe@intel.com>
 <634aa365-1f51-8684-24ae-3b68aba1e12a@redhat.com>
 <bbc4f4df98ec798ae15e5daa6b5ceab41bcc66f9.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <bbc4f4df98ec798ae15e5daa6b5ceab41bcc66f9.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 23.01.23 21:56, Edgecombe, Rick P wrote:
> Trying to answer both questions to this patch on this one.
> 
> On Mon, 2023-01-23 at 10:28 +0100, David Hildenbrand wrote:
>>> +/*
>>> + * Normally COW memory can result in Dirty=1,Write=0 PTEs. But in
>>> the case
>>> + * of X86_FEATURE_USER_SHSTK, the software COW bit is used, since
>>> the
>>> + * Dirty=1,Write=0 will result in the memory being treated as
>>> shadow stack
>>> + * by the HW. So when creating COW memory, a software bit is used
>>> + * _PAGE_BIT_COW. The following functions pte_mkcow() and
>>> pte_clear_cow()
>>> + * take a PTE marked conventionally COW (Dirty=1) and transition
>>> it to the
>>> + * shadow stack compatible version of COW (Cow=1).
>>> + */
>>
>> TBH, I find that all highly confusing.
>>
>> Dirty=1,Write=0 does not indicate a COW page reliably. You could
>> have
>> both, false negatives and false positives.
>>
>> False negative: fork() on a clean anon page.
>>
>> False positives: wrpotect() of a dirty anon page.
>>
>>
>> I wonder if it really has to be that complicated: what you really
>> want
>> to achieve is to disallow "Dirty=1,Write=0" if it's not a shadow
>> stack
>> page, correct?
> 
> The other thing is to save that the PTE is/was Dirty=1 somewhere (for
> non-shadow stack memory). A slightly different but related thing. But
> losing that information would would introduce differences for
> pte_dirty() between when shadow stack was enabled or not. GUP/COW
> doesn't need this anymore but there are lots of other places it gets
> checked.
> 
> Perhaps following your GUP changes, _PAGE_COW is just now the wrong
> name for it. _PAGE_SAVED_DIRTY maybe?

It goes into the direction of my other proposal/idea, yes. Not sure if 
_PAGE_SAVED_DIRTY would currently mimic what's happening here ... 
_PAGE_COW is certainly wrong and misleading.

-- 
Thanks,

David / dhildenb

