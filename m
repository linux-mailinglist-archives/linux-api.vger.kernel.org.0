Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9125D4F90A
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 01:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfFVXwp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 19:52:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43253 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfFVXwn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 19:52:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id f25so5106102pgv.10
        for <linux-api@vger.kernel.org>; Sat, 22 Jun 2019 16:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YImUcuCexeZRlvHVuEgl97R534Yty3oYIKuuE0evjLk=;
        b=Rf1ilzbL8+AgDuWH99sFiAoQpznSrapYKr9e8FEnSk7XhDnhFa72A9R2QKmy5EsDti
         28WtmVru9dtkuS8r3liYz5SjTg/EOFEPjlrzRRJX1Ws6+XX8jAgvQa6/VPUjZ47J4NZd
         qDPfxj0XwdlC5iYG/DtFnJN1puMtJ4LVADSe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YImUcuCexeZRlvHVuEgl97R534Yty3oYIKuuE0evjLk=;
        b=svtWhsDnx3qLvIzgsA4gPYXrFK3oyym9tHuknTUT0mLjJSL2P8bpm+kjjxkrFGKPhy
         f/3C8rCiaMuZtHzg7tE1uYJ+e5wKQ06ebq0GeWv1WgUEer8Gjn/eGvtkQkHorKnJspoO
         jznIGKlXVQMp1GTROXajih9k+L1zD39t5b+P5aS1shIQC9RL5M7C6yP3ffw6v05q6LqF
         Oc2/JhEB0g/jL0wXlxHAcqex96K7NFaZepKYpkeobuBepZJxTVannWRNOX/7TWte65gP
         xmfOhkpXDP19rBwKJwrt8KvMUz+eYw9vvm6kiUH86chIpOduH4fWotKadcqMtvaw8HJQ
         15Ew==
X-Gm-Message-State: APjAAAW3wZ5DsYWJJIAOFAHK9Mxrvi7VHMh5lzbcwV5zV4nduDmsRyVI
        PGbuvXI5Thb7keb42udeoavcVQ==
X-Google-Smtp-Source: APXvYqyZbf1k8nXLguShO8CcJZ0g/jEwuvxkTVmi1wi9zDTPNu8HEZNYcrRBr8lKX5YNCq494+RqeQ==
X-Received: by 2002:a17:90a:3590:: with SMTP id r16mr15677484pjb.44.1561247562065;
        Sat, 22 Jun 2019 16:52:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o13sm6826679pje.28.2019.06.22.16.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Jun 2019 16:52:40 -0700 (PDT)
Date:   Sat, 22 Jun 2019 16:52:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Subject: Re: [PATCH V34 05/29] Restrict /dev/{mem,kmem,port} when the kernel
 is locked down
Message-ID: <201906221648.F8F0741@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-6-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-6-matthewgarrett@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:34PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> Allowing users to read and write to core kernel memory makes it possible
> for the kernel to be subverted, avoiding module loading restrictions, and
> also to steal cryptographic information.
> 
> Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
> been locked down to prevent this.
> 
> Also disallow /dev/port from being opened to prevent raw ioport access and
> thus DMA from being used to accomplish the same thing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: x86@kernel.org
> ---
>  drivers/char/mem.c           | 6 +++++-
>  include/linux/security.h     | 1 +
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index b08dc50f9f26..93c02493f0fa 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -29,8 +29,8 @@
>  #include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/uio.h>
> -
>  #include <linux/uaccess.h>
> +#include <linux/security.h>
>  
>  #ifdef CONFIG_IA64
>  # include <linux/efi.h>
> @@ -786,6 +786,10 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
>  
>  static int open_port(struct inode *inode, struct file *filp)
>  {
> +	int ret = security_locked_down(LOCKDOWN_DEV_MEM);
> +
> +	if (ret)
> +		return ret;
>  	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;

Usually the ordering for LSM tests tends to follow capable checks, which
allows for things like audit to generate logs for capability rejections,
etc. I'd expect this to be:

	if (!capable(CAP_SYS_RAWIO))
		return -EPERM;

	return security_locked_down(LOCKDOWN_DEV_MEM)

With that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  }
>  
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 46d85cd63b06..200175c8605a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -83,6 +83,7 @@ enum lsm_event {
>  enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_MODULE_SIGNATURE,
> +	LOCKDOWN_DEV_MEM,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 25a3a5b0aa9c..565c87451f0f 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -19,6 +19,7 @@ static enum lockdown_reason kernel_locked_down;
>  static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
> +	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook
