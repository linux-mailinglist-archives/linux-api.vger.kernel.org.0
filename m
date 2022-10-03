Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB215F3581
	for <lists+linux-api@lfdr.de>; Mon,  3 Oct 2022 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJCSW7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 14:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJCSW5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 14:22:57 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C0227DE9
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 11:22:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so10891193pfh.6
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DpamCQg4r6DJ9TEvfJUx5RfmiJZUBbQ1vJaFAYMtbtE=;
        b=bKitYN0ycfUP50dLE5yBs9aVB69jVdFmdIDNWZSSiBtQ2XyHoGDEf5LYIZa1I/OwhF
         1fu8VI8iw+wr2lMK3sdEZx7+Gt162AqNHmK5PBQuBSw+CUdTXUH9di6lhhM8m5g4r6ni
         Cf/ac/CiSEYQJtBC8L2idRWiSX6thxVOEH5Tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DpamCQg4r6DJ9TEvfJUx5RfmiJZUBbQ1vJaFAYMtbtE=;
        b=KYk2a6fXbIz4YNNUD9dzN4S6R6sxbTd2/Zdtz/7xVFy44RLUKb8T8U2zfeTkxmQ/qT
         Ju/yJ+pg+GfnCHcVcJDhA9DAyOEZ2KVS/FW1cn/OGTVT3h17iyhMeMyGXQ1zNrxxr/4x
         wfw9MqQ5W8MD4Wp9rAgnNzeJUg1k00b727VVYUH8325ecrpgkVKiT2zwXr8hRQA1VRck
         nmA2TE4co3LTkikYSsdD+DTCCtcqaopirHd6W5BmrsrpC55ineF/CZaXDoG7ZIp9lH1U
         RD6TEExpHst6h8Fw/nOSgHgXBZgX9uobUJ8o63zLm64/MoMDx1n96PqYcXtIvzq4TaEq
         KOoQ==
X-Gm-Message-State: ACrzQf2GAoQDfj5/qJ1CsYQo2lvTtly6h655O29y4TstwHnQWgl0cH1a
        JTzE+LAPJ/XJTlkcS8QW30eBpg==
X-Google-Smtp-Source: AMsMyM7dTP6DXvLNUcsKmzIg6k7/Qu8IfrWs3YPR/Fd2tS7bSA3q/wwAl34jCHU6wmwWuCw+ROg+Fw==
X-Received: by 2002:a05:6a00:2185:b0:520:7276:6570 with SMTP id h5-20020a056a00218500b0052072766570mr23927389pfi.84.1664821374239;
        Mon, 03 Oct 2022 11:22:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902f54400b0017ee7f331ffsm3242061plf.291.2022.10.03.11.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:22:53 -0700 (PDT)
Date:   Mon, 3 Oct 2022 11:22:52 -0700
From:   Kees Cook <keescook@chromium.org>
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
Subject: Re: [PATCH v2 16/39] x86/mm: Update maybe_mkwrite() for shadow stack
Message-ID: <202210031122.A27CE24D39@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-17-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-17-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:13PM -0700, Rick Edgecombe wrote:
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> When serving a page fault, maybe_mkwrite() makes a PTE writable if there is
> a write access to it, and its vma has VM_WRITE. Shadow stack accesses to
> shadow stack vma's are also treated as write accesses by the fault handler.
> This is because setting shadow stack memory makes it writable via some
> instructions, so COW has to happen even for shadow stack reads.
> 
> So maybe_mkwrite() should continue to set VM_WRITE vma's as normally
> writable, but also set VM_WRITE|VM_SHADOW_STACK vma's as shadow stack.
> 
> Do this by adding a pte_mkwrite_shstk() and a cross-arch stub. Check for
> VM_SHADOW_STACK in maybe_mkwrite() and call pte_mkwrite_shstk()
> accordingly.
> 
> Apply the same changes to maybe_pmd_mkwrite().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
