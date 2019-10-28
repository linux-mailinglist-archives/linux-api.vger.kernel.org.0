Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF7E741D
	for <lists+linux-api@lfdr.de>; Mon, 28 Oct 2019 15:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390409AbfJ1Ozh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Oct 2019 10:55:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21259 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727227AbfJ1Ozh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Oct 2019 10:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572274535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SI6pU5ltjnpPB7iWVIT6QOJJZOAm4cxx0m6EK7PRco=;
        b=I0u3RieR61PkgDl/AtvRXVSF6h/BP3FLCAvubMYn5wXGf/Zx4ZJi03zDM2nLqCA2Ya1xdL
        wH1HFqLrucMNro7nPatYTZ6XB+PI7QxnAleOeOaD+tNfAVE5N8hYC/9BeUt35cqMrTL7e+
        vDwdmE0Vq6t1IT14zRm5X4OdnXIEIig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-9OF9M3p9Pzq4axXXmVk_FQ-1; Mon, 28 Oct 2019 10:55:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06FA51804972;
        Mon, 28 Oct 2019 14:55:30 +0000 (UTC)
Received: from [10.36.117.63] (ovpn-117-63.ams2.redhat.com [10.36.117.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68C2B612B1;
        Mon, 28 Oct 2019 14:55:26 +0000 (UTC)
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <1572171452-7958-2-git-send-email-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <9c844300-e151-97a0-7223-a6d341d0d75e@redhat.com>
Date:   Mon, 28 Oct 2019 15:55:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1572171452-7958-2-git-send-email-rppt@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 9OF9M3p9Pzq4axXXmVk_FQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 27.10.19 11:17, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
>=20
> The mappings created with MAP_EXCLUSIVE are visible only in the context o=
f
> the owning process and can be used by applications to store secret
> information that will not be visible not only to other processes but to t=
he
> kernel as well.
>=20
> The pages in these mappings are removed from the kernel direct map and
> marked with PG_user_exclusive flag. When the exclusive area is unmapped,
> the pages are mapped back into the direct map.
>=20
> The MAP_EXCLUSIVE flag implies MAP_POPULATE and MAP_LOCKED.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/x86/mm/fault.c                    | 14 ++++++++++
>   fs/proc/task_mmu.c                     |  1 +
>   include/linux/mm.h                     |  9 +++++++
>   include/linux/page-flags.h             |  7 +++++
>   include/linux/page_excl.h              | 49 +++++++++++++++++++++++++++=
+++++++
>   include/trace/events/mmflags.h         |  9 ++++++-
>   include/uapi/asm-generic/mman-common.h |  1 +
>   kernel/fork.c                          |  3 ++-
>   mm/Kconfig                             |  3 +++
>   mm/gup.c                               |  8 ++++++
>   mm/memory.c                            |  3 +++
>   mm/mmap.c                              | 16 +++++++++++
>   mm/page_alloc.c                        |  5 ++++
>   13 files changed, 126 insertions(+), 2 deletions(-)
>   create mode 100644 include/linux/page_excl.h
>=20
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 9ceacd1..8f73a75 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -17,6 +17,7 @@
>   #include <linux/context_tracking.h>=09/* exception_enter(), ...=09*/
>   #include <linux/uaccess.h>=09=09/* faulthandler_disabled()=09*/
>   #include <linux/efi.h>=09=09=09/* efi_recover_from_page_fault()*/
> +#include <linux/page_excl.h>=09=09/* page_is_user_exclusive()=09*/
>   #include <linux/mm_types.h>
>  =20
>   #include <asm/cpufeature.h>=09=09/* boot_cpu_has, ...=09=09*/
> @@ -1218,6 +1219,13 @@ static int fault_in_kernel_space(unsigned long add=
ress)
>   =09return address >=3D TASK_SIZE_MAX;
>   }
>  =20
> +static bool fault_in_user_exclusive_page(unsigned long address)
> +{
> +=09struct page *page =3D virt_to_page(address);
> +
> +=09return page_is_user_exclusive(page);
> +}
> +
>   /*
>    * Called for all faults where 'address' is part of the kernel address
>    * space.  Might get called for faults that originate from *code* that
> @@ -1261,6 +1269,12 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned =
long hw_error_code,
>   =09if (spurious_kernel_fault(hw_error_code, address))
>   =09=09return;
>  =20
> +=09/* FIXME: warn and handle gracefully */
> +=09if (unlikely(fault_in_user_exclusive_page(address))) {
> +=09=09pr_err("page fault in user exclusive page at %lx", address);
> +=09=09force_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)address);
> +=09}
> +
>   =09/* kprobes don't want to hook the spurious faults: */
>   =09if (kprobe_page_fault(regs, X86_TRAP_PF))
>   =09=09return;
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9442631..99e14d1 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -655,6 +655,7 @@ static void show_smap_vma_flags(struct seq_file *m, s=
truct vm_area_struct *vma)
>   #ifdef CONFIG_X86_INTEL_MPX
>   =09=09[ilog2(VM_MPX)]=09=09=3D "mp",
>   #endif
> +=09=09[ilog2(VM_EXCLUSIVE)]=09=3D "xl",
>   =09=09[ilog2(VM_LOCKED)]=09=3D "lo",
>   =09=09[ilog2(VM_IO)]=09=09=3D "io",
>   =09=09[ilog2(VM_SEQ_READ)]=09=3D "sr",
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cc29227..9c43375 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -298,11 +298,13 @@ extern unsigned int kobjsize(const void *objp);
>   #define VM_HIGH_ARCH_BIT_2=0934=09/* bit only usable on 64-bit architec=
tures */
>   #define VM_HIGH_ARCH_BIT_3=0935=09/* bit only usable on 64-bit architec=
tures */
>   #define VM_HIGH_ARCH_BIT_4=0936=09/* bit only usable on 64-bit architec=
tures */
> +#define VM_HIGH_ARCH_BIT_5=0937=09/* bit only usable on 64-bit architect=
ures */
>   #define VM_HIGH_ARCH_0=09BIT(VM_HIGH_ARCH_BIT_0)
>   #define VM_HIGH_ARCH_1=09BIT(VM_HIGH_ARCH_BIT_1)
>   #define VM_HIGH_ARCH_2=09BIT(VM_HIGH_ARCH_BIT_2)
>   #define VM_HIGH_ARCH_3=09BIT(VM_HIGH_ARCH_BIT_3)
>   #define VM_HIGH_ARCH_4=09BIT(VM_HIGH_ARCH_BIT_4)
> +#define VM_HIGH_ARCH_5=09BIT(VM_HIGH_ARCH_BIT_5)
>   #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
>  =20
>   #ifdef CONFIG_ARCH_HAS_PKEYS
> @@ -340,6 +342,12 @@ extern unsigned int kobjsize(const void *objp);
>   # define VM_MPX=09=09VM_NONE
>   #endif
>  =20
> +#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
> +# define VM_EXCLUSIVE=09VM_HIGH_ARCH_5
> +#else
> +# define VM_EXCLUSIVE=09VM_NONE
> +#endif
> +
>   #ifndef VM_GROWSUP
>   # define VM_GROWSUP=09VM_NONE
>   #endif
> @@ -2594,6 +2602,7 @@ struct page *follow_page(struct vm_area_struct *vma=
, unsigned long address,
>   #define FOLL_ANON=090x8000=09/* don't do file mappings */
>   #define FOLL_LONGTERM=090x10000=09/* mapping lifetime is indefinite: se=
e below */
>   #define FOLL_SPLIT_PMD=090x20000=09/* split huge pmd before returning *=
/
> +#define FOLL_EXCLUSIVE=090x40000=09/* mapping is exclusive to owning mm =
*/
>  =20
>   /*
>    * NOTE on FOLL_LONGTERM:
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f91cb88..32d0aee 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -131,6 +131,9 @@ enum pageflags {
>   =09PG_young,
>   =09PG_idle,
>   #endif
> +#if defined(CONFIG_EXCLUSIVE_USER_PAGES)
> +=09PG_user_exclusive,
> +#endif

Last time I tried to introduce a new page flag I learned that this is=20
very much frowned upon. Best you can usually do is reuse another flag -=20
if valid in that context.

--=20

Thanks,

David / dhildenb

