Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFFC677715
	for <lists+linux-api@lfdr.de>; Mon, 23 Jan 2023 10:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjAWJKy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Jan 2023 04:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjAWJKy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Jan 2023 04:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1BA1EFC6
        for <linux-api@vger.kernel.org>; Mon, 23 Jan 2023 01:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674465010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKFAim2DBhl4LLObFEbUn52dRxvU/t8Jxw2IGTWhezY=;
        b=Ial7/X4KRhblIFSPr+km5DT/H5DKsz0UT/mPezJiCbdefUd2dS0HSc6VdCwOyKYcEe4wuS
        RrnGVEo3zJg7gaeYKkEYI+RWAe+dzK/wjmbyp99zx+tRGQFDFM3ld1K+4CdmpvvPLT9OfX
        xV5Ofp3M4vTCllAJJzvrPr1eNEyPysM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-maqrYLKSMCC-W7BGrMY4hw-1; Mon, 23 Jan 2023 04:10:08 -0500
X-MC-Unique: maqrYLKSMCC-W7BGrMY4hw-1
Received: by mail-wm1-f70.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so7920979wmb.3
        for <linux-api@vger.kernel.org>; Mon, 23 Jan 2023 01:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HKFAim2DBhl4LLObFEbUn52dRxvU/t8Jxw2IGTWhezY=;
        b=NE/PhfUFYWh2vMN6s2Jj8Fs8FwVWgc4OOVuNIZgY4XhyvkQY5Bt83e4vGQv5wzQpkn
         JsVv4RyRBNNQDgGePlZ92e2RQThUemLZgdsVdzuLjQTH38Fub4gPgZ1MIhHI8UK1BDLK
         n72p1UoTULIVE6qkr7czVmqrjzmrBSqW43Xi8TAWgbLXTIHgV1SNSBoNg3Rev2o8tS6q
         UBvMeIUPuSRKbkJOtQu7lFziNw1QuTeX1MWQTCOtZUJTJV3Pv5X+XKwu+3haalc6lyRY
         6RSymkqkFB27jJuYLmlKhgS0DalfkmhbNacdcIQe6kO1MuoDZ1V/SCS152FIvu6ltJQS
         HIrA==
X-Gm-Message-State: AFqh2kqXCGc5EPqnWjVr5mA+OjDkLiKu7Vst6oe/xWCgSr+sS9GPT+CB
        0+2tx8zDzNffdOiW0+tCvCnhBGCGOzEZkzzIP9Qnq73dQW4PldO+WP/EYhHrqRmpWv6g0F4ojfJ
        J1Itl8qINuqOLsLIO0J/o
X-Received: by 2002:a05:600c:202:b0:3da:f80d:7230 with SMTP id 2-20020a05600c020200b003daf80d7230mr23062496wmi.8.1674465007340;
        Mon, 23 Jan 2023 01:10:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuEFJD+GlVkgCsrARqGaqnmZGpYCMV5PdkCH/Ay9YKbnuBq7J8R+uYOVSo7km0aft3L1OOxkg==
X-Received: by 2002:a05:600c:202:b0:3da:f80d:7230 with SMTP id 2-20020a05600c020200b003daf80d7230mr23062458wmi.8.1674465006917;
        Mon, 23 Jan 2023 01:10:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:1100:65a0:c03a:142a:f914? (p200300cbc704110065a0c03a142af914.dip0.t-ipconnect.de. [2003:cb:c704:1100:65a0:c03a:142a:f914])
        by smtp.gmail.com with ESMTPSA id p21-20020a05600c359500b003c70191f267sm11195784wmq.39.2023.01.23.01.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:10:06 -0800 (PST)
Message-ID: <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
Date:   Mon, 23 Jan 2023 10:10:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-24-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230119212317.8324-24-rick.p.edgecombe@intel.com>
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

On 19.01.23 22:23, Rick Edgecombe wrote:
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
> 
> Shadow stack memory is writable only in very specific, controlled ways.
> However, since it is writable, the kernel treats it as such. As a result
> there remain many ways for userspace to trigger the kernel to write to
> shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this a
> little less exposed, block writable GUPs for shadow stack VMAs.
> 
> Still allow FOLL_FORCE to write through shadow stack protections, as it
> does for read-only protections.

So an app can simply modify the shadow stack itself by writing to 
/proc/self/mem ?

Is that really intended? Looks like security hole to me at first sight, 
but maybe I am missing something important.

-- 
Thanks,

David / dhildenb

