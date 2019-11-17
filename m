Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632F5FFB43
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 19:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKQSA2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 13:00:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38390 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfKQSA1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 13:00:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id z19so16284388wmk.3;
        Sun, 17 Nov 2019 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=F4NQooBVjrSqmCsMJWptKKpcPoY0ZrH3mGqS/PbNMyo=;
        b=e+9/o/ZWKT0cU4m83XoyfZs75i6IFYMGA8WbEsk2yK8WOhCyUhqm5E0+LZ8JvuOLg/
         G1IJAWAzudJW4i/rbJ5i/Vxpp3iTaCbfsnJLuji2a8kqJNs1zt+xqLTnzlxfErJsT57d
         erwIUxx6HkQKIUiRqrM1hh7UJv3RkYpsaWstgVb+FsQicQPu7ViFDqySUSQ3gV+unrJe
         DQUXj6YuP0ETMKed22McFFY2Hx/Ct/xv8IBHMYOQbvif1ENm5S1vCW4xMD4i64EfB6oB
         sW0kVSlS2Le8ZH/d8mK/0flqlJ/ug0Etrgadasv7W5wq0g3Gd6wv4PKXvfTgZ/JpNnjf
         LSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=F4NQooBVjrSqmCsMJWptKKpcPoY0ZrH3mGqS/PbNMyo=;
        b=JlQZ3BJy0tX5sBUPua6+2JoOYyFDr9mAqX3S/45tLqN8VJjlRVsQwSTdbhfC8P9DdM
         5aUGc99xFAvfn+yHlOunxkV5kgTRV6EI9xaOwZHzwWtsilS4bcH2NjvOme88+uz9O+Bj
         kBCqfU3vdZbEMmwFuwgYcJI8KjrjYfvVetdUo+7ritAfSN5sNoVad8kndJB5Qo2XP9p+
         ICr3OrEThJWQxm8r479Ef5gmM77Vp1vMzbEEhFLRKMgYVL2OskADfypDO6B7fxjaMQLv
         DUV6n2VuaAZsYL8clQKf/OO34kDnLv87qD3MVZbTlwW/9EOa1JS64r14PNxOptzrlGI9
         fydA==
X-Gm-Message-State: APjAAAWbGAkOEwe2SiK57BrcHPqMeQMFbBprCp7helY2YjtvMYgXFfHm
        egfMAlb1Ko/9DGbPj/G2INQ=
X-Google-Smtp-Source: APXvYqwIiM0ZFTq/2AyHVnk/4vTtfdVDSku8hzp50grw/lqRjOknUsLjUkAdU35z8Pooouy43oUkOA==
X-Received: by 2002:a1c:28d4:: with SMTP id o203mr26025806wmo.147.1574013624416;
        Sun, 17 Nov 2019 10:00:24 -0800 (PST)
Received: from [192.168.178.53] (x5f752d31.dyn.telefonica.de. [95.117.45.49])
        by smtp.gmail.com with ESMTPSA id z11sm23701517wrg.0.2019.11.17.10.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2019 10:00:23 -0800 (PST)
Cc:     mtk.manpages@gmail.com, adrian@lisas.de, akpm@linux-foundation.org,
        arnd@arndb.de, avagin@gmail.com, christian.brauner@ubuntu.com,
        dhowells@redhat.com, fweimer@redhat.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        mingo@elte.hu, oleg@redhat.com, xemul@virtuozzo.com
Subject: Re: [PATCH 1/3] clone.2: Fix typos
To:     Christian Brauner <christian@brauner.io>
References: <20191116114114.7066-1-christian@brauner.io>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0ef00041-9952-3dea-1d6b-2d14536764d3@gmail.com>
Date:   Sun, 17 Nov 2019 19:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20191116114114.7066-1-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/16/19 12:41 PM, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>

Thanks, Christian, 

Patch applied.

Cheers,

Michael


> Fix two spelling mistakes in manpage describing the clone{2,3}()
> syscalls/syscall wrappers.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  man2/clone.2 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/clone.2 b/man2/clone.2
> index f67a60067..57a9eaba7 100644
> --- a/man2/clone.2
> +++ b/man2/clone.2
> @@ -70,12 +70,12 @@ create a new ("child") process, in a manner similar to
>  .PP
>  By contrast with
>  .BR fork (2),
> -these system cals provide more precise control over what pieces of execution
> +these system calls provide more precise control over what pieces of execution
>  context are shared between the calling process and the child process.
>  For example, using these system calls, the caller can control whether
>  or not the two processes share the virtual address space,
>  the table of file descriptors, and the table of signal handlers.
> -These system calls also allow the new child process to placed
> +These system calls also allow the new child process to be placed
>  in separate
>  .BR namespaces (7).
>  .PP
> 
> base-commit: 91243dad42a7a62df73e3b1dfbb810adc1b8b654
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
