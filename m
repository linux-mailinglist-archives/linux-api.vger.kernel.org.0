Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D432507CB4
	for <lists+linux-api@lfdr.de>; Wed, 20 Apr 2022 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358280AbiDSWqy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Apr 2022 18:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358276AbiDSWqx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Apr 2022 18:46:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6821530F46
        for <linux-api@vger.kernel.org>; Tue, 19 Apr 2022 15:44:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id i24so154477pfa.7
        for <linux-api@vger.kernel.org>; Tue, 19 Apr 2022 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLhwP2K5wAQdNCL/I+laKlmhhmXTIYpsE+P3ZBVdEQY=;
        b=r6feRZnKvLFz70LElt69P5H+fCR2FPIhGGDf/HEN3FRecAYZ9XCe48UHMGy+CySLim
         Nf5DSsTsuheV1j+T6ia1xrZDpsTF3FTPXu+PVf45W3eRaPm0iYir4XnaqNkn/g+rZCO2
         +mve4Z0JSADruCniouTjwzcvVDbH3e2O3juiT4JkLMIr7ZXwKFqeJlsDlQ8PoQ143YKV
         4mXbdBPsHAvnmaRpFABAN6Fu2TxYwMuj7lx3m1l+FUNKtOImv1EuD09eyGgiiWGIIwwL
         LNoj8AvJNwOZZPiT6ZBr88Y7Sec+d18PBB4ep9ryJg1nLwP6Jf9EVG8Bvth2Y321pPhZ
         R+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLhwP2K5wAQdNCL/I+laKlmhhmXTIYpsE+P3ZBVdEQY=;
        b=6faqsgx+wrNhHFS+8hK8HxmEU5UtNNcXfCEPzIFZBqjdE3q9Ob6BsKsnl3l4145kym
         mrDjbdyKgPx1wbpTbssJNgyrLKKz7dC9zes9IbPPLgt9SG0Y7UjskbOdm5GbHG25Zew7
         yQd8uEP0oOFxTCrscgAGOJRDkFcQSZC+oqimRbbRIL9nqbDs87qyRbRtvReCkhG30qhn
         XXut8gpcp6svJ8kmAiyEYkWzQFgMr68U2qisBb4sUYkdW6azhdcpfQIM8PiiuEqTc7Xq
         fBwqJXuuIYSfJh2/0F2nq0LOzkE64RTu0iBv7KTWBhNwopHpuqT8kDuwX8nUVvyr8ZOZ
         z7pQ==
X-Gm-Message-State: AOAM531YeiOHARZARuyrq4C0kl4lolfhKWPjLHaGY0Ik0ijYtulpvCrj
        9svJwcyCn6AygF7wYK5vMLRsINwwMYW6KdwXNX1vsA==
X-Google-Smtp-Source: ABdhPJy1nh6THruK7UwMlM2wpxzbJNt+bc4+NMZX+nwIAjwmQ/JmNyUx85odCJYd4rFIN0fRrs6lthI6/1JylF8mddI=
X-Received: by 2002:a65:56cb:0:b0:378:82ed:d74 with SMTP id
 w11-20020a6556cb000000b0037882ed0d74mr16683302pgs.491.1650408247642; Tue, 19
 Apr 2022 15:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com> <20220310140911.50924-12-chao.p.peng@linux.intel.com>
In-Reply-To: <20220310140911.50924-12-chao.p.peng@linux.intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Tue, 19 Apr 2022 15:43:56 -0700
Message-ID: <CAGtprH-qTB2sehidF7xkSvR3X4D5cUOLpMBXf4mhTEh0BUR-mQ@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] KVM: Zap existing KVM mappings when pages
 changed in the private fd
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        ak@linux.intel.com, david@redhat.com
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

On Thu, Mar 10, 2022 at 6:11 AM Chao Peng <chao.p.peng@linux.intel.com> wrote:
>
> KVM gets notified when memory pages changed in the memory backing store.
> When userspace allocates the memory with fallocate() or frees memory
> with fallocate(FALLOC_FL_PUNCH_HOLE), memory backing store calls into
> KVM fallocate/invalidate callbacks respectively. To ensure KVM never
> maps both the private and shared variants of a GPA into the guest, in
> the fallocate callback, we should zap the existing shared mapping and
> in the invalidate callback we should zap the existing private mapping.
>
> In the callbacks, KVM firstly converts the offset range into the
> gfn_range and then calls existing kvm_unmap_gfn_range() which will zap
> the shared or private mapping. Both callbacks pass in a memslot
> reference but we need 'kvm' so add a reference in memslot structure.
>
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  include/linux/kvm_host.h |  3 ++-
>  virt/kvm/kvm_main.c      | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 9b175aeca63f..186b9b981a65 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -236,7 +236,7 @@ bool kvm_setup_async_pf(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
>  #endif
>
> -#ifdef KVM_ARCH_WANT_MMU_NOTIFIER
> +#if defined(KVM_ARCH_WANT_MMU_NOTIFIER) || defined(CONFIG_MEMFILE_NOTIFIER)
>  struct kvm_gfn_range {
>         struct kvm_memory_slot *slot;
>         gfn_t start;
> @@ -568,6 +568,7 @@ struct kvm_memory_slot {
>         loff_t private_offset;
>         struct memfile_pfn_ops *pfn_ops;
>         struct memfile_notifier notifier;
> +       struct kvm *kvm;
>  };
>
>  static inline bool kvm_slot_is_private(const struct kvm_memory_slot *slot)
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 67349421eae3..52319f49d58a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -841,8 +841,43 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>
>  #ifdef CONFIG_MEMFILE_NOTIFIER
> +static void kvm_memfile_notifier_handler(struct memfile_notifier *notifier,
> +                                        pgoff_t start, pgoff_t end)
> +{
> +       int idx;
> +       struct kvm_memory_slot *slot = container_of(notifier,
> +                                                   struct kvm_memory_slot,
> +                                                   notifier);
> +       struct kvm_gfn_range gfn_range = {
> +               .slot           = slot,
> +               .start          = start - (slot->private_offset >> PAGE_SHIFT),
> +               .end            = end - (slot->private_offset >> PAGE_SHIFT),
> +               .may_block      = true,
> +       };
> +       struct kvm *kvm = slot->kvm;
> +
> +       gfn_range.start = max(gfn_range.start, slot->base_gfn);

gfn_range.start seems to be page offset within the file. Should this rather be:
gfn_range.start = slot->base_gfn + min(gfn_range.start, slot->npages);

> +       gfn_range.end = min(gfn_range.end, slot->base_gfn + slot->npages);
> +

Similar to previous comment, should this rather be:
gfn_range.end = slot->base_gfn + min(gfn_range.end, slot->npages);

> +       if (gfn_range.start >= gfn_range.end)
> +               return;
> +
> +       idx = srcu_read_lock(&kvm->srcu);
> +       KVM_MMU_LOCK(kvm);
> +       kvm_unmap_gfn_range(kvm, &gfn_range);
> +       kvm_flush_remote_tlbs(kvm);
> +       KVM_MMU_UNLOCK(kvm);
> +       srcu_read_unlock(&kvm->srcu, idx);
> +}
> +
> +static struct memfile_notifier_ops kvm_memfile_notifier_ops = {
> +       .invalidate = kvm_memfile_notifier_handler,
> +       .fallocate = kvm_memfile_notifier_handler,
> +};
> +
>  static inline int kvm_memfile_register(struct kvm_memory_slot *slot)
>  {
> +       slot->notifier.ops = &kvm_memfile_notifier_ops;
>         return memfile_register_notifier(file_inode(slot->private_file),
>                                          &slot->notifier,
>                                          &slot->pfn_ops);
> @@ -1963,6 +1998,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
>         new->private_file = file;
>         new->private_offset = mem->flags & KVM_MEM_PRIVATE ?
>                               region_ext->private_offset : 0;
> +       new->kvm = kvm;
>
>         r = kvm_set_memslot(kvm, old, new, change);
>         if (!r)
> --
> 2.17.1
>
