Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3F296698
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 18:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbfHTQjN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Aug 2019 12:39:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfHTQjM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 20 Aug 2019 12:39:12 -0400
Received: from linux-8ccs (unknown [92.117.154.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7653722DD3;
        Tue, 20 Aug 2019 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566319151;
        bh=gVkkoN4CalGvrq5CYCxbXHLC/0iPmTUko6ZPtdpSa8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AF0Mw1osWSFyJSa/26kxaUvosUxnCBBLsNLHuH86B9hXg174Dh5przqfV4AJKAYr5
         Za6oMNuvc/UK2/UNFJQHoD9fn5WPlih6HLg9ngaatGRPvAQVPII+d0J8XWlqWxTaam
         HSRm6t3uyD+cHCOOMXlLQX0cplroGvHhtgZQ3AE8=
Date:   Tue, 20 Aug 2019 18:39:05 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V40 19/29] lockdown: Lock down module params that specify
 hardware parameters (eg. ioport)
Message-ID: <20190820163905.GA28158@linux-8ccs>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-20-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190820001805.241928-20-matthewgarrett@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+++ Matthew Garrett [19/08/19 17:17 -0700]:
>From: David Howells <dhowells@redhat.com>
>
>Provided an annotation for module parameters that specify hardware
>parameters (such as io ports, iomem addresses, irqs, dma channels, fixed
>dma buffers and other types).
>
>Suggested-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
>Signed-off-by: David Howells <dhowells@redhat.com>
>Signed-off-by: Matthew Garrett <mjg59@google.com>
>Reviewed-by: Kees Cook <keescook@chromium.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Jessica Yu <jeyu@kernel.org>

Thanks!

>---
> include/linux/security.h     |  1 +
> kernel/params.c              | 21 ++++++++++++++++-----
> security/lockdown/lockdown.c |  1 +
> 3 files changed, 18 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/security.h b/include/linux/security.h
>index b4a85badb03a..1a3404f9c060 100644
>--- a/include/linux/security.h
>+++ b/include/linux/security.h
>@@ -113,6 +113,7 @@ enum lockdown_reason {
> 	LOCKDOWN_ACPI_TABLES,
> 	LOCKDOWN_PCMCIA_CIS,
> 	LOCKDOWN_TIOCSSERIAL,
>+	LOCKDOWN_MODULE_PARAMETERS,
> 	LOCKDOWN_INTEGRITY_MAX,
> 	LOCKDOWN_CONFIDENTIALITY_MAX,
> };
>diff --git a/kernel/params.c b/kernel/params.c
>index cf448785d058..8e56f8b12d8f 100644
>--- a/kernel/params.c
>+++ b/kernel/params.c
>@@ -12,6 +12,7 @@
> #include <linux/err.h>
> #include <linux/slab.h>
> #include <linux/ctype.h>
>+#include <linux/security.h>
>
> #ifdef CONFIG_SYSFS
> /* Protects all built-in parameters, modules use their own param_lock */
>@@ -96,13 +97,19 @@ bool parameq(const char *a, const char *b)
> 	return parameqn(a, b, strlen(a)+1);
> }
>
>-static void param_check_unsafe(const struct kernel_param *kp)
>+static bool param_check_unsafe(const struct kernel_param *kp)
> {
>+	if (kp->flags & KERNEL_PARAM_FL_HWPARAM &&
>+	    security_locked_down(LOCKDOWN_MODULE_PARAMETERS))
>+		return false;
>+
> 	if (kp->flags & KERNEL_PARAM_FL_UNSAFE) {
> 		pr_notice("Setting dangerous option %s - tainting kernel\n",
> 			  kp->name);
> 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 	}
>+
>+	return true;
> }
>
> static int parse_one(char *param,
>@@ -132,8 +139,10 @@ static int parse_one(char *param,
> 			pr_debug("handling %s with %p\n", param,
> 				params[i].ops->set);
> 			kernel_param_lock(params[i].mod);
>-			param_check_unsafe(&params[i]);
>-			err = params[i].ops->set(val, &params[i]);
>+			if (param_check_unsafe(&params[i]))
>+				err = params[i].ops->set(val, &params[i]);
>+			else
>+				err = -EPERM;
> 			kernel_param_unlock(params[i].mod);
> 			return err;
> 		}
>@@ -553,8 +562,10 @@ static ssize_t param_attr_store(struct module_attribute *mattr,
> 		return -EPERM;
>
> 	kernel_param_lock(mk->mod);
>-	param_check_unsafe(attribute->param);
>-	err = attribute->param->ops->set(buf, attribute->param);
>+	if (param_check_unsafe(attribute->param))
>+		err = attribute->param->ops->set(buf, attribute->param);
>+	else
>+		err = -EPERM;
> 	kernel_param_unlock(mk->mod);
> 	if (!err)
> 		return len;
>diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
>index 771c77f9c04a..0fa434294667 100644
>--- a/security/lockdown/lockdown.c
>+++ b/security/lockdown/lockdown.c
>@@ -28,6 +28,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
> 	[LOCKDOWN_ACPI_TABLES] = "modifying ACPI tables",
> 	[LOCKDOWN_PCMCIA_CIS] = "direct PCMCIA CIS storage",
> 	[LOCKDOWN_TIOCSSERIAL] = "reconfiguration of serial port IO",
>+	[LOCKDOWN_MODULE_PARAMETERS] = "unsafe module parameters",
> 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> };
>-- 
>2.23.0.rc1.153.gdeed80330f-goog
>
