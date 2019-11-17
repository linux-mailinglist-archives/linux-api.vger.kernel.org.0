Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0EDFFB49
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 19:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfKQSBW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 13:01:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43114 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfKQSBW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 13:01:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id n1so16752778wra.10;
        Sun, 17 Nov 2019 10:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4E8vsN26IckcMh6YLAd5L8bc5MBFn3KXLunbu3nT/YU=;
        b=rkhRGlPp6TwA0Hn1ctzUc7zD+7NNkWZR0NH8F0YP8arEENdzjxy+bfODzlhuPM8WVU
         YOhKFFjjiCMOos7f3P4LHeKidTPNze7vXb+W1doKI7W1+ajrem4Ozf2gpn80a/VjJ+ln
         mo4nMOgWXT/PfqQAuRg161YqWHIezKzwhWD6xI05CxXLVMoj9fVdYdzif2X0mZJuk02d
         FoqbPhTvtmX94LNiNCHX5RNr1+/KYm0Xd0H7ig1C06VSOgvhIvmmwjuAq2uUzgpZg3+D
         Ge3qYKQscYyGPWJoqJJMobAhjQDJaIPAdHrDcnC0IotrtylHkdeCUAohXjUeu3koCEOh
         4kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4E8vsN26IckcMh6YLAd5L8bc5MBFn3KXLunbu3nT/YU=;
        b=LFNhX2zdiuBqGV9qI6CWfJnmwV6mqDOqYqw3kymRCcwq3fsz+aZ5dXUkfRZ+6xCi/l
         CVPMduGI3uOdCD76Fj0OBDSpttFEHoEfG1honINyhUcxkmOfwqPSeso8BOKOBZkW4KmX
         F+pbJnrOIs4MtIViuBWqTq604fuCPQhpGWSz4PutwOv1p0pe9tPMi+AGba31y3yaXpgr
         p0denBhPUJo7kIiSSvpdSkOrhoJt0mfzjaLTwKOLERwZAHb6fI+z26fZ8+TtqcZcuoTV
         3L/Ms6tnf9EGvDEziR63cpeyBqQJWQoCQZjSTvMVPnImA3/cMcIdG2AS+IpAVqVGgedy
         /lGQ==
X-Gm-Message-State: APjAAAUE5rVFdznzXEzsPGROD43agOdo0u/dltAZumzHPrpzk/vhFFRm
        h8zNQLXMH1ka2DYm9VUx4pU=
X-Google-Smtp-Source: APXvYqzqC+ofJW92NVIIwzF0GMAlaMsXhL5IgRD/u9ekuJiywWNkRstfaPdJLjS860EEEYKf8PO5lQ==
X-Received: by 2002:adf:f20d:: with SMTP id p13mr24691953wro.325.1574013679908;
        Sun, 17 Nov 2019 10:01:19 -0800 (PST)
Received: from [192.168.178.53] (x5f752d31.dyn.telefonica.de. [95.117.45.49])
        by smtp.gmail.com with ESMTPSA id t187sm13327318wma.16.2019.11.17.10.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 10:01:18 -0800 (PST)
Cc:     mtk.manpages@gmail.com, adrian@lisas.de, akpm@linux-foundation.org,
        arnd@arndb.de, avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: Re: [PATCH 2/3] clone.2: Check for MAP_FAILED not NULL on mmap()
To:     Christian Brauner <christian@brauner.io>
References: <20191116114114.7066-1-christian@brauner.io>
 <20191116114114.7066-2-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e94e46a1-d852-f5df-352c-592d5e0e9c6a@gmail.com>
Date:   Sun, 17 Nov 2019 19:01:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191116114114.7066-2-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/16/19 12:41 PM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> If mmap() fails it will return MAP_FAILED which according to the manpage
> is (void *)-1 not NULL.

Sigh! Bad editing on my part.

Thanks, Christian.

Patch applied.

Cheers,

Michael



> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/clone.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index 57a9eaba7..faff2ada6 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -1628,7 +1628,7 @@ main(int argc, char *argv[])
>  
>      stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
>                   MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, \-1, 0);
> -    if (stack == NULL)
> +    if (stack == MAP_FAILED)
>          errExit("mmap");
>  
>      stackTop = stack + STACK_SIZE;  /* Assume stack grows downward */
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
