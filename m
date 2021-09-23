Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF59A4167EF
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 00:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbhIWWZn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 18:25:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37578 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbhIWWZf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 18:25:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632435841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Matoo2OIfdawfGuu3j6hbf2m+pvAyOqko4uRRDDqJ0=;
        b=N9ssRTZGMxorWOBqZEIQ9Tt2vNTC5I8aj19BMSE9Xssk0QWWtT/+0NICD6ssXGkA5FR8ds
        7HwcthwHMm5PC2Ku+n2v00I8mpZkiSVyBlEP9litACd8ROqGfpHbiBNt7rpSxNEqPlEYoy
        0WAbbsoSaHa38BXkXdMOEyhZcgpZeu/OVVG86ipRvJudoV8qZrOLuOHhnH4J38TdHWYzTm
        k2wC7mCPI2oPu5BiSuRDTc1c4YPpiojnhbSVvtiUjxhC8qtgZkHBzuLSFi9C4zMHQXQui+
        44GBHIIVFKD1k02kDBFfUkrxVzbrvQND6Rs33SPZqSweYAPfS01ntNPARWGLOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632435841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Matoo2OIfdawfGuu3j6hbf2m+pvAyOqko4uRRDDqJ0=;
        b=/7ConpvTXAvFWy6BmvzoZaT07ZxWDyhnP2mIpX3mCcpKyA1zbHQBf+ebCtIwiiVEMqZdvP
        uR9Iu/xxODMvHjBw==
To:     Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org
Cc:     Sohil Mehta <sohil.mehta@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 03/13] x86/cpu: Enumerate User Interrupts support
In-Reply-To: <20210913200132.3396598-4-sohil.mehta@intel.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-4-sohil.mehta@intel.com>
Date:   Fri, 24 Sep 2021 00:24:00 +0200
Message-ID: <87lf3nexrz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 13 2021 at 13:01, Sohil Mehta wrote:
> SENDUIPI is a special ring-3 instruction that makes a supervisor mode
> memory access to the UPID and UITT memory. Currently, KPTI needs to be
> off for User IPIs to work.  Processors that support user interrupts are
> not affected by Meltdown so the auto mode of KPTI will default to off.
>
> Users who want to force enable KPTI will need to wait for a later
> version of this patch series that is compatible with KPTI. We need to
> allocate the UPID and UITT structures from a special memory region that
> has supervisor access but it is mapped into userspace. The plan is to
> implement a mechanism similar to LDT.

Seriously?

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>

This SOB chain is invalid. Ditto in several other patches.

>  
> +config X86_USER_INTERRUPTS
> +	bool "User Interrupts (UINTR)"
> +	depends on X86_LOCAL_APIC && X86_64

X86_64 does not work w/o LOCAL_APIC so this dependency is pointless.

> +	depends on CPU_SUP_INTEL
> +	help
> +	  User Interrupts are events that can be delivered directly to
> +	  userspace without a transition through the kernel. The interrupts
> +	  could be generated by another userspace application, kernel or a
> +	  device.
> +
> +	  Refer, Documentation/x86/user-interrupts.rst for details.

"Refer, Documentation..." is not a sentence.

>  
> +/* User Interrupt interface */
> +#define MSR_IA32_UINTR_RR		0x985
> +#define MSR_IA32_UINTR_HANDLER		0x986
> +#define MSR_IA32_UINTR_STACKADJUST	0x987
> +#define MSR_IA32_UINTR_MISC		0x988	/* 39:32-UINV, 31:0-UITTSZ */

Bah, these tail comments are crap. Please define proper masks/shift
constants for this instead of using magic numbers in the code.

> +static __always_inline void setup_uintr(struct cpuinfo_x86 *c)

This has to be always inline because it's performance critical or what?

> +{
> +	/* check the boot processor, plus compile options for UINTR. */

Sentences start with uppercase letters.

> +	if (!cpu_feature_enabled(X86_FEATURE_UINTR))
> +		goto disable_uintr;
> +
> +	/* checks the current processor's cpuid bits: */
> +	if (!cpu_has(c, X86_FEATURE_UINTR))
> +		goto disable_uintr;
> +
> +	/*
> +	 * User Interrupts currently doesn't support PTI. For processors that
> +	 * support User interrupts PTI in auto mode will default to off.  Need
> +	 * this check only for users who have force enabled PTI.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_PTI)) {
> +		pr_info_once("x86: User Interrupts (UINTR) not enabled. Please disable PTI using 'nopti' kernel parameter\n");

That message does not make sense. The admin has explicitly added 'pti'
to the kernel command line on a CPU which is not affected. So why would
he now have to add 'nopti' ?

Thanks,

        tglx
