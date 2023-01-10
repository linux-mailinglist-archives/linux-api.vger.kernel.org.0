Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11E664F23
	for <lists+linux-api@lfdr.de>; Tue, 10 Jan 2023 23:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbjAJWx6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Jan 2023 17:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjAJWxd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Jan 2023 17:53:33 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295D755E0
        for <linux-api@vger.kernel.org>; Tue, 10 Jan 2023 14:51:47 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c7so12276978qtw.8
        for <linux-api@vger.kernel.org>; Tue, 10 Jan 2023 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nj+/7ufbi+mzc9WLMV9MhKIZ+vKN2tVNdm/p4PveWiw=;
        b=Z+LHP8EFN813rSHrstCkLabK4IngHI+cKeRWcxWaVpq6IuYGolxjNslezLPrqVjGqV
         q49LhzsEKIYTJGC5ECSyLgvYu9H6+d3+MoSEXFRuBNZkhp/bFYsGHLQVlAUclwstgUl/
         HA4F75LkF1TDyFZhI9t2f3OaD8uDIFSGgQkDwmVvJv1HJfjnrob4MIuu2lTVJTGD2K5s
         FR5lWKSZN3r86ua09Ari4/MY00ieOSSs2Nxy9skABpdMmfZbUcY4CQ2ZJ0yT0Fd/fH8u
         ay9FGbUCFo1jWFIKVNRkSTNDVKrkth2p5YEk7hVBNMXL4/rfsK5UKUx7+zHk/wkSssr/
         8Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nj+/7ufbi+mzc9WLMV9MhKIZ+vKN2tVNdm/p4PveWiw=;
        b=Ojij4ZfEIhJGuZ9dEyjELlLDaW+3egkOHL/7xU9Yxjup/bGV3ZGoxem1K5RTJDyNSm
         6/R1hmEga/6qqaoNpsf6hocSNjdiqr2Bv7BfeHJIK5CeHgtRgRadKTjqwz42C9WUH2/I
         9NM7nAHyqc4BtDZLnrI2E3UpkCniDoO/7RB0Smf2b7GpeHEFnfb1bu1JdTPFgv0WYuJs
         iQsxGvEuL+p7NfCOL7ZZeFJsmP9c5bgPBSICxXFlZtz84fYQFCS6qEks32fN9tcpOsGy
         Ce2N7fJ1+dh25/RRC5g0BHBECqEq8S19Wfb3oH4QVp1OYwBZV0pZPRKsoPp4rSKAqKhk
         dnqw==
X-Gm-Message-State: AFqh2kqaXiM7Qs0EAWRszRAT8oP0bEP2GNzXhevDU57QqZBgycWQn9AX
        R7g7YwMMC8Myz8KpvvOUCehong/hp6BCxbA9kqkKY0FIDMMQng==
X-Google-Smtp-Source: AMrXdXtCmgtL7XJA1AjxTGWmxlUVgcif515aqBGzxNtC4EL5mTP/V3O8hTigwzRJaQTQTj8cDIyP79kG4mIF4ZDOg8Y=
X-Received: by 2002:a05:622a:5c1a:b0:3a6:ee88:63dd with SMTP id
 gd26-20020a05622a5c1a00b003a6ee8863ddmr3310643qtb.446.1673391106667; Tue, 10
 Jan 2023 14:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-4-chao.p.peng@linux.intel.com> <Y7azFdnnGAdGPqmv@kernel.org>
 <20230106094000.GA2297836@chaop.bj.intel.com> <Y7xrtf9FCuYRYm1q@google.com> <20230110091432.GA2441264@chaop.bj.intel.com>
In-Reply-To: <20230110091432.GA2441264@chaop.bj.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 10 Jan 2023 14:51:35 -0800
Message-ID: <CAGtprH_V84eSDE1ohRBd24k=MuL+Y0zF1YVbKBjK4ROEHPJEpA@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] KVM: Extend the memslot to support fd-based
 private memory
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 10, 2023 at 1:19 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
> >
> > Regarding the userspace side of things, please include Vishal's selftests in v11,
> > it's impossible to properly review the uAPI changes without seeing the userspace
> > side of things.  I'm in the process of reviewing Vishal's v2[*], I'll try to
> > massage it into a set of patches that you can incorporate into your series.
>
> Previously I included Vishal's selftests in the github repo, but not
> include them in this patch series. It's OK for me to incorporate them
> directly into this series and review together if Vishal is fine.
>

Yeah, I am ok with incorporating selftest patches into this series and
reviewing them together.

Regards,
Vishal

> Chao
> >
> > [*] https://lore.kernel.org/all/20221205232341.4131240-1-vannapurve@google.com
