Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4372F849
	for <lists+linux-api@lfdr.de>; Wed, 14 Jun 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243729AbjFNIuq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jun 2023 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243533AbjFNIui (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jun 2023 04:50:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC91FE3
        for <linux-api@vger.kernel.org>; Wed, 14 Jun 2023 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686732589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Rsvso4l9koDuzHwHgyAvlpKhmbENWcT5E1vZaroQkI=;
        b=cPxBqrDHOVWQxXCYy1XNX3eBbzyTeD41HTkDl+qo9J3o28wZnzUwDy1ldW/0oiO5vDRqyz
        g1hWW8G0Ypd1UwOOeohmGxXBStmV/AZ5Gl1VQ0y0SX+HnQkmgrm0T0idq0Y3ME9zbsT66g
        Cx4avMgVCqHX8m3kJQmNNIgIYBqSNY4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-PVo9ImQgM5KuJBklBxtkzw-1; Wed, 14 Jun 2023 04:49:48 -0400
X-MC-Unique: PVo9ImQgM5KuJBklBxtkzw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f62d8e527bso5068896e87.1
        for <linux-api@vger.kernel.org>; Wed, 14 Jun 2023 01:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686732586; x=1689324586;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Rsvso4l9koDuzHwHgyAvlpKhmbENWcT5E1vZaroQkI=;
        b=jmFA1pgaOPRuTB08YqE5f/5UNremo4EdC3gWcjUp3gXjIZLNhLrqCezH17U9UCDwGv
         Dc25Y6LzQ1Qk1SKi4H7RGzq1E99KK68R9vXoRBUpoF1oD8HoZm040L98jghJ9OxhAbnz
         aK4UfGfXtTgBh9ie1bIUlGObLECsCRDbTzJqqZcdNWS1Qz/piONCx8edIiwgXQZD1g0c
         THKmC8DEZdn26HQTNIoU6vCzvlp9kY7vLncq9Z7cXWyeRtSgmzE/KBSMqU42s1+l8dVu
         /++tX2iYvtYWnSzQossPSixbFoXgp4VKgUCeyiY0v6ddTdfBHA/vnGhUINE4tC8u3STy
         2cjQ==
X-Gm-Message-State: AC+VfDx7s/94wAu/CvMoxUAAhP64xgLLcLGXngwcOSl8Djlk0OZngzMt
        kfumOgEqv1JxuSjVnzG3uVAooENt4sM5C/ausiEhytbcXkKVITP87oI5XRpqn8r/eUP6RJ3KOCS
        9lmnCmheLvxi7tNeoWT35
X-Received: by 2002:a19:4312:0:b0:4f4:b28f:6b9c with SMTP id q18-20020a194312000000b004f4b28f6b9cmr6502161lfa.29.1686732586584;
        Wed, 14 Jun 2023 01:49:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4r4XW6g5a7gzGlx/YsBE42/ZrV5TBz6ylOyFXzEPjbNlpThttCQBG7uP9TbF88yZOz/A7BQg==
X-Received: by 2002:a19:4312:0:b0:4f4:b28f:6b9c with SMTP id q18-20020a194312000000b004f4b28f6b9cmr6502133lfa.29.1686732586113;
        Wed, 14 Jun 2023 01:49:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b200:7d03:23db:ad5:2d21? (p200300cbc704b2007d0323db0ad52d21.dip0.t-ipconnect.de. [2003:cb:c704:b200:7d03:23db:ad5:2d21])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003f60e143d38sm16709642wmk.11.2023.06.14.01.49.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 01:49:45 -0700 (PDT)
Message-ID: <20afbea8-fef7-55de-20af-8497273bf11f@redhat.com>
Date:   Wed, 14 Jun 2023 10:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 04/42] mm: Re-introduce vm_flags to do_mmap()
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
        debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Pengfei Xu <pengfei.xu@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-5-rick.p.edgecombe@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230613001108.3040476-5-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 13.06.23 02:10, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
> 
>      commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
> 
> There is a new user now.  Shadow stack allocation passes VM_SHADOW_STACK to
> do_mmap().  Thus, re-introduce vm_flags to do_mmap().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

