Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF1105159
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 12:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKULZ4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 06:25:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45280 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfKULZ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 06:25:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so3874647wrs.12;
        Thu, 21 Nov 2019 03:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RKpyo00ROy+/Y9f0zH5fPZcKWCaV9OV4wE3z16JscDo=;
        b=tSu0ChpeAMAQ10VqOMxc8zVD/kaE9h6EIIzrGQVkEe3spJp7L21DiXW2ZRpUnGPufM
         s4QYhD2s3oiO8ywYgLdu/db1I9Co9bfPUoWmKoszt4aDEMbFbH3iwdJF17VKOyYfhnYz
         qjeDt28kY4/wKjsfFQXJkfqTKRPoS5qrjqLxrde3gOUKYQHqG8o1iS3mCm8klOEy4xKj
         4fWCULo+nSEvU9jTJm5EwXPTzQE9jaSmR9kBN1OMyo1uav93cR2QLAvXgbs0ULhpp9UK
         PAUpnxUn1VbPF7IzOKQlN3TMg5X+P5SE/3w0jPGwHKxs19VAEfcEisGUTyqJHLJvJ2Y+
         2HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RKpyo00ROy+/Y9f0zH5fPZcKWCaV9OV4wE3z16JscDo=;
        b=AmcBE7XaFWdQ9F3JBNz4o9WBv2rnGPu5JrEorJhwySYYYQhqeMx1JUaI8QnO/jE0TT
         dH19bSJavKqoHxjD4t5TozQupaqNM6IZpLbBOFt4CMYm/yNBND2fhNoggkLVv+dq5FFD
         Rh6MamVbYJTVx69OP8XFWIV4wBDlg9ExuZZ+et8KMoamO7pM1LxQKJ3eICUCFh7NkhNH
         Umb0jkH59zL5qOOQ3oUvWk8NsuDEWT+r4XZlrvxdWz9eWNj76nHH+2yOydyl9J22hrPb
         SItf3Ii5o/t1ScGh0Fs8h4dDM9EfHRkYb6FD9mvTrYM9Xpn//1pr1lcXMpB9iqSEhXd/
         udpw==
X-Gm-Message-State: APjAAAU4yUtKkvHQgrygMbXXBBS8jrOIh7yNkidW+c/NjcNnkMdv1A/c
        wZELj+3l7zD393jI/rxy79s=
X-Google-Smtp-Source: APXvYqz0KjTFP/rlC8vO1RXEgHqmE4R/K2ICQOdQl0uoKyR7t4F2/a+yHbz7fDC3TmQQ7t4khbBAHg==
X-Received: by 2002:a05:6000:150:: with SMTP id r16mr9674483wrx.313.1574335551966;
        Thu, 21 Nov 2019 03:25:51 -0800 (PST)
Received: from ?IPv6:2001:a61:3a4e:101:8d4d:f454:a7e5:543d? ([2001:a61:3a4e:101:8d4d:f454:a7e5:543d])
        by smtp.gmail.com with ESMTPSA id i203sm2267610wma.35.2019.11.21.03.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 03:25:51 -0800 (PST)
Cc:     mtk.manpages@gmail.com, adrian@lisas.de, akpm@linux-foundation.org,
        arnd@arndb.de, avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: Re: [PATCH] clone.2: Fix typo
To:     Christian Brauner <christian@brauner.io>
References: <20191121110646.1398-1-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <9218d76c-96ec-920c-7304-a9247fb6d05a@gmail.com>
Date:   Thu, 21 Nov 2019 12:25:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121110646.1398-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Christian,

On 11/21/19 12:06 PM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> This surely meant to say clone3() and not clone(3).

Thanks. Patch applied.

Cheers,

Michael

 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/clone.2 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index 382f6b791..e5ab2a096 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -252,7 +252,7 @@ argument supplied to
>  lb lb lb
>  l l l
>  li li l.
> -clone()	clone(3)	Notes
> +clone()	clone3()	Notes
>  	\fIcl_args\fP field
>  flags & ~0xff	flags	For most flags; details below
>  parent_tid	pidfd	See CLONE_PIDFD
> 
> base-commit: be479fdf027a3288e88d53dbe05ba76bf202776e
> 
Hi Christian,,

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
