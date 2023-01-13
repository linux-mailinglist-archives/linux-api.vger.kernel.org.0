Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072CE66A6DC
	for <lists+linux-api@lfdr.de>; Sat, 14 Jan 2023 00:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjAMXQn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Jan 2023 18:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjAMXQf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Jan 2023 18:16:35 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159208A213
        for <linux-api@vger.kernel.org>; Fri, 13 Jan 2023 15:16:33 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso25886048pjf.1
        for <linux-api@vger.kernel.org>; Fri, 13 Jan 2023 15:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWow72s2ZHPfyutUF3LRtthWGyQvB6TRG4mGrzQPS+Y=;
        b=E/wbWTkGCcwoXs6O8irB3PXyBwoRW4uEkWDuoU13XByhJzTvIiq4OfNzvKMYIxRBd8
         N5dRvUnnXxuGkG1NqPLQ9NcLguZ/hQembSMTLovSWxd/eNEA47F4pw2VMvBTgCh83EhX
         bKzfh13CLYQPbU31yNkCeE7nVtvWxeSrEzOQXXJn3Ra1e263z8sIZrm9ZwC48e/SEbDs
         3aEzaEkItlDgZ56c4opqTh+L6mEGkhcrmVBFbTe1hFC/UfsbAkExmK+Dw6Q5zVDBQe5Z
         vQO9KR1KEhsZRidc5t6FXrTt3AyPbDNocZckiEhBhgfdJEwaG1EcApBlL60GoZCzvH2P
         EHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWow72s2ZHPfyutUF3LRtthWGyQvB6TRG4mGrzQPS+Y=;
        b=M46qAiIQuAnBZ0wEQj/I2KG8zKYPaE2mofEhLl8713ANl9qm9cUcDbFDtlpsg5tF6F
         juaodydecjFzdgJvuTf1PHuzR5ZE56nQI8aEQ/aTWzhTeyv+DLT/bnHYsW/VMs5XQsXg
         4YcDgJx7p7L6UL1KopBHCGDyUl6423Gyu0AeWtuHkHmfdI3unwTzjkusVdt8V2F3uGJx
         Qn/7hoWEW/0mOC2FVgghwVHn4iyOyQNVJbnze5bVRl3eA0oXxjagkAE0yi2uoeUyh7ef
         q27u/hPK3sVnIrqKUjSl8zL6da3WNYPNTZrI0Y5tPq34jmI45Vqi11KCsgsERysdhTyf
         co1w==
X-Gm-Message-State: AFqh2krp14T9Y/gGOjVudwsaTqhTBzMj40Wcb15WKbybNp/Rsj2eg3Po
        vpnb2xdbf3zxUrewu8pgeD3Tug==
X-Google-Smtp-Source: AMrXdXsw5eR35BhM0SQtUTPreOToQACUohVatv5rPzW7S1K5nzUfkKmIR6WQPAlOT0G0H1aK7d4JHA==
X-Received: by 2002:a17:902:c409:b0:194:6d3c:38a5 with SMTP id k9-20020a170902c40900b001946d3c38a5mr502925plk.1.1673651792454;
        Fri, 13 Jan 2023 15:16:32 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id q3-20020a17090311c300b0018c990ce7fesm14720017plh.239.2023.01.13.15.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:16:31 -0800 (PST)
Date:   Fri, 13 Jan 2023 23:16:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 7/9] KVM: Update lpage info when private/shared
 memory are mixed
Message-ID: <Y8HmS2iE4u0Gfkrn@google.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202061347.1070246-8-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 02, 2022, Chao Peng wrote:
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9a07380f8d3c..5aefcff614d2 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -12362,6 +12362,8 @@ static int kvm_alloc_memslot_metadata(struct kvm *kvm,
>  		if ((slot->base_gfn + npages) & (KVM_PAGES_PER_HPAGE(level) - 1))
>  			linfo[lpages - 1].disallow_lpage = 1;
>  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
> +		if (kvm_slot_can_be_private(slot))
> +			ugfn |= slot->restricted_offset >> PAGE_SHIFT;
>  		/*
>  		 * If the gfn and userspace address are not aligned wrt each
>  		 * other, disable large page support for this slot.

Forgot to talk about the bug.  This code needs to handle the scenario where a
memslot is created with existing, non-uniform attributes.  It might be a bit ugly
(I didn't even try to write the code), but it's definitely possible, and since
memslot updates are already slow I think it's best to handle things here.

In the meantime, I added this so we don't forget to fix it before merging.

#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
	pr_crit_once("FIXME: Walk the memory attributes of the slot and set the mixed status appropriately");
#endif

