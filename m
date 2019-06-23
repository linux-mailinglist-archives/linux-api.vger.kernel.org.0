Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11EE4F93A
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 02:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfFWAAP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 20:00:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41951 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfFWAAP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 20:00:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so5422854pff.8
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l17kSA4cebdwaszrX4PylxVfM6zz9iSc9kiB9UHWgW8=;
        b=aOU8uC4Ys2KdB/JtPKpjtGhmwAOIsOGljrGxasiCVO7n0QTwpHnA3sRlTfHGTRKIe9
         tfUOHXZYpwfvhQErKfAwgaT6eeP+6My+2ksDjqwGFUPbQVtrDNSyycqeax2C8uI2IRqt
         1+NaYESergzZE+e+wIDckd0BpScJsDfEq2jF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l17kSA4cebdwaszrX4PylxVfM6zz9iSc9kiB9UHWgW8=;
        b=IUagL4jrZyASne3NItBvAufqdx/3m7RYHAFVMqEvEW0d58rwcADonqwsG8QoIIISFq
         DYxJl1EJ4noL7dRCkUHiNXVfcYI21SAQvAbnaAZxGBdHPtWZQal1AkVtAvZymY5n0DHE
         E+/k39XA4qoHgcTEbI4W6lw++R1j0O1QjsD+NUJEC2nAmtY0vt2/9YHdniySgzxAVuQp
         JcikpVgOmU4jF8SMSF7wCPEx1xn9QWageFk+xf0g+veaxu1ah1yG8Xlh9+9dEq84YP1W
         6lSjOKg40MnK7v6gBAaQ2joAc4spC0oHx/Cvez8LeVeHPPxaqDVov1OO8nT+OaAHfaCS
         qcHQ==
X-Gm-Message-State: APjAAAVuQw2KdRNBEtxBpLFj/6gEHgZcJ+lYwgna46RbWKc8Jq/Dg5AH
        MlJ8+xswAarYh+ZyDsQaGT+fqA==
X-Google-Smtp-Source: APXvYqyMopfoqvZ+DwxtsFDy82siF7CcLHjXJYUDFIFaw6nsQZzCAQyGZOnOzRYufo2is/oZADjubA==
X-Received: by 2002:a63:5a02:: with SMTP id o2mr24596077pgb.93.1561248015012;
        Sat, 22 Jun 2019 17:00:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm6740048pfi.35.2019.06.22.17.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 17:00:13 -0700 (PDT)
Date:   Sat, 22 Jun 2019 17:00:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Linn Crosetto <linn@hpe.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH V34 16/29] acpi: Disable ACPI table override if the
 kernel is locked down
Message-ID: <201906221700.B1CA4EF77E@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-17-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-17-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:45PM -0700, Matthew Garrett wrote:
> From: Linn Crosetto <linn@hpe.com>
> 
> From the kernel documentation (initrd_table_override.txt):
> 
>   If the ACPI_INITRD_TABLE_OVERRIDE compile option is true, it is possible
>   to override nearly any ACPI table provided by the BIOS with an
>   instrumented, modified one.
> 
> When lockdown is enabled, the kernel should disallow any unauthenticated
> changes to kernel space.  ACPI tables contain code invoked by the kernel,
> so do not allow ACPI tables to be overridden if the kernel is locked down.
> 
> Signed-off-by: Linn Crosetto <linn@hpe.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> cc: linux-acpi@vger.kernel.org
> ---
>  drivers/acpi/tables.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 8fccbe49612a..41d9ccd0e075 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -34,6 +34,7 @@
>  #include <linux/memblock.h>
>  #include <linux/earlycpio.h>
>  #include <linux/initrd.h>
> +#include <linux/security.h>
>  #include "internal.h"
>  
>  #ifdef CONFIG_ACPI_CUSTOM_DSDT
> @@ -539,6 +540,11 @@ void __init acpi_table_upgrade(void)
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
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
