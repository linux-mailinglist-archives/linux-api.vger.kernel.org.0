Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4105F3593
	for <lists+linux-api@lfdr.de>; Mon,  3 Oct 2022 20:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJCSY4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiJCSYn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 14:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D357C7F
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664821476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P57fOCRr8L8IWMz1idkV10HcfpUZXl9CrILykX0M7Do=;
        b=erUfC1BwJmdcS1u8aah8+SGooepxk/UTZkfAyq4Ba3kPwt6GRbkIn2HAnGCBN7lasqKIs/
        WNp4BauZ8OLxUq0crVQuUeF21R5W8MDCnOwJEVdg+F8Le8yxM/ZEhvY6xTnIErUOsDjp8R
        2SkwUS8v2DYyCogti63wJO8eMK2zCfI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-548-udQDeWRpMeOoGqHjrw7B4w-1; Mon, 03 Oct 2022 14:24:34 -0400
X-MC-Unique: udQDeWRpMeOoGqHjrw7B4w-1
Received: by mail-qk1-f197.google.com with SMTP id h7-20020a05620a400700b006cebec84734so9841372qko.23
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 11:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=P57fOCRr8L8IWMz1idkV10HcfpUZXl9CrILykX0M7Do=;
        b=dMDZAI1bamAJNDin8GbKCZEVoIQKCpnBNmvH2MhYCZwl4CIh4pD9q7XIca4XcIISdX
         FY9JFIvFaYZJYxq9KEcwXVTBIzIeQ5+XVnJgy/NF+feaPW4Y+XWFHnorVbE1DksnHLiT
         /QSV0Rl8MG6qg/J5Y7AgPvMNAdcIY9AOYyPjrei0/+/6/lhOckpy8ikh1Y/jtF1NlipW
         dhb6SxqwGz1SNKq//Lb9JshFyRWu330LfItw+jHHHUMlIGLthkHBqbneaib7dAwExD5X
         Q7LAD/RRoFejGten0+G0b4a1JjuGykSM8ea3VIcfkD1LAI4NI1fiWnUhjVjtfsfld1is
         ychQ==
X-Gm-Message-State: ACrzQf3tr5Yv//cIXiOdOHUlDhOIBO2WC18KtHh2w6kf2aGXTbv40xFs
        iiwSjT+jtMjjc+dvIctUbkTp5VExho5+tIfOxtgEGg3T7RwbZStmbVUClWrOo6gGkscENI0owCd
        RyJGxv2hsUqAV1qS/oN8F
X-Received: by 2002:a05:6214:5609:b0:4ac:aa5e:5425 with SMTP id mg9-20020a056214560900b004acaa5e5425mr17021794qvb.81.1664821474554;
        Mon, 03 Oct 2022 11:24:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Af9yw7ubrxehHYf5SG+wnB1n3fA8M/KRQPPpTdYDWvwqKkVBNCpZxbdY+JnLWNQEAjxNlsw==
X-Received: by 2002:a05:6214:5609:b0:4ac:aa5e:5425 with SMTP id mg9-20020a056214560900b004acaa5e5425mr17021775qvb.81.1664821474349;
        Mon, 03 Oct 2022 11:24:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8580c000000b0035d4f68232esm10631028qtg.3.2022.10.03.11.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:24:33 -0700 (PDT)
Date:   Mon, 3 Oct 2022 14:24:31 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 13/39] mm: Move VM_UFFD_MINOR_BIT from 37 to 38
Message-ID: <Yzso39wMlI8Tyn9c@x1n>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-14-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-14-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:10PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> To introduce VM_SHADOW_STACK as VM_HIGH_ARCH_BIT (37), and make all
> VM_HIGH_ARCH_BITs stay together, move VM_UFFD_MINOR_BIT from 37 to 38.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

