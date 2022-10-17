Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1E600C76
	for <lists+linux-api@lfdr.de>; Mon, 17 Oct 2022 12:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiJQKcG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Oct 2022 06:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJQKcE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Oct 2022 06:32:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB486052F
        for <linux-api@vger.kernel.org>; Mon, 17 Oct 2022 03:31:58 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d6so16777966lfs.10
        for <linux-api@vger.kernel.org>; Mon, 17 Oct 2022 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5nozSFDmTVpu8GTMuUa17TgcVMpawH1V5x78PIRZetg=;
        b=SDSplUZ2VPkr2D1rPark9w6rINsj4QsGj8mIaHHj3cG7qqYj2xeg5bRcHWiAiCGNxn
         GsUn6i3U2OjLAFYiVGFUliiR7Eg727DK3wDSXfnbZMZbfbIZ31+HdQCxkX49ygkx2h2T
         JvvJpr3zkIRAU4V1EE328YM6hb7KitEqUGTlUdtUSKdTXZdHKruA7oQebxjBvB7yCdng
         14amkvXgB/TlF3oG6EUoWuZ8TnSYQkSfag7jNPXgHEtx3NHXccP4GhcHXIeI1JTCLuLR
         Ff1yL/Q300jH2Amjcw85DuxVyH90T6VnZoMTJKObTmi2YSvh5JYckhqKh2RO00z96P+I
         iG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nozSFDmTVpu8GTMuUa17TgcVMpawH1V5x78PIRZetg=;
        b=nab9kwr7M43OATAsN3VSMngvhhHSfsa9sL/37DOPMhKnCT77636ecyuVQDIqwtbPw7
         T9XJL2LboE7CL2oF3KuchRtxRF9qxBSbgL8NEsmBdWSJ54EtC7ht16hMmPM1iTMwlT9i
         j20QFqFJlXd5DrjyUnMRYjV4/PtQhoYtzaz7/FjoERR1BviopFs888ZwiHTVAP/33ftN
         +tjZHKjMUM4o/lUhNr5DescxSO2K3j2jP7nCpGPHyjPiye/KFiQe8baezhVT+VtYfPGs
         94we/CHrjSEO3zlqHhlefjV6mAMrrnDBSzJ9GtEJZU4LVPxSBNdJE53Sx62jWKEMStJB
         iaUg==
X-Gm-Message-State: ACrzQf3AC8RtBp2gjjyL48nAGcLkmV+TVRkImKqeb7AEvjbltqKC2KqX
        Vm/EDCIc+bbYsnnFLTNZxghXSXdpteF2YmZXSr/syA==
X-Google-Smtp-Source: AMsMyM5QQdeoCZqf4USHrTYZuLKFaoT483vufBzxBArWmR3pEEZFNUg/KtF5cabXdDzXtcRyF9bfuHIHJTBpaJKALKA=
X-Received: by 2002:a05:6512:4cb:b0:4a2:25b6:9e73 with SMTP id
 w11-20020a05651204cb00b004a225b69e73mr3967251lfq.30.1666002715568; Mon, 17
 Oct 2022 03:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com> <CA+EHjTzy4iOxLF=5UX=s5v6HSB3Nb1LkwmGqoKhp_PAnFeVPSQ@mail.gmail.com>
 <20220926142330.GC2658254@chaop.bj.intel.com> <CA+EHjTz5yGhsxUug+wqa9hrBO60Be0dzWeWzX00YtNxin2eYHg@mail.gmail.com>
 <YzN9gYn1uwHopthW@google.com> <CA+EHjTw3din891hMUeRW-cn46ktyMWSdoB31pL+zWpXo_=3UVg@mail.gmail.com>
 <20221013133457.GA3263142@chaop.bj.intel.com>
In-Reply-To: <20221013133457.GA3263142@chaop.bj.intel.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Mon, 17 Oct 2022 11:31:19 +0100
Message-ID: <CA+EHjTzZ2zsm7Ru_OKCZg9FCYESgZsmB=7ScKRh6ZN4=4OZ3gw@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

> >
> > Actually, for pKVM, there is no need for the guest memory to be
> > GUP'able at all if we use the new inaccessible_get_pfn().
>
> If pKVM can use inaccessible_get_pfn() to get pfn and can avoid GUP (I
> think that is the major concern?), do you see any other gap from
> existing API?

Actually for this part no, there aren't any gaps and
inaccessible_get_pfn() is sufficient.

> > This of
> > course goes back to what I'd mentioned before in v7; it seems that
> > representing the memslot memory as a file descriptor should be
> > orthogonal to whether the memory is shared or private, rather than a
> > private_fd for private memory and the userspace_addr for shared
> > memory. The host can then map or unmap the shared/private memory using
> > the fd, which allows it more freedom in even choosing to unmap shared
> > memory when not needed, for example.
>
> Using both private_fd and userspace_addr is only needed in TDX and other
> confidential computing scenarios, pKVM may only use private_fd if the fd
> can also be mmaped as a whole to userspace as Sean suggested.

That does work in practice, for now at least, and is what I do in my
current port. However, the naming and how the API is defined as
implied by the name and the documentation. By calling the field
private_fd, it does imply that it should not be mapped, which is also
what api.rst says in PATCH v8 5/8. My worry is that in that case pKVM
would be mis/ab-using this interface, and that future changes could
cause unforeseen issues for pKVM.

Maybe renaming this to something like "guest_fp", and specifying in
the documentation that it can be restricted, e.g., instead of "the
content of the private memory is invisible to userspace" something
along the lines of  "the content of the guest memory may be restricted
to userspace".

What do you think?

Cheers,
/fuad

>
> Thanks,
> Chao
> >
> > Cheers,
> > /fuad
