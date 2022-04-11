Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B84FC0D1
	for <lists+linux-api@lfdr.de>; Mon, 11 Apr 2022 17:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347971AbiDKPfT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Apr 2022 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347852AbiDKPfS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Apr 2022 11:35:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FC4369FB
        for <linux-api@vger.kernel.org>; Mon, 11 Apr 2022 08:33:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 17so20620827lji.1
        for <linux-api@vger.kernel.org>; Mon, 11 Apr 2022 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xnPakWPy2yT3pIDHfh65ar6g/dls1kfh8Fm485ETQ5M=;
        b=dQKM0d07whgvlC9oDhJtSUhDkTW4MoFSVg0vfgfBTGbnyj/vLpwIRlpTJbwhAy5wXy
         t4NvGLtrVnALpqzfCg7AJJXugL5G+gxtpmDu4P3kfUwP/PxlbMFsvAkSX6LdhPrmqMXT
         qiLuU+fH5rX1P4bRYOwwYVvuKX3ABpSSlgtg6Az3/bkGGCuw7OQsN/ELNNrrh8dksm+L
         jdUaWuAeAK2VUjv+c+38AFbQNMQ+BBRMEFHjUicyzn/UUqkyKZ+8hd7a357wBJLh/+Ai
         HUBjhhdQSdLifDKyLGXJgEw/B/MdcmTILkWCG50hI08mI+XNVGIswEXj19aZoHfNzVBJ
         crnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnPakWPy2yT3pIDHfh65ar6g/dls1kfh8Fm485ETQ5M=;
        b=kXMckcQ42dhZgc1hHAmUKVri55fuICja38TZY1w1kWO3xo0xy3WYMYJlCAHH5pcanm
         aRUckIvJfetnW/1sRmniOz/v5Adk/9cdI/ugmYxCymNoiEmFUgrmvewmV22xjfq4vPDh
         5UhMLI4kbLrfXaNS+RTxgY40hemOyvfOr0rmJwXnW4RotCi1ssWWrkCo4g0645GmGguS
         AIxrFMRR9vxMzKDjpN0W4xUZPIjYLtbr8D3sHcaKz8a7xtAFvZ6XMTll1AWIGzulKfV4
         QCPTNFs/mPh+6HEwMytLH3onPkd6+q8VZBabv3AMCYuZcAsENFRxHZlVZZoudZt7kDt2
         ryIg==
X-Gm-Message-State: AOAM5309DzVGxHDyp+oe3M83ERxGHRasrK8/xzJN2Ai8vQSOyjfO/H4u
        HvsVF1qVB025pNlB+Q2UQWVAHQ==
X-Google-Smtp-Source: ABdhPJznGRs4U58z6UmE7zKZGIORoorFbfftosrGPlCNHfF3AfxicsXpipbZkrEfC0QnRLsaSTmPLw==
X-Received: by 2002:a2e:3a02:0:b0:24b:6120:1be4 with SMTP id h2-20020a2e3a02000000b0024b61201be4mr4554362lja.451.1649691181857;
        Mon, 11 Apr 2022 08:33:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c25-20020a2e6819000000b00247de61d3fdsm3162062lja.113.2022.04.11.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:33:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E5DD4103CE0; Mon, 11 Apr 2022 18:34:33 +0300 (+03)
Date:   Mon, 11 Apr 2022 18:34:33 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
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
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: Re: [PATCH v5 04/13] mm/shmem: Restrict MFD_INACCESSIBLE memory
 against RLIMIT_MEMLOCK
Message-ID: <20220411153433.6sqqqd6vzhyfjee6@box.shutemov.name>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <20220310140911.50924-5-chao.p.peng@linux.intel.com>
 <Yk8L0CwKpTrv3Rg3@google.com>
 <20220408130254.GB57095@chaop.bj.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408130254.GB57095@chaop.bj.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Apr 08, 2022 at 09:02:54PM +0800, Chao Peng wrote:
> > I think the correct approach is to not do the locking automatically for SHM_F_INACCESSIBLE,
> > and instead require userspace to do shmctl(.., SHM_LOCK, ...) if userspace knows the
> > consumers don't support migrate/swap.  That'd require wrapping migrate_page() and then
> > wiring up notifier hooks for migrate/swap, but IMO that's a good thing to get sorted
> > out sooner than later.  KVM isn't planning on support migrate/swap for TDX or SNP,
> > but supporting at least migrate for a software-only implementation a la pKVM should
> > be relatively straightforward.  On the notifiee side, KVM can terminate the VM if it
> > gets an unexpected migrate/swap, e.g. so that TDX/SEV VMs don't die later with
> > exceptions and/or data corruption (pre-SNP SEV guests) in the guest.
> 
> SHM_LOCK sounds like a good match.

Emm, no. shmctl(2) and SHM_LOCK are SysV IPC thing. I don't see how they
fit here.

-- 
 Kirill A. Shutemov
