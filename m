Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693A869C9A7
	for <lists+linux-api@lfdr.de>; Mon, 20 Feb 2023 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBTLUg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Feb 2023 06:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjBTLUe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 20 Feb 2023 06:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D30593F8
        for <linux-api@vger.kernel.org>; Mon, 20 Feb 2023 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676891987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Y0d/vI0Qp2mhR9IQ+0FEQIh8Qkf0r9E2FFAh9KN8Lg=;
        b=SnD3OxKHIAk39zwowbiV9/1S027SKew+gek9VljiPPVLtnSnMXyozFMNg77hehg9IHDDqw
        f97+8wKgJqW5rCs3WCwq+I65MYTfXQhr+St+YTB+Ue4oD5yc4sgVFY2zbU6tgwkqvMKVeI
        rKebOasRafFU3IR4JIhcGhP08HfATpw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-245-atM7YsQ1MUyLlh4cb7JZKg-1; Mon, 20 Feb 2023 06:19:46 -0500
X-MC-Unique: atM7YsQ1MUyLlh4cb7JZKg-1
Received: by mail-wm1-f72.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so417282wml.2
        for <linux-api@vger.kernel.org>; Mon, 20 Feb 2023 03:19:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y0d/vI0Qp2mhR9IQ+0FEQIh8Qkf0r9E2FFAh9KN8Lg=;
        b=O0pOEy1KxUvwZ1D/SznQk4KHvkxtoYziaXYj4mROZQSUxAcXat/A/4lX7RjGEbRhUV
         GBmmrVg8MZ1caHqG2ObPKDwZUqCb32Y/MF7z9obCr7OA7NHaQ2EpJiy4SmpoGH9376sn
         mufhqxAc7UdKa/2MIbaesta8BiH/96R2yzNPkAicB/1sr5OzDbemIHeUiZLIjcYiw/f0
         v7BmOqljRODYb15qwvpO/BKel6JV9hqrVvHrxHLW83yk0AcY6X5puREdxJyS0GP3lLbs
         14RnDkJxKAowV/AZ8UhmUlsBo9j5uS6qRjqw/0/ismPoHDf2N9gLgzuKPHmGjsnAcq2l
         CiKA==
X-Gm-Message-State: AO0yUKWTSV6yhE4xKYOZFLjMpwnIhbL7cFIZFHPMlN/7q/lbdBykvZ1H
        qlTKTcvmYftH1S/CB4SbBGx5tBQxHR5raZa05DhLDF5YW2zKyFeLqX4pGCIOkuOclOZdVYHwBDk
        qLMYaJQJDva8o857MJ1/z
X-Received: by 2002:a05:600c:13c3:b0:3e0:39:ec9d with SMTP id e3-20020a05600c13c300b003e00039ec9dmr667659wmg.23.1676891985217;
        Mon, 20 Feb 2023 03:19:45 -0800 (PST)
X-Google-Smtp-Source: AK7set8gwoTHdOCWEVucXLZ1cWaezJA5lkFoQjhOhQbs8nj/fdafmDMVp3INR4+sjGhG9kWSgEqR2w==
X-Received: by 2002:a05:600c:13c3:b0:3e0:39:ec9d with SMTP id e3-20020a05600c13c300b003e00039ec9dmr667628wmg.23.1676891984832;
        Mon, 20 Feb 2023 03:19:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:8300:e519:4218:a8b5:5bec? (p200300cbc7058300e5194218a8b55bec.dip0.t-ipconnect.de. [2003:cb:c705:8300:e519:4218:a8b5:5bec])
        by smtp.gmail.com with ESMTPSA id z5-20020a5d6405000000b002c5534db60bsm713917wru.71.2023.02.20.03.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 03:19:44 -0800 (PST)
Message-ID: <77f5e061-080b-f9f0-25f7-bbbe721b5e2e@redhat.com>
Date:   Mon, 20 Feb 2023 12:19:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 11/41] mm: Introduce pte_mkwrite_kernel()
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
        debug@rivosinc.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-12-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230218211433.26859-12-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 18.02.23 22:14, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> One of these changes is to allow for pte_mkwrite() to create different
> types of writable memory (the existing conventionally writable type and
> also the new shadow stack type). Future patches will convert pte_mkwrite()
> to take a VMA in order to facilitate this, however there are places in the
> kernel where pte_mkwrite() is called outside of the context of a VMA.
> These are for kernel memory. So create a new variant called
> pte_mkwrite_kernel() and switch the kernel users over to it. Have
> pte_mkwrite() and pte_mkwrite_kernel() be the same for now. Future patches
> will introduce changes to make pte_mkwrite() take a VMA.
> 
> Only do this for architectures that need it because they call pte_mkwrite()
> in arch code without an associated VMA. Since it will only currently be
> used in arch code, so do not include it in arch_pgtable_helpers.rst.
> 
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>

Acked-by: David Hildenbrand <david@redhat.com>

Do we also have to care about pmd_mkwrite() ?

-- 
Thanks,

David / dhildenb

