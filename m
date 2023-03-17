Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD40F6BEF4A
	for <lists+linux-api@lfdr.de>; Fri, 17 Mar 2023 18:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCQRMe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Mar 2023 13:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjCQRMd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Mar 2023 13:12:33 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BCA4FF05
        for <linux-api@vger.kernel.org>; Fri, 17 Mar 2023 10:12:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i6so6473053ybu.8
        for <linux-api@vger.kernel.org>; Fri, 17 Mar 2023 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679073150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ikWb9GqbCHXDoNjDF2yyQsEog3dPXb54BKqYKGLZKo=;
        b=Zfo2sCJiLQjkcgp4hl850DgKMGKFeMrifVhcXlQv2qElaBsO7vaXPlKO/mdARlti23
         8VPUEVXZngQedMVddPcy+xa7qlbkZuDci2xhcaUrExNMXCB0BLRPSznglejsnJNXw5ga
         RHzCNLPAoyv8psmkyR/QZtWDNz6zDpFfajtu9fd+byeuGP3OVNiTX1NwMkTXrRsmSiaM
         kwPuCZirTBcWpekpwTV60PfiSEURz6/awp/zWgGgnqKwCMh3QLkJmqKnQYqmXwIwAIlV
         kTtlgROVwfJgJkjXYAVD+QfBwuzQqod4NYECB2ZccqVLkcppcUvaY7Cc2QbGnU59+iYz
         YDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ikWb9GqbCHXDoNjDF2yyQsEog3dPXb54BKqYKGLZKo=;
        b=LRDKs7EYXFm/Zjbvc4f16XqtLJUWCoK8rII7JbgxeSuFyutVawuxcYOhVJRXTGu9eK
         OaYvTwaK25HmgyNkUUPrQSqQfUMkJfDsVcUok3560OZyUfMiqiC2QhKvexIKexzrqABq
         ggEdXNWFHj/yzKzXAK7Jk7yMmTXZc7xxaAfMQf0BPuwxGjq3IUX8sjcUHD8JERLzHeZZ
         nSzGDMqxq0bMgrqJjmOoY5Dw/dV4ySNaVpzrq4JNchQecG8VHWRtxuuPdGcb92gvxE1G
         M0c28uy6IPDf2Gu/2lTPooQVa7HOecr4PbyDqKKfIrXoOzlKZuZnSstautPRqewJpAmL
         Z7Hw==
X-Gm-Message-State: AO0yUKUFPL28PWS4c/rsrJmyopJDuiqpRnoMDn8yq6j6+T/mhGKCiA+x
        Lgr/E69unPoj+9bJX1iuppgERBNJTPIMaExtEOhTkQ==
X-Google-Smtp-Source: AK7set/QfKKXHCQJ3mrdY3gq80ku8GQMwyT8c5IhgvAeBv6xKwxPXs/SU34oJvp29NZ60hId0CNTrh08jaWhgmevYpM=
X-Received: by 2002:a5b:bc3:0:b0:ac2:a7a7:23c3 with SMTP id
 c3-20020a5b0bc3000000b00ac2a7a723c3mr154479ybr.12.1679073150497; Fri, 17 Mar
 2023 10:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com> <20230227222957.24501-23-rick.p.edgecombe@intel.com>
In-Reply-To: <20230227222957.24501-23-rick.p.edgecombe@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Fri, 17 Mar 2023 10:12:21 -0700
Message-ID: <CAKC1njQ+resjS-O8vAVLhRfLHEdgta09faEr5zwi1JTNSWK0Fw@mail.gmail.com>
Subject: Re: [PATCH v7 22/41] mm/mmap: Add shadow stack pages to memory accounting
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 27, 2023 at 2:31=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>
> The x86 Control-flow Enforcement Technology (CET) feature includes a new
> type of memory called shadow stack. This shadow stack memory has some
> unusual properties, which requires some core mm changes to function
> properly.
>
> Account shadow stack pages to stack memory. Do this by adding a
> VM_SHADOW_STACK check in is_stack_mapping().
>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> Tested-by: John Allen <john.allen@amd.com>
> Tested-by: Kees Cook <keescook@chromium.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Kees Cook <keescook@chromium.org>
>
> ---
> v7:
>  - Change is_stack_mapping() to know about VM_SHADOW_STACK so the
>    additions in vm_stat_account() can be dropped. (David Hildenbrand)
>
> v3:
>  - Remove unneeded VM_SHADOW_STACK check in accountable_mapping()
>    (Kirill)
>
> v2:
>  - Remove is_shadow_stack_mapping() and just change it to directly bitwis=
e
>    and VM_SHADOW_STACK.
>
> Yu-cheng v26:
>  - Remove redundant #ifdef CONFIG_MMU.
>
> Yu-cheng v25:
>  - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping=
().
> ---
>  mm/internal.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 7920a8b7982e..1d13d5580f64 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -491,14 +491,14 @@ static inline bool is_exec_mapping(vm_flags_t flags=
)
>  }
>
>  /*
> - * Stack area - automatically grows in one direction
> + * Stack area
>   *
> - * VM_GROWSUP / VM_GROWSDOWN VMAs are always private anonymous:
> - * do_mmap() forbids all other combinations.
> + * VM_GROWSUP, VM_GROWSDOWN VMAs are always private
> + * anonymous. do_mmap() forbids all other combinations.
>   */
>  static inline bool is_stack_mapping(vm_flags_t flags)
>  {
> -       return (flags & VM_STACK) =3D=3D VM_STACK;
> +       return ((flags & VM_STACK) =3D=3D VM_STACK) || (flags & VM_SHADOW=
_STACK);

Same comment here. `VM_SHADOW_STACK` is an x86 specific way of
encoding a shadow stack.
Instead let's have a proxy here which allows architectures to have
their own encodings to represent a shadow stack.

>  }
>
>  /*
> --
> 2.17.1
>
