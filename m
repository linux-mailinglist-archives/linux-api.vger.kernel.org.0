Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD428CCB6
	for <lists+linux-api@lfdr.de>; Wed, 14 Aug 2019 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfHNH14 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Aug 2019 03:27:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfHNH14 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Aug 2019 03:27:56 -0400
Received: from zn.tnic (p200300EC2F0BD0001434546E6F7AC9DD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d000:1434:546e:6f7a:c9dd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C72D1EC02FE;
        Wed, 14 Aug 2019 09:27:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565767675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S0pdHUrMZlxeH9o5UwMMdUNK7RCa7z7enuUZ3T7dyxs=;
        b=a+2XvMTBAV+kdnpbaxN0Sigc8m4vhX0OYPSlG8AU1aS+2M9vD6TsMMsb5+OGv0j5RZU0to
        b8Kwi73ybojH8SC051Zc330H6/dDjhb+Z9FUnhrIOEnoiBi2TOXgFik1iUAftMyEABQZus
        jfnyKD47r7Ub1s1LnreXItaO0wuVX2g=
Date:   Wed, 14 Aug 2019 09:28:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org,
        x86-ml <x86@kernel.org>
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
Message-ID: <20190814072844.GB27836@zn.tnic>
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808000721.124691-16-matthewgarrett@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 07, 2019 at 05:07:07PM -0700, Matthew Garrett wrote:
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

Also, why isn't an x86 person CCed here? This clearly needs an x86
maintainer's ACK before it goes in?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
