Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2F17D4DA
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbfHAFXN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 01:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHAFXM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 01:23:12 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04BE921841
        for <linux-api@vger.kernel.org>; Thu,  1 Aug 2019 05:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564636990;
        bh=94IQGV0QYBWO8K/XCIA6b9yDtF3D1dOqsGgzgwafnek=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hQUCO2raYS2WXjkn5N7OXvnQv058oj3NrtXLBj/UWLDgiqLJTlVI+q9Y/NPt2+ZpB
         qBxA2/+M0geN72cY6UUioedQVC0/PPlW3ypqWT0WqMJZjo9yCM8xhK6GgjdLR4/gq1
         u8TjV2EPSupQFbqVdSf3iJPGu2NX2wL3y2O7zTc8=
Received: by mail-wr1-f52.google.com with SMTP id y4so72094254wrm.2
        for <linux-api@vger.kernel.org>; Wed, 31 Jul 2019 22:23:09 -0700 (PDT)
X-Gm-Message-State: APjAAAXFFEvPsZwfIIZDI2cMjE4xExXAPCtnTrTFTgfS6PhNXTbxi1/Q
        01akfUuNAp2u4DKu70i58U72dfcoG+76Rs99By12WA==
X-Google-Smtp-Source: APXvYqx8cyIImdUMNEcsYhczUZ2j7poa+tXfY+rg9I0C82AB6c/ZW+5D+Lto55TFmr1rKuKbYskdSeOrpDW/1e+SG8U=
X-Received: by 2002:adf:cf02:: with SMTP id o2mr118396239wrj.352.1564636986592;
 Wed, 31 Jul 2019 22:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-24-dima@arista.com>
In-Reply-To: <20190729215758.28405-24-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 31 Jul 2019 22:22:54 -0700
X-Gmail-Original-Message-ID: <CALCETrX7uaBBzi+S4pOwhjr2kJrSxiung2v_8weSiGuMjVvPKQ@mail.gmail.com>
Message-ID: <CALCETrX7uaBBzi+S4pOwhjr2kJrSxiung2v_8weSiGuMjVvPKQ@mail.gmail.com>
Subject: Re: [PATCHv5 23/37] x86/vdso: Add offsets page in vvar
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        criu@openvz.org, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 29, 2019 at 2:58 PM Dmitry Safonov <dima@arista.com> wrote:
>
> From: Andrei Vagin <avagin@openvz.org>
>
> As modern applications fetch time from VDSO without entering the kernel,
> it's needed to provide offsets for userspace code inside time namespace.
>
> A page for timens offsets is allocated on time namespace construction.
> Put that page into VVAR for tasks inside timens and zero page for
> host processes.
>
> As VDSO code is already optimized as much as possible in terms of speed,
> any new if-condition in VDSO code is undesirable; the goal is to provide
> two .so(s), as was originally suggested by Andy and Thomas:
> - for host tasks with optimized-out clk_to_ns() without any penalty
> - for processes inside timens with clk_to_ns()
> For this purpose, define clk_to_ns() under CONFIG_TIME_NS.
>
> To eliminate any performance regression, clk_to_ns() will be called
> under static_branch with follow-up patches, that adds support for
> patching vdso.
>
> VDSO mappings are platform-specific, add Kconfig dependency for arch.
>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> Co-developed-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/Kconfig                          |  5 +++
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/entry/vdso/vdso-layout.lds.S |  9 ++++-
>  arch/x86/entry/vdso/vdso2c.c          |  3 ++
>  arch/x86/entry/vdso/vma.c             | 12 +++++++
>  arch/x86/include/asm/vdso.h           |  1 +
>  init/Kconfig                          |  1 +
>  lib/vdso/gettimeofday.c               | 47 +++++++++++++++++++++++++++
>  8 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index a7b57dd42c26..e43d27f510ec 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -729,6 +729,11 @@ config HAVE_ARCH_NVRAM_OPS
>  config ISA_BUS_API
>         def_bool ISA
>
> +config ARCH_HAS_VDSO_TIME_NS
> +       bool
> +       help
> +        VDSO can add time-ns offsets without entering kernel.
> +
>  #
>  # ABI hall of shame
>  #
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 222855cc0158..91615938b470 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -81,6 +81,7 @@ config X86
>         select ARCH_HAS_STRICT_MODULE_RWX
>         select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
> +       select ARCH_HAS_VDSO_TIME_NS
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG
>         select ARCH_MIGHT_HAVE_ACPI_PDC         if ACPI
>         select ARCH_MIGHT_HAVE_PC_PARPORT
> diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
> index 93c6dc7812d0..ba216527e59f 100644
> --- a/arch/x86/entry/vdso/vdso-layout.lds.S
> +++ b/arch/x86/entry/vdso/vdso-layout.lds.S
> @@ -7,6 +7,12 @@
>   * This script controls its layout.
>   */
>
> +#ifdef CONFIG_TIME_NS
> +# define TIMENS_SZ     PAGE_SIZE
> +#else
> +# define TIMENS_SZ     0
> +#endif
> +
>  SECTIONS
>  {
>         /*
> @@ -16,7 +22,7 @@ SECTIONS
>          * segment.
>          */
>
> -       vvar_start = . - 3 * PAGE_SIZE;
> +       vvar_start = . - (3 * PAGE_SIZE + TIMENS_SZ);
>         vvar_page = vvar_start;
>
>         /* Place all vvars at the offsets in asm/vvar.h. */
> @@ -28,6 +34,7 @@ SECTIONS
>
>         pvclock_page = vvar_start + PAGE_SIZE;
>         hvclock_page = vvar_start + 2 * PAGE_SIZE;
> +       timens_page = vvar_start + 3 * PAGE_SIZE;
>
>         . = SIZEOF_HEADERS;
>
> diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
> index ce67370d14e5..7380908045c7 100644
> --- a/arch/x86/entry/vdso/vdso2c.c
> +++ b/arch/x86/entry/vdso/vdso2c.c
> @@ -75,12 +75,14 @@ enum {
>         sym_vvar_page,
>         sym_pvclock_page,
>         sym_hvclock_page,
> +       sym_timens_page,
>  };
>
>  const int special_pages[] = {
>         sym_vvar_page,
>         sym_pvclock_page,
>         sym_hvclock_page,
> +       sym_timens_page,
>  };
>
>  struct vdso_sym {
> @@ -93,6 +95,7 @@ struct vdso_sym required_syms[] = {
>         [sym_vvar_page] = {"vvar_page", true},
>         [sym_pvclock_page] = {"pvclock_page", true},
>         [sym_hvclock_page] = {"hvclock_page", true},
> +       [sym_timens_page] = {"timens_page", true},
>         {"VDSO32_NOTE_MASK", true},
>         {"__kernel_vsyscall", true},
>         {"__kernel_sigreturn", true},
> diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> index 2dc4f0b5481c..9bd66f84db5e 100644
> --- a/arch/x86/entry/vdso/vma.c
> +++ b/arch/x86/entry/vdso/vma.c
> @@ -14,6 +14,7 @@
>  #include <linux/elf.h>
>  #include <linux/cpu.h>
>  #include <linux/ptrace.h>
> +#include <linux/time_namespace.h>
>  #include <asm/pvclock.h>
>  #include <asm/vgtod.h>
>  #include <asm/proto.h>
> @@ -23,6 +24,7 @@
>  #include <asm/desc.h>
>  #include <asm/cpufeature.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/page.h>
>
>  #if defined(CONFIG_X86_64)
>  unsigned int __read_mostly vdso64_enabled = 1;
> @@ -135,6 +137,16 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
>                 if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
>                         return vmf_insert_pfn(vma, vmf->address,
>                                         vmalloc_to_pfn(tsc_pg));
> +       } else if (sym_offset == image->sym_timens_page) {
> +               struct time_namespace *ns = current->nsproxy->time_ns;

What, if anything, guarantees that all tasks in the mm share the same timens?

--Andy
