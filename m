Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84896BF4
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2019 00:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfHTWIw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 18:08:52 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50629 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTWIv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Aug 2019 18:08:51 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 58fce0e735fe6fb1; Wed, 21 Aug 2019 00:08:49 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <lcrosetto@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V40 16/29] acpi: Disable ACPI table override if the kernel is locked down
Date:   Wed, 21 Aug 2019 00:08:48 +0200
Message-ID: <18886542.jEbjgeBmpC@kreacher>
In-Reply-To: <20190820001805.241928-17-matthewgarrett@google.com>
References: <20190820001805.241928-1-matthewgarrett@google.com> <20190820001805.241928-17-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tuesday, August 20, 2019 2:17:52 AM CEST Matthew Garrett wrote:
> From: Linn Crosetto <lcrosetto@gmail.com>
> 
> >From the kernel documentation (initrd_table_override.txt):
> 
>   If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
>   to override nearly any ACPI table provided by the BIOS with an
>   instrumented, modified one.
> 
> When lockdown is enabled, the kernel should disallow any unauthenticated
> changes to kernel space.  ACPI tables contain code invoked by the kernel,
> so do not allow ACPI tables to be overridden if the kernel is locked down.
> 
> Signed-off-by: Linn Crosetto <lcrosetto@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> cc: linux-acpi@vger.kernel.org
> Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index de974322a197..b7c29a11c0c1 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -20,6 +20,7 @@
>  #include <linux/memblock.h>
>  #include <linux/earlycpio.h>
>  #include <linux/initrd.h>
> +#include <linux/security.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -577,6 +578,11 @@ void __init acpi_table_upgrade(void)
>  	if (table_nr == 0)
>  		return;
>  
> +	if (security_locked_down(LOCKDOWN_ACPI_TABLES)) {
> +		pr_notice("kernel is locked down, ignoring table override\n");
> +		return;
> +	}
> +
>  	acpi_tables_addr =
>  		memblock_find_in_range(0, ACPI_TABLE_UPGRADE_MAX_PHYS,
>  				       all_tables_size, PAGE_SIZE);
> 




