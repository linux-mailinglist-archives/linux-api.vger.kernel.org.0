Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1334450620
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 11:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfFXJuw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 05:50:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35116 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfFXJuw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 05:50:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so12703414wml.0
        for <linux-api@vger.kernel.org>; Mon, 24 Jun 2019 02:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4NNAG9I48YK3TjGzt1EON8fog028feKahD05Bs4bPfI=;
        b=YrAMsLbOFa6qo4SqNzKc2huf4LtNfLM9NRM79nctBqcc3wyIQr7pGjXSzyHyG9/6KG
         hSYR7+PJ4EhVZNXtenb/9HKygjhaKNq8N6Clb8C6wcfQ2nVneMfTQdMNsXH5gTex4t4O
         y4rjC3dKFXWznd5fbM4cFhCHzncG7P0dupYz1AJ/L5PCplRQkqA4Uxb+AOaB4RJifIB7
         Vd0R+zMiFsmcKG2g2llcAFScJWQSTWkm8Llnz3IxEdzxezaDgNv0j+oi+WUDlehoVUfx
         Gy0eRADcU7Qp9sIBNvHbGrGPLuQqul4b+UbDVBO4LJ2YClX2ovxbUwnpYmXDJY0I1TIJ
         QQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4NNAG9I48YK3TjGzt1EON8fog028feKahD05Bs4bPfI=;
        b=pFdBvjwRDPq5PPEmQMN/Q7MY6fOnhFJtnSSIm5eaPljfSgXVV9NG5USKkYAr+x2Z5j
         aYmIeExROMi4lHoCe9qN6McNtdepdcJWJ7+vl7ufaXXXyjy300c1Nmi3Oy3KlYYcIjFR
         7SdwQdVpXswfNuh1b3LOGOUgSB05RVdVN92KmgsJAGKCqvKejdS0gLx4S8RyNlzKpYVH
         3WLYO2ADlyaZ8AMyfweDZkQBQm4rCFXnkfyjSw3C5TA0cdpwQzPgS5jQq7qntih7ikUh
         N/2z3HR1QUMgVMfE5gkH3y0dwu1QKp4zCtuZIipbbvbbsWNyOAt2vw04p7kD+jhjnNO4
         e5Fw==
X-Gm-Message-State: APjAAAW2hKfYZCxwMo+Yrz1YgzGR2Tpf+53Oj0E0luBsGFCEetfWRQgR
        N/NpUWtyk73JziSop8KOpBAdGw==
X-Google-Smtp-Source: APXvYqyShlMqnwZgT9Ce0Dr4d8PaoHyu+NJgeYFWEmHFnHgaWVaqpcpV8RV7C88/2eW9vklXON7kfg==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr15612703wma.164.1561369849990;
        Mon, 24 Jun 2019 02:50:49 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id r12sm11097613wrt.95.2019.06.24.02.50.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 02:50:49 -0700 (PDT)
Date:   Mon, 24 Jun 2019 11:50:48 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] samples: make pidfd-metadata fail gracefully on
 older kernels
Message-ID: <20190624095047.2ixebkmurvv4qjrk@brauner.io>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623112717.GA20697@altlinux.org>
 <20190623112800.GB20697@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190623112800.GB20697@altlinux.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jun 23, 2019 at 02:28:00PM +0300, Dmitry V. Levin wrote:
> Initialize pidfd to an invalid descriptor, to fail gracefully on
> those kernels that do not implement CLONE_PIDFD and leave pidfd
> unchanged.
> 
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Reviewed-by: Christian Brauner <christian@brauner.io>

Thank you Dmitry, queueing this up for rc7.

> ---
>  samples/pidfd/pidfd-metadata.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
> index 14b454448429..c459155daf9a 100644
> --- a/samples/pidfd/pidfd-metadata.c
> +++ b/samples/pidfd/pidfd-metadata.c
> @@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
>  
>  int main(int argc, char *argv[])
>  {
> -	int pidfd = 0, ret = EXIT_FAILURE;
> +	int pidfd = -1, ret = EXIT_FAILURE;
>  	char buf[4096] = { 0 };
>  	pid_t pid;
>  	int procfd, statusfd;
> @@ -91,7 +91,11 @@ int main(int argc, char *argv[])
>  
>  	pid = pidfd_clone(CLONE_PIDFD, &pidfd);
>  	if (pid < 0)
> -		exit(ret);
> +		err(ret, "CLONE_PIDFD");
> +	if (pidfd == -1) {
> +		warnx("CLONE_PIDFD is not supported by the kernel");
> +		goto out;
> +	}
>  
>  	procfd = pidfd_metadata_fd(pid, pidfd);
>  	close(pidfd);
> -- 
> ldv
