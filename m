Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35975396C5
	for <lists+linux-api@lfdr.de>; Tue, 31 May 2022 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346540AbiEaTPQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 31 May 2022 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiEaTPP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 31 May 2022 15:15:15 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2806AA59
        for <linux-api@vger.kernel.org>; Tue, 31 May 2022 12:15:13 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 129so9408615pgc.2
        for <linux-api@vger.kernel.org>; Tue, 31 May 2022 12:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LEQ/FAYXiOycH5Pgki0a9z4cyO6Zt9xfMoijJMruHE=;
        b=aoYECPuBKU7Lwlucej90ckQ541ZhjI9tXfhwwrKcylKXIDWfCbS506NUkmQoPpFtjp
         SxY2BDwXcLrnVWuj1tlKZZFXX3boTF7L4/UbiNTvLgRbtbDkTU4iJj5rlChLdWN+AXW9
         /8uU6E9xZwRmy7lGao0XRqc/MNAqTYJl5P/hqXTOYZPGOYjzn/bAAgwSrZzoRfJDN/cT
         SuEfeHBBPefKlsfPtsSVZxWgXtnCDoM36KPdTqy2nZJEgrImggnACjHpxleCCtC3++o9
         yxDwtO9/7vBZwXZmJ1VhyZ/Ls48fokKREiBfE3hRzy/o9DlM+JugKxkM4Tz9Yq/hcS03
         4NUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LEQ/FAYXiOycH5Pgki0a9z4cyO6Zt9xfMoijJMruHE=;
        b=I2IpTY7csxmQrvYdPK2AVnNGSdvTvvFG+iYjStNnt8FWirXyIo7c8JBPusfQilVCe2
         fE/mkwYX9ldhX3epnxp+2Gzxqofh9/iwDFecrk2xM7YPPccaDnBIp3OK7vzHuFbRjp6U
         ebAKRIBBvrR8t4wla4LTMKU4nbDtkZFuNsxH1pZ1KmcXMV7r8zS4/ht1bbjfk9N2kn4s
         MeDVpI/Byh/9dfT4coloXX9iwdu16GFKzwN7BOc/yjdR2E9AWjtGrKjMgZk+X3vGY/QW
         K+/Vzt4xUxZjJo3xA03Uu1pD4p+bmfnC7+YJNSgNdXmc3rLzyrqGRP+ctk1u45naYT2q
         jiOQ==
X-Gm-Message-State: AOAM532v9R4aCPv+iYRtUFOdq0a7t2IZqOYVUvhu5G5iDBIBg8V4g0TS
        6O7LRM/dt7r6pgCB64C9HscsMRa+aEczdEuX6l61ww==
X-Google-Smtp-Source: ABdhPJxAPLjjLuJnMkOUKZFNo6VjJcW6gX615tv0A0PeV8j4hPGz6HEz6HuE5g9ZfRLMUWFpXLfK3l0Q4MwhwgPaQrE=
X-Received: by 2002:a63:2ad6:0:b0:3f9:d9fa:2713 with SMTP id
 q205-20020a632ad6000000b003f9d9fa2713mr44449690pgq.512.1654024511581; Tue, 31
 May 2022 12:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220519153713.819591-1-chao.p.peng@linux.intel.com> <20220519153713.819591-4-chao.p.peng@linux.intel.com>
In-Reply-To: <20220519153713.819591-4-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 31 May 2022 12:15:00 -0700
Message-ID: <CAGtprH8EMsPMMoOEzjRu0SMVKT0RqmkLk=n+6uXkBA6-wiRtUA@mail.gmail.com>
Subject: Re: [PATCH v6 3/8] mm/memfd: Introduce MFD_INACCESSIBLE flag
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jun Nakajima <jun.nakajima@intel.com>, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
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

On Thu, May 19, 2022 at 8:41 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> Introduce a new memfd_create() flag indicating the content of the
> created memfd is inaccessible from userspace through ordinary MMU
> access (e.g., read/write/mmap). However, the file content can be
> accessed via a different mechanism (e.g. KVM MMU) indirectly.
>

SEV, TDX, pkvm and software-only VMs seem to have usecases to set up
initial guest boot memory with the needed blobs.
TDX already supports a KVM IOCTL to transfer contents to private
memory using the TDX module but rest of the implementations will need
to invent
a way to do this.

Is there a plan to support a common implementation for either allowing
initial write access from userspace to private fd or adding a KVM
IOCTL to transfer contents to such a file,
as part of this series through future revisions?

Regards,
Vishal
