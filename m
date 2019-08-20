Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B590296BF0
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2019 00:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfHTWIX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 18:08:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42167 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTWIW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Aug 2019 18:08:22 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id ce020b60fd909a29; Wed, 21 Aug 2019 00:08:18 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V40 15/29] acpi: Ignore acpi_rsdp kernel param when the kernel has been locked down
Date:   Wed, 21 Aug 2019 00:08:18 +0200
Message-ID: <8258877.02sui5J5Gm@kreacher>
In-Reply-To: <20190820001805.241928-16-matthewgarrett@google.com>
References: <20190820001805.241928-1-matthewgarrett@google.com> <20190820001805.241928-16-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tuesday, August 20, 2019 2:17:51 AM CEST Matthew Garrett wrote:
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
> Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

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
> index ad84239e595e..e726e9b44bb1 100644
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
> @@ -215,10 +215,7 @@ acpi_physical_address get_rsdp_addr(void)
>  {
>  	acpi_physical_address pa;
>  
> -	pa = get_acpi_rsdp();
> -
> -	if (!pa)
> -		pa = boot_params->acpi_rsdp_addr;
> +	pa = boot_params->acpi_rsdp_addr;
>  
>  	if (!pa)
>  		pa = efi_get_rsdp_addr();
> @@ -240,7 +237,17 @@ static unsigned long get_acpi_srat_table(void)
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
> index b85a7c54c6a1..d584128435cb 100644
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
> index 50a2b492fdd6..d0b8f5585a73 100644
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
> index cc7507091dec..b7c3aeb175dd 100644
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
> index d315d86844e4..268a4d91f54c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -632,6 +632,12 @@ bool acpi_gtdt_c3stop(int type);
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
> 




