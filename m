Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACE808C9B5
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 04:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfHNCv1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Aug 2019 22:51:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbfHNCv1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Aug 2019 22:51:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29F08470C;
        Wed, 14 Aug 2019 02:51:27 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5FBA808C0;
        Wed, 14 Aug 2019 02:51:17 +0000 (UTC)
Date:   Wed, 14 Aug 2019 10:51:13 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>, bhe@redhat.com,
        kasong@redhat.com, Borislav Petkov <bp@suse.de>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
Message-ID: <20190814025113.GA7058@dhcp-128-65.nay.redhat.com>
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808000721.124691-16-matthewgarrett@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 14 Aug 2019 02:51:27 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 08/07/19 at 05:07pm, Matthew Garrett wrote:
> From: Josh Boyer <jwboyer@redhat.com>
> 
> This option allows userspace to pass the RSDP address to the kernel, which
> makes it possible for a user to modify the workings of hardware. Reject
> the option when the kernel is locked down. This requires some reworking
> of the existing RSDP command line logic, since the early boot code also
> makes use of a command-line passed RSDP when locating the SRAT table
> before the lockdown code has been initialised. This is achieved by
> separating the command line RSDP path in the early boot code from the
> generic RSDP path, and then copying the command line RSDP into boot
> params in the kernel proper if lockdown is not enabled. If lockdown is
> enabled and an RSDP is provided on the command line, this will only be
> used when parsing SRAT (which shouldn't permit kernel code execution)
> and will be ignored in the rest of the kernel.
> 
> (Modified by Matthew Garrett in order to handle the early boot RSDP
> environment)
> 
> Signed-off-by: Josh Boyer <jwboyer@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> cc: Dave Young <dyoung@redhat.com>
> cc: linux-acpi@vger.kernel.org
> ---
>  arch/x86/boot/compressed/acpi.c | 19 +++++++++++++------
>  arch/x86/include/asm/acpi.h     |  9 +++++++++
>  arch/x86/include/asm/x86_init.h |  2 ++
>  arch/x86/kernel/acpi/boot.c     |  5 +++++
>  arch/x86/kernel/x86_init.c      |  1 +
>  drivers/acpi/osl.c              | 14 +++++++++++++-
>  include/linux/acpi.h            |  6 ++++++
>  7 files changed, 49 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 15255f388a85..149795c369f2 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -26,7 +26,7 @@ struct mem_vector immovable_mem[MAX_NUMNODES*2];
>   */
>  #define MAX_ADDR_LEN 19
>  
> -static acpi_physical_address get_acpi_rsdp(void)
> +static acpi_physical_address get_cmdline_acpi_rsdp(void)
>  {
>  	acpi_physical_address addr = 0;
>  
> @@ -278,10 +278,7 @@ acpi_physical_address get_rsdp_addr(void)
>  {
>  	acpi_physical_address pa;
>  
> -	pa = get_acpi_rsdp();
> -
> -	if (!pa)
> -		pa = boot_params->acpi_rsdp_addr;
> +	pa = boot_params->acpi_rsdp_addr;
>  
>  	/*
>  	 * Try to get EFI data from setup_data. This can happen when we're a
> @@ -311,7 +308,17 @@ static unsigned long get_acpi_srat_table(void)
>  	char arg[10];
>  	u8 *entry;
>  
> -	rsdp = (struct acpi_table_rsdp *)(long)boot_params->acpi_rsdp_addr;
> +	/*
> +	 * Check whether we were given an RSDP on the command line. We don't
> +	 * stash this in boot params because the kernel itself may have
> +	 * different ideas about whether to trust a command-line parameter.
> +	 */
> +	rsdp = (struct acpi_table_rsdp *)get_cmdline_acpi_rsdp();
> +
> +	if (!rsdp)
> +		rsdp = (struct acpi_table_rsdp *)(long)
> +			boot_params->acpi_rsdp_addr;
> +
>  	if (!rsdp)
>  		return 0;
>  
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index aac686e1e005..bc9693c9107e 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -117,6 +117,12 @@ static inline bool acpi_has_cpu_in_madt(void)
>  	return !!acpi_lapic;
>  }
>  
> +#define ACPI_HAVE_ARCH_SET_ROOT_POINTER
> +static inline void acpi_arch_set_root_pointer(u64 addr)
> +{
> +	x86_init.acpi.set_root_pointer(addr);
> +}
> +
>  #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
>  static inline u64 acpi_arch_get_root_pointer(void)
>  {
> @@ -125,6 +131,7 @@ static inline u64 acpi_arch_get_root_pointer(void)
>  
>  void acpi_generic_reduced_hw_init(void);
>  
> +void x86_default_set_root_pointer(u64 addr);
>  u64 x86_default_get_root_pointer(void);
>  
>  #else /* !CONFIG_ACPI */
> @@ -138,6 +145,8 @@ static inline void disable_acpi(void) { }
>  
>  static inline void acpi_generic_reduced_hw_init(void) { }
>  
> +static inline void x86_default_set_root_pointer(u64 addr) { }
> +
>  static inline u64 x86_default_get_root_pointer(void)
>  {
>  	return 0;
> diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
> index ac0934189017..19435858df5f 100644
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -134,10 +134,12 @@ struct x86_hyper_init {
>  
>  /**
>   * struct x86_init_acpi - x86 ACPI init functions
> + * @set_root_poitner:		set RSDP address
>   * @get_root_pointer:		get RSDP address
>   * @reduced_hw_early_init:	hardware reduced platform early init
>   */
>  struct x86_init_acpi {
> +	void (*set_root_pointer)(u64 addr);
>  	u64 (*get_root_pointer)(void);
>  	void (*reduced_hw_early_init)(void);
>  };
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 17b33ef604f3..04205ce127a1 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1760,6 +1760,11 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>  	e820__update_table_print();
>  }
>  
> +void x86_default_set_root_pointer(u64 addr)
> +{
> +	boot_params.acpi_rsdp_addr = addr;
> +}
> +
>  u64 x86_default_get_root_pointer(void)
>  {
>  	return boot_params.acpi_rsdp_addr;
> diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
> index 1bef687faf22..18a799c8fa28 100644
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -95,6 +95,7 @@ struct x86_init_ops x86_init __initdata = {
>  	},
>  
>  	.acpi = {
> +		.set_root_pointer	= x86_default_set_root_pointer,
>  		.get_root_pointer	= x86_default_get_root_pointer,
>  		.reduced_hw_early_init	= acpi_generic_reduced_hw_init,
>  	},
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 9c0edf2fc0dd..d43df3a3fa8d 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include <linux/jiffies.h>
>  #include <linux/semaphore.h>
> +#include <linux/security.h>
>  
>  #include <asm/io.h>
>  #include <linux/uaccess.h>
> @@ -180,8 +181,19 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>  	acpi_physical_address pa;
>  
>  #ifdef CONFIG_KEXEC
> -	if (acpi_rsdp)
> +	/*
> +	 * We may have been provided with an RSDP on the command line,
> +	 * but if a malicious user has done so they may be pointing us
> +	 * at modified ACPI tables that could alter kernel behaviour -
> +	 * so, we check the lockdown status before making use of
> +	 * it. If we trust it then also stash it in an architecture
> +	 * specific location (if appropriate) so it can be carried
> +	 * over further kexec()s.
> +	 */
> +	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES)) {
> +		acpi_arch_set_root_pointer(acpi_rsdp);
>  		return acpi_rsdp;
> +	}
>  #endif
>  	pa = acpi_arch_get_root_pointer();
>  	if (pa)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index e40e1e27ed8e..6b35f2f4cab3 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -643,6 +643,12 @@ bool acpi_gtdt_c3stop(int type);
>  int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
>  #endif
>  
> +#ifndef ACPI_HAVE_ARCH_SET_ROOT_POINTER
> +static inline void acpi_arch_set_root_pointer(u64 addr)
> +{
> +}
> +#endif
> +
>  #ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
>  static inline u64 acpi_arch_get_root_pointer(void)
>  {
> -- 
> 2.22.0.770.g0f2c4a37fd-goog
> 

I'm not sure why this series get posted quickly again.  As for this
patch it was restructured according the early rsdp parsing code, so
personally I think keep the original Reviewed-by is questionable and it
needs another review.  But I did not find time to read it carefully.

Add several cc to void it slipped.

Thanks
Dave
