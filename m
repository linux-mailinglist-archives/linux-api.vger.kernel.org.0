Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13C86A0A5
	for <lists+linux-api@lfdr.de>; Tue, 16 Jul 2019 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfGPC7f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 22:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfGPC7f (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 15 Jul 2019 22:59:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26AB5309178C;
        Tue, 16 Jul 2019 02:59:35 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7F1D1001B04;
        Tue, 16 Jul 2019 02:59:27 +0000 (UTC)
Date:   Tue, 16 Jul 2019 10:59:23 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V35 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
Message-ID: <20190716025923.GA5793@dhcp-128-65.nay.redhat.com>
References: <20190715195946.223443-1-matthewgarrett@google.com>
 <20190715195946.223443-16-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715195946.223443-16-matthewgarrett@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 02:59:35 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
On 07/15/19 at 12:59pm, Matthew Garrett wrote:
> From: Josh Boyer <jwboyer@redhat.com>
> 
> This option allows userspace to pass the RSDP address to the kernel, which
> makes it possible for a user to modify the workings of hardware .  Reject
> the option when the kernel is locked down.
> 
> Signed-off-by: Josh Boyer <jwboyer@redhat.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> cc: Dave Young <dyoung@redhat.com>
> cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/osl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 9c0edf2fc0dd..06e7cffc4386 100644
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
> @@ -180,7 +181,7 @@ acpi_physical_address __init acpi_os_get_root_pointer(void)
>  	acpi_physical_address pa;
>  
>  #ifdef CONFIG_KEXEC
> -	if (acpi_rsdp)
> +	if (acpi_rsdp && !security_locked_down(LOCKDOWN_ACPI_TABLES))
>  		return acpi_rsdp;

I'm very sorry I noticed this late, but have to say this will not work for
X86 with latest kernel code.

acpi_physical_address __init acpi_os_get_root_pointer(void)
{
        acpi_physical_address pa;

#ifdef CONFIG_KEXEC
        if (acpi_rsdp)
                return acpi_rsdp;
#endif
        pa = acpi_arch_get_root_pointer();
        if (pa)
                return pa;
[snip]

In above code, the later acpi_arch_get_root_pointer still get acpi_rsdp
from cmdline param if provided.

You can check the arch/x86/boot/compressed/acpi.c, and
arch/x86/kernel/acpi/boot.c

In X86 early code, cmdline provided acpi_rsdp pointer will be saved in boot_params.acpi_rsdp_addr;
and the used in x86_default_get_root_pointer
 
>  #endif
>  	pa = acpi_arch_get_root_pointer();
> -- 
> 2.22.0.510.g264f2c817a-goog
> 

Thanks
Dave
