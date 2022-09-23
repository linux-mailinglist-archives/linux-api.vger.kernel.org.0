Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DDB5E7E26
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiIWPVM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Sep 2022 11:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiIWPU7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Sep 2022 11:20:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08913C843
        for <linux-api@vger.kernel.org>; Fri, 23 Sep 2022 08:20:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id j24so448834lja.4
        for <linux-api@vger.kernel.org>; Fri, 23 Sep 2022 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=SUWKwcsZsry2fgvm0fDpc5kVnOus3A4t37kogjVDCAM=;
        b=ENR7gm/ufNi1bXyPhRkLqOIR8X61pAuHZDAxvBQJtBMo1XxcJXpZCyvZXjdZtxEGqs
         Rld/BEcs2SP4Qyo9L4ZnVLbMttpTZWKLplZzijm55RmkSXps8vg+nlMTQRL8Q8n8sP8V
         PQt74elT4aSaOtht+ghVFN1gYzIIvLmyZUBZycxab9teGDT4klNyOyRb/aF7xVrdEhn9
         7oLI/l2Io92zNWZn3GSEQCNXcxdOVW4hgKbxpiZ3V8r6dHHCPZ3UDzrOP3Zt+jMD0Csi
         vmw3ypm10IkLOpdYu1J8qcIYc6CXN4laL/fqx5HsbDxujMM99DHcUV+6BWkduPO9udYw
         ZNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SUWKwcsZsry2fgvm0fDpc5kVnOus3A4t37kogjVDCAM=;
        b=Ai99zMpQYgJRuyGEcQ4HV/G4xQgIFV9YTZjSmmLqOkwWvfmfnN1af7e9FY5N59cCRy
         k0M7MCGXCEASOIYqY4KQjzsypnUSrgx74mTQ/zfEQJTzoi+cXVUHfv9yVfyWh6dVjNnt
         C7WQMHrAj9cBY9K2RrOt/O1LRzoitzYnQk9VDjq/ZfdDjMhZ6X58PPFmrCG4MvCiOUKr
         CtkeVBeyM9/smP5ykYAX4UltqE7YPWdPjQACwXtYy0Ycgr+gcq9LcXoKBlSXCeHmTdE4
         457wXp8C2yOBhUWMhq2UkJhde++DhBu9vidvgdiV3PfyXv6gfsSwfoT20lHylxEBcKXd
         fkHg==
X-Gm-Message-State: ACrzQf3E9wuDqSjliOmi3oSwtPiBiV20o7K7lJCLWldIxpinBXuJxA6g
        JBjGYPaLAyLzBGj/RCDVivV9s55qGP3+dwcAsyPWfg==
X-Google-Smtp-Source: AMsMyM7wJ1CjDy1uo28Cq+7fc7qkrSMtXjul2vWncBmw/XrFOfxAvAKrbpIhjT0LJgDsFIw328yn+2TOFJu3bRs5xe4=
X-Received: by 2002:a05:651c:1508:b0:26c:622e:abe1 with SMTP id
 e8-20020a05651c150800b0026c622eabe1mr3040402ljf.228.1663946450628; Fri, 23
 Sep 2022 08:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220915142913.2213336-1-chao.p.peng@linux.intel.com>
 <20220915142913.2213336-2-chao.p.peng@linux.intel.com> <d16284f5-3493-2892-38e6-f1fa5c10bdbb@redhat.com>
 <Yyi+l3+p9lbBAC4M@google.com> <84e81d21-c800-4fd5-ad7c-f20bcdd7508b@www.fastmail.com>
In-Reply-To: <84e81d21-c800-4fd5-ad7c-f20bcdd7508b@www.fastmail.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Fri, 23 Sep 2022 16:20:13 +0100
Message-ID: <CA+EHjTzt6grmRx59ziG6LHWBsE598dxiOYqqRM4cKvpF3ujqHg@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] mm/memfd: Introduce userspace inaccessible memfd
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        David Hildenbrand <david@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>, wei.w.wang@intel.com,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

<...>

> > Regarding pKVM's use case, with the shim approach I believe this can be=
 done by
> > allowing userspace mmap() the "hidden" memfd, but with a ton of restric=
tions
> > piled on top.
> >
> > My first thought was to make the uAPI a set of KVM ioctls so that KVM
> > could tightly
> > tightly control usage without taking on too much complexity in the
> > kernel, but
> > working through things, routing the behavior through the shim itself
> > might not be
> > all that horrific.
> >
> > IIRC, we discarded the idea of allowing userspace to map the "private"
> > fd because
> > things got too complex, but with the shim it doesn't seem _that_ bad.
>
> What's the exact use case?  Is it just to pre-populate the memory?

Prepopulate memory and access memory that could go back and forth from
being shared to being private.

Cheers,
/fuad



> >
> > E.g. on the memfd side:
> >
> >   1. The entire memfd must be mapped, and at most one mapping is allowe=
d, i.e.
> >      mapping is all or nothing.
> >
> >   2. Acquiring a reference via get_pfn() is disallowed if there's a map=
ping for
> >      the restricted memfd.
> >
> >   3. Add notifier hooks to allow downstream users to further restrict t=
hings.
> >
> >   4. Disallow splitting VMAs, e.g. to force userspace to munmap() every=
thing in
> >      one shot.
> >
> >   5. Require that there are no outstanding references at munmap().  Or =
if this
> >      can't be guaranteed by userspace, maybe add some way for userspace=
 to wait
> >      until it's ok to convert to private?  E.g. so that get_pfn() doesn=
't need
> >      to do an expensive check every time.
>
> Hmm.  I haven't looked at the code to see if this would really work, but =
I think this could be done more in line with how the rest of the kernel wor=
ks by using the rmap infrastructure.  When the pKVM memfd is in not-yet-pri=
vate mode, just let it be mmapped as usual (but don't allow any form of GUP=
 or pinning).  Then have an ioctl to switch to to shared mode that takes lo=
cks or sets flags so that no new faults can be serviced and does unmap_mapp=
ing_range.
>
> As long as the shim arranges to have its own vm_ops, I don't immediately =
see any reason this can't work.
