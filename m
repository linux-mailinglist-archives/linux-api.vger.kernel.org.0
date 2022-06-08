Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49BD543CFC
	for <lists+linux-api@lfdr.de>; Wed,  8 Jun 2022 21:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiFHThh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Jun 2022 15:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiFHThf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Jun 2022 15:37:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AEA2347DA
        for <linux-api@vger.kernel.org>; Wed,  8 Jun 2022 12:37:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r1so1262420plo.10
        for <linux-api@vger.kernel.org>; Wed, 08 Jun 2022 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wh6/XuxZPZUDwyzy5Eh7VeXfArKnNs6YeEjpbWE+j5g=;
        b=ZAG/K6D48l0KrmmRn1p2FTmiQngI/15yOkQ8MG3uOIp2K2v36XwQ2z8ZERlay6GUnj
         f6Sg6s8FFS/vw4GmKlcbDU92NrHn2K9bSARE4ICPUYhAVS3ymvr75ETolLgVKsl3A513
         oscCyM1WP/DK5242tikPCpr2E/rKOv00sX5olq99qElwq471NkYsjKcAWArALuZx2UmC
         CgiqYG3dwPpKqe4lLXhreFySMsEDe8d4kPNvglQIKziVC1KrNkNXJk21EPdQMbqcRvJ6
         v8IdnFTEPtFo6VDq8R+YkUgfipwAH1spS4CjC2hG/IiGlAv6nPBHFnuhil0CZaWyp+5b
         sSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wh6/XuxZPZUDwyzy5Eh7VeXfArKnNs6YeEjpbWE+j5g=;
        b=GZJZ25xmS4mr+RYI4VrKKwhLAOmq5kUQJV36mZUxlmZyaUSi2Va31fqHujcsE3tgoT
         dCYdxs3z+DAm1NwtSKIE1Y5ZUaKCf76DmQBsUg+/9jsABE/le7snHgsv5nhvRYm9PKDb
         Nrp9fvRVjHl52j164BpMX/oSzWO3DpWpmj1rhu4qfuPgapH1H2h8GbJINApRxtYh1YJb
         kbDXgbfWA448wBIawhMh75+bCmRcagURE1U2yTNTH0DjNpJ29z6mSE/pOHQyi0lMY/JG
         F8+E+l++BKsQAKBOYXSWg6vPA3pGrsbfixp6TTrh8F34aQ5BKrEx6o93t5Lwm67cx+QG
         OD2A==
X-Gm-Message-State: AOAM532wglnRKsvMx7/eMyrarWS+pJAOrQGpSkiAUBnQdovdJJje8rr+
        vusm9VaotX063i7pWAJt0/fCP4SSilzhMTeStILs4Q==
X-Google-Smtp-Source: ABdhPJyfhv1kDe3gJcgewOBnTs26+Uc6YFkqzaIMBY+Sas+MZKd5jC6EwNSmICRKaXBZxv4CUZaYAZlNhfXBPpTEGHU=
X-Received: by 2002:a17:902:f710:b0:15f:165f:b50b with SMTP id
 h16-20020a170902f71000b0015f165fb50bmr36739481plo.158.1654717048302; Wed, 08
 Jun 2022 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
 <CAGtprH_83CEC0U-cBR2FzHsxbwbGn0QJ87WFNOEet8sineOcbQ@mail.gmail.com>
 <20220607065749.GA1513445@chaop.bj.intel.com> <CAA03e5H_vOQS-qdZgacnmqP5T5jJLnEfm44yfRzJQ2KVu0Br+Q@mail.gmail.com>
 <20220608021820.GA1548172@chaop.bj.intel.com>
In-Reply-To: <20220608021820.GA1548172@chaop.bj.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Wed, 8 Jun 2022 12:37:17 -0700
Message-ID: <CAGtprH8xyf07jMN7ubTC__BvDj+z41uVGRiCJ7Rc5cv3KWg03w@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM
 guest private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Marc Orr <marcorr@google.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

...
> With this patch series, it's actually even not possible for userspace VMM
> to allocate private page by a direct write, it's basically unmapped from
> there. If it really wants to, it should so something special, by intention,
> that's basically the conversion, which we should allow.
>

A VM can pass GPA backed by private pages to userspace VMM and when
Userspace VMM accesses the backing hva there will be pages allocated
to back the shared fd causing 2 sets of pages backing the same guest
memory range.

> Thanks for bringing this up. But in my mind I still think userspace VMM
> can do and it's its responsibility to guarantee that, if that is hard
> required. By design, userspace VMM is the decision-maker for page
> conversion and has all the necessary information to know which page is
> shared/private. It also has the necessary knobs to allocate/free the
> physical pages for guest memory. Definitely, we should make userspace
> VMM more robust.

Making Userspace VMM more robust to avoid double allocation can get
complex, it will have to keep track of all in-use (by Userspace VMM)
shared fd memory to disallow conversion from shared to private and
will have to ensure that all guest supplied addresses belong to shared
GPA ranges.
A coarser but simpler alternative could be to always allow shared to
private conversion with unbacking the memory from shared fd and exit
if the VMM runs in double allocation scenarios. In either cases,
unbacking shared fd memory ideally should prevent memory allocation on
subsequent write accesses to ensure double allocation scenarios are
caught early.

Regards,
Vishal
