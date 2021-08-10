Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEA73E50F2
	for <lists+linux-api@lfdr.de>; Tue, 10 Aug 2021 04:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbhHJCI1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Aug 2021 22:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbhHJCIY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Aug 2021 22:08:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAE6C0613D3;
        Mon,  9 Aug 2021 19:08:03 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so2135148pjs.0;
        Mon, 09 Aug 2021 19:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v7qOXxkhDcJDtLfYGjeWm7crxawwUhx3Jo2RHArHK7o=;
        b=kZr2MFpJb+HrDAFlUE+B1DBa4v2e+sEelA93ZpD8k/EqGx6HDNZc0Ma/obngQAYFTs
         9swosAEHpVF9VSA++7ZAysUPKcikf9ixUtoaQDd+/tbt1A1twrWcJJGE20d5AdgtMCvK
         bUP1Yc6WuxCITOUUMIGV9s9tr+TW/4vzr+CDtLbKjo8M4zor8IoPerygOyUIVUfLkuyw
         gsB61Xl6MnEDx7lpfzz/hcqVL5TQn45hEA9/tq66LzWQiW4fXPed5oSvUbckk3KanMR3
         QXdPI1SPGEjFnZsU0v94wKaO8yztqh+Mayr8fU4kLD9CiA/9TD6rTmNhq6erYIzF6d/6
         MN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v7qOXxkhDcJDtLfYGjeWm7crxawwUhx3Jo2RHArHK7o=;
        b=Bh2KK5F7MALtyzWU4GBqWkpo/RGvWf66aeiaNoGEyikIIl0IozglJSGGYuRFQy9vGh
         Zjota9a9eVsAwpMWX8ldtMz9ppw0llHRhiBSvGuyVyo8ykgJq2e2unywMfLag8hjG64t
         TMVZq+5jwmwdXT6MUtwK/WuAfU5ippz2rSpdBlneMTQ9uIDwuI3HJXShlxmre1ZBMGet
         Z1qjBmm63hVfBRd9rG6s9arswNLb1Dfa2/xdgT8TI6cBfwLlFNV//e5g2Av2tZugGjYb
         DNQavZ+vi941lfam3LqgcjKTjw6xlyIzoLaXOt1EHQrad/O964klcIrT3k1Mks1BRlhD
         3M0Q==
X-Gm-Message-State: AOAM532R2Aj1ibXXArgpG3A5lR+xDzZNCMMuzDsGOQGAPHW4B+M+EP5Q
        PNxihor3HygZbDxehEnIX5Af9QCBS7k=
X-Google-Smtp-Source: ABdhPJzl24llLvq6TUgfoQq5igPpwr6oDqJYKMfP77TqoX9ynYvLNX1tbw0ygzuuKXn1CLZFMQvHaQ==
X-Received: by 2002:a65:6a0c:: with SMTP id m12mr86484pgu.267.1628561282668;
        Mon, 09 Aug 2021 19:08:02 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id z1sm17392853pfg.18.2021.08.09.19.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 19:08:01 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, linux-man@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp.2: Clarify that bad system calls kill the thread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
References: <87r1gkp9i7.fsf@disp2133> <202106292156.9458CF22@keescook>
 <87k0mbp0yc.fsf_-_@disp2133>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <1da46e75-fd67-e3e6-4db3-1d37dcae7f75@gmail.com>
Date:   Tue, 10 Aug 2021 04:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87k0mbp0yc.fsf_-_@disp2133>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Eric,

On 6/30/21 10:11 PM, Eric W. Biederman wrote:
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Thanks. Patch applied, with Kees' Ack.

Cheers,

Michael


> ---
>  man2/seccomp.2 | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/seccomp.2 b/man2/seccomp.2
> index a3421871f0f4..bde54c3e3e99 100644
> --- a/man2/seccomp.2
> +++ b/man2/seccomp.2
> @@ -69,9 +69,10 @@ The only system calls that the calling thread is permitted to make are
>  .BR exit_group (2)),
>  and
>  .BR sigreturn (2).
> -Other system calls result in the delivery of a
> +Other system calls result in the termination of the calling thread,
> +or termination of the entire process with the
>  .BR SIGKILL
> -signal.
> +signal when there is only one thread.
>  Strict secure computing mode is useful for number-crunching
>  applications that may need to execute untrusted byte code, perhaps
>  obtained by reading from a pipe or socket.
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
