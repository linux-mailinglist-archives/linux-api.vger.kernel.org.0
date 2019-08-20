Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F82296BE8
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2019 00:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfHTWHN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 18:07:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48419 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730092AbfHTWHN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Aug 2019 18:07:13 -0400
Received: from 79.184.254.79.ipv4.supernova.orange.pl (79.184.254.79) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 3012fa65b7f729fb; Wed, 21 Aug 2019 00:07:10 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V40 14/29] ACPI: Limit access to custom_method when the kernel is locked down
Date:   Wed, 21 Aug 2019 00:07:10 +0200
Message-ID: <2669800.DxYg3DGudY@kreacher>
In-Reply-To: <20190820001805.241928-15-matthewgarrett@google.com>
References: <20190820001805.241928-1-matthewgarrett@google.com> <20190820001805.241928-15-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tuesday, August 20, 2019 2:17:50 AM CEST Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> custom_method effectively allows arbitrary access to system memory, making
> it possible for an attacker to circumvent restrictions on module loading.
> Disable it if the kernel is locked down.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> cc: linux-acpi@vger.kernel.org
> Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/custom_method.c | 6 ++++++
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
> index b2ef4c2ec955..7031307becd7 100644
> --- a/drivers/acpi/custom_method.c
> +++ b/drivers/acpi/custom_method.c
> @@ -9,6 +9,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/debugfs.h>
>  #include <linux/acpi.h>
> +#include <linux/security.h>
>  
>  #include "internal.h"
>  
> @@ -29,6 +30,11 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
>  
>  	struct acpi_table_header table;
>  	acpi_status status;
> +	int ret;
> +
> +	ret = security_locked_down(LOCKDOWN_ACPI_TABLES);
> +	if (ret)
> +		return ret;
>  
>  	if (!(*ppos)) {
>  		/* parse the table header to get the table length */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 010637a79eac..390e39395112 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -110,6 +110,7 @@ enum lockdown_reason {
>  	LOCKDOWN_PCI_ACCESS,
>  	LOCKDOWN_IOPORT,
>  	LOCKDOWN_MSR,
> +	LOCKDOWN_ACPI_TABLES,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index b1c1c72440d5..6d44db0ddffa 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -25,6 +25,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
>  	[LOCKDOWN_IOPORT] = "raw io port access",
>  	[LOCKDOWN_MSR] = "raw MSR access",
> +	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> 




